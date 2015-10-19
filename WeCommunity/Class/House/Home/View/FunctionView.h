//
//  FunctionView.h
//  WeCommunity
//
//  Created by Harry on 7/20/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FuntionItem.h"
@interface FunctionView : UIView

@property (nonatomic,strong) FuntionItem *firstItem;
@property (nonatomic,strong) FuntionItem *secondItem;
@property (nonatomic,strong) FuntionItem *thirdItem;
@property (nonatomic,strong) FuntionItem *fourthItem;
@property (nonatomic,strong) FuntionItem *fifthItem;
@property (nonatomic,strong) FuntionItem *sixthItem;

-(void)setupFunctionViewFirst:(NSString*)image1 title1:(NSString*)title1 Second:(NSString*)image2 title2:(NSString*)title2 Third:(NSString*)image3 title3:(NSString*)title3 Fourth:(NSString*)image4 title4:(NSString*)title4 Fifth:(NSString*)image5 title5:(NSString*)title5 Sixth:(NSString*)image6 title6:(NSString *)title6;
-(void)clearColor;
@end
