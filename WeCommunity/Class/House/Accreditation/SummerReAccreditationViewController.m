//
//  SummerReAccreditationViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/27.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerReAccreditationViewController.h"
#import "UIViewController+HUD.h"
#import "NSString+HTML.h"
#import "LocationTableViewController.h"

@interface SummerReAccreditationViewController ()<UITextFieldDelegate ,LocationTableViewControllerDelegate ,UIScrollViewDelegate ,UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIView *topView;
    UIView *botomView;
    
    NSArray *hourseLeve;
    UIButton *btnUnit;
    
    NSString *strUnitID;
    
    NSString *strBuildName;
    NSString *strUnitName;
    NSString *strRoomName;
}

@end

@implementation SummerReAccreditationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"再次认证";
    self.strCommunityID = _dicAccreditation[@"communityId"];
    self.houseId = _dicAccreditation[@"houseId"];
    strUnitID = _dicAccreditation[@"parentIds"][1];
    self.strCommunityName = _dicAccreditation[@"community"][@"name"];
    [self initWithSelfData];
    [self setupAppearance];
    [self initViewsLeves];
}

- (void)initWithSelfData{
    self.owerType = self.dicAccreditation[@"ownerType"];
    self.buildingId = self.dicAccreditation[@"parentIds"][0];
    
    strBuildName = self.dicAccreditation[@"parentNames"][0];
    strRoomName = self.dicAccreditation[@"parentNames"][2];
    strUnitName= self.dicAccreditation[@"parentNames"][1];
    if ([_dicAccreditation[@"parentIds"] count] == 3) {
        self.buildingId = _dicAccreditation[@"parentIds"][0];
        self.strUnit = _dicAccreditation[@"parentIds"][1];
        self.houseId = _dicAccreditation[@"parentIds"][2];
    }else{
        self.buildingId = _dicAccreditation[@"parentIds"][0];
        self.houseId = _dicAccreditation[@"parentIds"][1];
        
    }
}

-(void)setupAppearance{
    NSArray *picArr = @[@"姓名",@"证件号码",@"身份类型",@"小区名称"];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+50);
    [self.view addSubview:self.scrollView];
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREENSIZE.width, 140)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:topView];
    
    for (NSInteger index = 0; index < 3; index ++) {
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15 + 45*index, 20, 20)];
        iconView.image = [UIImage imageNamed:picArr[index]];
        [topView addSubview:iconView];
        if (index != 2) {
            CALayer *lineLayer = [CALayer layer];
            lineLayer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
            lineLayer.frame = CGRectMake(10, 60 + 42 * index , SCREENSIZE.width - 20, .5);
            [self.scrollView.layer addSublayer:lineLayer];
        }
        switch (index) {
            case 0:
                self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(60, 12, self.view.frame.size.width - 40, 30)];
                self.nameField.placeholder = self.titleArray[index];
                self.nameField.text = _dicAccreditation[@"realName"];
                self.nameField.delegate = self;
                [topView addSubview:self.nameField];
                break;
                
            case 1:
                self.cardNumberField = [[UITextField alloc] initWithFrame:CGRectMake(60, 55, SCREENSIZE.width - 40, 30)];
                self.cardNumberField.keyboardType = UIKeyboardTypeNumberPad;
                self.cardNumberField.placeholder = self.titleArray[index];
                self.cardNumberField.text = _dicAccreditation[@"cardNumber"];
                self.cardNumberField.delegate = self;
                [topView addSubview:self.cardNumberField];
                break;
                
            case 2:
                self.owerTypeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                self.owerTypeBtn.frame = CGRectMake(60, 100, SCREENSIZE.width - 40, 30);
                [self.owerTypeBtn leftStyle];
                [self.owerTypeBtn setTitle:_dicAccreditation[@"ownerTypeName"] forState:UIControlStateNormal];
                self.owerType = _dicAccreditation[@"ownerType"];
                [topView addSubview:self.owerTypeBtn];
                break;
                
            default:
                break;
        }
    }
    
    
    botomView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.frame.origin.y + topView.frame.size.height + 20, SCREENSIZE.width, 50)];
    botomView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:botomView];
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.submitBtn.frame = CGRectMake(40, botomView.frame.size.height + botomView.frame.origin.y + 60, self.view.frame.size.width-80, 40);
    [self.submitBtn configureButtonTitle:@"提交" backgroundColor:THEMECOLOR];
    [self.submitBtn addTarget:self action:@selector(uploadAccreditation) forControlEvents:UIControlEventTouchUpInside];
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 5;
    
    
    self.owerTypeBtn.tag = 1;
    
    [self.owerTypeBtn addTarget:self action:@selector(selectPicker:) forControlEvents:UIControlEventTouchUpInside];
    
    self.owerTypeArr = @[@"户主",@"业主"];
    self.owerTypeArrEn = @[@"Owner",@"NoOwner"];
    self.buildingArr = @[@"1",@"2",@"3"];
    self.houseArr = @[@"101",@"102"];
    self.pickerStr = nil;
    
    [self.scrollView addSubview:self.submitBtn];
    [self.loadingView removeFromSuperview];
