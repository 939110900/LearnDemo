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
        self = [[WNCarouselCustomizeView alloc] initWithFrame:frame];
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
    
    //设置图片显示内容
    [self setContent];
    //开启定时器
//    [self startTimer];
    
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
    }
    return _firstButton;
}

- (UIButton *)secondButton {
    if(!_secondButton) {
        _secondButton = [[UIButton alloc] init];
    }
    return _secondButton;
}

- (UIButton *)thirdButton {
    if(!_thirdButton) {
        _thirdButton = [[UIButton alloc] init];
    }
    return _thirdButton;
}

@end
