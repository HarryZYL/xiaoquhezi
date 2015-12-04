//
//  SummerRunloopView.m
//  MasoryDemon
//
//  Created by madarax on 15/12/2.
//  Copyright © 2015年 LiXia. All rights reserved.
//

#import "SummerRunloopView.h"

@interface SummerRunloopView ()<UIScrollViewDelegate>

@property (nonatomic ,strong)UIScrollView *mScrollView;
@property (nonatomic ,strong)UIPageControl *mPageControl;
@property (nonatomic ,strong)NSTimer *summerTimmer;

@end

@implementation SummerRunloopView
static NSTimeInterval summerInterval = 10;
- (void)confirmSubViews{
    [self mScrollView];
    for (NSInteger index = 0; index < self.loopImgArrary.count; index ++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(index * SCREENSIZE.width, 0, SCREENSIZE.width, 160)];
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.loopImgArrary[index]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
        imgView.userInteractionEnabled = YES;
        [_mScrollView addSubview:imgView];
        
        UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCurrentIndex)];
        [imgView addGestureRecognizer:tapView];
    }
    [self mPageControl];
    _summerTimmer = [NSTimer scheduledTimerWithTimeInterval:summerInterval target:self selector:@selector(nextImageView) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_summerTimmer forMode:NSRunLoopCommonModes];
}

- (void)tapCurrentIndex{
    if (_tapIndex) {
        _tapIndex(_mPageControl.currentPage);
    }
}

- (UIPageControl *)mPageControl{
    __weak typeof(self)weakSelf = self;
    _mPageControl = [UIPageControl new];
    [self addSubview:_mPageControl];
    _mPageControl.numberOfPages = self.loopImgArrary.count;
    [_mPageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    return _mPageControl;
}

- (UIScrollView *)mScrollView{
    _mScrollView = [UIScrollView new];
    _mScrollView.delegate = self;
    _mScrollView.pagingEnabled = YES;
    _mScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _mScrollView.showsHorizontalScrollIndicator = NO;
    _mScrollView.contentSize = CGSizeMake(SCREENSIZE.width * self.loopImgArrary.count, self.frame.size.height);
    _mScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:_mScrollView];
    [_mScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    return _mScrollView;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_summerTimmer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    _mPageControl.currentPage = targetContentOffset->x/self.frame.size.width;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [_summerTimmer setFireDate:[NSDate dateWithTimeIntervalSinceNow:summerInterval]];
}

- (void)nextImageView{
    NSInteger pageNumber = _mPageControl.currentPage;
    pageNumber ++;
    if (pageNumber < self.loopImgArrary.count) {
        _mScrollView.contentOffset = CGPointMake(pageNumber * self.frame.size.width, 0);
    }else{
        pageNumber = 0;
        _mScrollView.contentOffset = CGPointMake(pageNumber * self.frame.size.width, 0);
    }
    _mPageControl.currentPage = pageNumber;
}

- (void)dealloc{
    [_summerTimmer invalidate];
    _summerTimmer = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
