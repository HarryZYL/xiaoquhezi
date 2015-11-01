//
//  SummerPhoneNumberViewController.h
//  WeCommunity
//
//  Created by madarax on 15/10/31.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummerPhoneNumberViewController : UIViewController

@property (nonatomic ,weak)IBOutlet UITextField *phoneNumber;
@property (nonatomic ,weak)IBOutlet UITextField *remainField;
@property (nonatomic ,weak)IBOutlet UIButton *btnRemain;
@property (nonatomic ,weak)IBOutlet UIButton *suerBtn;
@property (nonatomic ,copy)NSString *strPhoneNumber;
@property (nonatomic,assign) int    timeIntervar;

@end