//    [self initWithBootomViews];
}

- (void)initWithBootomViews{
    botomView.frame = CGRectMake(0, topView.frame.origin.y + topView.frame.size.height + 20, SCREENSIZE.width, 45 * hourseLeve.count + 45);
    NSArray *titleArraryName;
    if (hourseLeve.count == 2) {
        titleArraryName = @[self.strCommunityName,@"点击选择楼号",@"请选择房号"];
    }else if (hourseLeve.count == 3) {
        titleArraryName = @[self.strCommunityName,@"点击选择楼号",@"请选择单元号",@"请选择房号"];
    }else{
        titleArraryName = @[self.strCommunityName];
    }
    
    for (NSInteger index = 0; index < hourseLeve.count + 1; index ++) {
        if (index != hourseLeve.count) {
            CALayer *lineLayer = [CALayer layer];
            lineLayer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
            lineLayer.frame = CGRectMake(10, 45 + 42 * index , SCREENSIZE.width - 20, .5);
            [botomView.layer addSublayer:lineLayer];
        }
        switch (index) {
            case 0:
            {
                UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
                iconView.image = [UIImage imageNamed:@"小区名称"];
                [botomView addSubview:iconView];
                
                self.communityName = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                self.communityName.frame = CGRectMake(60, 10, SCREENSIZE.width - 70, 30);
                [self.communityName leftStyle];
                [botomView addSubview:self.communityName];
                [self.communityName setTitle:_strCommunityName forState:UIControlStateNormal];
                [self.communityName setTitle:titleArraryName[index] forState:UIControlStateNormal];
                
            }
                break;
            case 1:
                self.buildingIDBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                self.buildingIDBtn.frame = CGRectMake(60, 50, SCREENSIZE.width - 70, 30);
                [self.buildingIDBtn leftStyle];
                if (strBuildName) {
                    [self.buildingIDBtn setTitle:[_dicAccreditation[@"parentNames"] firstObject] forState:UIControlStateNormal];
                }else{
                    [self.buildingIDBtn setTitle:titleArraryName[index] forState:UIControlStateNormal];
                }
                [botomView addSubview:self.buildingIDBtn];
                
                break;
            case 2:
                if (hourseLeve.count == 2) {
                    self.houseIDBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    self.houseIDBtn.frame = CGRectMake(60, 95, SCREENSIZE.width - 70, 30);
                    [self.houseIDBtn leftStyle];
                    if (strRoomName) {
                        [self.houseIDBtn setTitle:_dicAccreditation[@"parentNames"][1] forState:UIControlStateNormal];
                    }else{
                        [self.houseIDBtn setTitle:titleArraryName[index] forState:UIControlStateNormal];
                    }
                    [botomView addSubview:self.houseIDBtn];
                }else if (hourseLeve.count == 3){
                    btnUnit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    btnUnit.frame = CGRectMake(60, 95, SCREENSIZE.width - 70, 30);
                    [btnUnit leftStyle];
                    [btnUnit setTitle:titleArraryName[index] forState:UIControlStateNormal];
                    if (strUnitName) {
                        [btnUnit setTitle:_dicAccreditation[@"parentNames"][1] forState:UIControlStateNormal];
                    }
                    [botomView addSubview:btnUnit];
                }
                
                break;
            case 3:
                self.houseIDBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                self.houseIDBtn.frame = CGRectMake(60, 140, SCREENSIZE.width - 70, 30);
                [self.houseIDBtn leftStyle];
                if (strRoomName) {
                    [self.houseIDBtn setTitle:_dicAccreditation[@"parentNames"][2] forState:UIControlStateNormal];
                }else{
                    [self.houseIDBtn setTitle:titleArraryName[index] forState:UIControlStateNormal];
                }
                [botomView addSubview:self.houseIDBtn];
                break;
                
            default:
                break;
        }
    }
    self.buildingIDBtn.tag = 2;
    self.houseIDBtn.tag = 3;
    btnUnit.tag = 4;
    
    self.submitBtn.frame = CGRectMake(40, botomView.frame.size.height + botomView.frame.origin.y + 60, self.view.frame.size.width-80, 40);
    [btnUnit addTarget:self action:@selector(getUnitID:) forControlEvents:UIControlEventTouchUpInside];
    [self.buildingIDBtn addTarget:self action:@selector(getBuildingID:) forControlEvents:UIControlEventTouchUpInside];
    [self.houseIDBtn addTarget:self action:@selector(getHouseIdForBuilding:) forControlEvents:UIControlEventTouchUpInside];
    [self.communityName addTarget:self action:@selector(getOtherCommunityName) forControlEvents:UIControlEventTouchUpInside];
}

