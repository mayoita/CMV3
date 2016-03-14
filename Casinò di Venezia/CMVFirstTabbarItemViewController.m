//
//  CMVFirstTabbarItemViewController.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 18/12/13.
//  Copyright (c) 2013 Casinò di Venezia SPA. All rights reserved.
//

#import "CMVFirstTabbarItemViewController.h"


#import "CMVLocker.h"
#import "CMVAppDelegate.h"
#import "CMVSetUpCurrency.h"
#import "DVOMarqueeView.h"
#import "CMVGradientForNews.h"
#import "CMVLocalize.h"
#import "CRMotionView.h"
#import "CMVCheckWeekDay.h"
#import "CMVArrowChat.h"
#import "GAIDictionaryBuilder.h"
#import "KGModal.h"
#import <AWSDynamoDB/AWSDynamoDB.h>
#import "Jackpot.h"
#import "EventAds.h"
#import "Festivity.h"
#import "News.h"


#import <Parse/Parse.h>
#import "UIViewController+ECSlidingViewController.h"

#define VE 0
#define CN 1

@interface CMVFirstTabbarItemViewController () {
    DVOMarqueeView *labelMarquee;
    
}
@property (strong, nonatomic) UIImageView *myAds;
@property (weak, nonatomic) IBOutlet UILabel *chatWithUs;
@property (weak, nonatomic) IBOutlet CMVArrowChat *arrowChat;

@property (weak, nonatomic) IBOutlet UILabel *jackpot;

@property (weak, nonatomic) IBOutlet UILabel *labelJackpot;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;


@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (strong,nonatomic)CRMotionView *myMotionView;

@property (weak, nonatomic) IBOutlet UIImageView *homeLike;

@property (weak, nonatomic) IBOutlet UIImageView *arrowLike;



@property(strong,nonatomic)UILabel *labelMarqueeText;
@property(strong,nonatomic)DVOMarqueeView *labelMarquee;


@property(strong,nonatomic)UIButton *lockerButton;
@property (nonatomic,strong)CMVDataClass *site;


@property(strong,nonatomic)CMVSetUpCurrency *checkCurrency;

@end

@implementation CMVFirstTabbarItemViewController
@synthesize labelMarquee;
int Office;
BOOL VSP2 = 0;
Festivity *storageFestivity;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadStorageFestivity];

    [self setOffHelper];
    self.chatWithUs.layer.cornerRadius = 4.0;
    self.chatWithUs.layer.masksToBounds = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [self.homeLike setUserInteractionEnabled:YES];
    [self.homeLike addGestureRecognizer:singleTap];

    //CRMotion
//    CRMotionView *motionView = [[CRMotionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    self.myMotionView=motionView;
    
//    [motionView setImage:[UIImage imageNamed:@"HomeBackgroundVenezia.png"]];
//    [self.view insertSubview:motionView atIndex:1];
    
    
    self.site=[CMVDataClass getInstance];
 
    
    UIImage *myGradient = [UIImage imageNamed:@"JackpotColorPattern"];
    self.labelJackpot.textColor   = [UIColor colorWithPatternImage:myGradient];

    //Init currency rates
    
    self.checkCurrency=[[CMVSetUpCurrency alloc] init];
    [self.checkCurrency exchangeRates];
    
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
  
    [[dynamoDBObjectMapper load:[Jackpot class] hashKey:@"1" rangeKey:nil]
     continueWithBlock:^id(AWSTask *task) {
         if (task.error) {
             NSLog(@"The request failed. Error: [%@]", task.error);
         }
         if (task.exception) {
             NSLog(@"The request failed. Exception: [%@]", task.exception);
         }
         if (task.result) {
             
             Jackpot *item = task.result;
             self.jackpot.text=[NSString stringWithFormat:@"%@ €", item.jackpot];
         }
         return nil;
     }];
   

    
    self.mainTabBarController = (CMVMainTabbarController *)self.tabBarController;
    [self.mainTabBarController setCenterButtonDelegate:self];
//    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
//        [self addLabelMarquee];
//    }
    [KGModal sharedInstance].closeButtonType = KGModalCloseButtonTypeLeft;
    [self showAds];
    
}

-(void)showAds {
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    
    [[dynamoDBObjectMapper load:[EventAds class] hashKey:@"1" rangeKey:nil]
     continueWithBlock:^id(AWSTask *task) {
         if (task.error) {
             NSLog(@"The request failed. Error: [%@]", task.error);
         }
         if (task.exception) {
             NSLog(@"The request failed. Exception: [%@]", task.exception);
         }
         if (task.result) {
             
             EventAds *item = task.result;
             BOOL visible = item.visible;
             if (visible) {
                  UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 430)];
                 self.myAds = [[UIImageView alloc] initWithFrame:contentView.bounds];
                 self.myAds.backgroundColor = [UIColor whiteColor];
                 item.imageView= self.myAds;
                 self.myAds.image = item.image;
                 [contentView addSubview:self.myAds];
                [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];
             }
         }
         return nil;
    }];
 
}


