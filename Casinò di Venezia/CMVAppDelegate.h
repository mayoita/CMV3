//
//  CMVAppDelegate.h
//  Casinò di Venezia
//
//
//  Created by Massimo Moro on 25/10/13.
//  Copyright (c) 2013 Casinò di Venezia SPA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CMVEventKitController.h"


@interface CMVAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (nonatomic, readonly) int networkStatus;
@property (nonatomic, strong)CMVEventKitController *eventKit;

@property(strong,nonatomic)UIStoryboard *storyboard;
@property (strong, nonatomic) id<GAITracker> tracker;
@property (nonatomic)BOOL appOpen;
@property (strong, nonatomic) NSMutableArray *storage;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

- (BOOL)isParseReachable;
-(void)proximityMonitoring:(NSUserDefaults *)aDefaults;
-(void)venicerRegionMonitoring:(NSUserDefaults *)aDefaults;
@end
