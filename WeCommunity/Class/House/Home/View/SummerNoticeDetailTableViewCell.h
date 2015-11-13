//
//  SummerNoticeDetailTableViewCell.h
//  WeCommunity
//
//  Created by madarax on 15/11/4.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummerNoticeDetailTableViewCell : UITableViewCell

@property (nonatomic ,weak)IBOutlet UIImageView *cellTitleImg;
@property (nonatomic ,weak)IBOutlet UILabel *cellLabTitle;
@property (nonatomic ,weak)IBOutlet UILabel *cellLabTime;
@property (nonatomic ,weak)IBOutlet UILabel *cellLabTop;
@property (nonatomic ,weak)IBOutlet UITextView *cellLabContent;
@property (nonatomic ,weak)IBOutlet UILabel *cellLabReplay;

//@property (nonatomic ,weak)IBOutlet UIWebView *cellWebView;
//@property (nonatomic ,weak)IBOutlet UIImageView *cellUserImg;
//@property (nonatomic ,weak)IBOutlet UILabel *cellTitleLab;
//@property (nonatomic ,weak)IBOutlet UILabel *cellTimeLab;

@end
