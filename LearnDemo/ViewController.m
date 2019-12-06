//
//  ViewController.m
//  LearnDemo
//
//  Created by MOKA_MBP on 2019/11/26.
//  Copyright © 2019 魏宁. All rights reserved.
//

#import "ViewController.h"
#import "WNCarouselCustomizeView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WNCarouselCustomizeView *carouseView = [[WNCarouselCustomizeView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 100)];
    [self.view addSubview:carouseView];
    carouseView.imagesArray = @[[UIImage imageNamed:@"cancel_A"],
                                [UIImage imageNamed:@"channelA_bg"],
                                [UIImage imageNamed:@"channelA_title"],
                                [UIImage imageNamed:@"joinChannel_"]];
//    [carouseView.imagesArray addObject:[UIImage imageNamed:@"cancel_A"]];
//    [carouseView.imagesArray addObject:[UIImage imageNamed:@"channelA_bg"]];
//    [carouseView.imagesArray addObject:[UIImage imageNamed:@"joinChannel_"]];
    
}


@end
