//
//  Festivity.h
//  Casinò di Venezia
//
//  Created by Massimo Moro on 11/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import <AWSDynamoDB/AWSDynamoDB.h>

@interface Festivity : AWSDynamoDBObjectModel<AWSDynamoDBModeling>
@property (nonatomic, strong) NSString *festivity;
@end
