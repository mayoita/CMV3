//
//  ServicesVSP.h
//  Casinò di Venezia
//
//  Created by Massimo Moro on 15/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import <AWSDynamoDB/AWSDynamoDB.h>

@interface ServicesVSP : AWSDynamoDBObjectModel<AWSDynamoDBModeling>
@property (nonatomic, strong) NSString *LeftColumn;
@property (nonatomic, strong) NSString *RightColumn;
@property (nonatomic, strong) NSString *MEVE;
@property (nonatomic, strong) NSString *Order;

@end
