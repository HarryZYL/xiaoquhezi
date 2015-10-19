//
//  ActivityDetailView.h
//  WeCommunity
//
//  Created by Harry on 8/2/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicHeadDetailView.h"
#import "GrayLine.h"
#import "Activity.h"
@interface ActivityDetailView : UIView

@property (nonatomic,strong) BasicHeadDetailView *headView;
@property (nonatomic,strong) PageView *headImg;
@property (nonatomic,strong) UIImageView *userImg;
@property (nonatomic,strong) UIImageView *attendsImg;
@property (nonatomic,strong) UIButton *typeBtn;
-(id)initWithFrame:(CGRect)frame data:(NSDictionary*)data;
@end
//活动细节视图