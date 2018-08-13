//
//  JAWaterFallLayout.m
//  JAWaterFallDemo
//
//  Created by Jater on 2018/8/13.
//  Copyright © 2018年 Jater. All rights reserved.
//

#import "JAWaterFallLayout.h"

@interface JAWaterFallLayout()

//保存每一列最大y值的数组
@property (nonatomic, strong) NSMutableDictionary *maxYDic;

//保存一个item的attribute的数组
@property (nonatomic, strong) NSMutableArray *attributesArray;

@end

@implementation JAWaterFallLayout

- (instancetype)init {
    if (self = [super init]) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initData];
    }
    return self;
}

- (void)initData {
    self.columnCount = 2;
    self.attributesArray = [NSMutableArray array];
    self.maxYDic = [[NSMutableDictionary alloc] init];
}

#pragma mark - Rewrite

- (void)prepareLayout {
    [super prepareLayout];
    
    for (int i = 0; i < self.columnCount; i++) {
        self.maxYDic[@(i)] = @(self.sectionInset.top);
    }
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    [self.attributesArray removeAllObjects];
    
    for (int i = 0; i < itemCount; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attributesArray addObject:attributes];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    
    CGFloat itemWidth = (collectionViewWidth - self.sectionInset.left - self.sectionInset.right - (self.columnCount - 1) * self.columnSpacing) / self.columnCount;
    
    CGFloat itemHeight = 0;
    
    if ([self.delegate respondsToSelector:@selector(waterFallLayout:getHeightUseItemWidth:forIndexPath:)]) {
        itemHeight = [self.delegate waterFallLayout:self getHeightUseItemWidth:itemWidth forIndexPath:indexPath];
    }
    
    __block NSNumber *minIndex = @0;
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL * _Nonnull stop) {
        if ([self.maxYDic[minIndex] floatValue] > obj.floatValue) {
            minIndex = key;
        }
    }];
    
    CGFloat itemX = self.sectionInset.left + (self.columnSpacing + itemWidth) * minIndex.integerValue;
    
    CGFloat itemY = [self.maxYDic[minIndex] floatValue] + self.rowSpacing;
    
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    
    self.maxYDic[minIndex] = @(CGRectGetMaxY(attributes.frame));
    
    return attributes;
}

//返回collectionView 的contentSize 所有要找到最长的那个 确保滑动正常
- (CGSize)collectionViewContentSize {
    __block NSNumber *maxIndex = @0;
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL * _Nonnull stop) {
        if ([self.maxYDic[maxIndex] floatValue] < obj.floatValue) {
            maxIndex = key;
        }
    }];
    
    return CGSizeMake(0, [self.maxYDic[maxIndex] floatValue] + self.sectionInset.bottom);
}

//返回的是每个item的布局属性
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}

@end
