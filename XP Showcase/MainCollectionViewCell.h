//
//  MainCollectionViewCell.h
//  XP Showcase
//
//  Created by Yachin Ilya on 27.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewCell : UICollectionViewCell
@property(nonatomic)UIImageView *imageView;
-(void)invalidateIfSettingsChanged;
@end
