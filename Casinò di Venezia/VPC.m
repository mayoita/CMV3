//
//  VPC.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 15/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import "VPC.h"

@implementation VPC
+ (NSString *)dynamoDBTableName {
    return @"VPC";
}

+ (NSString *)hashKeyAttribute {
    return @"id";
}
@end
