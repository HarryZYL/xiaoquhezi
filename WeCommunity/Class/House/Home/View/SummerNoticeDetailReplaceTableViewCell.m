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

@interface SummerNoticeDetailReplaceTableViewCell ()
@property(nonatomic ,weak)IBOutlet NSLayoutConstraint *cellContentLayout;
@property(nonatomic ,weak)IBOutlet NSLayoutConstraint *cellBootomLayout;
@end

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
    [_cellTitleImg sd_setImageWithURL:dicTemp.detailNoticeModel.creatorInFo.headPhoto placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
    _cellNameLab.text = dicTemp.detailNoticeModel.creatorInFo.nickName;
    _cellTimeLab.text = [Util formattedDate:dicTemp.detailNoticeModel.createTime type:5];
    _cellContenLab.text = dicTemp.detailNoticeModel.content;
    
    //清空上次的状态
    if (dicTemp.detailReplyArrary.count > 0) {
        self.cellBootomLayout.constant = 5;
    }else{
        self.cellBootomLayout.constant = 55;
    }
    for (int index = 0; index < 3; index ++) {
        UIImageView *imgViewInfo = (UIImageView *)[self.contentView viewWithTag:index + 1];
        imgViewInfo.hidden = YES;
    }
    for (NSInteger index = 0; index < 3; index ++) {
        UIView *view = [self viewWithTag:index + 10];
        view.hidden = YES;
    }
    UILabel *labLine = (UILabel *)[self viewWithTag:9];
    if (dicTemp.detailReplyArrary.count) {
        labLine.hidden = NO;
    }else{
        labLine.hidden = YES;
    }
    
    if (![dicTemp.detailNoticeModel.pictures isEqual:[NSNull null]]) {
        self.cellContentLayout.constant = 85;
        if(dicTemp.detailNoticeModel.pictures.count > 3){
            for (NSInteger index = 0; index < 3; index ++) {
                UIImageView *imgViewInfo = (UIImageView *)[self.contentView viewWithTag:index + 1];
                imgViewInfo.hidden = NO;
                [imgViewInfo sd_setImageWithURL:[NSURL URLWithString:dicTemp.detailNoticeModel.pictures[index]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
            }
        }else{
            for (NSInteger index = 0; index < dicTemp.detailNoticeModel.pictures.count; index ++) {
                UIImageView *imgViewInfo = (UIImageView *)[self.contentView viewWithTag:index + 1];
                imgViewInfo.hidden = NO;
                [imgViewInfo sd_setImageWithURL:[NSURL URLWithString:dicTemp.detailNoticeModel.pictures[index]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
            }
        }
    }else{
        self.cellContentLayout.constant = 8;
    }
    for (NSInteger index = 0; index < dicTemp.detailReplyArrary.count; index ++) {
        
        SummerHomeDetailNoticeModel *noticeDetail = dicTemp.detailReplyArrary[index];
        UILabel *labReplay = (UILabel *)[self viewWithTag:index + 10];
        labReplay.hidden = NO;
        NSString *strTemp;
        if (![noticeDetail.creatorInFo.nickName isEqual:[NSNull null]]) {
            strTemp = [NSString stringWithFormat:@"%@：%@  %@",noticeDetail.creatorInFo.nickName,noticeDetail.content,[Util formattedDate:noticeDetail.createTime type:5]];
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:strTemp];
            
            [attriStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.259 alpha:1.000]} range:NSMakeRange(noticeDetail.creatorInFo.nickName.length + 1, strTemp.length - noticeDetail.creatorInFo.nickName.length - 1)];
            
            [attriStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.533 alpha:1.000]} range:NSMakeRange(strTemp.length - 5, 5)];
            
            labReplay.attributedText = attriStr;
        }else{
            strTemp = [NSString stringWithFormat:@"%@：%@  %@",noticeDetail.creatorInFo.userName,noticeDetail.content,[Util formattedDate:noticeDetail.createTime type:5]];
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:strTemp];
            
            [attriStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.259 alpha:1.000]} range:NSMakeRange(noticeDetail.creatorInFo.userName.length + 1, strTemp.length - noticeDetail.creatorInFo.userName.length - 1)];
            
            [attriStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.533 alpha:1.000]} range:NSMakeRange(strTemp.length - 5, 5)];
            
            labReplay.attributedText = attriStr;
        }
    }
    
    if (dicTemp.detailNoticeModel.childrenCount.intValue > 2) {
        
        UIButton *btnReply = (UIButton *)[self.contentView viewWithTag:12];
        btnReply.hidden = NO;
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














