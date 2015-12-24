//
//  SummerAddAdressViewController.m
//  WeCommunity
//
//  Created by madarax on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SummerAddAdressViewController.h"
#import "UIViewController+HUD.h"
#import "SummerAddressView.h"
#import "NSString+HTML.h"
@interface SummerAddAdressViewController ()<UITextFieldDelegate ,UIPickerViewDataSource ,UIPickerViewDelegate>
{
    NSString *strProvinceID;
    NSString *strCityID;
    NSString *strDistricteID;
    
    NSString *strCityName;
    NSString *strProvinceName;
    NSString *strDistricteName;
}
@property (nonatomic ,strong) SummerAddressView *contentView;
@property (nonatomic ,strong) UIPickerView *cityPickerView;
@property (nonatomic ,strong) UIView *selectAddressView;
@property (nonatomic ,strong) NSArray *dataProvinceArrary;
@property (nonatomic ,strong) NSArray *dataCitysArray;
@property (nonatomic ,strong) NSArray *dataDistricteArrary;

@end

@implementation SummerAddAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAddress)];
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.851 alpha:1.000];
    
    _contentView = [SummerAddressView new];
    [_contentView.btnAddress addTarget:self action:@selector(selectCitysID) forControlEvents:UIControlEventTouchUpInside];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view.mas_top).offset(74);
        make.height.mas_equalTo(183);
    }];
    
    if (_editeType == 0) {
        self.title = @"添加收货地址";
    }else{
        self.title = @"编辑收货地址";
        _contentView.nameText.text  = _addressDic[@"name"];
        _contentView.phoneText.text = _addressDic[@"phone"];
        _contentView.addressInformation.text = _addressDic[@"address"];
        [_contentView.btnAddress setTitle:[NSString stringWithFormat:@"%@ %@ %@%",_addressDic[@"provinceName"],_addressDic[@"cityName"],_addressDic[@"districtName"]] forState:UIControlStateNormal];
        strProvinceID = _addressDic[@"provinceCode"];
        strCityID = _addressDic[@"cityCode"];
        strDistricteID = _addressDic[@"districtCode"];
        
        UIButton *btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        btnDelete.titleLabel.font = [UIFont systemFontOfSize:15];
        [btnDelete addTarget:self action:@selector(deleteAddress:) forControlEvents:UIControlEventTouchUpInside];
        [btnDelete setTitle:@"删除地址" forState:UIControlStateNormal];
        [btnDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnDelete setBackgroundColor:THEMECOLOR];
        [self.view addSubview:btnDelete];
        [btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(10);
            make.right.equalTo(weakSelf.view.mas_right).offset(-10);
            make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-20);
            make.height.mas_equalTo(35);
        }];
    }
    _selectAddressView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENSIZE.height, SCREENSIZE.width, 200)];
    _selectAddressView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_selectAddressView];
    
    _cityPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, SCREENSIZE.width,150)];
    _cityPickerView.backgroundColor = [UIColor whiteColor];
    _cityPickerView.delegate   = self;
    _cityPickerView.dataSource = self;
    [_selectAddressView addSubview:_cityPickerView];
    
    UIButton *btnSure = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSure.frame = CGRectMake(SCREENSIZE.width - 60, 0, 60, 40);
    [btnSure setTitle:@"确定" forState:UIControlStateNormal];
    [btnSure addTarget:self action:@selector(btnSelectAddress) forControlEvents:UIControlEventTouchUpInside];
    [btnSure setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    [_selectAddressView addSubview:btnSure];
    
    UIButton *btnSureCansole = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSureCansole.frame = CGRectMake(0, 0, 60, 40);
    [btnSureCansole setTitle:@"取消" forState:UIControlStateNormal];
    [btnSureCansole addTarget:self action:@selector(btnSelectCansol) forControlEvents:UIControlEventTouchUpInside];
    [btnSureCansole setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    [_selectAddressView addSubview:btnSureCansole];
    
    [self getAllCityNameAndID];
}

- (void)getAllCityNameAndID{//所有城市信息
    NSMutableArray *citysName = [[NSMutableArray alloc] initWithCapacity:33];
    [Networking retrieveData:GET_ALL_CITY parameters:nil success:^(id responseObject) {
        for (NSDictionary *dic in responseObject) {
            NSArray *provinArrary = dic[@"children"];
            
            for (NSDictionary *dic2 in provinArrary) {
                NSArray *citysArrary = dic2[@"children"];
                
                for (NSDictionary *dic3 in citysArrary) {
                    NSArray *districteArrary = dic3[@"children"];
                    
                }
            }
        }
    }];
}

- (void)saveAddress{
    if (_contentView.nameText.text.length < 1) {
        [self showHint:@"姓名不能为空"];
        return;
    }
    if (![NSString filterPhoneNumber:_contentView.phoneText.text]) {
        [self showHint:@"手机号码不正确"];
        return;
    }
    if ([_contentView.btnAddress.currentTitle isEqualToString:@"所在区域"]) {
        [self showHint:@"记得填写所在城市"];
        return;
    }
    if(_contentView.addressInformation.text.length < 1){
        [self showHint:@"别忘记了详细地址"];
        return;
    }
    __weak typeof(self)weakSelf = self;
    if (_editeType == 0) {
        //添加
        [Networking retrieveData:JIN_ADD_ADDRESS parameters:@{@"token": [User getUserToken],
                                                     @"provinceCode":strProvinceID,
                                                     @"cityCode":strCityID,
                                                     @"districtCode":strDistricteID,
                                                     @"address":_contentView.addressInformation.text,
                                                     @"phone":_contentView.phoneText.text,
                                                     @"name":_contentView.nameText.text} success:^(id responseObject) {
                                                         if ([responseObject count] > 0) {
                                                             if (weakSelf.updataAddressSeccess) {
                                                                 weakSelf.updataAddressSeccess();
                                                             }
                                                             [weakSelf.navigationController popViewControllerAnimated:YES];
                                                         }
                                                     }];
    }else{
        //更新
        [Networking retrieveData:JIN_UPDATE_ADD parameters:@{@"token": [User getUserToken],
                                                             @"id":_addressDic[@"id"],
                                                             @"provinceCode":strProvinceID,
                                                             @"cityCode":strCityID,
                                                             @"districtCode":strDistricteID,
                                                             @"address":_contentView.addressInformation.text,
                                                             @"phone":_contentView.phoneText.text,
                                                             @"name":_contentView.nameText.text}];
        if (weakSelf.updataAddressSeccess) {
            weakSelf.updataAddressSeccess();
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }
    

}

- (void)deleteAddress:(UIButton *)sender{
    __weak typeof(self)weakSelf = self;
    if ([sender.currentTitle isEqualToString:@"删除地址"]) {
         [Networking retrieveData:JIN_DELETE_ADD parameters:@{@"token": [User getUserToken],@"id":_addressDic[@"id"]}];
        if (weakSelf.updataAddressSeccess) {
            weakSelf.updataAddressSeccess();
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }
}

- (void)getProvinceIDSWihtData:(NSDictionary *)dicTemp{
    __weak typeof(self)weakSelf = self;
    [Networking retrieveData:GET_CITY_PROVINCE parameters:nil success:^(id responseObject) {
        _dataProvinceArrary = responseObject;
        [weakSelf.cityPickerView reloadComponent:0];
        if (!dicTemp) {
            strProvinceID = _dataProvinceArrary[0][@"id"];
            strProvinceName = _dataProvinceArrary[0][@"name"];
        }
        [weakSelf getCitysIDWithData:dicTemp];
    }];
}

- (void)getCitysIDWithData:(NSDictionary *)dicTemp{
    __weak typeof(self)weakSelf = self;
    NSDictionary *dic = dicTemp ? dicTemp:_dataProvinceArrary[0];
    [Networking retrieveData:GET_CITY_CITYS parameters:@{@"provinceCode": dic[@"code"]} success:^(id responseObject) {
        _dataCitysArray = responseObject;
        [weakSelf.cityPickerView reloadComponent:1];
        strCityID = _dataCitysArray[0][@"id"];
        strCityName = _dataCitysArray[0][@"name"];
        [weakSelf getDistricteIDWithData:_dataCitysArray[0]];
    }];
    
}

- (void)getDistricteIDWithData:(NSDictionary *)dicTemp{
    __weak typeof(self)weakSelf = self;
    NSDictionary *dic = dicTemp ? dicTemp : _dataCitysArray[0];
    [Networking retrieveData:GET_CITY_DISTRICTS parameters:@{@"cityCode": dic[@"code"]} success:^(id responseObject) {
        _dataDistricteArrary = responseObject;
        strDistricteID = _dataDistricteArrary[0][@"id"];
        strDistricteName = _dataDistricteArrary[0][@"name"];
        [weakSelf.cityPickerView reloadComponent:2];
        
        [weakSelf.contentView.btnAddress setTitle:[NSString stringWithFormat:@"%@%@%@",strProvinceName,strCityName,strDistricteName] forState:UIControlStateNormal];
        [_contentView.btnAddress setTitleColor:[UIColor colorWithWhite:0.259 alpha:1.000] forState:UIControlStateNormal];
        
    }];
}

- (void)selectCitysID{
    [self getProvinceIDSWihtData:nil];
    [self.view endEditing:YES];
    _selectAddressView.frame = CGRectMake(0, SCREENSIZE.height - 200, SCREENSIZE.width, 200);
    strProvinceID = _dataProvinceArrary[0][@"id"];
    strProvinceName = _dataProvinceArrary[0][@"name"];
    
    strCityID = _dataCitysArray[0][@"id"];
    strCityName = _dataCitysArray[0][@"name"];
    
    strDistricteID = _dataDistricteArrary[0][@"id"];
    strDistricteName = _dataDistricteArrary[0][@"name"];
    
    [self.cityPickerView reloadAllComponents];
    [_contentView.btnAddress setTitle:[NSString stringWithFormat:@"%@%@%@",strProvinceName,strCityName,strDistricteName] forState:UIControlStateNormal];
    [_contentView.btnAddress setTitleColor:[UIColor colorWithWhite:0.259 alpha:1.000] forState:UIControlStateNormal];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 3;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return _dataProvinceArrary.count;
            break;
        case 1:
            return _dataCitysArray.count;
            break;
        case 2:
            return _dataDistricteArrary.count;
            break;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
        {
            NSDictionary *dic = _dataProvinceArrary[row];
            return dic[@"name"];
        }
            break;
        case 1:
        {
            NSDictionary *dic = _dataCitysArray[row];
            return dic[@"name"];
        }
            break;
        case 2:
        {
            NSDictionary *dic = _dataDistricteArrary[row];
            return dic[@"name"];
        }
            break;
            
        default:
            break;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:
        {
            strProvinceID = _dataProvinceArrary[row][@"id"];
            strProvinceName = _dataProvinceArrary[row][@"name"];
            [self getCitysIDWithData:_dataProvinceArrary[row]];
        }
            break;
        case 1:
        {
            strCityID = _dataCitysArray[row][@"id"];
            strCityName = _dataCitysArray[row][@"name"];
            [self getDistricteIDWithData:_dataCitysArray[row]];
        }
            break;
        case 2:
        {
            strDistricteID = _dataDistricteArrary[row][@"id"];
            strDistricteName = _dataDistricteArrary[row][@"name"];
        }
            break;
            
        default:
            break;
    }
    [_contentView.btnAddress setTitle:[NSString stringWithFormat:@"%@%@%@",strProvinceName,strCityName,strDistricteName] forState:UIControlStateNormal];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    _selectAddressView.frame = CGRectMake(0, SCREENSIZE.height, SCREENSIZE.width, 200);
}

- (void)btnSelectAddress{
    _selectAddressView.frame = CGRectMake(0, SCREENSIZE.height, SCREENSIZE.width, 200);
}

- (void)btnSelectCansol{
    _selectAddressView.frame = CGRectMake(0, SCREENSIZE.height, SCREENSIZE.width, 200);
    
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
