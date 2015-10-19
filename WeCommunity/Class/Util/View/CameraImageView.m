//
//  CameraImageView.m
//  WeCommunity
//
//  Created by Harry on 9/20/15.
//  Copyright © 2015 Harry. All rights reserved.
//

#import "CameraImageView.h"

static CGFloat height = 65;

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
    
    CGFloat margin = (self.frame.size.width - 5*height)/4;
    
    for (int i = 0; i<imageArr.count; i++) {
        UIImage *image = imageArr[i];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = image;
        if (i<5) {
            imageView.frame = CGRectMake((height+margin)*i, 0, height, height);
        }else{
            imageView.frame = CGRectMake((height+margin)*(i-5), height+margin, height, height);
        }
        
        [self addSubview:imageView];
    }
    
    if (imageArr.count<5) {
        self.addImageBtn.frame = CGRectMake((height+margin) * imageArr.count, 0, height, height);
    }else{
        self.addImageBtn.frame = CGRectMake((height+margin) * (imageArr.count-5), height+margin, height, height);
    }

    
}


@end
