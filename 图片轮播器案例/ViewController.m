//
//  ViewController.m
//  图片轮播器案例
//
//  Created by Volitation小星 on 16/5/23.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "ViewController.h"
#import "VXXcycleScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    NSMutableArray* mArr = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        NSString* s = [NSString stringWithFormat:@"img_%02d",i+1];
        [mArr addObject:s];
    }
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGRect frame = CGRectMake(0, 0, width, 180);
    
    VXXcycleScrollView* cycleView = [VXXcycleScrollView cycleScrollViewWithFrame:frame andResoucre:mArr];
    
    [self.view addSubview:cycleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
