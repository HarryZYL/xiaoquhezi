//
//  CameraImageView.h
//  WeCommunity
//
//  Created by Harry on 9/20/15.
//  Copyright © 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraImageView : UIView

@property (nonatomic,strong) UIButton *addImageBtn;
-(void)configureImage:(NSMutableArray*)imageArr;
@end
