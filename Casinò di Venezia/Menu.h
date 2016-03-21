//
//  Menu.h
//  Casinò di Venezia
//
//  Created by Massimo Moro on 15/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import <AWSDynamoDB/AWSDynamoDB.h>

@interface Menu : AWSDynamoDBObjectModel<AWSDynamoDBModeling>
@property (nonatomic, strong) NSString *StartDate;
@property (nonatomic, strong) NSString *EndDate;
@property (nonatomic, strong) NSString *FirstCourse;
@property (nonatomic, strong) NSString *SecondCourse;
@property (nonatomic, strong) NSString *Starters;
@property (nonatomic, strong) NSString *Dessert;
@property (nonatomic, strong) NSString *Chief;
@property (nonatomic, strong) NSString *ImageChief;

@end
