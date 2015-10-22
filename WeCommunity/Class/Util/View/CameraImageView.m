//
//  CameraImageView.m
//  WeCommunity
//
//  Created by Harry on 9/20/15.
//  Copyright © 2015 Harry. All rights reserved.
//

#import "CameraImageView.h"

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
    
    CGFloat margin = (self.frame.size.width - 4*height)/3;
    
    for (int i = 0; i<imageArr.count; i++) {
        UIImage *image = imageArr[i];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = image;
        if (i<4) {
            imageView.frame = CGRectMake((height+margin)*i, 0, height, height);
        }else{
            imageView.frame = CGRectMake((height+margin)*(i-4), height+margin-5, height, height);
        }
        
        [self addSubview:imageView];
    }
    
    if (imageArr.count<4) {
        self.addImageBtn.frame = CGRectMake((height+margin) * imageArr.count, 0, height, height);
    }else{
        self.addImageBtn.frame = CGRectMake((height+margin) * (imageArr.count-4), height+margin, height, height);
    }

    
}


@end
