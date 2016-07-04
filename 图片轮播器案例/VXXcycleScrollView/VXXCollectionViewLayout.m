//
//  XXCollectionViewLayout.m
//  图片轮播器案例
//
//  Created by Volitation小星 on 16/5/23.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "VXXCollectionViewLayout.h"

@implementation VXXCollectionViewLayout

-(instancetype)initWithSize:(CGSize)itemSize{
    
    if (self = [super init]) {
        
        self.itemSize = itemSize;
        
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self.minimumLineSpacing = 0;
        
    }
    return self;
}

@end