-(void)uploadAccreditation{
    [self.view endEditing:YES];
    if (self.nameField.text.length == 0) {
        [self showHint:@"请输入姓名"];
        return;
    }else if(![NSString filterIDCard:self.cardNumberField.text]){
        [self showHint:@"请输入正确的身份证号"];
        return;
    }else if (self.owerType == nil){
        [self showHint:@"请选择身份类型"];
        return;
    }else if (self.buildingId == nil){
        [self showHint:@"请选择楼号"];
        return;
    }else if (self.houseId == nil){
        [self showHint:@"请选择房号"];
        return;
    }else{
        [self.view addSubview:self.loadingView];
        NSDictionary *parameters;
        
        NSUInteger index = [self.owerTypeArrEn indexOfObject:self.owerType];
        if (hourseLeve.count == 2) {
            parameters = @{
                           @"id":self.dicAccreditation[@"id"],
                           @"token":[User getUserToken],
                           @"communityId":self.strCommunityID,
                           @"realName":self.nameField.text,
                           @"cardType":@"IdCard",
                           @"cardNumber":self.cardNumberField.text,
                           @"houseId":self.houseId,
                           @"ownerType":self.owerTypeArrEn[index]
                           };
        }else{
            parameters = @{
                           @"id":self.dicAccreditation[@"id"],
                           @"token":[User getUserToken],
                           @"communityId":self.strCommunityID,
                           @"realName":self.nameField.text,
                           @"cardType":@"IdCard",
                           @"cardNumber":self.cardNumberField.text,
                           @"houseId":self.houseId,
                           @"ownerType":self.owerTypeArrEn[index]
                           };
        }
        [Networking retrieveData:get_Apple_ReAuthentication parameters:parameters success:^(id responseObject) {
            [self.loadingView removeFromSuperview];
            [self.delegate issueCertifySeccessful];
            [self.navigationController popViewControllerAnimated:YES];
        } addition:^{
            [self.loadingView removeFromSuperview];
        }];
    }
}

