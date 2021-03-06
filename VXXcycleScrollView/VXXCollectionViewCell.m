//
//  XXCollectionViewCell.m
//  图片轮播器案例
//
//  Created by Volitation小星 on 16/5/23.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "VXXCollectionViewCell.h"
#import "VXXCollectionView.h"
#import "UIButton+WebCache.h"
#import "VXXButton.h"


@interface VXXCollectionViewCell ()

@property (weak,nonatomic) VXXButton* btnImg;

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
        
        VXXButton* btn = [[VXXButton alloc]init];
        
        [self.contentView addSubview:btn];
        
        self.btnImg = btn;
        
        [self.btnImg addTarget:self action:@selector(onBtnclicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

//这个是网络上获取图片
-(void)setImgpath:(NSString *)imgpath{
    
    NSURL* url = [NSURL URLWithString:imgpath];
    
    if (self.cellPlaceholderImage) {
        
        [self.btnImg sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:self.cellPlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [self setImg:image];
            
            cacheType = SDImageCacheTypeDisk;
            
        }];

        
    }else{
    
        
        [self.btnImg sd_setImageWithURL:url forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [self setImg:image];
            
            cacheType = SDImageCacheTypeDisk;
            
        }];
    
    }
    

    
}

//传过来的是图片
-(void)setImg:(UIImage *)img{
    
    if (!img) {
        NSString* s = [NSString stringWithFormat:@"数据拼命加载中..."];
        
        [self.btnImg setTitle:s forState:UIControlStateNormal];
        
    }else{
        
        _img = img;
        //这里设置图片
       
        if (self.img) {
            
            [self.btnImg setBackgroundImage:self.img forState:UIControlStateNormal];
            
        }
    }
}

-(void)onBtnclicked{
    //图片被点击了
    if (self.onBtnClicked) {
        
        self.onBtnClicked();
        
    }
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.btnImg.frame = self.bounds;
}

@end
