//
//  News.h
//  Casinò di Venezia
//
//  Created by Massimo Moro on 11/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import <AWSDynamoDB/AWSDynamoDB.h>

@interface News : AWSDynamoDBObjectModel<AWSDynamoDBModeling>
@property (nonatomic, strong) NSString *News;
@property (nonatomic, strong) NSString *NewsIT;
@property (nonatomic, strong) NSString *NewsES;
@property (nonatomic, strong) NSString *NewsFR;
@property (nonatomic, strong) NSString *NewsDE;
@property (nonatomic, strong) NSString *NewsRU;
@property (nonatomic, strong) NSString *NewsZH;
@end
