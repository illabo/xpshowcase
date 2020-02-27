//
//  WindowCreator.m
//  XP Showcase
//
//  Created by Yachin Ilya on 26.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import "WindowCreator.h"
#import "MainViewController.h"

@interface WindowCreator ()

@end

@implementation WindowCreator

+ (UIWindow *)createWindowWithScene:(UIWindowScene *)scene API_AVAILABLE(ios(13.0)){
    UIWindow *window = [[UIWindow alloc] initWithFrame: scene.coordinateSpace.bounds];
    [window setWindowScene: scene];
    [self setupViewControllers:window];
    return window;
}

+ (UIWindow*)createWindow{
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self setupViewControllers:window];
    return window;
}

+ (void)setupViewControllers:(UIWindow *)window{
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    window.rootViewController = nc;
}

@end
