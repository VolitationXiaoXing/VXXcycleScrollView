//
//  XXcycleScrollView.m
//  图片轮播器案例
//
//  Created by 小星 on 16/5/23.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "VXXcycleScrollView.h"
#import "VXXCollectionView.h"
#import "VXXCollectionViewLayout.h"
#import "VXXCollectionViewCell.h"
#import "UIImageView+WebCache.h"
typedef enum : NSUInteger {
    ImgModeNet,
    ImgModePath,
} ImgMode;

@interface VXXcycleScrollView ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (weak,nonatomic) VXXCollectionView* collectionView;


@property (weak,nonatomic) VXXCollectionViewLayout* layout;


@property (weak,nonatomic) UIPageControl* pageControl;

@property (assign,nonatomic) BOOL isFirst;



@property (strong,nonatomic) NSTimer* timer;

@property (assign,nonatomic) ImgMode imgMode;

@end


@implementation VXXcycleScrollView

+(instancetype)cycleScrollViewWithFrame:(CGRect)frame{
    
    VXXcycleScrollView* view = [[VXXcycleScrollView alloc]initWithFrame:frame andResoucre:nil];
    
    return view;
}

-(void)setRes:(NSArray *)res{

    _res = res;
    
    //在这里判断传过来的res是否是网络请求还是本地数据
    id data = res[0];
    
    if ([[data class] isSubclassOfClass:[NSString class]]) {
        
        NSString* s = data;
        
        if ([s hasPrefix:@"http"]) {
            
            self.imgMode = ImgModeNet;
            
        }else{
            
            self.imgMode = ImgModePath;
        }
        
    }else if(res == nil){
        
        NSLog(@"创建时没有设置数据源");
        
    }else{
        
        NSAssert([[data class] isSubclassOfClass:[NSString class]]||data == nil, @"数据传递错误了,只能传字符串");
        
    }
    
    if (self.pageControl) {
        
        self.pageControl.numberOfPages = res.count;
        
    }
    
}

+(instancetype)cycleScrollViewWithFrame:(CGRect)frame andResoucre:(NSArray*)res{
    
    VXXcycleScrollView* view = [[VXXcycleScrollView alloc]initWithFrame:frame andResoucre:res];

    return view;
}

/**
 *  初始化轮播器初始化
 *
 *  @return
 */
-(instancetype)initWithFrame:(CGRect)frame andResoucre:(NSArray*)res{
    
    if(self = [super initWithFrame:frame]){
        
        self.res = res;
        
        self.isFirst = YES;
        
        VXXCollectionViewLayout* layout = [[VXXCollectionViewLayout alloc]initWithSize:frame.size];
        self.layout = layout;
        
        VXXCollectionView* collectionView = [VXXCollectionView xXCollectionViewWithFrame:self.bounds andLayout:self.layout];
        
        [self addSubview:collectionView];
        
        self.collectionView = collectionView;
        
        self.collectionView.dataSource = self;
        
        self.collectionView.delegate = self;

        self.onceTime = 3;
        
        self.nowIndex = 0;
        
        [self setPageControl];
        
        NSIndexPath* ip = [NSIndexPath indexPathForItem:1 inSection:0];
        
        [self.collectionView scrollToItemAtIndexPath:ip atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.onceTime target:self selector:@selector(autoNext) userInfo:nil repeats:YES];
        
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        
        [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
    return self;
}

-(void)setPageControl{
    
    UIPageControl* page = [[UIPageControl alloc]init];
    
    self.pageControl = page;
    
    [self addSubview:self.pageControl];
    
    self.pageControl.numberOfPages = 5;
    
    self.pageControl.numberOfPages = self.res.count;
    
    self.pageControl.currentPage = self.nowIndex;
    
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    self.pageTintColor =  self.pageControl.pageIndicatorTintColor;
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    self.currentPageTintColor = self.pageControl.currentPageIndicatorTintColor;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //子空间布局
    
    if(self.pageControl){
        
        CGFloat x = 0;
        CGFloat width = self.bounds.size.width;
        CGFloat height = 20;
        CGFloat y = self.bounds.size.height - 5 - height;
        
        self.pageControl.frame =CGRectMake(x, y, width, height);
    }
    
}


#pragma mark- 定时器跳转
-(void)autoNext{
    
    NSInteger x =  self.nowIndex;
    
    if (x == self.res.count - 1) {
        
        x = 0;
        
    }else{
        
        x++;
        
    }

     self.pageControl.currentPage = x;
    
    NSIndexPath* ip = [NSIndexPath indexPathForItem:2 inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:ip atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((self.onceTime*0.9) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
         [self scrollViewDidEndDecelerating:self.collectionView];
        
    });
}


-(void)onBtnClicked{

    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didItemClickedAtIndex:)]) {
        
        [self.delegate cycleScrollView:self didItemClickedAtIndex:self.pageControl.currentPage];
    }
    
}

#pragma mark- collectionView数据源方法

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    VXXCollectionViewCell* cell = [VXXCollectionViewCell collectionViewCellWithCollectionView:self.collectionView andIndexPath:indexPath];
    
    cell.onBtnClicked = ^{
        
        [self onBtnClicked];
        
    };
    
        //这里是有图片的情况
        NSInteger x = self.nowIndex;
        
        if (indexPath.row == 0) {
            if (x == 0) {
                
                x = self.res.count - 1;
                
            }else{
                
                x--;
                
            }
        }else if(indexPath.row == 2){
            if (x == self.res.count - 1) {
                
                x = 0;
                
            }else{
                
                x++;
                
            }
        }
        
        
        if (self.imgMode == ImgModeNet) {
            
            cell.imgpath = self.res[x];
        
        }else{
            
            UIImage* img = [UIImage imageNamed:self.res[x]];
            
            cell.img = img;
        
        }
    
    return cell;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint p = self.collectionView.contentOffset;
    
    CGFloat times = p.x / self.collectionView.bounds.size.width;
    
    if (times == 0) {
        
        if (self.nowIndex == 0) {
            
            self.nowIndex = self.res.count -1;
            
        }else{
            
            self.nowIndex--;
            
        }
        
    }else if(times >= 2){
        
            if (self.nowIndex == self.res.count - 1) {
                
                self.nowIndex = 0;
                
            }else{
                
                self.nowIndex++;
            }
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self nextImg];
           });
}

-(void)nextImg{
    
    self.pageControl.currentPage = self.nowIndex;
    
    NSIndexPath* ip = [NSIndexPath indexPathForItem:1 inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:ip atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}


#pragma mark- scrollView代理方法

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //开始滑动时关闭定时器
    [self.timer invalidate];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //结束时从新开启定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.onceTime target:self selector:@selector(autoNext) userInfo:nil repeats:YES];
    
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark- 属性的设置方法

-(void)setCurrentPageTintColor:(UIColor *)currentPageTintColor{
    
    _currentPageTintColor = currentPageTintColor;
    
    self.pageControl.currentPageIndicatorTintColor = currentPageTintColor;
}

-(void)setPageTintColor:(UIColor *)pageTintColor{
    
    _currentPageTintColor = pageTintColor;
    
    self.pageControl.pageIndicatorTintColor = pageTintColor;
}


@end
