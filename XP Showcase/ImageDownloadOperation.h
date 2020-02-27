//
//  ImageDownloadOperation.h
//  XP Showcase
//
//  Created by Yachin Ilya on 27.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDownloadOperation : NSOperation
- (id)initWithItemId:(NSString *)index sucessHandler:(void(^)(void))onSuccess;
@end
