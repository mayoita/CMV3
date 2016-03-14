//
//  Tournament.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 11/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import "Tournament.h"
@interface Tournament() 
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation Tournament
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


+ (NSString *)dynamoDBTableName {
    return @"Tournaments";
}

+ (NSString *)hashKeyAttribute {
    return @"TournamentName";
}
+ (NSString *)rangeKeyAttribute {
    return @"StartDate";
}

-(NSDate *)StartDate {
    
    return [self.dateFormatter dateFromString:_StartDate];;
}
-(NSDate *)EndDate {
    
    return [self.dateFormatter dateFromString:_EndDate];;
}

-(NSArray *)TournamentEvent {
    if ([_TournamentEvent isEqualToString:@"NULL"]) {
        
        return [NSArray array];
    } else {
    return [NSJSONSerialization JSONObjectWithData:[_TournamentEvent dataUsingEncoding:NSUTF8StringEncoding]
                                           options:0 error:NULL];
    }
}
-(NSArray *)TournamentsRules {
    if ([_TournamentsRules isEqualToString:@"NULL"]) {
       
        return [NSArray array];
    } else {
    return [NSJSONSerialization JSONObjectWithData:[_TournamentsRules dataUsingEncoding:NSUTF8StringEncoding]
                                           options:0 error:NULL];
    }
}
@end
