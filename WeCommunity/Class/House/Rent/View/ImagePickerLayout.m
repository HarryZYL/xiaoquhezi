//
//  ImagePickerLayout.m
//  WeCommunity
//
//  Created by Harry on 8/26/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "ImagePickerLayout.h"

@implementation ImagePickerLayout

-(void)prepareLayout{
    [super prepareLayout];
    UIViewController *viewController =[[UIViewController alloc] init];
    CGFloat width =viewController.view.frame.size.width;
    self.minimumInteritemSpacing = 8;
    self.minimumLineSpacing = 8;
    self.itemSize = CGSizeMake((width-2*self.minimumInteritemSpacing)/3,(width-2*self.minimumInteritemSpacing)/3);
}


@end
