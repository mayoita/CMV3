//
//  CMVPushNews.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 25/03/14.
//  Copyright (c) 2014 Casinò di Venezia SPA. All rights reserved.
//

#import "CMVPushNews.h"
#import <Parse/Parse.h>
#import "UIViewController+ECSlidingViewController.h"


@interface CMVPushNews ()
@property (weak, nonatomic) IBOutlet UILabel *mySubLabel;
@property (strong, nonatomic)PFInstallation *myInstallation;
@end

@implementation CMVPushNews
@synthesize myInstallation;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"eventsNews"]) {
        [self.events setOn:[[[NSUserDefaults standardUserDefaults] objectForKey:@"eventsNews"] boolValue] ];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"slotNews"]) {
    [self.slot setOn:[[[NSUserDefaults standardUserDefaults] objectForKey:@"slotNews"] boolValue]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"pokerNews"]) {
    [self.poker setOn:[[[NSUserDefaults standardUserDefaults] objectForKey:@"pokerNews"] boolValue]];
    }
    
    myInstallation = [PFInstallation currentInstallation];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Subscriptions"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
}

-(void)shareButtonPress:(NSString *)type{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    //[tracker set:kGAIScreenName value:@"Stopwatch"];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"NOTIFICATIONS"
                                                              action:@"press"
                                                               label:type
                                                               value:nil] build]];
    
    [tracker set:kGAIScreenName value:nil];
}

- (IBAction)events:(id)sender {
    if (self.events.on) {
        [self shareButtonPress:@"YesEvents"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:YES forKey:@"eventsNews"];
        [userDefaults synchronize];
        [myInstallation addUniqueObject:@"Events" forKey:@"channels"];
        [myInstallation saveEventually];
    } else {
        [self shareButtonPress:@"NoEvents"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:NO forKey:@"eventsNews"];
        [userDefaults synchronize];
        [myInstallation removeObject:@"Events" forKey:@"channels"];
        [myInstallation saveEventually];
    }
   
}
- (IBAction)slot:(id)sender {
    if (self.slot.on) {
        [self shareButtonPress:@"YesSlots"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:YES forKey:@"slotNews"];
        [userDefaults synchronize];
        NSLog(@"Bool: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"slotNews"]);
        [myInstallation addUniqueObject:@"Slots" forKey:@"channels"];
        [myInstallation saveEventually];
    } else {
        [self shareButtonPress:@"NoSlots"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:NO forKey:@"slotNews"];
        [userDefaults synchronize];
        NSLog(@"Bool: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"slotNews"]);
        [myInstallation removeObject:@"Slots" forKey:@"channels"];
        [myInstallation saveEventually];
    }
}
- (IBAction)poker:(id)sender {
    if (self.poker.on) {
        [self shareButtonPress:@"YesPoker"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:YES forKey:@"pokerNews"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [myInstallation addUniqueObject:@"Poker" forKey:@"channels"];
        [myInstallation saveEventually];
    } else {
        [self shareButtonPress:@"NoPoker"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:NO forKey:@"pokerNews"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [myInstallation removeObject:@"Poker" forKey:@"channels"];
        [myInstallation saveEventually];
    }
}

- (IBAction)openMenu:(id)sender {
   [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (iPHONE) {
        
      
        UIImage *myGradient = [UIImage imageNamed:@"LogInColorPattern"];
       
        self.mySubLabel.textColor   = [UIColor colorWithPatternImage:myGradient];
    } else {
       
        UIImage *myGradient = [UIImage imageNamed:@"LogInColorPattern35"];
        self.mySubLabel.textColor   = [UIColor colorWithPatternImage:myGradient];
    }
    
}
@end
