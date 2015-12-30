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
        CGFloat margin = (self.frame.size.width - 4*height)/5;
        self.addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addImageBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        self.addImageBtn.frame = CGRectMake(0, 0, height, height);
        [self addSubview:self.addImageBtn];
    }
    return self;
}


-(void)configureImage:(NSMutableArray*)imageArr{
    CGFloat margin = (self.frame.size.width - 4*height)/5;
    if (!self.addImageBtn) {
        self.addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addImageBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        self.addImageBtn.frame = CGRectMake(0, 0, height, height);
        [self addSubview:self.addImageBtn];
    }
    
    for (int i = 0; i<imageArr.count; i++) {
        UIImage *image = imageArr[i];
        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
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
    }else if(imageArr.count >= 4 && imageArr.count <= 7){
        self.addImageBtn.frame = CGRectMake((height+margin) * (imageArr.count-4), height+margin-5, height, height);
    }else{
        self.addImageBtn.frame = CGRectMake(SCREENSIZE.width, height+margin-5, height, height);
    }
}

- (void)selectImgView:(UITapGestureRecognizer_Data *)sender{
    [self.delegate returnTapImageViewTagIndex:sender.tapTagImg - 1000];
}

- (void)chuckSubViews{
    for (id views in self.subviews) {
        if ([views isKindOfClass:[UIImageView class]]) {
            [views removeFromSuperview];
        }        
    }
}

@end
