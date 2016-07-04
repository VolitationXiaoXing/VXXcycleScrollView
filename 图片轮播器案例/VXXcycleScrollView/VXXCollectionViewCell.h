//
//  XXCollectionViewCell.h
//  图片轮播器案例
//
//  Created by Volitation小星 on 16/5/23.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VXXCollectionView;

@interface VXXCollectionViewCell : UICollectionViewCell

@property (strong,nonatomic) UIImage* img;

+(instancetype)collectionViewCellWithCollectionView:(VXXCollectionView*)collectionView andIndexPath:(NSIndexPath*)indexPath;

@end
