//
//  NoticeView.m
//  WeCommunity
//
//  Created by Harry on 8/18/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "NoticeView.h"

@implementation NoticeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
                UIColor *fontColor = [UIColor whiteColor];
                self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
                self.titleLabel.textAlignment = NSTextAlignmentCenter;
                self.titleLabel.textColor = fontColor;
                [self addSubview:self.titleLabel];
        
                self.bodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, self.frame.size.width-10, 80)];
                self.bodyLabel.textAlignment = NSTextAlignmentLeft;
                self.bodyLabel.numberOfLines = 2;
                self.bodyLabel.textColor = fontColor;
                [self addSubview:self.bodyLabel];
        
//                self.communityLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-150, 105, 150, 20)];
//                self.communityLabel.textAlignment = NSTextAlignmentCenter;
//                self.communityLabel.textColor = fontColor;
//                [self addSubview:self.communityLabel];
        
                self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-160, 90, 150, 20)];
                self.dateLabel.textAlignment = NSTextAlignmentCenter;
                self.dateLabel.textColor = fontColor;
                self.dateLabel.font = [UIFont fontWithName:fontName size:13];
                [self addSubview:self.dateLabel];

    }
    return self;
}

-(void)configureTitle:(NSString*)title content:(NSString*)content community:(NSString*)community date:(NSString*)date{
    self.titleLabel.text = title;
    self.bodyLabel.text = content;
    self.communityLabel.text = community;
    self.dateLabel.text = date;
}

@end
