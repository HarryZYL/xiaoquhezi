//
//  CameraImageView.m
//  WeCommunity
//
//  Created by Harry on 9/20/15.
//  Copyright © 2015 Harry. All rights reserved.
//

#import "CameraImageView.h"
#import "UITapGestureRecognizer+Data.h"

static CGFloat height = 70;

@implementation CameraImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addImageBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        self.addImageBtn.frame = CGRectMake(0, 0, height, height);
        [self addSubview:self.addImageBtn];
    }
    return self;
}

-(void)configureImage:(NSMutableArray*)imageArr{
    if (self.addImageBtn) {
        self.addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addImageBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        self.addImageBtn.frame = CGRectMake(0, 0, height, height);
        [self addSubview:self.addImageBtn];
    }
    
    CGFloat margin = (self.frame.size.width - 4*height)/3;
    
    for (int i = 0; i<imageArr.count; i++) {
        UIImage *image = imageArr[i];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 1000 + i;
        imageView.image = image;
        if (i<4) {
            imageView.frame = CGRectMake((height+margin)*i, 0, height, height);
        }else{
            imageView.frame = CGRectMake((height+margin)*(i-4), height+margin-5, height, height);
        }
        UITapGestureRecognizer_Data *tap = [[UITapGestureRecognizer_Data alloc] initWithTarget:self action:@selector(selectImgView:)];
        tap.tapTagImg = imageView.tag;
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
    }
    
    if (imageArr.count < 4) {
        self.addImageBtn.frame = CGRectMake((height+margin) * imageArr.count, 0, height, height);
    }else{
        self.addImageBtn.frame = CGRectMake((height+margin) * (imageArr.count-4), height+margin-5, height, height);
    }
}

- (void)selectImgView:(UITapGestureRecognizer_Data *)sender{
    [self.delegate returnTapImageViewTagIndex:sender.tapTagImg - 1000];
}

- (void)chuckSubViews{
    for (UIView *views in self.subviews) {
        [views removeFromSuperview];
    }
}

@end
