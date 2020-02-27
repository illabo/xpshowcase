//
//  NetworkManager.h
//  XP Showcase
//
//  Created by Yachin Ilya on 27.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkManager : NSObject
- (void)downloadImageForItem:(NSString *)itemId withCompletion:(void(^)(void))completion;
- (void)setOperationStatus:(NSString*)status toItemId:(NSString*)index;
- (void)clearOperationStatusForItemId:(NSString*)index;
+ (id)sharedInstance;
@end
