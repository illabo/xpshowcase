//
//  WindowCreator.h
//  XP Showcase
//
//  Created by Yachin Ilya on 26.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WindowCreator : NSObject 

+(UIWindow *)createWindowWithScene:(UIWindowScene *)scene API_AVAILABLE(ios(13.0));
+(UIWindow *)createWindow;

@end
