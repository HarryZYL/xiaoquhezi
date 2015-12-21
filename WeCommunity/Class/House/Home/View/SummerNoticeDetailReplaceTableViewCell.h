//
//  SummerNoticeDetailReplaceTableViewCell.h
//  WeCommunity
//
//  Created by madarax on 15/11/6.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AsyncDisplayKit/ASDisplayNode.h>
#import "SummerNoticeCenterDetailModel.h"

@protocol SummerNoticeDetailReplaceTableViewCellDelegate <NSObject>

- (void)summerNoticeDetailMoreClickWithData:(id)viewModel;

@end

@interface SummerNoticeDetailReplaceTableViewCell : UITableViewCell

@property (nonatomic ,weak)IBOutlet UIImageView *cellTitleImg;
@property (nonatomic ,weak)IBOutlet UILabel *cellNameLab;
@property (nonatomic ,weak)IBOutlet UILabel *cellTimeLab;
@property (nonatomic ,weak)IBOutlet UILabel *cellContenLab;
@property (nonatomic ,weak)IBOutlet UIButton *cellFloorBtn;
@property (nonatomic ,weak) id delegate;
@property (nonatomic ,copy) void(^tapImageView)(UIImageView *);

- (void)confirmCellInformationWithData:(SummerNoticeCenterDetailModel *)dicTemp;

@end
