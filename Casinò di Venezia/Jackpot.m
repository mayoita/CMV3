//
//  Jackpot.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 11/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import "Jackpot.h"

@implementation Jackpot
+ (NSString *)dynamoDBTableName {
    return @"Jackpot";
}

+ (NSString *)hashKeyAttribute {
    return @"id";
}

@end
