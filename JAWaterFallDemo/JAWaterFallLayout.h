//
//  JAWaterFallLayout.h
//  JAWaterFallDemo
//
//  Created by Jater on 2018/8/13.
//  Copyright © 2018年 Jater. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JAWaterFallLayout;

@protocol JAWaterFallLayoutDetegate <NSObject>

@required

//计算item高度的代理方法 将item的高度和indexPath 传递给外面
- (CGFloat)waterFallLayout:(JAWaterFallLayout *)layout getHeightUseItemWidth:(CGFloat)itemWidth forIndexPath:(NSIndexPath *)indexPath;

@end

@interface JAWaterFallLayout : UICollectionViewLayout

//总列数 default 2
@property (nonatomic, assign) NSInteger columnCount;

//列间距 default 0
@property (nonatomic, assign) NSInteger columnSpacing;

//行间距 default 0
@property (nonatomic, assign) NSInteger rowSpacing;

//section到CollectionView的边距  default (0, 0, 0, 0)
@property (nonatomic, assign) UIEdgeInsets sectionInset;

//代理 用来计算item的高度
@property (nonatomic, weak) id<JAWaterFallLayoutDetegate> delegate;

@end