-(void)setOffHelper {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if ([userDefaults objectForKey:@"helper"]) {
       
        if ((int)[[NSUserDefaults standardUserDefaults] integerForKey:@"helper"] < 5) {
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay  fromDate:[NSDate date]];
            NSInteger day = [components day];
            if ([userDefaults integerForKey:@"today"] == day) {
                self.chatWithUs.hidden = YES;
                self.arrowChat.hidden = YES;
                self.homeLike.hidden = YES;
                self.arrowLike.hidden = YES;
            } else {
                self.chatWithUs.hidden = NO;
                self.arrowChat.hidden = NO;
                self.homeLike.hidden = NO;
                self.arrowLike.hidden = NO;
                
            }
        } else {
         //   if ([userDefaults objectForKey:@"today"] == [NSDate date]) {
          
                self.chatWithUs.hidden = YES;
                self.arrowChat.hidden = YES;
                self.homeLike.hidden = YES;
                self.arrowLike.hidden = YES;
          //  }
           
        }

        [userDefaults synchronize];
    } else {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay  fromDate:[NSDate date]];
        NSInteger day = [components day];
      
        [userDefaults setInteger:0 forKey:@"helper"];
        [userDefaults setInteger:day forKey:@"today"];
        [userDefaults synchronize];
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
     //[self refreshLabelMarquee];
    [self animateChat];
    [self animateLike];
    
    NSString *value=@"";
    if ([CMVDataClass getInstance].location == VENEZIA) {
        value=@"HomeCN";
    } else {
        value=@"HomeVE";
    }
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:value];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    [self.mainTabBarController setCenterButtonDelegate:self];
    [self setOffice];
}

-(void)animateChat {
    //Animation
    [UIView animateWithDuration:3.5 delay:0 usingSpringWithDamping:0.05 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^(void) {
  
        self.chatWithUs.center=CGPointMake(self.chatWithUs.center.x, self.chatWithUs.center.y - 5);
        self.arrowChat.center=CGPointMake(self.arrowChat.center.x, self.arrowChat.center.y - 5);
    }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:1.0 animations:^(void) {
                             self.chatWithUs.alpha = 0.0;
                         }
                          ];
                         [UIView animateWithDuration:1.0 animations:^(void) {
                             self.arrowChat.alpha = 0.0;
                         }
                          ];
                         
                     }];
}

-(void)animateLike {
    [UIView animateWithDuration:4 delay:0 usingSpringWithDamping:0.05 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^(void) {
        

        self.arrowLike.center=CGPointMake(self.arrowLike.center.x - 5, self.arrowLike.center.y);
    }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:1.0 animations:^(void) {
                             self.homeLike.alpha = 0.0;
                         }
                          ];
                         [UIView animateWithDuration:1.0 animations:^(void) {
                             self.arrowLike.alpha = 0.0;
                         }
                          ];
                         
                     }];
    
}

-(void)loadFestivity:(NSString *)todayOpen andVSP:(NSString *)vsp{

    for (id object in storageFestivity) {
        
        if ([[CMVCheckWeekDay checkWeekDAy][@"day"] intValue] == [object[0] intValue] && [[CMVCheckWeekDay checkWeekDAy][@"month"] intValue] == [object[1] intValue]) {
            VSP2=1;
        }
    }
    
    [self checkWeekDAy:todayOpen andVSP:vsp];
}

-(void)loadStorageFestivity {
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    
    [[dynamoDBObjectMapper load:[Festivity class] hashKey:@"1" rangeKey:nil]
     continueWithBlock:^id(AWSTask *task) {
         if (task.error) {
             NSLog(@"The request failed. Error: [%@]", task.error);
         }
         if (task.exception) {
             NSLog(@"The request failed. Exception: [%@]", task.exception);
         }
         if (task.result) {
             
             Festivity *item = task.result;
             storageFestivity = item.festivity;
         }
         return nil;
     }];
    
    
}

-(void)checkWeekDAy:(NSString *)todayOpen andVSP:(NSString *)vsp{

    if ([[CMVCheckWeekDay checkWeekDAy][@"month"] intValue] == 12 && (([[CMVCheckWeekDay checkWeekDAy][@"day"] intValue] == 24) || ([[CMVCheckWeekDay checkWeekDAy][@"day"] intValue] == 25))) {
        self.today.text=NSLocalizedString(@"Today is closed", @"");
    } else {
    if (([[CMVCheckWeekDay checkWeekDAy][@"weekday"] intValue] == 7) || VSP2) {
        self.today.text=todayOpen;
    } else {
        self.today.text=vsp;
    }
    }
}



