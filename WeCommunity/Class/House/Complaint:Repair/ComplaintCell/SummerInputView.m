//
//  SummerInputView.m
//  WeCommunity
//
//  Created by madarax on 15/11/2.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerInputView.h"

@implementation SummerInputView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        self.btnAddImg = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnAddImg.frame = CGRectMake(0, 0, 40, 40);
        [self.btnAddImg setImage:[UIImage imageNamed:@"xiangce"] forState:UIControlStateNormal];
        [self addSubview:self.btnAddImg];
        
        self.summerInputView = [[UITextView alloc] initWithFrame:CGRectMake(44, 5, SCREENSIZE.width - 88, 30)];
        self.summerInputView.layer.cornerRadius = 3;
        self.summerInputView.layer.masksToBounds = YES;
        [self addSubview:self.summerInputView];
        
        self.btnSenderMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSenderMessage.frame = CGRectMake(SCREENSIZE.width - 40, 0, 40, 40);
        [self.btnSenderMessage setTitle:@"发送" forState:UIControlStateNormal];
        [self.btnSenderMessage setTitleColor:[UIColor colorWithRed:61/255.0 green:204/255.0 blue:184/255.0 alpha:1] forState:UIControlStateNormal];
        [self addSubview:self.btnSenderMessage];
        
        self.viewWithImg = [[UIView alloc] initWithFrame:CGRectMake(0, 60, SCREENSIZE.width, 0)];
        [self addSubview:self.viewWithImg];
    }
    return self;
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
