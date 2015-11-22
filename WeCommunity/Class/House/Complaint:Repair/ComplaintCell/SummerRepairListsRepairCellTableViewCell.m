//
//  SummerRepairListsRepairCellTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/11/10.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerRepairListsRepairCellTableViewCell.h"

@implementation SummerRepairListsRepairCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)confirmsCellDataWithData:(NSDictionary *)dicTemp{
    [self.cellTitleImg sd_setImageWithURL:[NSURL URLWithString:dicTemp[@"creatorInfo"][@"headPhoto"]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
    self.cellTitleName.text = dicTemp[@"creatorInfo"][@"nickName"];
    self.cellTimeLab.text = [Util formattedDate:dicTemp[@"createTime"] type:1];
    self.cellContent.text = [dicTemp[@"content"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    self.cellContent.backgroundColor = [UIColor redColor];
    for (NSInteger index = 0; index < 3; index ++) {
        UIImageView *img = (UIImageView *)[self viewWithTag:index + 1];
        img.hidden = YES;
    }
    NSArray *arraryImages = dicTemp[@"pictures"];
    if ([arraryImages isEqual:[NSNull null]]) {
        self.cellContentLayout.constant = 8;
        return;
    }else{
        if (arraryImages.count > 3) {
            for (NSInteger index = 0; index < 3; index ++) {
                UIImageView *img = (UIImageView *)[self viewWithTag:index + 1];
                img.hidden = NO;
                [img sd_setImageWithURL:[NSURL URLWithString:arraryImages[index]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
            }
        }else{
            for (NSInteger index = 0; index < arraryImages.count; index ++) {
                UIImageView *img = (UIImageView *)[self viewWithTag:index + 1];
                img.hidden = NO;
                [img sd_setImageWithURL:[NSURL URLWithString:arraryImages[index]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
            }
        }
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
