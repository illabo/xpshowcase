//
//  ImageDownloadOperation.m
//  XP Showcase
//
//  Created by Yachin Ilya on 27.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import "ImageDownloadOperation.h"
#import "Constants.h"
#import "NetworkManager.h"

typedef void(^CompletionHandler)(void);

@interface  ImageDownloadOperation ()
@property(nonatomic) NSString *itemIndex;
@property(nonatomic) CompletionHandler successHandler;
@end

@implementation ImageDownloadOperation

- (id)initWithItemId:(NSString *)index sucessHandler:(void(^)(void))onSuccess{
    self = [super init];
    if (self) {
        _itemIndex = index;
        _successHandler = onSuccess;
    }
    return self;
}

- (void)main{
    NSURL *url = [NSURL URLWithString:kDefaultApiUrl];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSString *itemIndex = _itemIndex;
    CompletionHandler successHandler = _successHandler;
    _itemIndex = nil;
    _successHandler = nil;
    
    [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
        NSInteger status = [r statusCode];
        if (error==nil &&
            data!=nil &&
            r!=nil &&
            status>=200 &&
            status<=299){
            NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:itemIndex];
            [data writeToFile:filePath atomically:YES];
            [NetworkManager.sharedInstance clearOperationStatusForItemId:itemIndex];
            successHandler();
        } else {
            [NetworkManager.sharedInstance setOperationStatus:@"FAIL" toItemId:itemIndex];
        }
    }].resume;
}

@end
