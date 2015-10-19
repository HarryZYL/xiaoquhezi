//
//  BasicHeadDetailView.m
//  WeCommunity
//
//  Created by Harry on 8/1/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "BasicHeadDetailView.h"

@implementation BasicHeadDetailView

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        UIColor *fontColorLigntGray = [UIColor lightGrayColor];
        // head part
        self.backgroundColor = [UIColor whiteColor];
        self.headImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width/1.5)];
        [self addSubview:self.headImg];
        
        self.headTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, self.headImg.frame.size.height +10, frame.size.width-40, 20)];
        self.headTitle.font = [UIFont fontWithName:fontName size:20];
        [self addSubview:self.headTitle];
        
        self.headPrice = [[UILabel alloc] init];
        self.headPrice.font = [UIFont fontWithName:fontName size:20];
        
        UIFont *font = self.headPrice.font;
        NSString *price = @"1000";
        CGSize stringsize = [price sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
        self.headPrice.frame = CGRectMake(self.headTitle.frame.origin.x, self.headTitle.frame.origin.y + self.headTitle.frame.size.height + 5, stringsize.width, stringsize.height);
        self.headPrice.textColor = [UIColor redColor];
        [self addSubview:self.headPrice];
        
        self.headPriceUnit = [[UILabel alloc] init];
        self.headPriceUnit.font = [UIFont fontWithName:fontName size:15];
        self.headPriceUnit.textColor = fontColorLigntGray;
        [self addSubview:self.headPriceUnit];
        
        self.headDate = [[UILabel alloc] initWithFrame:CGRectMake(self.headPrice.frame.origin.x,  self.headPrice.frame.origin.y+self.headPrice.frame.size.height +5 , frame.size.width-self.headPrice.frame.origin.x*2, 20)];
        self.headDate.font = [UIFont fontWithName:fontName size:15];
        self.headDate.textColor = fontColorLigntGray;
        [self addSubview:self.headDate];
    }
    return self;
}

-(void)setUpPrice:(NSString*)price{
    UIFont *font = self.headPrice.font;
    CGSize stringsize = [price sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    self.headPrice.frame = CGRectMake(self.headTitle.frame.origin.x, self.headTitle.frame.origin.y + self.headTitle.frame.size.height + 5, stringsize.width, stringsize.height);
    self.headPrice.text = price;
    
    self.headPriceUnit.frame = CGRectMake(self.headPrice.frame.origin.x+self.headPrice.frame.size.width+2, self.headPrice.frame.origin.y+self.headPrice.frame.size.height - 18, 40, 15);
}

@end
