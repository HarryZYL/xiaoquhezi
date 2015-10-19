//
//  SecondHandPostView.h
//  WeCommunity
//
//  Created by Harry on 8/16/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrayLine.h"
#import "Util.h"
#import "SAMTextView.h"
#import "CameraImageView.h"
@interface SecondHandPostView : UIView
//二手发布页面
@property (nonatomic,strong) UITextField *titleField;
@property (nonatomic,strong) UITextField *originalPriceField;
@property (nonatomic,strong) UITextField *dealPriceField;
@property (nonatomic, strong) SAMTextView  *describleView;
@property (nonatomic,strong) CameraImageView *cameraView;
@end
