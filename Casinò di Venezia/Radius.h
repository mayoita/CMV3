//
//  Radius.h
//  Casinò di Venezia
//
//  Created by Massimo Moro on 15/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import <AWSDynamoDB/AWSDynamoDB.h>

@interface Radius : AWSDynamoDBObjectModel<AWSDynamoDBModeling>
@property (nonatomic) int radius;

@end
