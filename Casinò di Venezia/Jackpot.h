//
//  Jackpot.h
//  Casinò di Venezia
//
//  Created by Massimo Moro on 11/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import <AWSDynamoDB/AWSDynamoDB.h>

@interface Jackpot : AWSDynamoDBObjectModel<AWSDynamoDBModeling>
@property (nonatomic, strong) NSString *jackpot;
@property (nonatomic, strong) NSString *ourJackpotES;
@property (nonatomic, strong) NSString *ourJackpotFR;
@property (nonatomic, strong) NSString *ourJackpotDE;
@property (nonatomic, strong) NSString *ourJackpotIT;
@property (nonatomic, strong) NSString *ourJackpotRU;
@property (nonatomic, strong) NSString *ourJackpotZH;
@property (nonatomic, strong) NSString *ourJackpot;
@end
