//
//  MainViewControllerViewModel.m
//  XP Showcase
//
//  Created by Yachin Ilya on 26.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import "MainViewControllerViewModel.h"
#import "ItemsRepository.h"
#import "MainCollectionViewCell.h"

@interface MainViewControllerViewModel ()
@property (strong,nonatomic)ItemsRepository *repository;
@property (strong,nonatomic)NSMutableArray *showableItems;
@end

@implementation MainViewControllerViewModel

- (ItemsRepository *)repository{
    if (_repository==nil){
        _repository = [ItemsRepository sharedInstance];
    }
    return _repository;
}

- (NSMutableArray *)showableItems{
    if (_showableItems==nil){
        _showableItems = [NSMutableArray arrayWithArray:[self.repository getItemsArray]];
    }
    return _showableItems;
}

- (NSString *)imageIdByRow:(NSUInteger)row{
    return self.showableItems[row];
}

- (void)reloadItemsFromCacheForCollection:(UICollectionView*)collection{
    _showableItems = [NSMutableArray arrayWithArray:[self.repository getItemsArray]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [collection reloadData];
        [collection.collectionViewLayout invalidateLayout];
        [collection layoutSubviews];
    });
}

- (void)clearCacheForCollection:(UICollectionView*)collection{
    [self.repository clearCache];
    dispatch_async(dispatch_get_main_queue(), ^{
        [collection reloadData];
        [collection.collectionViewLayout invalidateLayout];
        [collection layoutSubviews];
    });
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCollectionViewCell" forIndexPath:indexPath];
    NSString *imgId = self.showableItems[indexPath.row];
    UIImage *image = [self.repository getImageById:imgId withCompletion:^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [collectionView reloadData];
            [collectionView.collectionViewLayout invalidateLayout];
            [collectionView layoutSubviews];
        });
    }];
    cell.imageView.image = image;
    [cell invalidateIfSettingsChanged];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.showableItems.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger idx = indexPath.row;
    [_showableItems removeObjectAtIndex:idx];
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    double d = MIN(collectionView.frame.size.width, collectionView.frame.size.height)-20;
    return CGSizeMake(d, d);
}


@end
