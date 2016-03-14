//
//  Festivity.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 11/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import "Festivity.h"

@implementation Festivity
+ (NSString *)dynamoDBTableName {
    return @"Festivity";
}

+ (NSString *)hashKeyAttribute {
    return @"id";
}
-(NSArray *)festivity {
    if ([_festivity isEqualToString:@"NULL"]) {
        
        return [NSArray array];
    } else {
        return [NSJSONSerialization JSONObjectWithData:[_festivity dataUsingEncoding:NSUTF8StringEncoding]
                                               options:0 error:NULL];
    }
}
@end
