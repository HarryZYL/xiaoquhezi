//
//  SummerInputView.m
//  WeCommunity
//
//  Created by madarax on 15/11/2.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerInputView.h"

@interface SummerInputView ()<UITextFieldDelegate>

@end

@implementation SummerInputView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithWhite:0.851 alpha:1.000].CGColor;
        self.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
        
        self.btnAddImg = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnAddImg.frame = CGRectMake(15, 11, 25, 25);
        [self.btnAddImg setBackgroundImage:[UIImage imageNamed:@"xiangce"] forState:UIControlStateNormal];
        [self addSubview:self.btnAddImg];
        
        self.summerInputLabNumbers = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        self.summerInputLabNumbers.textAlignment = NSTextAlignmentCenter;
        self.summerInputLabNumbers.backgroundColor = [UIColor redColor];
        self.summerInputLabNumbers.layer.cornerRadius = self.summerInputLabNumbers.frame.size.width/2;
        self.summerInputLabNumbers.layer.masksToBounds = YES;
        self.summerInputLabNumbers.hidden = YES;
        self.summerInputLabNumbers.textColor = [UIColor whiteColor];
        [self addSubview:self.summerInputLabNumbers];
        
        self.summerInputView = [[UITextField alloc] initWithFrame:CGRectMake(55, 8, SCREENSIZE.width - 110, 34)];
        self.summerInputView.placeholder = @"添加评论....";
        [self.summerInputView addTarget:self action:@selector(summerInputViewChanges:) forControlEvents:UIControlEventEditingChanged];
        self.summerInputView.delegate = self;
        self.summerInputView.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:self.summerInputView];
        
        self.btnSenderMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSenderMessage.frame = CGRectMake(SCREENSIZE.width - 50, 0, 50, 50);
        [self.btnSenderMessage setTitle:@"发送" forState:UIControlStateNormal];
        self.btnSenderMessage.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.btnSenderMessage setTitleColor:[UIColor colorWithWhite:0.259 alpha:1.000] forState:UIControlStateNormal];
        [self addSubview:self.btnSenderMessage];

        self.viewWithImg = [[UIView alloc] initWithFrame:CGRectMake(0, 60, SCREENSIZE.width, 0)];
        [self addSubview:self.viewWithImg];
    }
    return self;
}

- (void)summerInputViewChanges:(UITextField *)textField{
    if (textField.text.length == 0) {
        self.btnAddImg.hidden = NO;
    }
}

- (void)confirmsSelectImage:(NSArray *)imgArrary{
    for (UIImageView *img in self.viewWithImg.subviews) {
        [img removeFromSuperview];
    }
    self.viewWithImg.frame = CGRectMake(0, 60, SCREENSIZE.width, 3 + (imgArrary.count/4 + 1)*(SCREENSIZE.width - 50)/2);
    for (NSInteger index = 0; index < imgArrary.count; index ++) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:imgArrary[index]];
        int xLine = 10 + (10 + (SCREENSIZE.width - 50)/2) * index;
        int yRow  = 3 + index/4*((SCREENSIZE.width - 50)/2 + 3);
        imgView.frame = CGRectMake(xLine, yRow, (SCREENSIZE.width - 50)/2, (SCREENSIZE.width - 50)/2);
        [self.viewWithImg addSubview:imgView];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
