//
//  SummerInputView.h
//  WeCommunity
//
//  Created by madarax on 15/11/2.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummerInputView : UIView

@property (nonatomic ,strong)UILabel *summerInputLabNumbers;
@property (nonatomic ,strong)UITextField *summerInputView;
@property (nonatomic ,strong)UIButton    *btnSelectAdd;
@property (nonatomic ,strong)UIButton *btnAddImg;
@property (nonatomic ,strong)UIButton *btnSenderMessage;

@property (nonatomic ,copy)voidBlock btnAddImageViews;
@property (nonatomic ,copy)void(^tapImageView)(NSInteger);
//@property (nonatomic ,strong)UIView *viewWithImg;

- (void)confirmsSelectImage:(NSArray *)imgArrary;

@end