-(void)getBuildingID:(id)sender{
    [self.view addSubview:self.loadingView];//小区号－－－－>楼号
    NSDictionary *parama = @{@"communityId":self.strCommunityID};
    [Networking retrieveData:getBuilding parameters:parama success:^(id responseObject) {
        self.buildingArr = responseObject;
        [self.loadingView removeFromSuperview];
        //pickerView
        [self selectPicker:sender];
    } addition:^{
        [self.loadingView removeFromSuperview];
    }];
    
}

- (void)getUnitID:(id)sender{
    NSDictionary *parama = @{@"communityId":self.strCommunityID,@"id":self.buildingId};
    [Networking retrieveData:getBuilding parameters:parama success:^(id responseObject) {
        self.arraryUnit = responseObject;
        [self selectPicker:sender];
    }];
}

- (void)getHouseIDSender:(id)sender{
    NSDictionary *parama = @{@"communityId":self.strCommunityID,@"id":self.strUnit};
    [Networking retrieveData:getBuilding parameters:parama success:^(id responseObject) {
        self.houseArr = responseObject;
        [self selectPicker:sender];
    }];
}

-(void)getHouseIdForBuilding:(id)sender{
    if (self.buildingId == nil) {
        [Util alertNetworingError:@"请先选择楼号"];
    }else{
        if (self.houseArr.count==0) {
            [Util alertNetworingError:@"此栋楼暂未录入"];
        }else{
            [self getHouseIDSender:sender];
        }
    }
}

-(void)selectPicker:(id)sender{
    UIButton *button = (UIButton*)sender;
    [self.view endEditing:YES];
    
    self.pickerTag = [NSString stringWithFormat:@"%ld",(long)button.tag];
    
    [self.pickerView removeFromSuperview];
    self.pickerView = [[PickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width, 200)];
    self.pickerView.pickerView.delegate = self;
    self.pickerView.pickerView.dataSource = self;
    [self.pickerView.confirmBtn addTarget:self action:@selector(confirmPicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerView.cancelBtn addTarget:self action:@selector(cancelPicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pickerView];
    
    if ([self.pickerTag isEqualToString:@"1"]) {
        self.pickerStr =  self.owerTypeArr[0];
        self.owerType = self.owerTypeArrEn[0];
    }else if ([self.pickerTag isEqualToString:@"2"]){
        self.pickerStr = self.buildingArr[0][@"name"];
        self.buildingId = self.buildingArr[0][@"id"];
    }else if([self.pickerTag isEqualToString:@"3"]){
        self.pickerStr = self.houseArr[0][@"name"];
        self.houseId = self.houseArr[0][@"id"];
    }else{
        self.pickerStr = self.arraryUnit[0][@"name"];
        self.strUnit = self.arraryUnit[0][@"id"];
    }

}


// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([self.pickerTag isEqualToString:@"1"]) {
        return self.owerTypeArr.count;
    }else if ([self.pickerTag isEqualToString:@"2"]){
        return self.buildingArr.count;
    }else if ([self.pickerTag isEqualToString:@"3"]){
        return self.houseArr.count;
    }else{
        return self.arraryUnit.count;
    }
    
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return 200;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.pickerTag isEqualToString:@"1"]) {
        self.pickerStr =  self.owerTypeArr[row];
        self.owerType = self.owerTypeArrEn[row];
    }else if ([self.pickerTag isEqualToString:@"2"]){
        self.pickerStr = self.buildingArr[row][@"name"];
        self.buildingId = self.buildingArr[row][@"id"];
    }else if([self.pickerTag isEqualToString:@"3"]){
        self.pickerStr = self.houseArr[row][@"name"];
        self.houseId = self.houseArr[row][@"id"];
    }else{
        self.pickerStr = self.arraryUnit[row][@"name"];
        self.strUnit = self.arraryUnit[row][@"id"];
    }
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([self.pickerTag isEqualToString:@"1"]) {
        self.pickerStr =  self.owerTypeArr[row];
        self.owerType = self.owerTypeArrEn[row];
        return self.owerTypeArr[row];
    }else if ([self.pickerTag isEqualToString:@"2"]){
        self.pickerStr = self.buildingArr[row][@"name"];
        self.buildingId = self.buildingArr[row][@"id"];
        return self.buildingArr[row][@"name"];
    }else if([self.pickerTag isEqualToString:@"3"]){
        self.pickerStr = self.houseArr[row][@"name"];
        self.houseId = self.houseArr[row][@"id"];
        return self.houseArr[row][@"name"];
    }else{
        self.pickerStr = self.arraryUnit[row][@"name"];
        return self.pickerStr;
    }
}

