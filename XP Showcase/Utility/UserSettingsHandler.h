//
//  UserSettingsHandler.h
//  XP Showcase
//
//  Created by Yachin Ilya on 28.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSettingsHandler : NSObject
+ (id)sharedInstance;
- (Float32)getCurvatureSetting;
-(void)updateSettingForCurvature:(Float32)multiplier;
@end
