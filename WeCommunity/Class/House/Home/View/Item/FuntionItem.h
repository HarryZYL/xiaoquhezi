//
//  FuntionItem.h
//  WeCommunity
//
//  Created by Harry on 7/20/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuntionItem : UIView

@property (nonatomic ,strong) UIButton *functionButton;
@property (nonatomic, strong) UILabel *titleLabel;
-(void)setupFunctionItemForImage:(NSString *)imageName TitleLabel:(NSString *)title;
-(void)chosen;
-(void)clearColor;
@end
