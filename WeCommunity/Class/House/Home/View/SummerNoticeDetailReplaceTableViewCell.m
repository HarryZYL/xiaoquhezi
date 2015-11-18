//
//  SummerNoticeDetailReplaceTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/11/6.
//  Copyright © 2015年 Harry. All rights reserved.
//
#import "UITapGestureRecognizer+Data.h"
#import "SummerNoticeDetailReplaceTableViewCell.h"

#define IMG_WIDTH 70
@implementation SummerNoticeDetailReplaceTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _cellTitleImg.layer.cornerRadius = _cellTitleImg.frame.size.width/2;
    _cellTitleImg.layer.masksToBounds = YES;
    UILabel *labeTapName = (UILabel *)[self.contentView viewWithTag:10];
    labeTapName.userInteractionEnabled = YES;
    UITapGestureRecognizer_Data *labTap = [[UITapGestureRecognizer_Data alloc] initWithTarget:self action:@selector(replayTapWithTag:)];
    labTap.tapTagImg = labeTapName.tag;
    [labeTapName addGestureRecognizer:labTap];
    
    UILabel *labeTapName1 = (UILabel *)[self.contentView viewWithTag:11];
    UITapGestureRecognizer_Data *labTap1 = [[UITapGestureRecognizer_Data alloc] initWithTarget:self action:@selector(replayTapWithTag:)];
    labTap1.tapTagImg = labeTapName1.tag;
    [labeTapName1 addGestureRecognizer:labTap1];
}

