//
//  VXXHeadController.m
//  WYNews
//
//  Created by Volitation小星 on 16/7/5.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "VXXHeadController.h"
#import "VXXcycleScrollView.h"
#import "VXXHeadModel.h"


@interface VXXHeadController ()

@property (strong,nonatomic) VXXcycleScrollView* cycleScrollView;

@property (strong,nonatomic) NSArray* headImgArr;

@end

@implementation VXXHeadController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
   self.cycleScrollView  = [VXXcycleScrollView cycleScrollViewWithFrame:self.view.frame];
    
    [self.view addSubview:self.cycleScrollView];
    
    //加载的时候从网络下载数据
    [VXXHeadModel headImgArrayWithSuccess:^(NSArray *array) {
        
        NSMutableArray* arr = [NSMutableArray arrayWithCapacity:20];
        
        for (VXXHeadModel* model in array) {
            [arr addObject:model.imgsrc];
        }
        
        self.cycleScrollView.resource = arr;
        
    } andfailure:^(NSError *error) {
        
        
    }];
}

-(void)viewDidLayoutSubviews{
    
    self.cycleScrollView.frame = self.view.bounds;
    
}


@end
