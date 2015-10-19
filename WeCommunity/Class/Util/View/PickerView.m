//
//  PickerView.m
//  XinHunPai
//
//  Created by Harry on 10/10/15.
//  Copyright © 2015 Harry. All rights reserved.
//

#import "PickerView.h"

@implementation PickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.confirmBtn.frame = CGRectMake(self.frame.size.width-80, 0, 80, 20);
        [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self addSubview:self.confirmBtn];
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.cancelBtn.frame = CGRectMake(0, 0, 80, 20);
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self addSubview:self.cancelBtn];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height-20)];
        self.pickerView.showsSelectionIndicator=YES;
        self.pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.pickerView];
    }
    return self;
}

@end
