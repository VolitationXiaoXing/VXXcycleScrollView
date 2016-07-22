//
//  XXcycleScrollView.h
//  图片轮播器案例
//
//  Created by Volitation小星 on 16/5/23.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VXXcycleScrollView : UIView

+(instancetype)cycleScrollViewWithFrame:(CGRect)frame andResoucre:(NSArray*)res;

+(instancetype)cycleScrollViewWithFrame:(CGRect)frame;


//图片资源
@property (strong,nonatomic) NSArray* res;

//每次切换图片时间
@property (assign,nonatomic) CGFloat onceTime;

@end