- (void)confirmCellInformationWithData:(SummerNoticeCenterDetailModel *)dicTemp{
    
    [_cellTitleImg sd_setImageWithURL:dicTemp.detailNoticeModel.creatorInFo.headPhoto placeholderImage:[UIImage imageNamed:@"宠物"]];
    NSString *strTime = [Util formattedDate:dicTemp.detailNoticeModel.createTime type:5];
    NSString *strName = [NSString stringWithFormat:@"%@  %@",dicTemp.detailNoticeModel.creatorInFo.nickName,strTime];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:strName];
    [attriStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]} range:NSMakeRange(0, dicTemp.detailNoticeModel.creatorInFo.nickName.length - 1)];
    [attriStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.463 alpha:1.000]} range:NSMakeRange(strName.length - strTime.length, strTime.length)];
    _cellNameLab.attributedText = attriStr;
    CGFloat contentHeight = [Util getHeightForString:dicTemp.detailNoticeModel.content width:SCREENSIZE.width - 100 font:[UIFont systemFontOfSize:14]];
    
    _cellContenLab.frame = CGRectMake(60, 30, SCREENSIZE.width - 100, contentHeight);
    _cellContenLab.text = dicTemp.detailNoticeModel.content;
    
    _cellFloorBtn.frame = CGRectMake(SCREENSIZE.width - 30, 10, 19, 19);
    
    for (int index = 0; index < 8; index ++) {
        UIImageView *imgViewInfo = (UIImageView *)[self.contentView viewWithTag:index + 1];
        imgViewInfo.frame = CGRectZero;
    }
    if (![dicTemp.detailNoticeModel.pictures isEqual:[NSNull null]]) {
        if (dicTemp.detailNoticeModel.pictures.count > 0) {
            for (int indexPath = 0; indexPath < dicTemp.detailNoticeModel.pictures.count; indexPath ++) {
                UIImageView *imgViewInfo = (UIImageView *)[self.contentView viewWithTag:indexPath + 1];
                [imgViewInfo sd_setImageWithURL:[NSURL URLWithString:dicTemp.detailNoticeModel.pictures[indexPath]]];
                CGFloat xRow = 60 + (10 + IMG_WIDTH) * (indexPath%4);
                CGFloat yRow = _cellContenLab.frame.origin.y + _cellContenLab.frame.size.height + 5 + (40 + 5) * (indexPath/4);
                imgViewInfo.frame = CGRectMake(xRow, yRow, IMG_WIDTH, IMG_WIDTH);
            }
        }
    }
    for (NSInteger index = 0; index < 3; index ++) {
        UIView *view = [self viewWithTag:index + 10];
        view.frame = CGRectZero;
    }
    if (![dicTemp.detailNoticeModel.pictures isEqual:[NSNull null]]) {
        for (NSInteger index = 0; index < dicTemp.detailReplyArrary.count; index ++) {
            UIImageView *imgViewInfo = (UIImageView *)[self.contentView viewWithTag:1];
            SummerHomeDetailNoticeModel *noticeDetail = dicTemp.detailReplyArrary[index];
            UILabel *labReplay = (UILabel *)[self viewWithTag:index + 10];
            NSString *strTemp;
            if (![noticeDetail.creatorInFo.nickName isEqual:[NSNull null]]) {
                strTemp = [NSString stringWithFormat:@"%@：%@  %@",noticeDetail.creatorInFo.nickName,noticeDetail.content,[Util formattedDate:noticeDetail.createTime type:5]];
                NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:strTemp];
                
                [attriStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(noticeDetail.creatorInFo.nickName.length + 1, strTemp.length - noticeDetail.creatorInFo.nickName.length - 1)];
                labReplay.attributedText = attriStr;
            }else{
                strTemp = [NSString stringWithFormat:@"%@：%@  %@",noticeDetail.creatorInFo.userName,noticeDetail.content,[Util formattedDate:noticeDetail.createTime type:5]];
                NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:strTemp];
                
                [attriStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(noticeDetail.creatorInFo.userName.length + 1, strTemp.length - noticeDetail.creatorInFo.userName.length - 1)];
                labReplay.attributedText = attriStr;
            }
            CGFloat replayLabHeight = [Util getHeightForString:strTemp width:SCREENSIZE.width - 90 font:[UIFont systemFontOfSize:15]];
            if (index == 0) {
                labReplay.frame = CGRectMake(60, imgViewInfo.frame.origin.y + imgViewInfo.frame.size.height + 5, SCREENSIZE.width - 70, ceil(replayLabHeight));
            }else{
                UILabel *labReplay1 = (UILabel *)[self viewWithTag:10];
                labReplay.frame = CGRectMake(60, labReplay1.frame.origin.y + labReplay1.frame.size.height, SCREENSIZE.width - 70, ceil(replayLabHeight));
            }
        }
    }else{
        for (NSInteger index = 0; index < dicTemp.detailReplyArrary.count; index ++) {
            SummerHomeDetailNoticeModel *noticeDetail = dicTemp.detailReplyArrary[index];
            UILabel *labReplay = (UILabel *)[self viewWithTag:index + 10];
            NSString *strTemp;
            if (![noticeDetail.creatorInFo.nickName isEqual:[NSNull null]]) {
                strTemp = [NSString stringWithFormat:@"%@：%@  %@",noticeDetail.creatorInFo.nickName,noticeDetail.content,[Util formattedDate:noticeDetail.createTime type:5]];
                NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:strTemp];
                
                [attriStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(noticeDetail.creatorInFo.nickName.length + 1, strTemp.length - noticeDetail.creatorInFo.nickName.length - 1)];
                labReplay.attributedText = attriStr;
            }else{
                strTemp = [NSString stringWithFormat:@"%@：%@  %@",noticeDetail.creatorInFo.userName,noticeDetail.content,[Util formattedDate:noticeDetail.createTime type:5]];
                NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:strTemp];
                
                [attriStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(noticeDetail.creatorInFo.userName.length + 1, strTemp.length - noticeDetail.creatorInFo.userName.length - 1)];
                labReplay.attributedText = attriStr;
            }
            CGFloat replayLabHeight = [Util getHeightForString:strTemp width:SCREENSIZE.width - 90 font:[UIFont systemFontOfSize:15]];
            if (index == 0) {
                labReplay.frame = CGRectMake(64, _cellContenLab.frame.origin.y + _cellContenLab.frame.size.height + 10, SCREENSIZE.width - 70, replayLabHeight);
            }else{
                UILabel *labReplay1 = (UILabel *)[self viewWithTag:10];
                labReplay.frame = CGRectMake(64, labReplay1.frame.origin.y + labReplay1.frame.size.height, SCREENSIZE.width - 70, replayLabHeight);
            }
            
        }
    }
    if (dicTemp.detailNoticeModel.childrenCount.intValue > 2) {
        UIButton *btnReply = (UIButton *)[self.contentView viewWithTag:12];
        btnReply.hidden = NO;
        btnReply.frame = CGRectMake(SCREENSIZE.width - 74, self.contentView.frame.size.height - 30, 74, 30);
        [btnReply setTitle:@"查看更多回复" forState:UIControlStateNormal];
    }else{
        UIButton *btnReply = (UIButton *)[self.contentView viewWithTag:12];
        btnReply.hidden = YES;
    }
}

- (void)replayTapWithTag:(UITapGestureRecognizer_Data *)sender{
    UILabel *lab = (UILabel *)[self.contentView viewWithTag:sender.tapTagImg];
    [self.delegate summerNoticeDetailMoreClickWithData:lab];
}

- (IBAction)summerMoreReply:(UIButton *)sender{
    [self.delegate summerNoticeDetailMoreClickWithData:sender];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end














