//
//  EventAds.h
//  Casinò di Venezia
//
//  Created by Massimo Moro on 11/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import <AWSDynamoDB/AWSDynamoDB.h>

@interface EventAds : AWSDynamoDBObjectModel<AWSDynamoDBModeling>
@property (nonatomic, strong) NSString *image;
@property (nonatomic) BOOL visible;
@property (nonatomic, strong) UIImageView *imageView;
@end
