//
//  ImagePickerCollectionViewCell.m
//  WeCommunity
//
//  Created by Harry on 8/26/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "ImagePickerCollectionViewCell.h"

@implementation ImagePickerCollectionViewCell


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;
}


-(UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

-(UIButton*)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(self.contentView.frame.size.width-27, 2, 25, 25);
        [self.contentView addSubview:_deleteBtn];
    }
    return _deleteBtn;
}

@end
