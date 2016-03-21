//
//  Menu.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 15/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import "Menu.h"
#import <AWSS3/AWSS3.h>
#import "AWSConfiguration.h"
@interface Menu() {
    BOOL imUno;
    BOOL imDue;
    BOOL imTre;
}
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end
@implementation Menu
+ (NSString *)dynamoDBTableName {
    return @"Menu";
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
-(NSDate *)StartDate {
    
    return [self.dateFormatter dateFromString:_StartDate];;
}
-(NSDate *)EndDate {
    
    return [self.dateFormatter dateFromString:_EndDate];;
}
-(NSArray *)Starters {
    if ([_Starters isEqualToString:@"NULL"]) {
        
        return [NSArray array];
    } else {
        return [NSJSONSerialization JSONObjectWithData:[_Starters dataUsingEncoding:NSUTF8StringEncoding]
                                               options:0 error:NULL];
    }
}
-(NSArray *)FirstCourse {
    if ([_FirstCourse isEqualToString:@"NULL"]) {
        
        return [NSArray array];
    } else {
        return [NSJSONSerialization JSONObjectWithData:[_FirstCourse dataUsingEncoding:NSUTF8StringEncoding]
                                               options:0 error:NULL];
    }
}
-(NSArray *)SecondCourse {
    if ([_SecondCourse isEqualToString:@"NULL"]) {
        
        return [NSArray array];
    } else {
        return [NSJSONSerialization JSONObjectWithData:[_SecondCourse dataUsingEncoding:NSUTF8StringEncoding]
                                               options:0 error:NULL];
    }
}
-(NSArray *)Dessert {
    if ([_Dessert isEqualToString:@"NULL"]) {
        
        return [NSArray array];
    } else {
        return [NSJSONSerialization JSONObjectWithData:[_Dessert dataUsingEncoding:NSUTF8StringEncoding]
                                               options:0 error:NULL];
    }
}

@end
