//
//  BottomBtn.h
//  WeCommunity
//
//  Created by Harry on 7/29/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
@interface  UIButton (BottomBtn)

-(void)configureButtonTitle:(NSString*)title backgroundColor:(UIColor*)color;
-(void)leftStyle;
-(void)roundRect;
@end
