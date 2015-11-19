//
//  RentDetailView.m
//  WeCommunity
//
//  Created by Harry on 7/29/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "RentDetailView.h"

@implementation RentDetailView

- (id)initWithFrame:(CGRect)frame andDataArray:(NSDictionary*)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.houseDeal = [[HouseDeal alloc] initWithData:dataArray];
        UIColor *fontColorGray = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        
        
        // head part
        self.headView = [[BasicHeadDetailView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width+100)];
//        self.headView.layer.borderWidth = 1;
//        self.headView.layer.borderColor = [UIColor colorWithWhite:0.851 alpha:1.000].CGColor;
        self.headImg = [[PageView alloc] initWithFrame:self.headView.headImg.frame andImagePathArr:self.houseDeal.pictures pageControl:NO];
        [self.headImg configureImagePageView:self.houseDeal.pictures];
        [self.headView addSubview:self.headImg];
        
        self.headView.headTitle.text = self.houseDeal.title;
        self.headView.headTitle.textColor = [UIColor colorWithWhite:0.259 alpha:1.000];
        [self.headView setUpPrice:[NSString stringWithFormat:@"%@",self.houseDeal.price]];
        
        self.headView.headPriceUnit.text = @"元/月";
        
        self.headView.headDate.text = self.houseDeal.createTime;
        self.headView.headDate.textColor = [UIColor colorWithWhite:0.533 alpha:1.000];
        [self addSubview:self.headView];
        
//        GrayLine *firstLine = [[GrayLine alloc] initWithFrame:CGRectMake(0, self.headView.headDate.frame.origin.y+self.headView.headDate.frame.size.height+5, frame.size.width, 15)];
//        firstLine.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
//        [self addSubview:firstLine];
        CALayer *firstLine = [[CALayer alloc] init];
        firstLine.frame = CGRectMake(0, self.headView.headDate.frame.origin.y+self.headView.headDate.frame.size.height+5, frame.size.width, 15);
        firstLine.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000].CGColor;
        firstLine.borderColor = [UIColor colorWithWhite:0.851 alpha:1.000].CGColor;
        
        [self.layer addSublayer:firstLine];
        
        // middle part
        CGFloat margin = 5;
        CGFloat heignt = 30;
        CGFloat width = (frame.size.width - 2*self.headView.headDate.frame.origin.x)/2;
        
        NSArray *fixArray = @[@"厅室",@"面积",@"朝向",@"概况",@"楼层",@""];
        NSString *room = [NSString stringWithFormat:@"%@室%@厅%@卫", self.houseDeal.room,self.houseDeal.sittingRoom,self.houseDeal.bathRoom ];
        NSString *area = [NSString stringWithFormat:@"%@平米",self.houseDeal.area];
        NSString *orientation = self.houseDeal.houseOrientation;
        NSString *houseType = self.houseDeal.houseType;
        NSString *floor = [NSString stringWithFormat:@"%@层/总%@层",self.houseDeal.floor,self.houseDeal.totalFloor];
        NSArray *detailArray = @[room,area,orientation,houseType,floor,@""];

        for (int i=0; i<3; i++) {
            for (int j=0; j<2; j++) {
                UILabel *fixLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headView.headDate.frame.origin.x+width*j, firstLine.frame.origin.y+firstLine.frame.size.height +margin +(margin + heignt)*i , 40, heignt)];
                fixLabel.text = fixArray[i*2 + j];
                fixLabel.textColor = [UIColor colorWithWhite:0.533 alpha:1.000];
                [self addSubview:fixLabel];

                
                UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headView.headDate.frame.origin.x+width*j +50, firstLine.frame.origin.y+firstLine.frame.size.height +margin +(margin + heignt)*i , 120, heignt)];
                detailLabel.text = detailArray[i*2 + j];
                detailLabel.textColor = [UIColor colorWithWhite:0.259 alpha:1.000];
                [self addSubview:detailLabel];
                
            }
        }
        
        GrayLine *secondLine = [[GrayLine alloc] initWithFrame:CGRectMake(0, firstLine.frame.origin.y+firstLine.frame.size.height+(heignt+margin)*3, frame.size.width, 15)];
        [self addSubview:secondLine];
        
        // address part
        
        CGFloat addressHeight = 40;
        NSArray *addressArray = @[@"小区",@"地址"];
        NSArray *addressDetailArray=@[self.houseDeal.community[@"name"],self.houseDeal.community[@"roadName"]];
        
        for (int i = 0 ; i<2; i++) {
            UILabel *fixLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headView.headTitle.frame.origin.x, secondLine.frame.origin.y+secondLine.frame.size.height +addressHeight*i, 40, addressHeight)];
            fixLabel.text = addressArray[i];
            fixLabel.textColor = [UIColor colorWithWhite:0.533 alpha:1.000];
            [self addSubview:fixLabel];
            
            UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headView.headTitle.frame.origin.x+50,secondLine.frame.origin.y+secondLine.frame.size.height +addressHeight*i, frame.size.width-50, addressHeight)];
            addressLabel.text = addressDetailArray[i];
            addressLabel.textColor = [UIColor colorWithWhite:0.259 alpha:1.000];
            [self addSubview:addressLabel];
        }
        
        GrayLine *addressLine = [[GrayLine alloc] initWithFrame:CGRectMake(0, secondLine.frame.origin.y+secondLine.frame.size.height + addressHeight, frame.size.width, 1)];
        [self addSubview:addressLine];
        
        GrayLine *thirdLine = [[GrayLine alloc] initWithFrame:CGRectMake(0, secondLine.frame.origin.y+secondLine.frame.size.height + addressHeight*2, frame.size.width, 15)];
        thirdLine.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
        [self addSubview:thirdLine];
        
        // description part
        UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headView.headTitle.frame.origin.x, thirdLine.frame.origin.y + thirdLine.frame.size.height, 100, 30)];
        descriptionLabel.textColor = [UIColor colorWithWhite:0.533 alpha:1.000];
        descriptionLabel.text = @"房源描述";
        [self addSubview:descriptionLabel];
        
        UITextView *descriptionView = [[UITextView alloc] initWithFrame:CGRectMake(self.headView.headTitle.frame.origin.x, descriptionLabel.frame.origin.y+descriptionLabel.frame.size.height, frame.size.width-2*self.headView.headTitle.frame.origin.x, 100)];
        descriptionView.text = self.houseDeal.content;
        descriptionView.font = [UIFont fontWithName:fontName size:15];
        descriptionView.textColor = [UIColor colorWithWhite:0.259 alpha:1.000];
        [self addSubview:descriptionView];

    }
    return self;
}

@end
