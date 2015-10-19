//
//  UIImageExt.h
//  Dsmart
//
//  Created by Harry on 15/2/3.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageExt : UIImage

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end
