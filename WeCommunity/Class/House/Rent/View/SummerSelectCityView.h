//
//  SummerSelectCityView.h
//  WeCommunity
//
//  Created by madarax on 15/10/29.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SummerSelectCityViewDelegate <NSObject>

@optional
- (void)selectCityCommnityWithData:(NSDictionary *)commnityDic;

@end

@interface SummerSelectCityView : UIView

@property (nonatomic ,weak) id delegate;

@end
