//
//  FuntionItem.m
//  WeCommunity
//
//  Created by Harry on 7/20/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "FuntionItem.h"

@implementation FuntionItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.functionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.functionButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
        [self addSubview:self.functionButton];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(-15, self.frame.size.width, self.frame.size.width+30, 30)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        [self addSubview:self.titleLabel];
        
        
    }
    return self;
}

-(void)setupFunctionItemForImage:(NSString *)imageName TitleLabel:(NSString *)title{
    if (imageName!=nil && title != nil) {
        [self.functionButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        self.titleLabel.text = title;
    }
}

-(void)chosen{
    self.titleLabel.textColor = THEMECOLOR;
}
-(void)clearColor{
    self.titleLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
}

@end
