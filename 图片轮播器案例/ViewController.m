//
//  ViewController.m
//  图片轮播器案例
//
//  Created by Volitation小星 on 16/5/23.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "ViewController.h"
#import "VXXcycleScrollView.h"

@interface ViewController ()<VXXcycleScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    NSMutableArray* mArr = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        NSString* s = [NSString stringWithFormat:@"img_%02d",i+1];
        [mArr addObject:s];
    }
    
//    mArr = [@[@"http://a.hiphotos.baidu.com/news/crop%3D0%2C1%2C500%2C300%3Bw%3D638/sign=ed46473f28a446236a85ff22a5125e3f/cf1b9d16fdfaaf5173babcfa845494eef01f7a1d.jpg",@"http://c.hiphotos.baidu.com/news/crop%3D0%2C11%2C670%2C402%3Bw%3D638/sign=3443832dd909b3defff0be28f18f40b0/a2cc7cd98d1001e95b0c304ab00e7bec54e79746.jpg",@"http://h.hiphotos.baidu.com/news/crop%3D0%2C164%2C1599%2C959%3Bw%3D638/sign=f2b9a58e4b166d222c384fd47b1325c6/d000baa1cd11728be052ae67c0fcc3cec3fd2c73.jpg"] mutableCopy];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGRect frame = CGRectMake(0, 0, width, 180);
    
    VXXcycleScrollView* cycleView = [VXXcycleScrollView cycleScrollViewWithFrame:frame andResoucre:mArr];
    
    [self.view addSubview:cycleView];
    
    cycleView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)cycleScrollView:(VXXcycleScrollView *)cycleScrollView didItemClickedAtIndex:(NSInteger)index{
    
    NSLog(@"%ld",index);
    
}

@end
