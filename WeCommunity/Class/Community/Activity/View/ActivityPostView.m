//
//  ActivityPostView.m
//  WeCommunity
//
//  Created by Harry on 8/15/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "ActivityPostView.h"

@implementation ActivityPostView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat textHeight = 45;
        // first part
        self.titleField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, frame.size.width-20, textHeight)];
        self.titleField.placeholder = @"标题";
        [self addSubview:self.titleField];
        
        GrayLine *firstLine = [[GrayLine alloc] initWithFrame:CGRectMake(0, textHeight, frame.size.width, 1)];
        [self addSubview:firstLine];
        
        self.activityTypeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.activityTypeBtn.frame = CGRectMake(10, textHeight, frame.size.width-20, textHeight);
        [self.activityTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.activityTypeBtn setTitle:@"活动类型" forState:UIControlStateNormal];
        [self addSubview:self.activityTypeBtn];
        
        GrayLine *secondLine = [[GrayLine alloc] initWithFrame:CGRectMake(0, textHeight*2, frame.size.width, 1)];
        [self addSubview:secondLine];
        
        
        // second part
        NSArray *firstArray = @[@"活动开始时间",@"活动结束时间",@"报名截止时间",@"活动地点"];
        for (int i = 0; i<4; i++) {
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, secondLine.frame.origin.y+10+i*textHeight, 120, textHeight)];
            title.text = firstArray[i];
            [self addSubview:title];
            switch (i) {
                case 0:
                    self.beginTimeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [self.beginTimeBtn setTitle:@"2015-08-07 15:20" forState:UIControlStateNormal];
                    self.beginTimeBtn.tag = 1;
                    self.beginTimeBtn.frame = CGRectMake(title.frame.size.width+10, title.frame.origin.y, frame.size.width-200, textHeight);
                    [self addSubview:self.beginTimeBtn];
                    break;
                case 1:
                    self.endTimeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [self.endTimeBtn setTitle:@"2015-08-07 15:20" forState:UIControlStateNormal];
                    self.endTimeBtn.frame = CGRectMake(title.frame.size.width+10, title.frame.origin.y, frame.size.width-200, textHeight);
                    self.endTimeBtn.tag = 2;
                    [self addSubview:self.endTimeBtn];
                    break;
                case 2:
                    self.applicantExpiredTimeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [self.applicantExpiredTimeBtn setTitle:@"2015-08-07 15:20" forState:UIControlStateNormal];
                    self.applicantExpiredTimeBtn.frame = CGRectMake(title.frame.size.width+10, title.frame.origin.y, frame.size.width-200, textHeight);
                    self.applicantExpiredTimeBtn.tag = 3;
                    [self addSubview:self.applicantExpiredTimeBtn];
                    break;
                case 3:
                    self.addressField = [[UITextField alloc] init];
                    self.addressField.frame = CGRectMake(title.frame.size.width+10, title.frame.origin.y+8.5, frame.size.width-150, textHeight-15);
                    self.addressField.borderStyle = UITextBorderStyleRoundedRect;
                    [self addSubview:self.addressField];
                    break;
                    
                default:
                    break;
            }
        }
        
        // third part
        self.describleView=[[SAMTextView alloc] initWithFrame:CGRectMake(10,self.addressField.frame.origin.y+50, frame.size.width-20, 100)];
        self.describleView.placeholder=@"活动详情";
        self.describleView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.5];
        self.describleView.font=[UIFont fontWithName:@"Arial" size:15];
        [self addSubview:self.describleView];
        
        self.cameraView = [[CameraImageView alloc] initWithFrame:CGRectMake(10, self.describleView.frame.size.height+self.describleView.frame.origin.y+10, frame.size.width-20, 150)];
        [self addSubview:self.cameraView];

    }
    return self;
}

@end
