//
//  ItemsRepository.h
//  XP Showcase
//
//  Created by Yachin Ilya on 27.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemsRepository : NSObject

- (void)clearCache;
- (NSArray *_Nonnull)getItemsArray;
- (UIImage *)getImageById:(NSString *)imageId withCompletion:(void(^)(void))completion;
+ (id _Nonnull )sharedInstance;

@end
