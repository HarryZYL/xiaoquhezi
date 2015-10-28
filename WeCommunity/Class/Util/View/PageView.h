//
//  PageView.h
//  WeCommunity
//
//  Created by Harry on 7/25/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeView.h"
#import "Notice.h"
static CGFloat const chageImageTime = 10.0;
@interface PageView : UIView<UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView *adScrollView;
@property (nonatomic , strong) UIPageControl *adPageControl;
@property (nonatomic) BOOL isTimeUp;
@property (nonatomic) NSTimer * moveTime;//循环滚动的周期时间

- (id)initWithFrame:(CGRect)frame andImagePathArr:(NSArray *)pathArr pageControl:(BOOL)control;
- (void) pageTurn:(UIPageControl *)sender;
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
-(void)configureNoticePageView:(NSArray*)pathArr;
-(void)configureImagePageView:(NSArray*)pathArr;
@end
