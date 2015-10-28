//
//  HousePostView.m
//  WeCommunity
//
//  Created by Harry on 7/20/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "HousePostView.h"

@implementation HousePostView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIColor *fontColor = [UIColor whiteColor];
        
        self.noticeImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
        self.noticeImg.image = [UIImage imageNamed:@"notice"];
        [self addSubview:self.noticeImg];
        
        self.headLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 100, 30)];
        self.headLabel.text = @"最新公告";
        self.headLabel.textColor = fontColor;
        [self addSubview:self.headLabel];
        
        self.moreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.moreButton.frame = CGRectMake(self.frame.size.width-65, 0, 55, 25);
        [self.moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [self.moreButton setBackgroundImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
        [self.moreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.moreButton.tintColor = fontColor;
        [self addSubview:self.moreButton];
        

    }
    return self;
}

-(void)configurePageViewData:(NSArray*)dataArray{
    
    self.pageView = [[PageView alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width, 150) andImagePathArr:dataArray pageControl:YES];
    [self.pageView configureNoticePageView:dataArray];
    [self addSubview:self.pageView];
}

@end
