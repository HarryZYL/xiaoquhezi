//
//  SummerRepairListsHeaderTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/11/10.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerRepairListsHeaderTableViewCell.h"

@implementation SummerRepairListsHeaderTableViewCell
#define IMG_WIDTH 40
- (void)awakeFromNib {
    // Initialization code
    
}

- (void)confirmTableViewHeaderViewWithData:(TextDeal *)dicTemp{
    [self.cellTitleImageView sd_setImageWithURL:dicTemp.creatorInfo.headPhoto placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
    self.cellTitleName.text = [NSString stringWithFormat:@"%@",dicTemp.textType[@"name"]];
    CGFloat contentHeight = [Util getHeightForString:[dicTemp.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] width:SCREENSIZE.width - 20 font:[UIFont systemFontOfSize:15]];
    
    self.cellContentLab.frame = CGRectMake(10, 5, self.cellImagesView.frame.size.width, contentHeight);
    self.cellContentLab.text = [dicTemp.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    for (NSInteger index = 0; index < 8; index ++) {
        UIImageView *img = (UIImageView *)[self.cellImagesView viewWithTag:index + 1];
        img.frame = CGRectZero;
    }
    for (NSInteger index = 0; index < dicTemp.pictures.count; index ++) {
        UIImageView *img = (UIImageView *)[self.cellImagesView viewWithTag:index + 1];
        [img sd_setImageWithURL:[NSURL URLWithString:dicTemp.pictures[index]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
    }
    
    if (![dicTemp.pictures isEqual:[NSNull null]]) {
        if (dicTemp.pictures.count > 0) {
            CGFloat imgHeight = 0;
            for (int indexPath = 0; indexPath < dicTemp.pictures.count; indexPath ++) {
                UIImageView *imgViewInfo = (UIImageView *)[self.contentView viewWithTag:indexPath + 1];
                [imgViewInfo sd_setImageWithURL:[NSURL URLWithString:dicTemp.pictures[indexPath]]];
                CGFloat xRow = 10 + (20 + 40) * (indexPath%4);
                CGFloat yRow = 10 + (40 + 5) * (indexPath/4) + self.cellContentLab.frame.size.height;
                imgViewInfo.frame = CGRectMake(xRow, yRow, IMG_WIDTH, IMG_WIDTH);
                imgHeight = yRow;
            }
            if (dicTemp.pictures.count >= 4) {
                contentHeight = 70 + imgHeight;
            }else{
                contentHeight = 70;
            }
        }
    }
    self.cellImagesView.frame = CGRectMake(10, 60, SCREENSIZE.width - 20, contentHeight);
    
    self.cellRepairPeople.text = [NSString stringWithFormat:@"报修人：%@",dicTemp.creatorInfo.nickName];
    self.cellPhoneNumber.text  = [NSString stringWithFormat:@"手机号：%@",dicTemp.phone];
    
    self.cellRepairManView.frame = CGRectMake(10, self.cellImagesView.frame.origin.y + self.cellImagesView.frame.size.height + 5, SCREENSIZE.width - 20, 53);
    self.cellRepairTakeNote.frame = CGRectMake(10, self.cellRepairManView.frame.origin.y + self.cellRepairManView.frame.size.height + 10, SCREENSIZE.width - 20, 80);
    self.cellTakeNoteLab.text = [NSString stringWithFormat:@"维修记录"];
    
    self.cellLineLab.frame = CGRectMake(0, self.cellRepairManView.frame.size.height/2, self.cellRepairManView.frame.size.width, .5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end













