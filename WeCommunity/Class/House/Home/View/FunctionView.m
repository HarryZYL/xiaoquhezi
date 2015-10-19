//
//  FunctionView.m
//  WeCommunity
//
//  Created by Harry on 7/20/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "FunctionView.h"

@implementation FunctionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat itemWidth = 70;
        CGFloat itemHeight = 100;
        CGFloat itemMargin = (self.frame.size.width - 3*itemWidth)/2 ;
        self.firstItem = [[FuntionItem alloc] initWithFrame:CGRectMake(0, 0, itemWidth, itemHeight)];
        self.firstItem.functionButton.tag = 1;
        [self addSubview:self.firstItem];
        
        self.secondItem = [[FuntionItem alloc] initWithFrame:CGRectMake(itemWidth+itemMargin, 0, itemWidth, itemHeight)];
        self.secondItem.functionButton.tag = 2;
        [self addSubview:self.secondItem];
        
        self.thirdItem = [[FuntionItem alloc] initWithFrame:CGRectMake(itemWidth*2 + 2*itemMargin, 0, itemWidth, itemHeight)];
        self.thirdItem.functionButton.tag = 3;
        [self addSubview:self.thirdItem];
        
        self.fourthItem = [[FuntionItem alloc] initWithFrame:CGRectMake(0, 110, itemWidth, itemHeight)];
        self.fourthItem.functionButton.tag = 4;
        [self addSubview:self.fourthItem];
        
        self.fifthItem = [[FuntionItem alloc] initWithFrame:CGRectMake(itemWidth+itemMargin, 110,itemWidth, itemHeight)];
        self.fifthItem.functionButton.tag = 5;
        [self addSubview:self.fifthItem];
        
        self.sixthItem = [[FuntionItem alloc] initWithFrame:CGRectMake(itemWidth*2 + 2*itemMargin, 110, itemWidth, itemHeight)];
        self.sixthItem.functionButton.tag = 6;
        [self addSubview:self.sixthItem];
        
        
    }
    return self;
}

-(void)setupFunctionViewFirst:(NSString*)image1 title1:(NSString*)title1 Second:(NSString*)image2 title2:(NSString*)title2 Third:(NSString*)image3 title3:(NSString*)title3 Fourth:(NSString*)image4 title4:(NSString*)title4 Fifth:(NSString*)image5 title5:(NSString*)title5 Sixth:(NSString*)image6 title6:(NSString *)title6{
    
    [self.firstItem setupFunctionItemForImage:image1 TitleLabel:title1];
    [self.secondItem setupFunctionItemForImage:image2 TitleLabel:title2];
    [self.thirdItem setupFunctionItemForImage:image3 TitleLabel:title3];
    [self.fourthItem setupFunctionItemForImage:image4 TitleLabel:title4];
    [self.fifthItem setupFunctionItemForImage:image5 TitleLabel:title5];
    [self.sixthItem setupFunctionItemForImage:image6 TitleLabel:title6];

}
-(void)clearColor{
    [self.firstItem clearColor];
    [self.secondItem clearColor];
    [self.thirdItem clearColor];
    [self.fourthItem clearColor];
    [self.fifthItem clearColor];
    [self.sixthItem clearColor];

}
@end
