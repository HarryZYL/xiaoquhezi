//
//  SummerScoreSegmentControl.m
//  WeCommunity
//
//  Created by madarax on 15/12/17.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SummerScoreSegmentControl.h"

@interface SummerScoreSegmentControl ()
@property (assign)NSInteger selectedIndex;
@end

@implementation SummerScoreSegmentControl
@synthesize currentSelectIndex = _currentSelectIndex;
- (id)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _selectedIndex = 0;
        _currentSelectIndex = 0;
    }
    return self;
}

- (void)setItems:(NSArray *)items{
    for (NSInteger index = 0; index < items.count; index ++) {
        UIButton *itemsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        itemsBtn.frame = CGRectMake(self.frame.size.width/items.count * index, 0, self.frame.size.width/items.count, self.frame.size.height);
        itemsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [itemsBtn setTitle:items[index] forState:UIControlStateNormal];
        [itemsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [itemsBtn addTarget:self action:@selector(btnSelectCurrentIndex:) forControlEvents:UIControlEventTouchUpInside];
        itemsBtn.tag = index + 1;
        [self addSubview:itemsBtn];
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/items.count * index, self.frame.size.height - 2, self.frame.size.width/items.count, 2)];
        lineLab.backgroundColor = THEMECOLOR;
        lineLab.hidden = YES;
        lineLab.tag = 20 + index;
        [self addSubview:lineLab];
        
        if (index < items.count - 1) {
            CALayer *lineLayer = [CALayer layer];
            lineLayer.frame = CGRectMake(self.frame.size.width/items.count * (index + 1), 0, 1, self.frame.size.height);
            lineLayer.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000].CGColor;
            [self.layer addSublayer:lineLayer];
        }
        
    }
}

- (void)btnSelectCurrentIndex:(UIButton *)sender{
    self.currentSelectIndex = sender.tag - 1;
    if (self.tapIndexTag) {
        _tapIndexTag(sender.tag - 1);
    }
}

- (void)setTitleFont:(UIFont *)titleFont{
    for (NSInteger index = 0; index < _items.count; index ++) {
        UIButton *btnSelect = (UIButton *)[self viewWithTag:index + 1];
        btnSelect.titleLabel.font = titleFont;
    }
}

- (void)setCurrentSelectIndex:(NSInteger)currentSelectIndex{
    
    UIButton *btnSelect = (UIButton *)[self viewWithTag:currentSelectIndex + 1];
    UIButton *btnSelected = (UIButton *)[self viewWithTag:_selectedIndex + 1];
    
    [btnSelected setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSelect setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    
    UILabel *lineLab = (UILabel *)[self viewWithTag:currentSelectIndex + 20];
    UILabel *lineLabSelected = (UILabel *)[self viewWithTag:_selectedIndex + 20];
    
    if (_selectedIndex != currentSelectIndex) {
        lineLab.hidden = NO;
        lineLabSelected.hidden = YES;
    }else{
        lineLab.hidden = NO;
    }
    _selectedIndex = currentSelectIndex;
    _currentSelectIndex = currentSelectIndex;
}

@end
