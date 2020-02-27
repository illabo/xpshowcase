//
//  UserSettingsHandler.m
//  XP Showcase
//
//  Created by Yachin Ilya on 28.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import "UserSettingsHandler.h"
#import "Constants.h"

@interface UserSettingsHandler ()

@end

@implementation UserSettingsHandler

+ (id)sharedInstance{
    static UserSettingsHandler *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(Float32)getCurvatureSetting{
    NSString *value = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsKeyForCorner];
    if (value==nil){ return 0; }
    Float32 fVal = [value floatValue];
    if (fVal>1){ return 0.5; }
    return fVal;
}

-(void)updateSettingForCurvature:(Float32)multiplier{
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f", multiplier] forKey:kUserDefaultsKeyForCorner];
}

@end
