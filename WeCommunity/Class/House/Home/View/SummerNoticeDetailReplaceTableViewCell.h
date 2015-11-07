//
//  SummerNoticeDetailReplaceTableViewCell.h
//  WeCommunity
//
//  Created by madarax on 15/11/6.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SummerHomeDetailNoticeModel.h"

@interface SummerNoticeDetailReplaceTableViewCell : UITableViewCell

@property (nonatomic ,strong)UIImageView *cellTitleImg;
@property (nonatomic ,strong)UILabel *cellNameLab;
@property (nonatomic ,strong)UILabel *cellTimeLab;
@property (nonatomic ,strong)UILabel *cellContenLab;
@property (nonatomic ,strong)UIButton *cellReplayBtn;

- (void)confirmCellInformationWithData:(SummerHomeDetailNoticeModel *)dicTemp;

@end
