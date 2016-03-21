//
//  Radius.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 15/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import "Radius.h"

@implementation Radius
+ (NSString *)dynamoDBTableName {
    return @"Radius";
}

+ (NSString *)hashKeyAttribute {
    return @"id";
}
@end
