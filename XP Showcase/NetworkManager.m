//
//  NetworkManager.m
//  XP Showcase
//
//  Created by Yachin Ilya on 27.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import "NetworkManager.h"
#import "Constants.h"
#import "ImageDownloadOperation.h"

@interface NetworkManager ()

@property(strong,nonatomic) NSMutableDictionary<NSString *, NSString *> *operationsStatuses;
@property(strong,nonatomic) NSOperationQueue *operationQueue;

@end


@implementation NetworkManager
+(id)sharedInstance{
    static NetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


- (NSOperationQueue *)operationQueue{
    if (_operationQueue==nil){
        _operationQueue=[[NSOperationQueue alloc] init];
    }
    return _operationQueue;
}

- (NSMutableDictionary<NSString *, NSString *> *)operationsStatuses{
    if (_operationsStatuses==nil){
        _operationsStatuses=[[NSMutableDictionary alloc] initWithCapacity:kMaxNumberOfItems];
    }
    return _operationsStatuses;
}

- (void)downloadImageForItem:(NSString *)itemId withCompletion:(void(^)(void))completion{
    if (![self.operationsStatuses[itemId] isEqual:@"RUN"]){
        ImageDownloadOperation *op = [[ImageDownloadOperation alloc] initWithItemId:itemId sucessHandler:completion];
        [[self operationQueue] addOperation:op];
        [self setOperationStatus:@"RUN" toItemId:itemId];
    }
}

- (void)setOperationStatus:(NSString*)status toItemId:(NSString*)index{
    self.operationsStatuses[index] = status;
}

- (void)clearOperationStatusForItemId:(NSString*)index{
    [self.operationsStatuses removeObjectForKey:index];
}

@end
