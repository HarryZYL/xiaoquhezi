//
//  SummerReAccreditationViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/27.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerReAccreditationViewController.h"
#import "LocationTableViewController.h"

@interface SummerReAccreditationViewController ()<UITextFieldDelegate ,LocationTableViewControllerDelegate>
{
    NSArray *hourseLeve;
    UIButton *btnUnit;
    NSString *strUnitID;
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
}

-(void)setupAppearance{
    
    NSArray *picArr;
    if (hourseLeve.count == 2) {
        picArr = @[@"姓名",@"证件号码",@"身份类型",@"小区名称",@"楼号",@"房号"];
    }else if (hourseLeve.count == 3){
        picArr = @[@"姓名",@"证件号码",@"身份类型",@"小区名称",@"楼号",@"房号",@"房号"];
    }
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+50);
    [self.view addSubview:self.scrollView];
    
    CGFloat height = 50;
    
    int floor = 0;
    
    for (int i = 0; i<self.titleArray.count; i++) {
        for (int j = 0; j < [self.titleArray[i] count]; j++) {
            UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 80 + height*floor + i*10 +j , self.view.frame.size.width, height)];
            background.backgroundColor = [UIColor whiteColor];
            [self.scrollView addSubview:background];
            UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
            int index;
            if (i==0) {
                index = j;
            }else{
                index = 3+j;
            }
            iconImage.image = [UIImage imageNamed:picArr[index]];
            [background addSubview:iconImage];
            switch (i) {
                case 0:
                    
                    switch (j) {
                            
                        case 0:
                            self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(60, 10, self.view.frame.size.width - 40, 30)];
                            self.nameField.placeholder = self.titleArray[i][j];
                            self.nameField.text = _dicAccreditation[@"realName"];
                            
                            self.nameField.delegate = self;
                            [background addSubview:self.nameField];
                            break;
                            
                        case 1:
                            self.cardNumberField = [[UITextField alloc] initWithFrame:self.nameField.frame];
                            self.cardNumberField.keyboardType = UIKeyboardTypeNumberPad;
                            self.cardNumberField.placeholder = self.titleArray[i][j];
                            self.cardNumberField.text = _dicAccreditation[@"cardNumber"];
                            self.cardNumberField.delegate = self;
                            [background addSubview:self.cardNumberField];
                            break;
                            
                        case 2:
                            self.owerTypeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                            self.owerTypeBtn.frame = self.nameField.frame;
                            [self.owerTypeBtn leftStyle];
                        
                            [self.owerTypeBtn setTitle:_dicAccreditation[@"ownerTypeName"] forState:UIControlStateNormal];
                            self.owerType = _dicAccreditation[@"ownerTypeName"];
                            [background addSubview:self.owerTypeBtn];
                            break;
                            
                        default:
                            break;
                    }
                    
                    break;
                case 1:
                    switch (j) {
                        case 0:
                            self.communityName = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                            self.communityName.frame = self.nameField.frame;
                            [self.communityName leftStyle];
                            [self.communityName setTitle:_dicAccreditation[@"community"][@"name"] forState:UIControlStateNormal];
                            self.strCommunityName = _dicAccreditation[@"community"][@"name"];
                            [background addSubview:self.communityName];
                            break;
                        case 1:
                            self.buildingIDBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                            self.buildingIDBtn.frame = self.nameField.frame;
                            [self.buildingIDBtn leftStyle];
                            [self.buildingIDBtn setTitle:[self.dicAccreditation[@"parentNames"] firstObject] forState:UIControlStateNormal];
                            self.buildingId = [self.dicAccreditation[@"parentNames"] firstObject];
                            [background addSubview:self.buildingIDBtn];
                            
                            break;
                        case 2:
                            if (hourseLeve.count == 2) {
                                self.houseIDBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                                self.houseIDBtn.frame = self.nameField.frame;
                                [self.houseIDBtn leftStyle];
                                [self.houseIDBtn setTitle:self.dicAccreditation[@"parentNames"][1] forState:UIControlStateNormal];
                                self.houseId = self.dicAccreditation[@"parentNames"][2];
                                [background addSubview:self.houseIDBtn];
                            }else if (hourseLeve.count == 3){
                                btnUnit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                                btnUnit.frame = self.nameField.frame;
                                [btnUnit leftStyle];
                                [btnUnit setTitle:self.dicAccreditation[@"parentNames"][1] forState:UIControlStateNormal];
                                self.strUnit = self.dicAccreditation[@"parentIds"][1];
                                [background addSubview:btnUnit];
                            }
                            
                            break;
                        case 3:
                            self.houseIDBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                            self.houseIDBtn.frame = self.nameField.frame;
                            [self.houseIDBtn leftStyle];
                            [self.houseIDBtn setTitle:self.dicAccreditation[@"parentNames"][2] forState:UIControlStateNormal];
                            self.houseId = self.dicAccreditation[@"parentNames"][2];
                            [background addSubview:self.houseIDBtn];
                            break;
                        default:
                            break;
                    }
                    
                    break;
                    
                default:
                    break;
            }
            
            
            floor ++;
        }
    }
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.submitBtn.frame = CGRectMake(40, height*8+80, self.view.frame.size.width-80, 40);
    [self.submitBtn configureButtonTitle:@"提交" backgroundColor:THEMECOLOR];
    [self.submitBtn addTarget:self action:@selector(uploadAccreditation) forControlEvents:UIControlEventTouchUpInside];
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 5;
    
    
    self.owerTypeBtn.tag = 1;
    self.buildingIDBtn.tag = 2;
    self.houseIDBtn.tag = 3;
    btnUnit.tag = 4;
    
    [btnUnit addTarget:self action:@selector(getUnitID:) forControlEvents:UIControlEventTouchUpInside];
    [self.owerTypeBtn addTarget:self action:@selector(selectPicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.buildingIDBtn addTarget:self action:@selector(getBuildingID:) forControlEvents:UIControlEventTouchUpInside];
    [self.houseIDBtn addTarget:self action:@selector(getHouseIdForBuilding:) forControlEvents:UIControlEventTouchUpInside];
    [self.communityName addTarget:self action:@selector(getOtherCommunityName) forControlEvents:UIControlEventTouchUpInside];
    self.owerTypeArr = @[@"户主",@"业主"];
    self.owerTypeArrEn = @[@"Owner",@"NoOwner"];
    self.buildingArr = @[@"1",@"2",@"3"];
    self.houseArr = @[@"101",@"102"];
    self.pickerStr = nil;
    
    [self.scrollView addSubview:self.submitBtn];
    [self.loadingView removeFromSuperview];
}

