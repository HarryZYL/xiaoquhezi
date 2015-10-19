//
//  NoticeView.h
//  WeCommunity
//
//  Created by Harry on 8/18/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
@interface NoticeView : UIView
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *bodyLabel;
@property (nonatomic,strong) UILabel *communityLabel;
@property (nonatomic,strong) UILabel *dateLabel;
-(void)configureTitle:(NSString*)title content:(NSString*)content community:(NSString*)community date:(NSString*)date;
@end
