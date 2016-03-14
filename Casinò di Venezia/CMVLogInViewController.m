//
//  CMVLogInViewController.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 11/02/14.
//  Copyright (c) 2014 Casinò di Venezia SPA. All rights reserved.
//

#import "CMVLogInViewController.h"

#import "UIViewController+ECSlidingViewController.h"
#import "MyLogInViewController.h"
#import "MySignUpViewController.h"
#import <Parse/Parse.h>
#import "CMVGreenButton.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <ParseTwitterUtils/ParseTwitterUtils.h>
#import "CMVAppDelegate.h"


@interface CMVLogInViewController ()

@property (weak, nonatomic) IBOutlet CMVGreenButton *logIn;
@end
NSString *myName;
@implementation CMVLogInViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *myGradient = [[UIImage alloc] init];
    if (iPHONE) {
        myGradient = [UIImage imageNamed:@"LogInColorPattern"];
    } else {
        myGradient = [UIImage imageNamed:@"LogInColorPatterniPAD"];
    }
   

    [self.logIn setTitleColor:[UIColor colorWithPatternImage:myGradient] forState:UIControlStateNormal];


    self.pictureImageView.alpha = 0.5;
    self.pictureImageView.layer.masksToBounds = YES;
    [self.pictureImageView.layer setCornerRadius:(self.pictureImageView.frame.size.height/2)];
    [self.pictureImageView.layer setMasksToBounds:YES];
    self.vip.hidden=YES;
    self.badge.hidden=YES;
    
    if ([PFUser currentUser]) {
    
        [self updateProfile];
    }

    [self presentLogIn];
}
-(void)presentLogIn {
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        MyLogInViewController *logInViewController = [[MyLogInViewController alloc] init];
       
        [logInViewController setDelegate:self];
        
        
        logInViewController.fields=PFLogInFieldsUsernameAndPassword
        | PFLogInFieldsLogInButton
        | PFLogInFieldsTwitter
        | PFLogInFieldsFacebook
        | PFLogInFieldsSignUpButton
        | PFLogInFieldsPasswordForgotten
        | PFLogInFieldsDismissButton;
        // Set permissions required from the facebook user account
        NSArray *permissionsArray = @[ @"user_about_me", @"user_birthday", @"user_location", @"email"];
       
        [logInViewController setFacebookPermissions:permissionsArray];
        
        
        // Create the sign up view controller
        MySignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"LogIn"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    if ([PFUser currentUser]) {
        // If the user is logged in, show their name in the welcome label.
        [self.logIn setTitle:@"LOG OUT" forState:UIControlStateNormal];
        [self.view setNeedsLayout];
        if ([PFTwitterUtils isLinkedWithUser:[PFUser currentUser]]) {
            // If user is linked to Twitter, we'll use their Twitter screen name
            self.welcomeLabel.text =[NSString stringWithFormat:NSLocalizedString(@"Welcome\n @%@", nil), [PFTwitterUtils twitter].screenName];
            self.vip.hidden=YES;
            self.badge.hidden=YES;
            
        } else if ([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
            // If user is linked to Facebook, we'll use the Facebook Graph API to fetch their full name. But first, show a generic Welcome label.
            self.welcomeLabel.text =[NSString stringWithFormat:NSLocalizedString(@"Welcome\n ", nil)];
            CMVAppDelegate *appDelegate=(CMVAppDelegate *)[UIApplication sharedApplication].delegate;
            if (appDelegate.appOpen) {
                [self updateProfile];
            } else {

            NSDictionary* parameters = @{@"fields": @"id, name, email, location "};
            // Create Facebook Request for user's details
            FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters];
            [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                // This is an asynchronous method. When Facebook responds, if there are no errors, we'll update the Welcome label.
                if (!error) {
                    // Parse the data received
                    NSDictionary *userData = (NSDictionary *)result;
                    
                    NSString *facebookID = userData[@"id"];
                    
                    NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
                    
                    
                    NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:5];
                    
                    if (facebookID) {
                        userProfile[@"facebookId"] = facebookID;
                    }
                    
                    if (userData[@"name"]) {
                        userProfile[@"name"] = userData[@"name"];
                    }
                    
                    
                    if (userData[@"location"]) {
                        userProfile[@"location"] = userData[@"location"];
                    }
                    
                    if (userData[@"email"]) {
                        userProfile[@"email"] = userData[@"email"];
                    }
                    
                    if ([pictureURL absoluteString]) {
                        userProfile[@"pictureURL"] = [pictureURL absoluteString];
                    }
                    
                    [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
                    [[PFUser currentUser] saveEventually];
                    
                    [self updateProfile];

        
                }
            }];
        }
        
        } else {
            // If user is linked to neither, let's use their username for the Welcome label.
            self.welcomeLabel.text =[NSString stringWithFormat:NSLocalizedString(@"Welcome\n %@", nil), [PFUser currentUser].username];
            
        }
        
    } else {
        self.welcomeLabel.text = NSLocalizedString(@"Not logged in", nil);
    }
    
}

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    if ([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"LOGGING"
                                                              action:@"press"
                                                               label:@"FacebookLogIn"
                                                               value:nil] build]];
        
        
    }
    if ([PFTwitterUtils isLinkedWithUser:[PFUser currentUser]]) {
        
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"LOGGING"
                                                              action:@"press"
                                                               label:@"TwitterLogIn"
                                                               value:nil] build]];
        
        
    }
    [tracker set:kGAIScreenName value:nil];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
