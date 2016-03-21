//
//  Services.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 15/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import "Services.h"

@implementation Services
+ (NSString *)dynamoDBTableName {
    return @"Services";
}

+ (NSString *)hashKeyAttribute {
    return @"id";
}
@end
