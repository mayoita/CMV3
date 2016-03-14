//
//  CMVServices.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 02/04/14.
//  Copyright (c) 2014 Casinò di Venezia SPA. All rights reserved.
//

#import "CMVServices.h"
#import <Parse/Parse.h>
#import "UIViewController+ECSlidingViewController.h"
#import "CMVAppDelegate.h"
#import "CMVBusTime.h"
#import "FBShimmeringView.h"
#import "CMVShimmerLabel.h"
#import "CMVCheckWeekDay.h"
#import "CMVConstants.h"
#import "CMVCloseButton.h"


#import "CMVCellServicesTableViewCell.h"
#define REUSE_ID @"ServicesCell"


@interface CMVServices ()
@property (strong, nonatomic)NSArray *dataSource;
@property (strong, nonatomic)NSString *fromTo;
@property (strong, nonatomic)UIRefreshControl *refreshControl;
@property(strong,nonatomic)NSString *leftColumn;
@property(strong,nonatomic)NSString *rightClomun;
@property(strong,nonatomic)PFQuery *query;
@property (weak, nonatomic) IBOutlet CMVCloseButton *closeButton;


@end

@implementation CMVServices
BOOL VSP = 0;


@synthesize times=_times;

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
    
    [self loadFestivity];
    self.headerView.backgroundColor=[UIColor blackColor];
    self.tableView.backgroundColor=[UIColor blackColor];
    self.closeButton.color=[UIColor whiteColor];
   
    //TODO: Adjust format for label
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    self.refreshControl=refresh;
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    
    [self.tableView addSubview:refresh];
    
    [refresh addTarget:self action:@selector(reloadTableData) forControlEvents:UIControlEventValueChanged];
    

    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.tableView.contentInset = UIEdgeInsetsMake(0., 0., CGRectGetHeight(self.tabBarController.tabBar.frame), 0);
    }
    
    self.everyDay.text=NSLocalizedString(@"EVERYDAY", nil);
    if (iPHONE ) {
        self.everyDay.font=GOTHAM_XLight(20);
        self.fromCaNoghera.text=NSLocalizedString(@"FROM CA' NOGHERA", nil);
        self.fromMestre.font=GOTHAM_BOOK(13);
        self.fromCaNoghera.font=GOTHAM_BOOK(13);
    } else {
        self.everyDay.font=GOTHAM_XLight(30);
        self.fromCaNoghera.text=NSLocalizedString(@"FROM CA' NOGHERA", nil);
        self.fromMestre.font=GOTHAM_BOOK(18);
        self.fromCaNoghera.font=GOTHAM_BOOK(18);
    }
    if (self.tabBarController.selectedIndex == 0) {
        self.fromMestre.text=NSLocalizedString(@"FROM VENEZIA", nil);
       self.fromTo=@"VE";
       
    } else {
        self.fromMestre.text=NSLocalizedString(@"FROM MESTRE", nil);
        self.fromTo=@"ME";
     
    }
    if (iPHONE) {
        [self.tableView registerNib:[UINib nibWithNibName:@"CMVCellServicesTableViewCell" bundle:nil] forCellReuseIdentifier:REUSE_ID];
    } else {
        [self.tableView registerNib:[UINib nibWithNibName:@"CMVCellServicesTableViewCelliPad" bundle:nil] forCellReuseIdentifier:REUSE_ID];
    }
  
}


