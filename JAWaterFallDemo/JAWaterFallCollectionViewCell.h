//
//  JAWaterFallCollectionViewCell.h
//  JAWaterFallDemo
//
//  Created by Jater on 2018/8/13.
//  Copyright © 2018年 Jater. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JAWaterFallCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

- (void)configImageLink:(NSString *)imageLink;

@end
