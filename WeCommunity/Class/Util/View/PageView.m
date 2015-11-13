//
//  PageView.m
//  WeCommunity
//
//  Created by Harry on 7/25/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//
#define MAIN_SCREEN ([UIScreen mainScreen].bounds.size)
#import "PageView.h"

@implementation PageView

- (id)initWithFrame:(CGRect)frame andImagePathArr:(NSArray *)pathArr pageControl:(BOOL)control
{
    if (self = [super initWithFrame:frame]) {
        _adScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _adScrollView.pagingEnabled = true;
        _adScrollView.showsHorizontalScrollIndicator = NO;
        _adScrollView.bounces = false;
        _adScrollView.delegate = self;
        _adScrollView.contentSize = CGSizeMake(frame.size.width * pathArr.count, frame.size.height);
        [self addSubview:_adScrollView];
        
        
        _adPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 30)];
        [_adPageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventAllEditingEvents];
        _adPageControl.numberOfPages = pathArr.count;
        _adPageControl.currentPage = 0;
        if (control) {
            [self addSubview:_adPageControl];
        }
        _moveTime = [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
        _isTimeUp = YES;
    }
    return self;
}


- (void) pageTurn:(UIPageControl *)sender
{
    CGSize viewSize = _adScrollView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [_adScrollView scrollRectToVisible:rect animated:YES];
    
}

#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage
{
    if (_isTimeUp) {
        NSInteger page = _adPageControl.currentPage;
        if (page == _adPageControl.numberOfPages - 1) {
            page = 0;
        }else{
            page ++;
        }
        _adPageControl.currentPage = page;
        
        CGFloat xPoint = page * self.frame.size.width;
//        CGSize viewSize = _adScrollView.frame.size;
//        CGRect rect = CGRectMake(_adPageControl.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
//        [_adScrollView scrollRectToVisible:rect animated:YES];
        self.adScrollView.contentOffset = CGPointMake(xPoint, 0);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.moveTime setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:10.0]];
    _adPageControl.currentPage = self.adScrollView.contentOffset.x/self.frame.size.width;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:10.0]];
    _adPageControl.currentPage = self.adScrollView.contentOffset.x/self.frame.size.width;
}

#pragma mark different view 

-(void)configureNoticePageView:(NSArray*)pathArr{
    for (int i = 0; i < pathArr.count; i++) {
        NoticeView *adImageView = [[NoticeView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
        Notice *notice = [[Notice alloc] initWithData:pathArr[i]];
        [adImageView configureTitle:notice.title content:notice.contentTxt community:@"玉兰香苑" date:notice.createTime];
        [self.adScrollView addSubview:adImageView];
    }
}

-(void)configureImagePageView:(NSArray*)pathArr{
    for (int i = 0; i < pathArr.count; i++) {
        UIImageView *adImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
        [adImg sd_setImageWithURL:[NSURL URLWithString:pathArr[i]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
        adImg.contentMode = UIViewContentModeScaleAspectFill;
        adImg.tag = i;
        [self.adScrollView addSubview:adImg];
    }

}

- (void)dealloc{
    [_moveTime isValid];
}

@end
