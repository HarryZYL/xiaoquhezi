//
//  SummerStarView.m
//  123
//
//  Created by madarax on 15/12/7.
//  Copyright © 2015年 LiXia. All rights reserved.
//

#import "SummerStarView.h"

@implementation SummerStarView
@synthesize starSize = _starSize;
@synthesize maxStar = _maxStar;
@synthesize showStar = _showStar;
@synthesize emptyColor = _emptyColor;
@synthesize fullColor = _fullColor;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //默认的长度设置为100
        self.maxStar = self.frame.size.width;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.starSize = 15.0f;
    //未点亮时的颜色是 灰色的
    self.emptyColor = [UIColor colorWithRed:167.0f / 255.0f green:167.0f / 255.0f blue:167.0f / 255.0f alpha:1.0f];
    //点亮时的颜色是 亮黄色的
    self.fullColor = [UIColor yellowColor];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSString* stars = @"★★★★★";
    rect = self.bounds;
    UIFont *font = [UIFont boldSystemFontOfSize:_starSize];
    CGSize starSize = [stars sizeWithAttributes:@{NSFontAttributeName: font}];
    rect.size=starSize;
    [_emptyColor set];
    [stars drawInRect:rect withAttributes:@{NSFontAttributeName: font,NSForegroundColorAttributeName:self.emptyColor}];
    
    CGRect clip = rect;
    clip.size.width = clip.size.width * _showStar / _maxStar;
    CGContextClipToRect(context,clip);
    
    CGContextRelease(context);
    [_fullColor set];
    [stars drawInRect:rect withAttributes:@{NSFontAttributeName: font,NSForegroundColorAttributeName:self.fullColor}];
}


@end
