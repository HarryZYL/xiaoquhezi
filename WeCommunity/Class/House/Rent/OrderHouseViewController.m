//
//  OrderHouseViewController.m
//  WeCommunity
//
//  Created by Harry on 7/30/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "OrderHouseViewController.h"
#import "UIViewController+HUD.h"
#import "NSString+HTML.h"

@interface OrderHouseViewController ()

@end

@implementation OrderHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    self.loadingView.titleLabel.text = @"正在加载";
    [self setupAppearance];
}

-(void)setupAppearance{
    
    User *user = [[User alloc] initWithData];
    
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(30, 84, self.view.frame.size.width-60, 40)];
    [self.nameField setBorderStyle:UITextBorderStyleRoundedRect];
    self.nameField.text = user.nickName;
    [self.view addSubview:self.nameField];
    
    self.tellField = [[UITextField alloc] initWithFrame:CGRectMake(self.nameField.frame.origin.x, self.nameField.frame.origin.y+self.nameField.frame.size.height+5, self.nameField.frame.size.width, self.nameField.frame.size.height)];
    self.tellField.placeholder = @"请输入您的手机号";
    self.tellField.text = user.userName;
    [self.tellField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:self.tellField];
    
    self.dateBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.dateBtn.frame =CGRectMake(self.nameField.frame.origin.x, self.tellField.frame.origin.y + self.tellField.frame.size.height +5 , self.nameField.frame.size.width, self.nameField.frame.size.height);
    [self.dateBtn setTitle:@"请选择预约时间" forState:UIControlStateNormal];
    [self.dateBtn addTarget:self action:@selector(setupDatePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dateBtn];
    
    self.orderBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.orderBtn configureButtonTitle:@"预约" backgroundColor:THEMECOLOR];
    [self.orderBtn addTarget:self action:@selector(booking) forControlEvents:UIControlEventTouchUpInside];
    [self.orderBtn roundRect];
    self.orderBtn.frame = CGRectMake(40, self.dateBtn.frame.origin.y+self.dateBtn.frame.size.height+10, self.view.frame.size.width-80, 40);
    [self.view addSubview:self.orderBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)booking{
    [self selfViewEndEditing];
    if (self.nameField.text.length < 1 || [self.nameField.text isEqualToString:@" "]) {
        [self showHint:@"请输入姓名"];
        return;
    }
    if ([self.dateBtn.titleLabel.text isEqualToString:@"请选择预约时间"]) {
        [self showHint:@"请选择预约时间"];
    }else if (![NSString filterPhoneNumber:self.tellField.text]){
        [self showHint:@"手机号码不正确"];
        return;
    }else{
        [self.view addSubview:self.loadingView];
        NSDictionary *parameters = @{
                                     @"token":[User getUserToken],
                                     @"id":self.houseID,
                                     @"name":self.nameField.text,
                                     @"phone":self.tellField.text,
                                     @"time":self.dateBtn.titleLabel.text
                                     };
        [Networking retrieveData:bookingHouse parameters:parameters success:^(id responseObject) {
            [self showHint:@"预约成功"];
            [self.delegate orderHouseRentSeccess];
            [self.navigationController popViewControllerAnimated:YES];
            
        } addition:^{
            [self.loadingView removeFromSuperview];
        }];

    }
}

#pragma mark date picker

-(void)setupDatePicker{
    // UIDatePicker控件的常用方法  时间选择控件
    [self.view endEditing:YES];
    [self.oneDatePicker removeFromSuperview];
    self.oneDatePicker = [[UIDatePicker alloc] init];
    self.oneDatePicker.frame = CGRectMake(0, self.orderBtn.frame.origin.y + 40, self.view.frame.size.width, 110); // 设置显示的位置和大小
    NSDate *minDate = [NSDate dateWithTimeIntervalSinceNow:15*60];
    self.oneDatePicker.minimumDate = minDate;
    
    self.oneDatePicker.date = [NSDate date]; // 设置初始时间
    // [oneDatePicker setDate:[NSDate dateWithTimeIntervalSinceNow:48 * 20 * 18] animated:YES]; // 设置时间，有动画效果
    self.oneDatePicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"]; // 设置时区，中国在东八区
//    self.oneDatePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 30 * 60 * 60 * -1]; // 设置最小时间
    self.oneDatePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 30 * 60 * 60]; // 设置最大时间
    
    self.oneDatePicker.datePickerMode = UIDatePickerModeDateAndTime; // 设置样式
      
    [self.oneDatePicker addTarget:self action:@selector(oneDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // 添加监听器
    
    [self.view addSubview:self.oneDatePicker]; // 添加到View上
}

#pragma mark - 实现oneDatePicker的监听方法
- (void)oneDatePickerValueChanged:(UIDatePicker *) sender {
    NSDate *select = [sender date]; // 获取被选中的时间
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm"; // 设置时间和日期的格式
    NSString *dateAndTime = [selectDateFormatter stringFromDate:select]; // 把date类型转为设置好格式的string类型
    [self.dateBtn setTitle:dateAndTime forState:UIControlStateNormal];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self selfViewEndEditing];
}

- (void)selfViewEndEditing{
    [self.view endEditing:YES];
    [UIView animateWithDuration:.3 animations:^{
        self.oneDatePicker.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 250);
    }];
}

@end
