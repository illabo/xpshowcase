//
//  MainViewControllerViewModel.h
//  XP Showcase
//
//  Created by Yachin Ilya on 26.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewControllerViewModel: NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
- (void)reloadItemsFromCacheForCollection:(UICollectionView*)collection;
- (void)clearCacheForCollection:(UICollectionView*)collection;
@end