-(void)viewDidAppear:(BOOL)animated {
    if (self.tabBarController.selectedIndex == 0) {
        self.tabBarController.tabBar.tintColor=BRAND_GREEN_COLOR;
    } else  {
        self.tabBarController.tabBar.tintColor=BRAND_RED_COLOR;
    }
    
    NSString *value=@"";
    if ([CMVDataClass getInstance].location == VENEZIA) {
        value=@"ServicesInfoCN";
    } else {
        value=@"ServicesInfoVE";
    }
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:value];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    [self.tableView reloadData];
}
- (void)reloadTableData {
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

-(void)loadFestivity {
    PFQuery *queryFestivity = [PFQuery queryWithClassName:@"Festivity"];
    [queryFestivity setCachePolicy:kPFCachePolicyNetworkOnly];
    if (![[UIApplication sharedApplication].delegate performSelector:@selector(isParseReachable)]) {
        [queryFestivity setCachePolicy:kPFCachePolicyCacheThenNetwork];
    }
    [queryFestivity getObjectInBackgroundWithId:@"7VTo3n7rum" block:^(PFObject *festivityarray, NSError *error) {
        
        for (id object in festivityarray[@"festivity"]) {
            
            if ([[CMVCheckWeekDay checkWeekDAy][@"day"] intValue] == [object[0] intValue] && [[CMVCheckWeekDay checkWeekDAy][@"month"] intValue] == [object[1] intValue]) {
                VSP=1;
            }
        }
        
        _times=nil;
        [self.tableView reloadData];
    }];
}


-(NSMutableArray *)times {
   
    if (!_times) {
        self.query=nil;
        if (!self.query) {
            if (([[CMVCheckWeekDay checkWeekDAy][@"weekday"] intValue] == 7 || [[CMVCheckWeekDay checkWeekDAy][@"weekday"] intValue] == 6) || VSP) {
                self.query = [PFQuery queryWithClassName:@"ServicesVSP"];
            } else {
                self.query = [PFQuery queryWithClassName:@"Services"];
            }
        }
      
        [self.query setCachePolicy:kPFCachePolicyNetworkOnly];
        if (![[UIApplication sharedApplication].delegate performSelector:@selector(isParseReachable)]) {
            [self.query setCachePolicy:kPFCachePolicyCacheThenNetwork];
        }
        
        [self.query whereKey:@"MEVE" equalTo:self.fromTo];
        [self.query orderByAscending:@"Order"];

        [self.query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                    _times = [NSMutableArray array];
                    [_times addObjectsFromArray:objects];
                    
                    [self.tableView reloadData];
                
            } else {
                
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
    return _times;
}

-(int)stringtoSeconds:(NSString *)stringToConvert {
    NSTimeInterval seconds;
    int hoursBus = [[stringToConvert substringToIndex:2] intValue];
    int minutesBus = [[stringToConvert substringFromIndex:3] intValue];

    seconds = hoursBus * 3600 + minutesBus*60;
 
    return seconds;
}

-(NSDate *)dateWithOutTime:(NSDate *)datDate {
    if( datDate == nil ) {
        datDate = [NSDate date];
    }
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:datDate];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

-(void)isNextBus:(NSString *)hours nextHour:(NSString *)hourBefore inCell:(FBShimmeringView *)cell withCell:(UILabel *)labelTextColor {

    // get current date/time
    NSDate *today = [NSDate date];
    NSDate *todayWithoutTime=[self dateWithOutTime:today];

    int currenttimeInSeconds = (int)[today timeIntervalSinceDate:todayWithoutTime];
    
    int nextBusinSeconds=[self stringtoSeconds:hours];
    int previousBusInSeconds =[self stringtoSeconds:hourBefore];

    CMVShimmerLabel *label= (CMVShimmerLabel*)cell.contentView;
    if (self.tabBarController.selectedIndex == 0) {
        label.textColor=BRAND_GREEN_COLOR;
        
    } else  {
        label.textColor=BRAND_RED_COLOR;
        
    }
    if (nextBusinSeconds < LastBusInSeconds && nextBusinSeconds != 0) {
        nextBusinSeconds=nextBusinSeconds+DayInSeconds;
    }
    if (previousBusInSeconds < LastBusInSeconds && previousBusInSeconds != 0) {
        previousBusInSeconds=previousBusInSeconds+DayInSeconds;

    }
    if (currenttimeInSeconds < LastBusInSeconds) {
        currenttimeInSeconds=currenttimeInSeconds+DayInSeconds;
      
    }
    if (((nextBusinSeconds-currenttimeInSeconds) > 0) && ((previousBusInSeconds-currenttimeInSeconds)< 0)) {

        label.text=[NSString stringWithFormat:NSLocalizedString(@"Leaving %@", nil),[self timeFormatted:nextBusinSeconds-currenttimeInSeconds]];

        cell.hidden=NO;
        cell.shimmering = YES;
        cell.shimmeringSpeed=150.0f;
        cell.shimmeringOpacity=0.7f;
        if (self.tabBarController.selectedIndex == 0) {
           
            labelTextColor.textColor=BRAND_GREEN_COLOR;
           
        } else  {
           
            labelTextColor.textColor=BRAND_RED_COLOR;
         
        }
        
       
    } else {
        label.text=@"";
        cell.hidden=YES;
        labelTextColor.textColor=[UIColor whiteColor];
        
    }
    
}


- (NSString *)timeFormatted:(int)totalSeconds
{
    
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    NSString *timeString =@"";
    NSString *formatString=@"";
    if(hours > 0){
        formatString=hours==1?NSLocalizedString(@"in %d hour",nil):NSLocalizedString(@"in %d hours",nil);
        timeString = [timeString stringByAppendingString:[NSString stringWithFormat:formatString,hours]];
        if(minutes > 0 ){
            formatString=minutes==1?NSLocalizedString(@" %d minute",nil):NSLocalizedString(@" %d minutes",nil);
            timeString = [timeString stringByAppendingString:[NSString stringWithFormat:formatString,minutes]];
        }
    } else if (minutes == 0 && hours == 0 ) {
        timeString = [timeString stringByAppendingString:NSLocalizedString(@" now!", nil)];
    } else {
        formatString=minutes==1?NSLocalizedString(@"in %d minute",nil):NSLocalizedString(@"in %d minutes",nil);
        timeString = [timeString stringByAppendingString:[NSString stringWithFormat:formatString,minutes]];
    }

    return timeString;
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.times count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = REUSE_ID;
    CMVCellServicesTableViewCell *cell = (CMVCellServicesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if ([[CMVCheckWeekDay checkWeekDAy][@"month"] intValue] == 12 && (([[CMVCheckWeekDay checkWeekDAy][@"day"] intValue] == 24) || ([[CMVCheckWeekDay checkWeekDAy][@"day"] intValue] == 25))) {
        cell.leftLabel.text=NSLocalizedString(@"No services today", nil);
        cell.leftLabel.font=GOTHAM_BOOK(12);
        cell.rightLabel.text=NSLocalizedString(@"No services today", nil);
        cell.rightLabel.font=GOTHAM_BOOK(12);
    } else {
    
    PFObject *object=self.times[indexPath.row];
    PFObject *beforeObject;
    if ((indexPath.row - 1) != -1) {
        beforeObject=self.times[indexPath.row - 1];
    }
   
    [self isNextBus:object[@"LeftColumn"] nextHour:beforeObject[@"LeftColumn"]  inCell:cell.leftImage withCell:cell.leftLabel];
    [self isNextBus:object[@"RightColumn"] nextHour:beforeObject[@"RightColumn"] inCell:cell.rightImage withCell:cell.rightLabel];
    
    cell.leftLabel.text=object[@"LeftColumn"];
    cell.rightLabel.text=object[@"RightColumn"] ;
    }

    
    return cell;
}
- (IBAction)closeController:(id)sender {
    [self.presentingViewController
     dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)openMenu:(id)sender {
 [self.slidingViewController anchorTopViewToRightAnimated:YES];
}


@end