-(void)uploadAccreditation{
    
    if (self.nameField.text.length == 0) {
        [Util alertNetworingError:@"请输入姓名"];
    }else if(self.cardNumberField.text.length == 0){
        [Util alertNetworingError:@"请输入身份证号"];
    }else if (self.owerType == nil){
        [Util alertNetworingError:@"请选择身份类型"];
    }else if (self.buildingId == nil){
        [Util alertNetworingError:@"请选择楼号"];
    }else if (self.houseId == nil){
        [Util alertNetworingError:@"请选择房号"];
    }else{
        
        [self.view addSubview:self.loadingView];
        NSDictionary *parameters;
        
        NSUInteger index = [self.owerTypeArr indexOfObject:self.owerType];
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
            if (!self.strUnit) {
                self.strUnit = self.arraryUnit.firstObject[@"id"];
            }
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
    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:locationVC];
    locationVC.delegate = self;
    locationVC.locationStyle = LocationStyleSelectCommunityNameAndID;
    [self.navigationController pushViewController:locationVC animated:YES];
}

- (void)selectedFinishedCommunityNameAndID:(NSDictionary *)dicTemp{
    self.strCommunityID = dicTemp[@"communityID"];
    self.strCommunityName = dicTemp[@"communityName"];
    for (UIView *viewSub in self.scrollView.subviews) {
        [viewSub removeFromSuperview];
    }
    [self initViewsLeves];//当前小区层级
    //    [self.communityName setTitle:_strCommunityName forState:UIControlStateNormal];
}

- (void)initViewsLeves{
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    self.loadingView.titleLabel.text = @"正在加载";
    [Networking retrieveData:get_HOUSE_LEVEL parameters:@{@"communityId": [Util getCommunityID]} success:^(id responseObject) {
        hourseLeve = responseObject;
        [self setupData];
    }];
}

-(void)setupData{
    if (hourseLeve.count == 2) {
        NSArray *section1 = @[@"请输入你的真实姓名",@"请输入你的身份证号码",@"点击选择身份类型"];
        NSArray *section2 = @[self.strCommunityName,@"点击选择楼号",@"点击选择房号"];
        self.titleArray = @[section1,section2];
    }else if (hourseLeve.count == 3){
        NSArray *section1 = @[@"请输入你的真实姓名",@"请输入你的身份证号码",@"点击选择身份类型"];
        NSArray *section2 = @[self.strCommunityName,@"点击选择楼号",@"点击选择单元号",@"点击选择房号"];
        self.titleArray = @[section1,section2];
    }
    [self setupAppearance];
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