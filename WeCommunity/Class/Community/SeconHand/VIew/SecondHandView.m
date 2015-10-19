//
//  SecondHandView.m
//  WeCommunity
//
//  Created by Harry on 8/2/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "SecondHandView.h"

@implementation SecondHandView

-(id)initWithFrame:(CGRect)frame withData:(NSDictionary*)data{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        SecondHand *secondHand = [[SecondHand alloc] initWithData:data];
        
        self.headView = [[BasicHeadDetailView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width-35)];
        
        self.headImg = [[PageView alloc] initWithFrame:self.headView.headImg.frame andImagePathArr:secondHand.pictures pageControl:NO];
        [self.headImg configureImagePageView:secondHand.pictures];
        [self.headView addSubview:self.headImg];
        //活动标题
        
        self.headView.headTitle.text = secondHand.title;
        
        self.userImg = [[UIImageView alloc] init];
        self.userImg.frame = CGRectMake(self.headView.headTitle.frame.origin.x, self.headView.headTitle.frame.origin.y + self.headView.headTitle.frame.size.height+10, 40, 40);
        [self.userImg sd_setImageWithURL:secondHand.creatorInfo.headPhoto placeholderImage:[UIImage imageNamed:@"advise"] ];
        self.userImg.layer.masksToBounds = YES;
        self.userImg.layer.cornerRadius = self.userImg.frame.size.width/2;
        [self.headView addSubview:self.userImg];
        
        // 发图 id
        self.headView.headDate.text = secondHand.creatorInfo.nickName;
        self.headView.headDate.frame = CGRectMake(self.userImg.frame.origin.x+self.userImg.frame.size.width+10, self.userImg.frame.origin.y, 200, 20);
        
        //发表日期
        self.headView.headPriceUnit.frame = CGRectMake(self.headView.headDate.frame.origin.x , self.headView.headDate.frame.origin.y + self.headView.headDate.frame.size.height, 200, 20);
        self.headView.headPriceUnit.text = secondHand.createTime;
        
        self.headView.headPrice.text = @"";

        
        
        [self addSubview:self.headView];
        
        GrayLine *firstLine = [[GrayLine alloc] initWithFrame:CGRectMake(0, self.headView.frame.size.height, frame.size.width, 15)];
        [self addSubview:firstLine];
        
        NSArray *fixArray = @[@"入手原价",@"转让价格"];
        NSString *originalPrice = [NSString stringWithFormat:@"%@元",secondHand.originalPrice];
        NSString *dealPrice = [NSString stringWithFormat:@"%@元",secondHand.dealPrice];
        NSArray *detailArray = @[originalPrice,dealPrice];
        
        for (int i = 0; i<2; i++) {
            
            UILabel *activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, firstLine.frame.origin.y+firstLine.frame.size.height + 10 +30*i , 80, 30)];
            activityLabel.text = fixArray[i];
            [self addSubview:activityLabel];
            
            UILabel *activityDetail = [[UILabel alloc] initWithFrame:CGRectMake(100, firstLine.frame.origin.y+firstLine.frame.size.height + 10 +30*i, 250, 30)];
            activityDetail.text = detailArray[i];
            activityDetail.textColor = [UIColor grayColor];
            [self addSubview:activityDetail];
            
        }
        
        GrayLine *secondLine = [[GrayLine alloc] initWithFrame:CGRectMake(20, firstLine.frame.origin.y+90, frame.size.width-20, 1)];
        [self addSubview:secondLine];
        
        //活动描述
        UILabel *describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, secondLine.frame.origin.y+5, 80, 30)];
        describeLabel.text = @"描述";
        [self addSubview:describeLabel];
        
        UITextView *describe = [[UITextView alloc] initWithFrame:CGRectMake(20, secondLine.frame.origin.y+40, frame.size.width-35, 200)];
        describe.text = secondHand.content;
        describe.font = [UIFont fontWithName:fontName size:15];
        describe.textColor = [UIColor grayColor];
        [self addSubview:describe];
        
        
        
    }
    
    return self;
}

@end
