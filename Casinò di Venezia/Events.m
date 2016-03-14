//
//  Events.m
//  MySampleApp
//
//  Created by Massimo Moro on 19/02/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "Events.h"
#import "AWSConfiguration.h"
#import <AWSS3/AWSS3.h>
@interface Events() {
    BOOL imUno;
    BOOL imDue;
    BOOL imTre;
}
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation Events

-(id)init{
    self = [super init];
    if (self) {
        self.dateFormatter = [NSDateFormatter new];
        self.dateFormatter.dateStyle = kCFDateFormatterShortStyle;
        self.dateFormatter.timeStyle = kCFDateFormatterShortStyle;
        self.dateFormatter.locale = [NSLocale currentLocale];
        [self.dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];

    }
    return self;
}


+ (NSString *)dynamoDBTableName {
    return @"Events";
}

+ (NSString *)hashKeyAttribute {
    return @"Name";
}
+ (NSString *)rangeKeyAttribute {
    return @"StartDate";
}

-(NSDate *)StartDate {
    
    return [self.dateFormatter dateFromString:_StartDate];;
}
-(NSDate *)EndDate {
    
    return [self.dateFormatter dateFromString:_EndDate];;
}
-(UIImage *)ImageName {
    if (_ImageName) {
      
        
        AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
        AWSS3TransferManagerDownloadRequest *downloadRequest = [AWSS3TransferManagerDownloadRequest new];
        
        NSString *downloadingFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:_ImageName];
        NSURL *downloadingFileURL = [NSURL fileURLWithPath:downloadingFilePath];
        downloadRequest.bucket = S3BucketName;
        downloadRequest.key = _ImageName;
        
        downloadRequest.downloadingFileURL = downloadingFileURL;
        if ([UIImage imageWithContentsOfFile:downloadingFilePath] == nil) {
            // Download the file.
            [[transferManager download:downloadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor]
                                                                   withBlock:^id(AWSTask *task) {
                                                                       if (task.error){
                                                                           if ([task.error.domain isEqualToString:AWSS3TransferManagerErrorDomain]) {
                                                                               switch (task.error.code) {
                                                                                   case AWSS3TransferManagerErrorCancelled:
                                                                                   case AWSS3TransferManagerErrorPaused:
                                                                                       break;
                                                                                       
                                                                                   default:
                                                                                       NSLog(@"Error: %@", task.error);
                                                                                       break;
                                                                               }
                                                                           } else {
                                                                               // Unknown error.
                                                                               NSLog(@"Error: %@", task.error);
                                                                           }
                                                                       }
                                                                       
                                                                       if (task.result) {
                                                                           
                                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                                               [self.theTableView reloadData];
                                                                           });
                                                                           
                                                                       }
                                                                       return nil;
                                                                   }];
        }
        
        if ([UIImage imageWithContentsOfFile:downloadingFilePath] == nil) {
            return [UIImage imageNamed:@"640x408default.jpg"];
        } else {
        return [UIImage imageWithContentsOfFile:downloadingFilePath];
        }
   
    }

    return [UIImage imageNamed:@"640x408default.jpg"];
}

@end
