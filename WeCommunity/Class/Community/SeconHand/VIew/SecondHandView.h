//
//  SecondHandView.h
//  WeCommunity
//
//  Created by Harry on 8/2/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicHeadDetailView.h"
#import "GrayLine.h"
#import "SecondHand.h"
@interface SecondHandView : UIView
@property (nonatomic,strong) BasicHeadDetailView *headView;
@property (nonatomic,strong) PageView *headImg;
@property (nonatomic,strong) UIImageView *userImg;
-(id)initWithFrame:(CGRect)frame withData:(NSDictionary*)data;
@end
//二手页面