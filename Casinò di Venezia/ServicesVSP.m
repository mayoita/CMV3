//
//  ServicesVSP.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 15/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import "ServicesVSP.h"

@implementation ServicesVSP
+ (NSString *)dynamoDBTableName {
    return @"ServicesVSP";
}

+ (NSString *)hashKeyAttribute {
    return @"id";
}
@end
