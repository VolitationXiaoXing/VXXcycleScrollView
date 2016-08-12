//
//  XXcycleScrollView.h
//  图片轮播器案例
//
//  Created by Volitation小星 on 16/5/23.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VXXcycleScrollView : UIView

/**
 *  这个方法返回一个图片轮播器
 *
 *  @param frame 图片轮播器的大小位置
 *  @param path  图片轮播器的图片的地址数组
 */
+(instancetype)cycleScrollViewWithFrame:(CGRect)frame andResoucre:(NSArray*)res;

+(instancetype)cycleScrollViewWithFrame:(CGRect)frame;

//当前页面
@property (assign,nonatomic) NSInteger nowIndex;

//图片资源
@property (strong,nonatomic) NSArray* res;

//每次切换图片时间，这里默认是3秒
@property (assign,nonatomic) CGFloat onceTime;

@end
