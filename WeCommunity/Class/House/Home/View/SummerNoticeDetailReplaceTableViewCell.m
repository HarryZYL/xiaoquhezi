//
//  SummerNoticeDetailReplaceTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/11/6.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerNoticeDetailReplaceTableViewCell.h"
#define IMG_WIDTH 40
@implementation SummerNoticeDetailReplaceTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _cellTitleImg.layer.cornerRadius = _cellTitleImg.frame.size.width/2;
    _cellTitleImg.layer.masksToBounds = YES;
}

- (void)confirmCellInformationWithData:(SummerHomeDetailNoticeModel *)dicTemp{
    
    [_cellTitleImg sd_setImageWithURL:dicTemp.creatorInFo.headPhoto placeholderImage:[UIImage imageNamed:@"宠物"]];
    _cellNameLab.text = dicTemp.content;
    CGFloat contentHeight = [Util getHeightForString:dicTemp.content width:SCREENSIZE.width - 100 font:[UIFont systemFontOfSize:14]];
    _cellContenLab.frame = CGRectMake(69, 35, SCREENSIZE.width - 140, contentHeight);
    _cellContenLab.text = dicTemp.content;
    
    _cellTimeLab.text = dicTemp.createTime;
    _cellTimeBtn.frame = CGRectMake(SCREENSIZE.width - 80, 0, 80, 80);
    [_cellTimeBtn setTitle:dicTemp.createTime forState:UIControlStateNormal];
    
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
            CGFloat xRow = 69 + (5 + 40) * (indexPath%4);
            CGFloat yRow = _cellContenLab.frame.origin.y + _cellContenLab.frame.size.height + 5 + (40 + 5) * (indexPath/4);
            imgViewInfo.frame = CGRectMake(xRow, yRow, IMG_WIDTH, IMG_WIDTH);
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (UIImageView *)cellTitleImg{
//    _cellTitleImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 44, 44)];
//    return _cellTitleImg;
//}
//
//- (UILabel *)cellNameLab{
//    _cellNameLab = [[UILabel alloc] initWithFrame:CGRectMake(self.cellTitleImg.frame.origin.x + self.cellTitleImg.frame.size.width + 8, 10, 100, 15)];
//    return _cellNameLab;
//}
//
//- (UILabel *)cellTimeLab{
//    _cellTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(self.cellTitleImg.frame.origin.x + self.cellTitleImg.frame.size.width + 8, self.cellNameLab.frame.origin.y + self.cellNameLab.frame.size.height + 3, 200, 15)];
//    _cellTimeLab.font = [UIFont systemFontOfSize:14];
//    return _cellTimeLab;
//}
//
//- (UILabel *)cellContenLab{
//    _cellContenLab = [[UILabel alloc] init];
//    _cellContenLab.font = [UIFont systemFontOfSize:14];
//    return _cellContenLab;
//}
//
//- (UIButton *)cellReplayBtn{
//    _cellReplayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _cellReplayBtn.frame = CGRectMake(SCREENSIZE.width - 100, 0, 100, 50);
//    [_cellReplayBtn setTitleColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1] forState:UIControlStateNormal];
//    _cellReplayBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    return _cellReplayBtn;
//}

@end














