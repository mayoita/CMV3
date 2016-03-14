//
//  CMVSharedClass.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 18/02/14.
//  Copyright (c) 2014 Casinò di Venezia SPA. All rights reserved.
//

#import "CMVSharedClass.h"
#import <AWSDynamoDB/AWSDynamoDB.h>
#import "CMVAppDelegate.h"
#import "Events.h"
@implementation CMVSharedClass




-(NSMutableArray *)retrieveSlotsEvents:(NSString *)className eventType:(int)eventChar carousel:(iCarousel *) myCaraousel{
    NSMutableArray *allObjects = [NSMutableArray array];
    NSArray *eventStrings = [CMVSharedClass eventTypeStrings];
    NSString *eventType = eventStrings[eventChar];
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    
    //DynamoScan
    AWSDynamoDBScanExpression *scanExpression = [AWSDynamoDBScanExpression new];
    scanExpression.limit = @20;
    scanExpression.filterExpression = @"eventType = :val";
    scanExpression.expressionAttributeValues = @{@":val":eventType};
    scanExpression.filterExpression = @"isSlotEvents = :val2";
    scanExpression.expressionAttributeValues = @{@":val2":@"true"};
    
    [[dynamoDBObjectMapper scan:[Events class]
                     expression:scanExpression]
     continueWithBlock:^id(AWSTask *task) {
         if (task.error) {
             NSLog(@"The request failed. Error: [%@]", task.error);
         }
         if (task.exception) {
             NSLog(@"The request failed. Exception: [%@]", task.exception);
         }
         if (task.result) {
             AWSDynamoDBPaginatedOutput *paginatedOutput = task.result;
             if ([allObjects count] == 0) {
             for (Events *event in paginatedOutput.items) {
                 
                 [allObjects addObject:event];
                 
             }
             }
             [myCaraousel reloadData];
         }
         return nil;
     }];
    
//    PFQuery *query = [PFQuery queryWithClassName:className];
//    // If no objects are loaded in memory, we look to the cache first to fill the table
//    // and then subsequently do a query against the network. https://parse.com/docs/ios_guide#queries-caching/iOS
//    //BOOL isInCache = [query hasCachedResult];
//    //query.cachePolicy = kPFCachePolicyCacheElseNetwork;
//    [query setCachePolicy:kPFCachePolicyNetworkOnly];
//    if (![[UIApplication sharedApplication].delegate performSelector:@selector(isParseReachable)]) {
//        [query setCachePolicy:kPFCachePolicyCacheThenNetwork];
//    }
//    
//    NSArray *eventStrings = [CMVSharedClass eventTypeStrings];
//    NSString *eventType = eventStrings[eventChar];
//   
//    
//    [query whereKey:@"eventType" containsString:eventType];
//    [query whereKey:@"isSlotsEvents" equalTo:[NSNumber numberWithBool:YES]];
//    [query orderByDescending:@"StartDate"];
//    
//    NSMutableArray *allObjects = [NSMutableArray array];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//
//            if ([allObjects count] == 0) {
//                
//                [allObjects addObjectsFromArray:objects];
//                
//                
//            }
//            [myCaraousel reloadData];
//            
//        } else {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];
    
    return allObjects;
}

+ (NSArray *)eventTypeStrings
{
    return @[@"E",@"A",@"T"];
}

+ (NSArray *)officeTypeString
{
    return @[@"VE",@"CN"];
}
@end
