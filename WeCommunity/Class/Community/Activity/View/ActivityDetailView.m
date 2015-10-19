//
//  ActivityDetailView.m
//  WeCommunity
//
//  Created by Harry on 8/2/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "ActivityDetailView.h"

@implementation ActivityDetailView

-(id)initWithFrame:(CGRect)frame data:(NSDictionary*)data{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        Activity *activity = [[Activity alloc] initWithData:data];
        
        self.headView = [[BasicHeadDetailView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width-35)];
        
        self.headImg = [[PageView alloc] initWithFrame:self.headView.headImg.frame andImagePathArr:activity.pictures pageControl:NO];
        [self.headImg configureImagePageView:activity.pictures];
        [self.headView addSubview:self.headImg];
        
        //活动标题
        self.headView.headTitle.text = activity.title;
        
        self.userImg = [[UIImageView alloc] init];
        self.userImg.frame = CGRectMake(self.headView.headTitle.frame.origin.x, self.headView.headTitle.frame.origin.y + self.headView.headTitle.frame.size.height+10, 40, 40);
        [self.userImg sd_setImageWithURL:[NSURL URLWithString:activity.creatorInfo[@"headPhoto"]] placeholderImage:[UIImage imageNamed:@"house1"]];
        self.userImg.layer.masksToBounds = YES;
        self.userImg.layer.cornerRadius = self.userImg.frame.size.width/2;
        [self.headView addSubview:self.userImg];
        
        // 活动日期
        self.headView.headDate.text = activity.beginTime;
        self.headView.headDate.frame = CGRectMake(self.userImg.frame.origin.x+self.userImg.frame.size.width+10, self.userImg.frame.origin.y, 200, 20);
        
        //参与人数
        self.attendsImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"活动参加人数"]];
        self.attendsImg.frame = CGRectMake(self.headView.headDate.frame.origin.x , self.headView.headDate.frame.origin.y + self.headView.headDate.frame.size.height, 20, 20);
        [self.headView addSubview:self.attendsImg];
        
        self.headView.headPriceUnit.frame = CGRectMake(self.attendsImg.frame.origin.x + self.attendsImg.frame.size.width, self.attendsImg.frame.origin.y, 40, 20);
        self.headView.headPriceUnit.text = [NSString stringWithFormat:@"%@",activity.applicantCount];
        
        self.headView.headPrice.text = @"";
        
//        // 活动类型
        self.typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.typeBtn.frame = CGRectMake(frame.size.width-80, self.headView.headPriceUnit.frame.origin.y-10, 60, 30);
        [self.typeBtn setBackgroundImage:[UIImage imageNamed:@"活动类型"] forState:UIControlStateNormal];
        [self.typeBtn setTitle:activity.activityTypeName forState:UIControlStateNormal];
        [self.headView addSubview:self.typeBtn];
        
        [self addSubview:self.headView];
        
        GrayLine *firstLine = [[GrayLine alloc] initWithFrame:CGRectMake(0, self.headView.frame.size.height, frame.size.width, 15)];
        [self addSubview:firstLine];
        
        NSArray *fixArray = @[@"活动时间",@"报名截止",@"活动地址"];
        NSArray *detailArray = @[activity.beginTime,activity.applicantExpiredTime,activity.address];
        
        for (int i = 0; i<3; i++) {
            
            UILabel *activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, firstLine.frame.origin.y+firstLine.frame.size.height + 10 +30*i , 80, 30)];
            activityLabel.text = fixArray[i];
            [self addSubview:activityLabel];
            
            UILabel *activityDetail = [[UILabel alloc] initWithFrame:CGRectMake(100, firstLine.frame.origin.y+firstLine.frame.size.height + 10 +30*i, 250, 30)];
            activityDetail.text = detailArray[i];
            activityDetail.textColor = [UIColor grayColor];
            [self addSubview:activityDetail];
            
        }
        
        GrayLine *secondLine = [[GrayLine alloc] initWithFrame:CGRectMake(20, firstLine.frame.origin.y+120, frame.size.width-20, 1)];
        [self addSubview:secondLine];
        
        //活动描述
        UILabel *describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, secondLine.frame.origin.y+5, 80, 30)];
        describeLabel.text = @"活动描述";
        [self addSubview:describeLabel];
        
        UITextView *describe = [[UITextView alloc] initWithFrame:CGRectMake(20, secondLine.frame.origin.y+40, frame.size.width-35, 200)];
        describe.text = activity.describ;
        describe.font = [UIFont fontWithName:fontName size:15];
        describe.textColor = [UIColor grayColor];
        [self addSubview:describe];
        
    }
    
    return self;
}

@end
