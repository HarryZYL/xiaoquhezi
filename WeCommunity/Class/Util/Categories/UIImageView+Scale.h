//
//  UIImageView+Scale.h
//  WeCommunity
//
//  Created by Harry on 9/13/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface  UIImageView (Scale)

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end
