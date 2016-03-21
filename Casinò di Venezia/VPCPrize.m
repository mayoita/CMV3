//
//  VPCPrize.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 15/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import "VPCPrize.h"
@interface VPCPrize()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end
@implementation VPCPrize
+ (NSString *)dynamoDBTableName {
    return @"VPCPrize";
}

+ (NSString *)hashKeyAttribute {
    return @"id";
}
-(id)init{
    self = [super init];
    if (self) {
        self.dateFormatter = [NSDateFormatter new];
        self.dateFormatter.dateStyle = kCFDateFormatterShortStyle;
        self.dateFormatter.timeStyle = kCFDateFormatterShortStyle;
        self.dateFormatter.locale = [NSLocale currentLocale];
        [self.dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
        
    }
    return self;
}
-(NSDate *)Date {
    
    return [self.dateFormatter dateFromString:_Date];;
}
@end
