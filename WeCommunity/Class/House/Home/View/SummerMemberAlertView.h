//
//  SummerMemberAlertView.h
//  WeCommunity
//
//  Created by madarax on 15/11/1.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SummerMemberAlertViewDelegate <NSObject>

- (void)didSelectIndexWithInformation:(NSInteger)index;

@end

@interface SummerMemberAlertView : UIView

@property(nonatomic,weak)IBOutlet UIButton *btnInfomation;
@property(nonatomic,weak)IBOutlet UIButton *btnRemove;
@property(nonatomic,weak)IBOutlet UIButton *btnSure;
@property(nonatomic,weak)IBOutlet UIButton *btnCansole;
@property(nonatomic,weak)IBOutlet UIView *bgView;
@property(nonatomic,assign) NSInteger currentIndex;
@property(nonatomic,weak)id delegate;

@end
