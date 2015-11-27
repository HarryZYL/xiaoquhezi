//
//  CameraImageView.h
//  WeCommunity
//
//  Created by Harry on 9/20/15.
//  Copyright © 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CameraImageViewDelegate <NSObject>

@optional
- (void)returnTapImageViewTagIndex:(NSInteger)index;

@end

@interface CameraImageView : UIView

@property (nonatomic ,strong) UIButton *addImageBtn;
@property (nonatomic ,weak) id delegate;

//- (void)setbtnAddSelectImage

- (void)configureImage:(NSMutableArray*)imageArr;
- (void)chuckSubViews;

@end
