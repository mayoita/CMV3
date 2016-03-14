//
//  News.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 11/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import "News.h"

@implementation News
+ (NSString *)dynamoDBTableName {
    return @"News";
}

+ (NSString *)hashKeyAttribute {
    return @"id";
}
@end
