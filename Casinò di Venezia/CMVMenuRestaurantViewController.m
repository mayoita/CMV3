//
//  CMVMenuRestaurantViewController.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 25/03/14.
//  Copyright (c) 2014 Casinò di Venezia SPA. All rights reserved.
//

#import "CMVMenuRestaurantViewController.h"
#import "CMVAppDelegate.h"
#import "CMVCloseButton.h"
#import "Menu.h"
#import <AWSS3/AWSS3.h>
#import "AWSConfiguration.h"

@interface CMVMenuRestaurantViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet CMVCloseButton *closeButton;
@property(strong,nonatomic)NSString *rowId;
@end

@implementation CMVMenuRestaurantViewController

static NSString *RPSlidingCellIdentifier = @"RPSlidingCellIdentifier";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.collectionView.collectionViewLayout = [[RPSlidingMenuLayout alloc] init];
    self.chiefName.hidden=YES;
    self.fromTo.hidden=YES;
    self.closeButton.color = [UIColor whiteColor];

    
    [self.collectionView registerClass:[RPSlidingMenuCell class] forCellWithReuseIdentifier:RPSlidingCellIdentifier];
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_texture_05"]];
 
    if (self.office == 0) {
        self.rowId = @"1";
    } else {
        self.rowId = @"2";
    }
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    
    [[dynamoDBObjectMapper load:[Menu class] hashKey:self.rowId rangeKey:nil]
     continueWithBlock:^id(AWSTask *task) {
         if (task.error) {
             NSLog(@"The request failed. Error: [%@]", task.error);
         }
         if (task.exception) {
             NSLog(@"The request failed. Exception: [%@]", task.exception);
         }
         if (task.result) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 Menu *menu = task.result;
                 if (![menu.Chief isEqualToString:@"NULL"]) {
                     self.chiefName.hidden=NO;
                     self.chiefName.text=[@"CHEF " stringByAppendingString:menu.Chief];
                 }
                 
                 if (menu.StartDate) {
                     self.fromTo.hidden=NO;
                     NSString *from= NSLocalizedString(@"FROM ", @"Menu context (add one space)");
                     NSString *to= NSLocalizedString(@" TO ", @"Menu context(add one space before and one after");
                     
                     NSDateFormatter *dateStartFormat = [[NSDateFormatter alloc] init];
                     [dateStartFormat setDateFormat:@"d"];
                     NSString *dateString = [dateStartFormat stringFromDate:menu.StartDate];
                     
                     NSDateFormatter *dateEndFormat = [[NSDateFormatter alloc] init];
                     [dateEndFormat setDateFormat:@"dd MMM yyyy"];
                     NSString *dateEndString = [dateEndFormat stringFromDate:menu.EndDate].uppercaseString;
                     
                     NSString *toEnd=[to stringByAppendingString:dateEndString];
                     NSString *fromStart=[from stringByAppendingString:dateString];
                     
                     NSString *fromto=[fromStart stringByAppendingString:toEnd];
                     self.fromTo.text=fromto;
                 }
                 
                 if ([menu.ImageChief isEqualToString:@"NULL"]) {
                     
                     //aa
                 } else {
                     AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
                     AWSS3TransferManagerDownloadRequest *downloadRequest = [AWSS3TransferManagerDownloadRequest new];
                     
                     NSString *downloadingFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:menu.ImageChief ];
                     NSURL *downloadingFileURL = [NSURL fileURLWithPath:downloadingFilePath];
                     downloadRequest.bucket = S3BucketName;
                     downloadRequest.key = menu.ImageChief ;
                     
                     downloadRequest.downloadingFileURL = downloadingFileURL;
                     if ([UIImage imageWithContentsOfFile:downloadingFilePath] == nil) {
                         // Download the file.
                         [[transferManager download:downloadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor]
                                                                                withBlock:^id(AWSTask *task) {
                                                                                    if (task.error){
                                                                                        if ([task.error.domain isEqualToString:AWSS3TransferManagerErrorDomain]) {
                                                                                            switch (task.error.code) {
                                                                                                case AWSS3TransferManagerErrorCancelled:
                                                                                                case AWSS3TransferManagerErrorPaused:
                                                                                                    break;
                                                                                                    
                                                                                                default:
                                                                                                    NSLog(@"Error: %@", task.error);
                                                                                                    break;
                                                                                            }
                                                                                        } else {
                                                                                            // Unknown error.
                                                                                            NSLog(@"Error: %@", task.error);
                                                                                        }
                                                                                    }
                                                                                    
                                                                                    if (task.result) {
                                                                                        
                                                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                                            self.chiefImage.image=[UIImage imageWithContentsOfFile:downloadingFilePath];
                                                                                        });
                                                                                        
                                                                                    }
                                                                                    return nil;
                                                                                }];
                     } else {
                         self.chiefImage.image=[UIImage imageWithContentsOfFile:downloadingFilePath];
                     }
                     
                 }
             });
             
         }
         return nil;
     }];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString *value=@"";
    if ([CMVDataClass getInstance].location == VENEZIA) {
        value=@"RestaurantMenuCN";
    } else {
        value=@"RestaurantMenuVE";
    }
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:value];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark RPSlidingMenu

-(NSInteger)numberOfItemsInSlidingMenu{
    
    return 4;
    
}

- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row{
    // alternate for demo.  Simply set the properties of the passed in cell
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    
    [[dynamoDBObjectMapper load:[Menu class] hashKey:self.rowId rangeKey:nil]
     continueWithBlock:^id(AWSTask *task) {
         if (task.error) {
             NSLog(@"The request failed. Error: [%@]", task.error);
         }
         if (task.exception) {
             NSLog(@"The request failed. Exception: [%@]", task.exception);
         }
         if (task.result) {
              dispatch_async(dispatch_get_main_queue(), ^{
             Menu *menu = task.result;
             switch (row) {
                 case 0: {
                     slidingMenuCell.dataMenu=menu.Starters;
                     slidingMenuCell.textLabel.text = @"Starters";
                     slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"paper_texture_05"];
                     
                 }
                     break;
                 case 1: {
                     slidingMenuCell.dataMenu=menu.FirstCourse;
                     slidingMenuCell.textLabel.text = @"First Course";
                     slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"paper_texture_05"];
                     
                 }
                     break;
                 case 2: {
                     slidingMenuCell.dataMenu=menu.SecondCourse;
                     slidingMenuCell.textLabel.text = @"Second Course";
                     
                     slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"paper_texture_05"];
                 }
                     break;
                 case 3: {
                     slidingMenuCell.dataMenu=menu.Dessert;
                     slidingMenuCell.textLabel.text = @"Dessert";
                     
                     slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"paper_texture_05"];
                 }
                     break;
                     
                 default:
                     break;
             }
             [slidingMenuCell.menuTableView reloadData];
                  });
         }
         return nil;
     }];

    
}

- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row{
    // when a row is tapped do some action
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row Tapped"
                                                    message:[NSString stringWithFormat:@"Row %ld tapped.", (long)row]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self numberOfItemsInSlidingMenu];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    RPSlidingMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RPSlidingCellIdentifier forIndexPath:indexPath];
    [self customizeCell:cell forRow:indexPath.row];
    return cell;
}




@end
