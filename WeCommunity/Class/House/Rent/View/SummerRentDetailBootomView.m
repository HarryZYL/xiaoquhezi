//
//  SummerRentDetailBootomView.m
//  WeCommunity
//
//  Created by madarax on 15/11/6.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerRentDetailBootomView.h"

@implementation SummerRentDetailBootomView

- (instancetype)initWithFrame:(CGRect)frame withItem:(NSInteger) countIndex{
    if (self = [super initWithFrame:frame]) {
        if (countIndex == 1) {
            self.btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
            self.btnLeft.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
            [self.btnLeft setTitle:@"预约看房" forState:UIControlStateNormal];
            [self addSubview:self.btnLeft];
        }else{
            self.btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
            self.btnLeft.frame = CGRectMake(0, 0, frame.size.width/2, frame.size.height);
            [self.btnLeft setTitle:@"查看预约" forState:UIControlStateNormal];
            [self addSubview:self.btnLeft];
            
            self.btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
            self.btnRight.frame = CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height);
            [self.btnRight setTitle:@"修改" forState:UIControlStateNormal];
            [self addSubview:self.btnRight];
            
            UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREENSIZE.width/2, 0, 1, frame.size.height)];
            lineLab.backgroundColor = [UIColor whiteColor];
            [self addSubview:lineLab];
        }
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
