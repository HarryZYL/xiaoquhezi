//
//  HouseFooterView.h
//  WeCommunity
//
//  Created by Harry on 7/20/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FooterItem.h"
@interface HouseFooterView : UIView
@property (nonatomic,strong) FooterItem *firstItem;
@property (nonatomic,strong) FooterItem *secondItem;
@property (nonatomic,strong) FooterItem *thirdItem;
@end
