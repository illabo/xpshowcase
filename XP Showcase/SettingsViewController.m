//
//  SettingsViewController.m
//  XP Showcase
//
//  Created by Yachin Ilya on 28.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import "SettingsViewController.h"
#import "UserSettingsHandler.h"
#import "Constants.h"

@interface SettingsViewController ()
@property(strong,nonatomic)UISlider *curvatureSlider;
@property(nonatomic)UserSettingsHandler *settingsHandler;
@end

@implementation SettingsViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    UISlider *curvatureSlider = self.curvatureSlider;
    [self.view addSubview:curvatureSlider];
    curvatureSlider.translatesAutoresizingMaskIntoConstraints = NO;
    [[curvatureSlider.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]setActive:YES];
    [[curvatureSlider.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]setActive:YES];
    [[curvatureSlider.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:32]setActive:YES];
    [[curvatureSlider.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-32]setActive:YES];
    
    UITextField *iconsCopyright = [[UITextField alloc] init];
    iconsCopyright.text = kIconsCopyright;
    if (@available(iOS 13.0, *)) {
        iconsCopyright.textColor = [UIColor labelColor];
    } else {
        iconsCopyright.textColor = [UIColor darkTextColor];
    }
    iconsCopyright.textAlignment = NSTextAlignmentCenter;
    [iconsCopyright setFont: [UIFont systemFontOfSize: [UIFont smallSystemFontSize]]];
    [self.view addSubview:iconsCopyright];
    iconsCopyright.translatesAutoresizingMaskIntoConstraints = NO;
    [[iconsCopyright.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]setActive:YES];
    [[iconsCopyright.centerYAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-32]setActive:YES];
    [[iconsCopyright.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:32]setActive:YES];
    [[iconsCopyright.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-32]setActive:YES];
}

-(void)updateCurvatureSetting{
    [self.settingsHandler updateSettingForCurvature:self.curvatureSlider.value];
}

-(UserSettingsHandler *)settingsHandler{
    if(_settingsHandler==nil){
        _settingsHandler = [UserSettingsHandler sharedInstance];
    }
    return _settingsHandler;
}

-(UISlider *)curvatureSlider{
    if (_curvatureSlider==nil){
        UISlider *curvatureSlider = [[UISlider alloc] init];
        UIImage *square = [UIImage imageNamed:@"Square"];
        UIImage *circle = [UIImage imageNamed:@"Circle"];
        if (@available(iOS 13.0, *)) {
             square = [square imageWithTintColor:self.view.tintColor renderingMode:UIImageRenderingModeAlwaysTemplate];
             circle = [circle imageWithTintColor:self.view.tintColor renderingMode:UIImageRenderingModeAlwaysTemplate];
            curvatureSlider.minimumValueImage = square;
            curvatureSlider.maximumValueImage = circle;
        } else {
            square = [square imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            circle = [circle imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            curvatureSlider.minimumValueImage = square;
            curvatureSlider.maximumValueImage = circle;
            curvatureSlider.tintColor = self.view.tintColor;
        }
        curvatureSlider.minimumValue = 0.0;
        curvatureSlider.maximumValue = 0.5;
        curvatureSlider.minimumValueImage = square;
        curvatureSlider.maximumValueImage = circle;
        [curvatureSlider setValue:[self.settingsHandler getCurvatureSetting] animated:YES];
        [curvatureSlider addTarget:self action:@selector(updateCurvatureSetting) forControlEvents:UIControlEventTouchUpInside];
        _curvatureSlider = curvatureSlider;
    }
    return _curvatureSlider;
}

@end
