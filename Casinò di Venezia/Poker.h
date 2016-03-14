//
//  Poker.h
//  Casinò di Venezia
//
//  Created by Massimo Moro on 10/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import <AWSDynamoDB/AWSDynamoDB.h>

@interface Poker : AWSDynamoDBObjectModel<AWSDynamoDBModeling>

@property (nonatomic, strong) NSString *TournamentName;
@property (nonatomic, strong) NSDate *StartDate;
@property (nonatomic, strong) NSDate *EndDate;
@property (nonatomic, strong) NSString *PokerData;
@property (nonatomic, strong) NSString *TournamentDate;
@property (nonatomic, strong) NSString *TournamentDescription;
@property (nonatomic, strong) NSString *TournamentEvent;
@property (nonatomic, strong) NSString *TournamentRules;
@property (nonatomic, strong) NSString *office;
@property (nonatomic, strong) NSString *TournamentURL;
@property (nonatomic, strong)UITableView *theTableView;
@end
