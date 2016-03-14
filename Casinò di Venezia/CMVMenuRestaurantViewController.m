//
//  CMVMenuRestaurantViewController.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 25/03/14.
//  Copyright (c) 2014 Casinò di Venezia SPA. All rights reserved.
//

#import "CMVMenuRestaurantViewController.h"
#import <Parse/Parse.h>
#import "CMVAppDelegate.h"
#import "CMVCloseButton.h"

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
    PFQuery *query = [PFQuery queryWithClassName:@"Menu"];
    [query setCachePolicy:kPFCachePolicyNetworkOnly];
    if (![[UIApplication sharedApplication].delegate performSelector:@selector(isParseReachable)]) {
        [query setCachePolicy:kPFCachePolicyCacheThenNetwork];
    }
    if (self.office == 0) {
        self.rowId = @"25WSnGlEDW";
    } else {
        self.rowId = @"k5xjqXyLe7";
    }
    [query getObjectInBackgroundWithId:self.rowId block:^(PFObject *menu, NSError *error) {
        if (!error) {
        
        if (![menu[@"Chief"] isEqualToString:@""]) {
            self.chiefName.hidden=NO;
            self.chiefName.text=[@"CHEF " stringByAppendingString:menu[@"Chief"]];
        }
        
        if (menu[@"StartDate"]) {
            self.fromTo.hidden=NO;
            NSString *from= NSLocalizedString(@"FROM ", @"Menu context (add one space)");
            NSString *to= NSLocalizedString(@" TO ", @"Menu context(add one space before and one after");
            
            NSDateFormatter *dateStartFormat = [[NSDateFormatter alloc] init];
            [dateStartFormat setDateFormat:@"d"];
            NSString *dateString = [dateStartFormat stringFromDate:menu[@"StartDate"]];
            
            NSDateFormatter *dateEndFormat = [[NSDateFormatter alloc] init];
            [dateEndFormat setDateFormat:@"dd MMM yyyy"];
            NSString *dateEndString = [dateEndFormat stringFromDate:menu[@"EndDate"]].uppercaseString;
            
            NSString *toEnd=[to stringByAppendingString:dateEndString];
            NSString *fromStart=[from stringByAppendingString:dateString];
            
            NSString *fromto=[fromStart stringByAppendingString:toEnd];
            self.fromTo.text=fromto;
        }
        
        PFFile *imageFile=menu[@"ImageChief"];
        if (([imageFile isKindOfClass:[NSNull class]]) || (imageFile == nil)) {
            
            
        } else {
            [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                self.chiefImage.image=[UIImage imageWithData:data];
            }    ];
        }
        }
        
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
    PFQuery *query = [PFQuery queryWithClassName:@"Menu"];
    [query setCachePolicy:kPFCachePolicyNetworkOnly];
    if (![[UIApplication sharedApplication].delegate performSelector:@selector(isParseReachable)]) {
        [query setCachePolicy:kPFCachePolicyCacheThenNetwork];
    }
    [query getObjectInBackgroundWithId:self.rowId block:^(PFObject *menu, NSError *error) {
        
        switch (row) {
            case 0: {
                slidingMenuCell.dataMenu=menu[@"Starters"];
                slidingMenuCell.textLabel.text = @"Starters";
                slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"paper_texture_05"];
                
            }
                break;
            case 1: {
                slidingMenuCell.dataMenu=menu[@"FirstCourse"];
                slidingMenuCell.textLabel.text = @"First Course";
                slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"paper_texture_05"];
                
            }
                break;
            case 2: {
                slidingMenuCell.dataMenu=menu[@"SecondCourse"];
                slidingMenuCell.textLabel.text = @"Second Course";
               
                slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"paper_texture_05"];
            }
                break;
            case 3: {
                slidingMenuCell.dataMenu=menu[@"Dessert"];
                slidingMenuCell.textLabel.text = @"Dessert";
             
                slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"paper_texture_05"];
            }
                break;
                
            default:
                break;
        }
        [slidingMenuCell.menuTableView reloadData];
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