//    [[[UIAlertView alloc] initWithTitle:@"Internet connection"
//                                message:@"The Internet connection appears to be offline."
//                               delegate:nil
//                      cancelButtonTitle:@"ok"
//                      otherButtonTitles:nil] show];
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
   [self dismissViewControllerAnimated:YES completion:NULL]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}
- (IBAction)openMenu:(id)sender {
   [self.slidingViewController anchorTopViewToRightAnimated:YES];
}


- (IBAction)logOutButton:(id)sender {
    [self logOutButtonPress:@"LogOutButton"];
     if ([PFUser currentUser]) {
         
         [self.logIn setTitle:@"Log in" forState:UIControlStateNormal];
          [self.view setNeedsLayout];
         [PFUser logOut];
         self.welcomeLabel.text=NSLocalizedString(@"Please Log in or Sign up.", nil);
         self.birthdayLabel.text=@"";
         self.pictureImageView.image=[UIImage imageNamed:@"UserNew.png"];
         self.emailLabel.text=@"";
         self.vip.hidden=YES;
         self.badge.hidden=YES;
     } else {
         [self.logIn setTitle:@"Log in" forState:UIControlStateNormal];
         [self.view setNeedsLayout];
         [self presentLogIn];
     }
    
}
-(void)logOutButtonPress:(NSString *)type{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];

    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"LOGGING"
                                                              action:@"press"
                                                               label:type
                                                               value:nil] build]];
    
    [tracker set:kGAIScreenName value:nil];
}
// Set received values if they are not nil and reload the table
- (void)updateProfile {
    self.vip.hidden=YES;
    self.badge.hidden=YES;
    if ([[PFUser currentUser] objectForKey:@"profile"][@"location"]) {
        self.birthdayLabel.text=[[PFUser currentUser] objectForKey:@"profile"][@"location"][@"name"];
    }

    if ([[PFUser currentUser] objectForKey:@"profile"][@"email"]) {
        self.emailLabel.text=[NSString stringWithFormat:NSLocalizedString(@"Email: %@", nil),[[PFUser currentUser] objectForKey:@"profile"][@"email"]];
    }
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"name"]) {
        //self.headerNameLabel.text = [[PFUser currentUser] objectForKey:@"profile"][@"name"];
        self.welcomeLabel.text =[NSString stringWithFormat:NSLocalizedString(@"Welcome\n %@", nil), [[PFUser currentUser] objectForKey:@"profile"][@"name"]];
        
    }
    
    // Download the user's facebook profile picture
    self.imageData = [[NSMutableData alloc] init]; // the data will be loaded in here
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"pictureURL"]) {
        NSURL *pictureURL = [NSURL URLWithString:[[PFUser currentUser] objectForKey:@"profile"][@"pictureURL"]];
        
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:pictureURL
                                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:2.0f];
        // Run network request asynchronously
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
        if (!urlConnection) {
            NSLog(@"Failed to download picture");
        }
    }
}



#pragma mark - NSURLConnectionDataDelegate

/* Callback delegate methods used for downloading the user's profile picture */

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // As chuncks of the image are received, we build our data file
    [self.imageData appendData:data];

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // All data has been downloaded, now we can set the image in the header image view
    self.pictureImageView.image = [UIImage imageWithData:self.imageData];
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:self.imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // The image has now been uploaded to Parse. Associate it with a new object
            [[PFUser currentUser] setObject:imageFile forKey:@"image"];
            
            [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    NSLog(@"Saved");
                }
                else{
                    // Error
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
    }];
    self.pictureImageView.alpha = 1.0;
    
    // Add a nice corner radius to the image
    //self.pictureImageView.layer.cornerRadius = 8.0f;
    self.pictureImageView.layer.masksToBounds = YES;
    [self.pictureImageView.layer setCornerRadius:(self.pictureImageView.frame.size.height/2)];
    [self.pictureImageView.layer setMasksToBounds:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
    // Set frame for elements
//    if (iPHONE) {
//        if (self.view.bounds.size.height > 480.0f) {
//           self.logIn.frame =CGRectOffset(self.logIn.frame, 0, +55);
//            //
//        } else {
//            
//           self.emailLabel.frame =CGRectOffset(self.emailLabel.frame, 0, -40);
//         //   self.logIn.frame =CGRectOffset(self.logIn.frame, 0, -55);
//            self.birthdayLabel.frame =CGRectOffset(self.birthdayLabel.frame, 0, -40);
//        }
//    } else {
//        
//        
//        
//    }
    
}
@end
