//
//  ViewController.m
//  JAWaterFallDemo
//
//  Created by Jater on 2018/8/13.
//  Copyright © 2018年 Jater. All rights reserved.
//

#import "ViewController.h"
#import "JAWaterFallCollectionViewCell.h"
#import "JAWaterFallLayout.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, JAWaterFallLayoutDetegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *imageLinksArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JAWaterFallLayout *flowLayout = [[JAWaterFallLayout alloc] init];
    flowLayout.columnCount = 2;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    flowLayout.columnSpacing = 10;
    flowLayout.rowSpacing = 10;
    flowLayout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[JAWaterFallCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    
}

#pragma mark - delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JAWaterFallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    [cell configImageLink:self.imageLinksArr[indexPath.row]];
    return cell;
}

#pragma mark - JAWaterFallLayout Detegate

- (CGFloat)waterFallLayout:(JAWaterFallLayout *)layout getHeightUseItemWidth:(CGFloat)itemWidth forIndexPath:(NSIndexPath *)indexPath {
    JAWaterFallCollectionViewCell *cell = (JAWaterFallCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    CGFloat imageHeight = cell.imageView.image.size.height;
    if (imageHeight > 0) {
        return imageHeight;
    }
    return arc4random() % 200 + 50;
}

#pragma mark - Getter and Setter

- (NSMutableArray *)imageLinksArr {
    if (!_imageLinksArr) {
        _imageLinksArr = [[NSMutableArray alloc] initWithCapacity:100];
        
        NSArray *temp = @[@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5XmUhwCzTtA8VLGWgN-qjcaQfkCvFermFVSmjRc-4-qmhWwb0",@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuti97R6xBLCPdE7xJuYXj2T2uivdHsQ7fZ9DrMWjDOPZlXt3HVA",@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUCbsYvDWJYISRjHrZxec5DpfH4HJNxPJhVo3PR5zMW9ADzT8zYQ",@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuzhpak06F4FAgvgEVBtY8LSBgiOT6W-HfoEZ_Cp-ZWShSJFeV-Q",@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcy7x0aSCm17VmLDxVv4wpE8LwTwr6tMHyA-z9KnLxWNS3CAFAdA"];
        
        while (_imageLinksArr.count <= 100) {
            [_imageLinksArr addObjectsFromArray:temp];
        }
        return _imageLinksArr;
    }
    return _imageLinksArr;
}

@end
