//
//  SummerInputView.h
//  WeCommunity
//
//  Created by madarax on 15/11/2.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummerInputView : UIView

@property (nonatomic ,strong)UITextView *summerInputView;
@property (nonatomic ,strong)UIButton *btnAddImg;
@property (nonatomic ,strong)UIButton *btnSenderMessage;
@property (nonatomic ,strong)UIView *viewWithImg;

- (void)confirmsSelectImage:(NSArray *)imgArrary;

@end
