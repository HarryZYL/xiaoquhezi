//
//  HousePostView.h
//  WeCommunity
//
//  Created by Harry on 7/20/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "NoticeView.h"
#import "PageView.h"
@interface HousePostView : UIView

@property (nonatomic,strong) UILabel *headLabel;
@property (nonatomic,strong) UIImageView *noticeImg;
@property (nonatomic,strong) UIButton *moreButton;
@property (nonatomic,strong) NoticeView *noticeView;
@property (nonatomic,strong) PageView *pageView;
-(void)configurePageViewData:(NSArray*)dataArray;
@end
