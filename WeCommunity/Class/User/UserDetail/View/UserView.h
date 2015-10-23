//
//  UserView.h
//  WeCommunity
//
//  Created by Harry on 8/21/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrayLine.h"
#import "Util.h"
@interface UserView : UIView

//这个是新版的第二版的用户界面，也就是抽屉的界面  这块是用View写的 所以你看看能不能优化成tableView
//以下所有button 都是用来跳转页面的 是看不见的button

@property (nonatomic,strong) UIImageView *userHeadImg;
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *address;
@property (nonatomic,strong) UILabel *detail;
@property (nonatomic,strong) UILabel *owerType;
@property (nonatomic,strong) UIButton *topBtn;
@property (nonatomic,strong) UIButton *addressBtn;
@property (nonatomic,strong) UIButton *firstBtn;
@property (nonatomic,strong) UIButton *secondBtn;
@property (nonatomic,strong) UIButton *thirdBtn;
@property (nonatomic,strong) UIButton *fourthBtn;
@property (nonatomic,strong) UIButton *fifthBtn;
@property (nonatomic,strong) UIButton *sixthBtn;
-(void)configureHead:(NSURL*)image title:(NSString*)username;

@end
