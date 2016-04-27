//
//  CMVLogInViewController.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 11/02/14.
//  Copyright (c) 2014 Casinò di Venezia SPA. All rights reserved.
//

#import "CMVLogInViewController.h"

#import "UIViewController+ECSlidingViewController.h"
#import "CMVGreenButton.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "CMVAppDelegate.h"
#import "AWSIdentityManager.h"
#import <AWSCognito/AWSCognito.h>


@interface CMVLogInViewController ()

@property (weak, nonatomic) IBOutlet CMVGreenButton *logIn;
@end
NSString *myName;
AWSIdentityManager *identityManager;
@implementation CMVLogInViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    identityManager = [AWSIdentityManager sharedInstance];
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
}

-(void)presentLogIn {
        UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"SignIn"
                                                                  bundle:nil];
        UIViewController *loginController = [loginStoryboard instantiateViewControllerWithIdentifier:@"SignIn"];
        
    
        [self presentViewController:loginController animated:YES completion:NULL];
  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"LogIn"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    
    if (identityManager.userName) {
        AWSCognito *syncClient = [AWSCognito defaultCognito];
        AWSCognitoDataset *dataset = [syncClient openOrCreateDataset:@"myDataset"];
        self.welcomeLabel.text =[NSString stringWithFormat:NSLocalizedString(@"Welcome\n %@", nil), identityManager.userName];
        if ([dataset stringForKey:@"location"]) {
            self.birthdayLabel.text =[dataset stringForKey:@"location"];
        } else {
            self.birthdayLabel.text = identityManager.userLocation;
            [dataset setString:identityManager.userLocation forKey:@"location"];
        }
        if ([dataset stringForKey:@"email"]) {
            self.emailLabel.text =[dataset stringForKey:@"email"];
        } else {
            self.emailLabel.text = identityManager.userEmail;
            [dataset setString:identityManager.userEmail forKey:@"email"];
        }
        
        [self.logIn setTitle:@"Log out" forState:UIControlStateNormal];
        
        // Create a record in a dataset and synchronize with the server

        [[dataset synchronize] continueWithBlock:^id(AWSTask *task) {
            // Your handler code here
            return nil;
        }];
    } else {
        self.welcomeLabel.text = NSLocalizedString(@"GUEST USER", @"Placeholder text for the guest user.");
    }
   
    NSURL *imageUrl = identityManager.imageURL;
    
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *profileImage = [UIImage imageWithData:imageData];
    if (profileImage) {
        self.pictureImageView.image = profileImage;
    } else {
        self.pictureImageView.image = [UIImage imageNamed:@"UserNew.png"];
    }
    
}


- (IBAction)openMenu:(id)sender {
   [self.slidingViewController anchorTopViewToRightAnimated:YES];
}


- (IBAction)logOutButton:(id)sender {
    [self logOutButtonPress:@"LogOutButton"];
    if ([[AWSIdentityManager sharedInstance] isLoggedIn]) {
        [[AWSIdentityManager sharedInstance] logoutWithCompletionHandler:^(id result, NSError *error) {
            [self.logIn setTitle:@"Log in" forState:UIControlStateNormal];
            [self.view setNeedsLayout];
            self.welcomeLabel.text = NSLocalizedString(@"GUEST USER", @"Placeholder text for the guest user.");
            self.birthdayLabel.text = @"";
            self.pictureImageView.image=[UIImage imageNamed:@"UserNew.png"];
            self.emailLabel.text=@"";
            self.vip.hidden=YES;
            self.badge.hidden=YES;
        }];

    } else {
        [self.logIn setTitle:@"Log out" forState:UIControlStateNormal];
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





@end
