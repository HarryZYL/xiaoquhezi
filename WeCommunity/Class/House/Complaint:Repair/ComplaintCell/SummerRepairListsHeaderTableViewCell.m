//
//  SummerRepairListsHeaderTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/11/10.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerRepairListsHeaderTableViewCell.h"

@implementation SummerRepairListsHeaderTableViewCell
#define IMG_WIDTH 70
- (void)awakeFromNib {
    // Initialization code
    
}

- (void)confirmTableViewHeaderViewWithData:(TextDeal *)dicTemp{
    [self.cellTitleImageView sd_setImageWithURL:dicTemp.textType[@"logo"] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
    self.cellTitleName.text = [NSString stringWithFormat:@"%@",dicTemp.textType[@"name"]];
    CGFloat contentHeight = [Util getHeightForString:[dicTemp.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] width:SCREENSIZE.width - 20 font:[UIFont systemFontOfSize:15]];
    self.cellImagesView.frame = CGRectMake(10, 60, SCREENSIZE.width - 20, contentHeight + 10);
    self.cellContentLab.frame = CGRectMake(5, 5, SCREENSIZE.width - 30, contentHeight);
    
    self.cellContentLab.text = [dicTemp.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    for (NSInteger index = 0; index < 8; index ++) {
        UIImageView *img = (UIImageView *)[self.cellImagesView viewWithTag:index + 1];
        img.frame = CGRectZero;
    }
    
    if (![dicTemp.pictures isEqual:[NSNull null]]) {
        if (dicTemp.pictures.count > 0 && [dicTemp.pictures.firstObject length] > 5) {
            CGFloat imgHeight = 0;
            for (int indexPath = 0; indexPath < dicTemp.pictures.count; indexPath ++) {
                UIImageView *imgViewInfo = (UIImageView *)[self.contentView viewWithTag:indexPath + 1];
                [imgViewInfo sd_setImageWithURL:[NSURL URLWithString:dicTemp.pictures[indexPath]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
                CGFloat xRow = 5 + (20 + IMG_WIDTH) * (indexPath%4);
                CGFloat yRow = (IMG_WIDTH + 5) * (indexPath/4) + self.cellContentLab.frame.size.height + self.cellContentLab.frame.origin.y + 8;
                imgViewInfo.frame = CGRectMake(xRow, yRow, IMG_WIDTH, IMG_WIDTH);
                imgHeight = yRow + 10;
            }
            if ((dicTemp.pictures.count - 1) > 4) {
                contentHeight += imgHeight*(dicTemp.pictures.count - 1)/4 - 30;
            }else{
                contentHeight += 90;
            }
            
        }
        self.cellImagesView.frame = CGRectMake(10, 60, SCREENSIZE.width - 20, contentHeight);
    }
    
    
    self.cellRepairManView.frame = CGRectMake(10, self.cellImagesView.frame.origin.y + self.cellImagesView.frame.size.height + 5, SCREENSIZE.width - 20, 53);
    
    self.cellRepairPeople.text = [NSString stringWithFormat:@"报修人：%@",dicTemp.creatorInfo.nickName];
    self.cellPhoneNumber.text  = [NSString stringWithFormat:@"手机号：%@",dicTemp.phone];
    
    
    self.cellRepairTakeNote.frame = CGRectMake(10, self.cellRepairManView.frame.origin.y + self.cellRepairManView.frame.size.height + 10, SCREENSIZE.width - 20, 80);
    self.cellTakeNoteLab.text = [NSString stringWithFormat:@"维修记录"];
    
    self.cellLineLab.frame = CGRectMake(0, self.cellRepairManView.frame.size.height/2, self.cellRepairManView.frame.size.width, .5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end













