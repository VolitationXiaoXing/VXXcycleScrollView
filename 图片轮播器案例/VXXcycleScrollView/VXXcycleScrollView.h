//
//  XXcycleScrollView.h
//  图片轮播器案例
//
//  Created by Volitation小星 on 16/5/23.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VXXcycleScrollView;
//无限轮播器的代理方法
@protocol VXXcycleScrollViewDelegate <NSObject>

-(void)cycleScrollView:(VXXcycleScrollView*)cycleScrollView didItemClickedAtIndex:(NSInteger)index;

@end

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

//没有选中的页面指示器颜色
@property (strong,nonatomic) UIColor* pageTintColor;

///选中的页面指示器颜色
@property (strong,nonatomic) UIColor* currentPageTintColor;

//代理
@property (weak,nonatomic) id<VXXcycleScrollViewDelegate> delegate;


@end