-(void)confirmPicker:(id)sender{
    
    [self.pickerView removeFromSuperview];
    if (self.pickerStr) {
        if ([self.pickerTag isEqualToString:@"1"]) {
            [self.owerTypeBtn setTitle:self.pickerStr forState:UIControlStateNormal];
        }else if ([self.pickerTag isEqualToString:@"2"]){
            [self.buildingIDBtn setTitle:self.pickerStr forState:UIControlStateNormal];
            
        }else if([self.pickerTag isEqualToString:@"3"]){
            [self.houseIDBtn setTitle:self.pickerStr forState:UIControlStateNormal];
        }else{
            [btnUnit setTitle:self.pickerStr forState:UIControlStateNormal];
            self.strUnit = self.arraryUnit.firstObject[@"id"];
        }
    }
    self.pickerStr = nil;
}

-(void)cancelPicker:(id)sender{
    [self.pickerView removeFromSuperview];
    
    if (self.pickerStr) {
        if ([self.pickerTag isEqualToString:@"1"]) {
            [self.owerTypeBtn setTitle:@"点击选择身份类型" forState:UIControlStateNormal];
            self.owerType = nil;
        }else if ([self.pickerTag isEqualToString:@"2"]){
            [self.buildingIDBtn setTitle:@"点击选择楼号" forState:UIControlStateNormal];
            self.buildingId = nil;
        }else if([self.pickerTag isEqualToString:@"3"]){
            [self.houseIDBtn setTitle:@"点击选择房号" forState:UIControlStateNormal];
            self.houseId = nil;
        }else{
            [btnUnit setTitle:@"点击选择单元号" forState:UIControlStateNormal];
        }
    }
    self.pickerStr = nil;
}

- (void)getOtherCommunityName{
    LocationTableViewController *locationVC = [[LocationTableViewController alloc] init];
    locationVC.delegate = self;
    locationVC.locationStyle = LocationStyleSelectCommunityNameAndID;
    [self.navigationController pushViewController:locationVC animated:YES];
}

- (void)selectedFinishedCommunityNameAndID:(NSDictionary *)dicTemp{
    self.strCommunityID = dicTemp[@"communityID"];
    self.strCommunityName = dicTemp[@"communityName"];
    strRoomName = nil;
    strUnitName = nil;
    strBuildName = nil;
    self.houseId = nil;
    self.strUnit = nil;
    self.buildingId = nil;
    
    for (UIView *viewSub in botomView.subviews) {
        [viewSub removeFromSuperview];
    }
    [self initViewsLeves];//当前小区层级
}

- (void)initViewsLeves{
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    self.loadingView.titleLabel.text = @"正在加载";
    [Networking retrieveData:get_HOUSE_LEVEL parameters:@{@"communityId": self.strCommunityID} success:^(id responseObject) {
        hourseLeve = responseObject;
        [self setupData];
    }];
}

-(void)setupData{
//    if (hourseLeve.count == 2) {
//        NSArray *section1 = @[@"请输入你的真实姓名",@"请输入你的身份证号码",@"点击选择身份类型"];
//        NSArray *section2 = @[self.strCommunityName,@"点击选择楼号",@"点击选择房号"];
//        self.titleArray = @[section1,section2];
//    }else if (hourseLeve.count == 3){
//        NSArray *section1 = @[@"请输入你的真实姓名",@"请输入你的身份证号码",@"点击选择身份类型"];
//        NSArray *section2 = @[self.strCommunityName,@"点击选择楼号",@"点击选择单元号",@"点击选择房号"];
//        self.titleArray = @[section1,section2];
//    }
    [self initWithBootomViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
