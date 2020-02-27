//
//  MainCollectionFlow.m
//  XP Showcase
//
//  Created by Yachin Ilya on 27.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import "MainCollectionFlow.h"

@interface MainCollectionFlow ()

@end

@implementation MainCollectionFlow

-(instancetype)initWithInteritemSpacing:(CGFloat)interitem lineSpacing:(CGFloat)line sectionInset:(UIEdgeInsets)inset{
    self = [super init];
    
    self.minimumInteritemSpacing = interitem;
    self.minimumLineSpacing = line;
    self.sectionInset = inset;
    if (@available(iOS 10.0, *)) {
        self.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    }
    
    return self;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attr = [super layoutAttributesForItemAtIndexPath:indexPath];
    CGFloat viewW = self.collectionView.frame.size.width;
    CGFloat viewMinCW = MIN(viewW, self.collectionView.frame.size.height);
    CGFloat numberOfCols = ceil(viewW/viewMinCW);
    
    CGFloat marginsAndInsets;
    if (@available(iOS 11.0, *)) {
        marginsAndInsets = (self.collectionView.safeAreaInsets.left + self.collectionView.safeAreaInsets.right + self.sectionInset.left + self.sectionInset.right + self.minimumInteritemSpacing) * (numberOfCols - 1);
    } else {
        marginsAndInsets = (self.sectionInset.left + self.sectionInset.right + self.minimumInteritemSpacing) * (numberOfCols - 1);
    }
    CGFloat boundsSizeWidth = ceil((self.collectionView.bounds.size.width - marginsAndInsets) / numberOfCols);
    attr.bounds = CGRectMake(attr.bounds.origin.x, attr.bounds.origin.y, boundsSizeWidth, attr.bounds.size.height);
    
    return attr;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
//    NSInteger rowIdx = itemIndexPath.row;
//    if (rowIdx>0) {
//        rowIdx-=1;
//    }
//    NSIndexPath *startIndexPath = [NSIndexPath indexPathForRow:rowIdx inSection:itemIndexPath.section];
//    UICollectionViewLayoutAttributes *startAttr = [self layoutAttributesForItemAtIndexPath:startIndexPath];
    UICollectionViewLayoutAttributes *attr = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    attr.transform = CGAffineTransformMakeScale(0.1, 0.1);
    attr.center = CGPointMake(self.collectionView.bounds.size.width+attr.bounds.size.width, attr.center.y);
    
    return attr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    if (!CGSizeEqualToSize(oldBounds.size, newBounds.size)) {
        return YES;
    }
    return NO;
}

@end
