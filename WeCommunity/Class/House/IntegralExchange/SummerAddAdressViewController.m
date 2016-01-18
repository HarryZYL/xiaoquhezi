//
//  SummerAddAdressViewController.m
//  WeCommunity
//
//  Created by madarax on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SummerAddAdressViewController.h"
#import "SummerNavigationBarView.h"
#import "UIViewController+HUD.h"
#import "SummerProvicesModel.h"
#import "SummerAddressView.h"
#import "NSString+HTML.h"
@interface SummerAddAdressViewController ()<UITextFieldDelegate ,UIPickerViewDataSource ,UIPickerViewDelegate>

@property (nonatomic ,strong) SummerAddressView *contentView;
@property (nonatomic ,strong) UIPickerView *cityPickerView;
@property (nonatomic ,strong) UIView *selectAddressView;
@property (nonatomic ,strong) NSMutableArray *dataProvinceArrary;

@property (nonatomic ,strong) SummerProvicesModel *provicesModel;
@property (nonatomic ,strong) SummerCityAddressModel *cityModel;
@property (nonatomic ,strong) SummerDistrictModel *districtModel;

@end

@implementation SummerAddAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAddress)];
    _dataProvinceArrary = [[NSMutableArray alloc] initWithCapacity:0];
    NSDictionary *dicAdd = [FileManager getData:@"CityAddressModel"];
    if (dicAdd) {
        for (NSDictionary *dic in dicAdd[@"cityArrary"]) {
            [_dataProvinceArrary addObject:[[SummerProvicesModel alloc] initWithData:dic]];
        }
        _provicesModel = _dataProvinceArrary[0];
        _cityModel = _provicesModel.cityArrary[0];
        _districtModel = _cityModel.districtArrary[0];
    }else{
        [self getAllCityNameAndID];
    }
    __weak typeof(self)weakSelf = self;
    self.view.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    if (_editeType == 0) {
        self.navigationItem.title = @"添加收货地址";
    }else{
        //        self.navigationItem.title = @"编辑收货地址";
        self.navigationController.navigationBarHidden = YES;
        SummerNavigationBarView *navbarView = [[SummerNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, 64)];
        navbarView.labTitle.text = @"编辑收货地址";
        [navbarView.btnRight addTarget:self action:@selector(saveAddress) forControlEvents:UIControlEventTouchUpInside];
        [navbarView.btnLeft addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:navbarView];
    }
    
    _contentView = [SummerAddressView new];
    [_contentView.btnAddress addTarget:self action:@selector(selectCitysID) forControlEvents:UIControlEventTouchUpInside];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view.mas_top).offset(74);
        make.height.mas_equalTo(183);
    }];
    
    if (_editeType != 0) {
        _contentView.nameText.text  = _addressDic[@"name"];
        _contentView.phoneText.text = _addressDic[@"phone"];
        _contentView.addressInformation.text = _addressDic[@"address"];
        [_contentView.btnAddress setTitle:[NSString stringWithFormat:@"%@ %@ %@%",_addressDic[@"provinceName"],_addressDic[@"cityName"],_addressDic[@"districtName"]] forState:UIControlStateNormal];
        [_contentView.btnAddress setTitleColor:[UIColor colorWithWhite:0.259 alpha:1.000] forState:UIControlStateNormal];
        
        UIButton *btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        btnDelete.layer.cornerRadius = 5;
        btnDelete.layer.masksToBounds = YES;
        
        btnDelete.titleLabel.font = [UIFont systemFontOfSize:18];
        [btnDelete addTarget:self action:@selector(deleteAddress:) forControlEvents:UIControlEventTouchUpInside];
        [btnDelete setTitle:@"删除地址" forState:UIControlStateNormal];
        [btnDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnDelete setBackgroundColor:THEMECOLOR];
        [self.view addSubview:btnDelete];
        [btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(320);
            make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-20);
            make.centerX.equalTo(weakSelf.view);
            make.height.mas_equalTo(40);
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
}

- (void)selectCitysID{
    [self viewDisplayPikerView];
}
- (void)getAllCityNameAndID{//所有城市信息
    [Networking retrieveData:GET_ALL_CITY parameters:nil success:^(id responseObject) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [FileManager saveDataToFile:@{@"cityArrary":responseObject} filePath:@"CityAddressModel"];
        });
        for (NSDictionary *dic in responseObject) {
            [_dataProvinceArrary addObject:[[SummerProvicesModel alloc] initWithData:dic]];
        }
        _provicesModel = _dataProvinceArrary[0];
        _cityModel = _provicesModel.cityArrary[0];
        _districtModel = _cityModel.districtArrary[0];
    }];
}

- (void)saveAddress{
    [self.view endEditing:YES];
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
                                                     @"provinceCode":_provicesModel.strCode,
                                                     @"cityCode":_cityModel.strCode,
                                                     @"districtCode":_districtModel.strCode,
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
                                                             @"provinceCode":_provicesModel.strCode,
                                                             @"cityCode":_cityModel.strCode,
                                                             @"districtCode":_districtModel.strCode,
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
        [weakSelf.navigationController popToViewController:weakSelf.navigationController.viewControllers[3] animated:YES];
    }
}

- (void)viewDisplayPikerView{
    _selectAddressView.frame = CGRectMake(0, SCREENSIZE.height - 200, SCREENSIZE.width, 200);
    [self.cityPickerView reloadAllComponents];
    [_contentView.btnAddress setTitle:[NSString stringWithFormat:@"%@ %@ %@",_provicesModel.strName,_cityModel.strName,_districtModel.strName] forState:UIControlStateNormal];
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
            return _provicesModel.cityArrary.count;
            break;
        case 2:
            return _cityModel.districtArrary.count;
            break;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
        {
            SummerProvicesModel *dic = _dataProvinceArrary[row];
            return dic.strName;
        }
            break;
        case 1:
        {
            SummerCityAddressModel *dic = _provicesModel.cityArrary[row];
            return dic.strName;
        }
            break;
        case 2:
        {
            SummerDistrictModel *dic = _cityModel.districtArrary[row];
            return dic.strName;
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
            _provicesModel = _dataProvinceArrary[row];
            _cityModel = _provicesModel.cityArrary[0];
            _districtModel = _cityModel.districtArrary[0];
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
        case 1:
        {
            _cityModel = _provicesModel.cityArrary[row];
            _districtModel = _cityModel.districtArrary[0];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
        case 2:
        {
            _districtModel = _cityModel.districtArrary[row];
            
        }
            break;
            
        default:
            break;
    }
    [_contentView.btnAddress setTitle:[NSString stringWithFormat:@"%@ %@ %@",_provicesModel.strName,_cityModel.strName,_districtModel.strName] forState:UIControlStateNormal];
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

- (void)backView{
    [self.navigationController popViewControllerAnimated:YES];
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
