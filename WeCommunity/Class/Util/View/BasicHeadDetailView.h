//
//  BasicHeadDetailView.h
//  WeCommunity
//
//  Created by Harry on 8/1/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
@interface BasicHeadDetailView : UIView

@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *headTitle;
@property (nonatomic,strong) UILabel *headPrice;
@property (nonatomic,strong) UILabel *headPriceUnit;
@property (nonatomic,strong) UILabel *headDate;
-(void)setUpPrice:(NSString*)price;

@end
