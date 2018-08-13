//
//  JAWaterFallCollectionViewCell.m
//  JAWaterFallDemo
//
//  Created by Jater on 2018/8/13.
//  Copyright © 2018年 Jater. All rights reserved.
//

#import "JAWaterFallCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation JAWaterFallCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self drawUI];
    }
    return self;
}

- (void)configImageLink:(NSString *)imageLink  {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageLink] placeholderImage:[UIImage imageNamed:@"掠人之美.jpg"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

- (void)drawUI {
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = self.bounds;
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds = YES;
    [self addSubview:self.imageView];
    
}

@end
