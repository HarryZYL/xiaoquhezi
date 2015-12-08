//
//  SummerStarView.m
//  123
//
//  Created by madarax on 15/12/7.
//  Copyright © 2015年 LiXia. All rights reserved.
//

#import "SummerStarView.h"

@implementation SummerStarView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIImage *img = [UIImage imageNamed:@"contactflag_star_mark"];
    for (NSInteger index = 0; index < 5; index ++) {
        CGRect rectImg = CGRectMake(13 * index, 0, 13, 13);
        drawImage(context, img.CGImage, rectImg);
    }
//    CGContextRelease(context);
}

void drawImage(CGContextRef context, CGImageRef image , CGRect rect){
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, rect.origin.x, rect.origin.y);//4
    CGContextTranslateCTM(context, 0, rect.size.height);//3
    CGContextScaleCTM(context, 1.0, -1.0);//2
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);//1
    CGContextDrawImage(context, rect, image);
    CGContextRestoreGState(context);
}

@end
