//
//  RentDetailView.h
//  WeCommunity
//
//  Created by Harry on 7/29/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "GrayLine.h"
#import "BasicHeadDetailView.h"
#import "HouseDeal.h"
@interface RentDetailView : UIView
@property (nonatomic,strong) BasicHeadDetailView *headView;
@property (nonatomic,strong) PageView *headImg;
@property (nonatomic,strong) UILabel *headTitle;
@property (nonatomic,strong) UILabel *headPrice;
@property (nonatomic,strong) UILabel *headPriceUnit;
@property (nonatomic,strong) UILabel *headDate;
@property (nonatomic,strong) NSArray *detailArray;
@property (nonatomic,strong) NSArray *addressArray;
@property (nonatomic,strong) HouseDeal *houseDeal;

- (id)initWithFrame:(CGRect)frame andDataArray:(NSDictionary*)dataArray;
@end
