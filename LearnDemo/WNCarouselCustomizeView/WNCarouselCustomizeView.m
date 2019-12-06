//
//  WNCarouselCustomizeView.m
//  LearnDemo
//
//  Created by MOKA_MBP on 2019/11/26.
//  Copyright © 2019 魏宁. All rights reserved.
//

#import "WNCarouselCustomizeView.h"
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height

@interface WNCarouselCustomizeView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *baseScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger showIndex;
@property (nonatomic, strong) UIButton *firstButton;
@property (nonatomic, strong) UIButton *secondButton;
@property (nonatomic, strong) UIButton *thirdButton;

@end

@implementation WNCarouselCustomizeView

- (instancetype)init {
    if(!self) {
        self = [[WNCarouselCustomizeView alloc] init];
        self.showIndex = 0;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.showIndex = 0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //设置scrollView的frame
    self.baseScrollView.frame = self.bounds;
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    self.baseScrollView.contentSize = CGSizeMake(width * 3, height);
    
    [self addSubview:self.baseScrollView];
    
    [self.baseScrollView addSubview:self.firstButton];
    [self.baseScrollView addSubview:self.secondButton];
    [self.baseScrollView addSubview:self.thirdButton];
    self.firstButton.frame = CGRectMake(0, 0, width, height);
    self.secondButton.frame = CGRectMake(width, 0, width, height);
    self.thirdButton.frame = CGRectMake(width * 2, 0, width, height);
    
    self.baseScrollView.contentOffset = CGPointMake(width, 0);
}

//根据传入的图片数组设置图片
- (void)setImagesArray:(NSArray *)imagesArray {
    _imagesArray = imagesArray;
    
    
    [self contentSetImage];
    
    //开启定时器
//    [self startTimer];
    
}

- (void)contentSetImage {
    if(!self.imagesArray || self.imagesArray.count == 0) {
        return;
    }
    //设置图片显示内容
    if(self.showIndex <= 0) {
        [self.firstButton setImage:self.imagesArray[self.imagesArray.count - 1] forState:UIControlStateNormal];
        
    }else {
        [self.firstButton setImage:self.imagesArray[self.showIndex - 1] forState:UIControlStateNormal];
    }
    [self.secondButton setImage:self.imagesArray[self.showIndex] forState:UIControlStateNormal];
    if(self.showIndex >= self.imagesArray.count - 1) {
        [self.thirdButton setImage:self.imagesArray[0] forState:UIControlStateNormal];
    }else {
        [self.thirdButton setImage:self.imagesArray[self.showIndex + 1] forState:UIControlStateNormal];
    }
}

//状态改变之后更新显示内容
- (void)updateContent {
    CGFloat width = self.bounds.size.width;
    [self contentSetImage];
    //唯一跟设置显示内容不同的就是重新设置偏移量，让它永远用中间的按钮显示图片,滑动之后就偷偷的把偏移位置设置回去，这样就实现了永远用中间的按钮显示图片
    //设置偏移量在中间
    self.baseScrollView.contentOffset = CGPointMake(width, 0);
}

#pragma mark - UIScrollViewDelegate
//拖拽的时候执行哪些操作
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //拖动的时候，哪张图片最靠中间，也就是偏移量最小，就滑到哪页
    //用来设置当前页
    //遍历三个imageView,看那个图片偏移最小，也就是最靠中间
    
    
}
//开始拖拽的时候停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
}
//结束拖拽的时候开始定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}
//结束拖拽的时候更新image内容
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat distanceFirst = ABS(self.firstButton.frame.origin.x - scrollView.contentOffset.x);
    CGFloat distanceSecond = ABS(self.secondButton.frame.origin.x - scrollView.contentOffset.x);
    CGFloat distanceThird = ABS(self.thirdButton.frame.origin.x - scrollView.contentOffset.x);
    if(distanceFirst <= distanceSecond && distanceFirst <= distanceThird) {
        if(self.showIndex <= 0){
            self.showIndex = self.imagesArray.count - 1;
        }else {
            self.showIndex = self.showIndex - 1;
        }
        
    }else if(distanceSecond <= distanceFirst && distanceSecond <= distanceThird) {
        
    }else {
        if(self.showIndex >= self.imagesArray.count - 1){
            self.showIndex = 0;
        }else {
            self.showIndex = self.showIndex + 1;
        }
        
    }
    [self updateContent];
}
//scroll滚动动画结束的时候更新image内容
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    CGFloat distanceFirst = ABS(self.firstButton.frame.origin.x - scrollView.contentOffset.x);
//    CGFloat distanceSecond = ABS(self.secondButton.frame.origin.x - scrollView.contentOffset.x);
//    CGFloat distanceThird = ABS(self.thirdButton.frame.origin.x - scrollView.contentOffset.x);
//    if(distanceFirst <= distanceSecond && distanceFirst <= distanceThird) {
//        if(self.showIndex == 0){
//            self.showIndex = self.imagesArray.count - 1;
//        }else {
//            self.showIndex = self.showIndex - 1;
//        }
//
//    }else if(distanceSecond <= distanceFirst && distanceSecond <= distanceThird) {
//
//    }else {
//        if(self.showIndex == self.imagesArray.count - 1){
//            self.showIndex = 0;
//        }else {
//            self.showIndex = self.showIndex + 1;
//        }
//
//    }
//    [self updateContent];
}


- (UIScrollView *)baseScrollView {
    if(!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc] init];
        _baseScrollView.delegate = self;
        //横竖两种滚轮都不显示
        _baseScrollView.showsVerticalScrollIndicator = NO;
        _baseScrollView.showsHorizontalScrollIndicator = NO;
        //需要分页
        _baseScrollView.pagingEnabled = YES;
        //不需要回弹（试了一下加不加应该都没什么影响）
        _baseScrollView.bounces = NO;
    }
    return _baseScrollView;
}

- (UIButton *)firstButton {
    if(!_firstButton) {
        _firstButton = [[UIButton alloc] init];
//        _firstButton.backgroundColor = [UIColor greenColor];
        
    }
    return _firstButton;
}

- (UIButton *)secondButton {
    if(!_secondButton) {
        _secondButton = [[UIButton alloc] init];
//        _secondButton.backgroundColor = [UIColor blueColor];
    }
    return _secondButton;
}

- (UIButton *)thirdButton {
    if(!_thirdButton) {
        _thirdButton = [[UIButton alloc] init];
//        _thirdButton.backgroundColor = [UIColor blackColor];
    }
    return _thirdButton;
}

@end
