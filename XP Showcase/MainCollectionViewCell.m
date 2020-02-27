//
//  MainCollectionViewCell.m
//  XP Showcase
//
//  Created by Yachin Ilya on 27.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import "MainCollectionViewCell.h"
#import "UserSettingsHandler.h"

@interface MainCollectionViewCell ()
@property(nonatomic)Float32 cornerCurvature;
@end

@implementation MainCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.imageView];
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (@available(iOS 13.0, *)) {
        self.contentView.backgroundColor = [UIColor secondarySystemBackgroundColor];
    } else {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
    }
    
    [self styleCellCorners];
}

-(void)invalidateIfSettingsChanged{
    if(_cornerCurvature!=self.cornerCurvature){
        _cornerCurvature=self.cornerCurvature;
        [self layoutSubviews];
    }
}

-(Float32)cornerCurvature{
    return [[UserSettingsHandler sharedInstance] getCurvatureSetting];
}


-(void)styleCellCorners{
    Float32 radius = self.cornerCurvature * MIN(self.contentView.layer.bounds.size.width, self.contentView.layer.bounds.size.height);
    
    self.imageView.layer.borderWidth = 0.5;
    self.imageView.layer.cornerRadius = radius;
    self.imageView.layer.borderColor = [[UIColor clearColor] CGColor];
    self.imageView.layer.masksToBounds = YES;
    self.imageView.clipsToBounds = YES;
    
    self.contentView.layer.borderWidth = 0.0;
    self.contentView.layer.cornerRadius = radius;
    self.contentView.layer.masksToBounds = YES;
    if (@available(iOS 13.0, *)) {
        self.contentView.layer.shadowColor = [[UIColor systemGray3Color] CGColor];
    } else {
        self.contentView.layer.shadowColor = [[UIColor lightGrayColor] CGColor];
    }
    self.contentView.layer.shadowOffset = CGSizeMake(0.3, 0.7);
    self.contentView.layer.shadowRadius = 2.3;
    self.contentView.layer.shadowOpacity = 0.9;
    self.contentView.clipsToBounds = NO;
}

-(void)prepareForReuse{
    [super prepareForReuse];
    
    self.imageView.image = nil;
}

@end
