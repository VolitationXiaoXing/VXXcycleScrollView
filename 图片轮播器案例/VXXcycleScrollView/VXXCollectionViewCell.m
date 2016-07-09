//
//  XXCollectionViewCell.m
//  图片轮播器案例
//
//  Created by Volitation小星 on 16/5/23.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "VXXCollectionViewCell.h"
#import "VXXCollectionView.h"
#import <UIButton+WebCache.h>


@interface VXXCollectionViewCell ()

@property (weak,nonatomic) UIButton* btnImg;

@property (strong,nonatomic) NSIndexPath* indexPath;

@end

@implementation VXXCollectionViewCell

static NSString* const ID = @"cell";

+(instancetype)collectionViewCellWithCollectionView:(VXXCollectionView *)collectionView andIndexPath:(NSIndexPath*)indexPath{
    
    VXXCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.indexPath = indexPath;

    
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIButton* btn = [[UIButton alloc]init];
        
        [self.contentView addSubview:btn];
        
        self.btnImg = btn;
        
    }
    return self;
}


-(void)setImgpath:(NSString *)imgpath{
    
    NSURL* url = [NSURL URLWithString:imgpath];
    
//    [self.btnImg sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
    
    [self.btnImg sd_setImageWithURL:url forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self setImg:image];
    }];
    
    [self.btnImg setTitle:@"" forState:UIControlStateNormal];
    
}

-(void)setImg:(UIImage *)img{
    
    
    if (!img) {
        NSString* s = [NSString stringWithFormat:@"这是第%ld个",self.indexPath.row];
        [self.btnImg setTitle:s forState:UIControlStateNormal];
        
    }else{
        _img = img;
        //这里设置图片
       
        if (self.img) {
            [self.btnImg setBackgroundImage:self.img forState:UIControlStateNormal];
        }
    }
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.btnImg.frame = self.bounds;
}

@end