- (void)addLabelMarquee
{

         self.labelMarqueeText=[UILabel new];

    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    
    [[dynamoDBObjectMapper load:[News class] hashKey:@"1" rangeKey:nil]
     continueWithBlock:^id(AWSTask *task) {
         if (task.error) {
             NSLog(@"The request failed. Error: [%@]", task.error);
         }
         if (task.exception) {
             NSLog(@"The request failed. Exception: [%@]", task.exception);
         }
         if (task.result) {
             
             News *item = task.result;
             switch ([CMVLocalize myDeviceLocaleIs]) {
                 case IT :
                     self.labelMarqueeText.text=item.NewsIT;
                     break;
                 case DE :
                     self.labelMarqueeText.text=item.NewsDE;
                     break;
                 case FR :
                     self.labelMarqueeText.text=item.NewsFR;
                     break;
                 case ES :
                     self.labelMarqueeText.text=item.NewsES;
                     break;
                 case RU  :
                     self.labelMarqueeText.text=item.NewsRU;
                     break;
                 case ZH:
                     self.labelMarqueeText.text=item.NewsZH;
                     break;
                     
                 default:
                     self.labelMarqueeText.text=item.News;
                     break;
             }
             
             self.labelMarqueeText.textColor=[UIColor whiteColor];
             [ self.labelMarqueeText sizeToFit];
             
             labelMarquee = [[DVOMarqueeView alloc] initWithFrame:CGRectMake(0, self.tabBarController.tabBar.frame.origin.y -35, CGRectGetWidth(self.view.bounds), 30)];
             labelMarquee.viewToScroll =  self.labelMarqueeText;
             CMVGradientForNews *gradient=[[CMVGradientForNews alloc] initWithFrame:CGRectMake(0, self.tabBarController.tabBar.frame.origin.y -35, CGRectGetWidth(self.view.bounds), 30)];
             self.labelMarquee=labelMarquee;
             [self.view addSubview:labelMarquee];
             [self.view addSubview:gradient];
             
             [labelMarquee beginScrolling];
         }
         return nil;
     }];
    

    
}

-(void)refreshLabelMarquee {
    self.labelMarqueeText.text=@"";
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    
    [[dynamoDBObjectMapper load:[News class] hashKey:@"1" rangeKey:nil]
     continueWithBlock:^id(AWSTask *task) {
         if (task.error) {
             NSLog(@"The request failed. Error: [%@]", task.error);
         }
         if (task.exception) {
             NSLog(@"The request failed. Exception: [%@]", task.exception);
         }
         if (task.result) {
             
             News *item = task.result;
             switch ([CMVLocalize myDeviceLocaleIs]) {
                 case IT :
                     self.labelMarqueeText.text=item.NewsIT;
                     break;
                 case DE :
                     self.labelMarqueeText.text=item.NewsDE;
                     break;
                 case FR :
                     self.labelMarqueeText.text=item.NewsFR;
                     break;
                 case ES :
                     self.labelMarqueeText.text=item.NewsES;
                     break;
                 case RU  :
                     self.labelMarqueeText.text=item.NewsRU;
                     break;
                 case ZH:
                     self.labelMarqueeText.text=item.NewsZH;
                     break;
                     
                 default:
                     self.labelMarqueeText.text=item.News;
                     break;
             }
             
             [self.labelMarqueeText sizeToFit];
             self.labelMarquee.viewToScroll =  self.labelMarqueeText;
         }
         return nil;
     }];
    
}



- (IBAction)openHelp:(id)sender {
    [self infoButtonPress:@"HelpSfhift"];
    
   [[Helpshift sharedInstance] showConversation:self withOptions:nil];
    //[[Helpshift sharedInstance] showFAQs:self
                       //      withOptions:@{@"enableContactUs":@"ALWAYS"}];
    
}

-(void)infoButtonPress:(NSString *)type{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"INFORMATION"
                                                              action:@"press"
                                                               label:type
                                                               value:nil] build]];
    [tracker set:kGAIScreenName value:nil];
}

#pragma mark - Center button delegate
-(void)centerButtonAction:(UIButton *)sender {
    
    [self setOffice];
    
}

-(void)setOffice {
    if (self.site.location == VENEZIA) {
        Office=CN;
      // [self.mymotionView setImage:[UIImage imageNamed:@"LandingCN.png"]];
        [self.backgroundImage setImage:[UIImage imageNamed:@"HomeBackgroundCaNoghera.png"]];
        self.vendraminNoghera.text=@"CA' NOGHERA";
        self.tabBarController.tabBar.tintColor=BRAND_GREEN_COLOR;
        [self loadFestivity:NSLocalizedString(@"Today open 11:00 am - 03:45 am", nil) andVSP:NSLocalizedString(@"Today open 11:00 am - 03:15 am",nil)];
    } else {
        Office=VE;
     // [self.mymotionView setImage:[UIImage imageNamed:@"LandingVE.jpg"]];
        [self.backgroundImage setImage:[UIImage imageNamed:@"HomeBackgroundVenezia.png"]];
        self.vendraminNoghera.text=@"CA' VENDRAMIN CALERGI";
        self.tabBarController.tabBar.tintColor=BRAND_RED_COLOR;
        [self loadFestivity:NSLocalizedString(@"Today open 11.00 am - 03.15 am",nil) andVSP:NSLocalizedString(@"Today open 11:00 am - 02:45 am",nil)];
    }
}

- (IBAction)openMenu:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

-(void)tapDetected{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

@end
