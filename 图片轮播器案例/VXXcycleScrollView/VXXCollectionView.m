//
//  XXCollectionView.m
//  图片轮播器案例
//
//  Created by Volitation小星 on 16/5/23.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "VXXCollectionView.h"
#import "VXXCollectionViewLayout.h"
#import "VXXCollectionViewCell.h"


@implementation VXXCollectionView
/**
 *  cell重用ID
 */
static NSString* const ID = @"cell";

+(instancetype)xXCollectionViewWithFrame:(CGRect)frame andLayout:(VXXCollectionViewLayout*)layout{
    
    VXXCollectionView* view = [[VXXCollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    
    view.backgroundColor = [UIColor greenColor];
    
    return view;
}


-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        [self registerClass:[VXXCollectionViewCell class] forCellWithReuseIdentifier:ID];
        
    }
    
    return self;
}


@end
