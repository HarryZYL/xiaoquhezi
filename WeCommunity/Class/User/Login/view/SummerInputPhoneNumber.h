//
//  SummerInputPhoneNumber.h
//  WeCommunity
//
//  Created by madarax on 15/10/30.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SummerInputPhoneNumberDelegate <NSObject>

- (void)summerInputPhonetNumber:(NSString *)strPhone;

@end

@interface SummerInputPhoneNumber : UIView

@property (nonatomic ,strong) UITextField *inputPhoneNumber;
@property (nonatomic ,weak) id delegate;

@end
