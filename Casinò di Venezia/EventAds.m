//
//  EventAds.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 11/03/16.
//  Copyright © 2016 Casinò di Venezia SPA. All rights reserved.
//

#import "EventAds.h"
#import "AWSConfiguration.h"
#import <AWSS3/AWSS3.h>

@implementation EventAds
+ (NSString *)dynamoDBTableName {
    return @"EventAds";
}

+ (NSString *)hashKeyAttribute {
    return @"id";
}
-(UIImage *)image {
    if (_image) {
        
        
        AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
        AWSS3TransferManagerDownloadRequest *downloadRequest = [AWSS3TransferManagerDownloadRequest new];
        
        NSString *downloadingFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:_image];
        NSURL *downloadingFileURL = [NSURL fileURLWithPath:downloadingFilePath];
        downloadRequest.bucket = S3BucketName;
        downloadRequest.key = _image;
        
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
                                                                               self.imageView.image = [UIImage imageWithContentsOfFile:downloadingFilePath];
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
