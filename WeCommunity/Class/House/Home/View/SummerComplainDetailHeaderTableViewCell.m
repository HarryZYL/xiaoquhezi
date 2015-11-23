//
//  SummerComplainDetailHeaderTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/11/8.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerComplainDetailHeaderTableViewCell.h"
#import "UITapGestureRecognizer+Data.h"

@implementation SummerComplainDetailHeaderTableViewCell
#define IMG_WIDTH 70
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _cellHeaderUserImg.layer.cornerRadius = _cellHeaderUserImg.frame.size.width/2;
    _cellHeaderUserImg.layer.masksToBounds = YES;
    for (NSInteger index = 0; index < 8; index ++) {
        UIImageView *imgView = (UIImageView *)[self viewWithTag:index + 1];
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer_Data *tapView = [[UITapGestureRecognizer_Data alloc] initWithTarget:self action:@selector(openUserImageView:)];
        tapView.tapTagImg = imgView.tag;
        [imgView addGestureRecognizer:tapView];
    }
}

- (void)confirmCellCompliteDetailWithData:(TextDeal *)dicTemp{
    [self.cellHeaderUserImg sd_setImageWithURL:dicTemp.creatorInfo.headPhoto placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
    self.cellHeaderName.text = dicTemp.creatorInfo.nickName;
    self.cellHeaderTime.frame = CGRectMake(60, _cellHeaderName.frame.origin.y + 20, SCREENSIZE.width - 100, 15);
    self.cellHeaderTime.text = dicTemp.createTime;
    
    self.cellHeaderContent.frame = CGRectMake(60, _cellHeaderTime.frame.origin.y + 20, SCREENSIZE.width - 70, 15);
    self.cellHeaderContent.text = dicTemp.content;
    
    self.cellHeaderReplayBtn.hidden = YES;
    
    for (int index = 0; index < 8; index ++) {
        UIImageView *imgViewInfo = (UIImageView *)[self.contentView viewWithTag:index + 1];
        imgViewInfo.frame = CGRectZero;
    }
    if ([dicTemp.pictures isEqual:[NSNull null]]) {
        return;
    }
    
    if (dicTemp.pictures.count > 0) {
        for (int indexPath = 0; indexPath < dicTemp.pictures.count; indexPath ++) {
            UIImageView *imgViewInfo = (UIImageView *)[self.contentView viewWithTag:indexPath + 1];
            [imgViewInfo sd_setImageWithURL:[NSURL URLWithString:dicTemp.pictures[indexPath]]];
            CGFloat xRow = 60 + (5 + IMG_WIDTH) * (indexPath%4);
            CGFloat yRow = _cellHeaderContent.frame.origin.y + _cellHeaderContent.frame.size.height + 10 + (IMG_WIDTH + 10) * (indexPath/4);
            imgViewInfo.frame = CGRectMake(xRow, yRow, IMG_WIDTH, IMG_WIDTH);
        }
    }

}

//配置section
- (void)confirmCellInformationWithData:(TextDeal *)dicTemp withHeightHeaderView:(CGFloat)headerView{
    [self.cellHeaderUserImg sd_setImageWithURL:dicTemp.creatorInfo.headPhoto placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
    self.cellHeaderName.text = dicTemp.creatorInfo.nickName;
    
    CGFloat heightContent = [Util getHeightForString:[dicTemp.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] width:SCREENSIZE.width - 80 font:[UIFont systemFontOfSize:15]];
    self.cellHeaderContent.text = [dicTemp.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    self.cellHeaderContent.frame = CGRectMake(60, 31, SCREENSIZE.width - 70, heightContent);
    
    self.cellHeaderTime.frame = CGRectMake(60, headerView - 20, SCREENSIZE.width - 100, 15);
    self.cellHeaderReplayBtn.frame = CGRectMake(SCREENSIZE.width - 64, headerView - 26, 64, 26);
    self.cellHeaderTime.text = dicTemp.createTime;
    [self.cellHeaderReplayBtn setTitle:[NSString stringWithFormat:@"%@",dicTemp.replyCount] forState:UIControlStateNormal];
    
    for (int index = 0; index < 8; index ++) {
        UIImageView *imgViewInfo = (UIImageView *)[self.contentView viewWithTag:index + 1];
        imgViewInfo.frame = CGRectZero;
    }
    if ([dicTemp.pictures isEqual:[NSNull null]]||[dicTemp.pictures.firstObject length]<5) {
        self.cellHeaderTime.frame = CGRectMake(60, self.cellHeaderContent.frame.origin.y + self.cellHeaderContent.frame.size.height+ 7, SCREENSIZE.width - 80, 15);
        self.cellHeaderReplayBtn.frame = CGRectMake(SCREENSIZE.width - 84, self.cellHeaderTime.frame.origin.y + 8, 64, 26);
        
        return;
    }
    
    if (dicTemp.pictures.count > 0 && [dicTemp.pictures.firstObject length] > 5) {
        for (int indexPath = 0; indexPath < dicTemp.pictures.count; indexPath ++) {
            UIImageView *imgViewInfo = (UIImageView *)[self.contentView viewWithTag:indexPath + 1];
            [imgViewInfo sd_setImageWithURL:[NSURL URLWithString:dicTemp.pictures[indexPath]]];
            CGFloat xRow = 60 + (20 + IMG_WIDTH) * (indexPath%3);
            CGFloat yRow = _cellHeaderContent.frame.origin.y + _cellHeaderContent.frame.size.height + 8 + (IMG_WIDTH + 8) * (indexPath/3);
            imgViewInfo.frame = CGRectMake(xRow, yRow, IMG_WIDTH, IMG_WIDTH);
            if (indexPath == dicTemp.pictures.count - 1) {
                self.cellHeaderTime.frame = CGRectMake(60, imgViewInfo.frame.origin.y + imgViewInfo.frame.size.height+ 7, SCREENSIZE.width - 80, 15);
                self.cellHeaderReplayBtn.frame = CGRectMake(SCREENSIZE.width - 84, self.cellHeaderTime.frame.origin.y + 8, 64, 26);
            }
        }
    }
    
}

- (void)openUserImageView:(UITapGestureRecognizer_Data *)sender{
    UIImageView *imgModel = (UIImageView *)[self viewWithTag:sender.tapTagImg];
    [self.delegate selectDetailHeaderCellImageView:imgModel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
