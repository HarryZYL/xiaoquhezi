//
//  ActivityPostView.h
//  WeCommunity
//
//  Created by Harry on 8/15/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "GrayLine.h"
#import "SAMTextView.h"
#import "CameraImageView.h"
@interface ActivityPostView : UIView

@property (nonatomic,strong) UITextField *titleField;
@property (nonatomic,strong) UIButton *activityTypeBtn;
@property (nonatomic,strong) UIButton *applicantExpiredTimeBtn;
@property (nonatomic,strong) UIButton *beginTimeBtn;
@property (nonatomic,strong) UIButton *endTimeBtn;
@property (nonatomic,strong) UITextField *addressField;
@property (nonatomic, strong) SAMTextView  *describleView;
@property (nonatomic,strong) CameraImageView *cameraView;

@end
//活动发布视图