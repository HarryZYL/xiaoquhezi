//
//  SummerRePostMyRentViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/21.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerRePostMyRentViewController.h"

@interface SummerRePostMyRentViewController ()

@property(nonatomic ,strong) NSMutableArray *chosenImages;
@end

@implementation SummerRePostMyRentViewController

- (instancetype)init{
    if (self == [super init]) {
        UIBarButtonItem *pushItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(upLoadData)];
        self.navigationItem.rightBarButtonItem = pushItem;
        _chosenImages = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"编辑";
    self.view.backgroundColor = [UIColor whiteColor];
    _alertViewModel = [[SummerRentAlertView alloc] initWithFrame:self.view.frame];
    _alertViewModel.houseDeal = self.houseDeal;
    [self.view addSubview:_alertViewModel];
    [_alertViewModel setContentTitle];
}

- (void)upLoadData{
    UITextField *titleField = (UITextField *)[self.alertViewModel viewWithTag:17];
    SAMTextView *contentField = (SAMTextView *)[self.alertViewModel viewWithTag:18];
    
    UITextField *roomField = (UITextField *)[self.alertViewModel viewWithTag:10];
    UITextField *roomSittingField = (UITextField *)[self.alertViewModel viewWithTag:11];
    UITextField *roomBathField = (UITextField *)[self.alertViewModel viewWithTag:12];
    UITextField *totalField = (UITextField *)[self.alertViewModel viewWithTag:14];
    UITextField *floorField = (UITextField *)[self.alertViewModel viewWithTag:13];
    
    UITextField *areaField = (UITextField *)[self.alertViewModel viewWithTag:15];
    UITextField *priceField = (UITextField *)[self.alertViewModel viewWithTag:16];
    NSString *houseType ;
    if (self.houseDealType == SummerHouseDealTypeSale) {
        houseType = @"Sale";
    }else if (self.houseDealType == SummerHouseDealTypeRent){
        houseType = @"Rent";
    }
    if (self.chosenImages.count) {
        [Networking upload:self.chosenImages success:^(id responseObject) {
            NSDictionary *parameters = @{
                                         @"token":[User getUserToken],
                                         @"communityId":[Util getCommunityID],
                                         @"houseDealType":houseType,
                                         @"title":titleField.text,
                                         @"content":contentField.text,
                                         @"pictures":responseObject,
                                         @"room":roomField.text,
                                         @"sittingRoom":roomSittingField.text,
                                         @"bathRoom":roomBathField.text,
                                         @"area":areaField.text,
                                         @"floor":floorField.text,
                                         @"totalFloor":totalField.text,
                                         
                                         @"houseOrientation":self.alertViewModel,
                                         @"houseType":self.alertViewModel,
                                         @"price":priceField.text
                                         };
            [Networking retrieveData:houseDeal_add parameters:parameters success:^(id responseObject) {
                
                [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
            } addition:^{
//                [self.loadingView removeFromSuperview];
            }];
        }];
        
    }else{
        NSDictionary *parameters = @{
                                     @"token":[User getUserToken],
                                     @"communityId":[Util getCommunityID],
                                     @"houseDealType":houseType,
                                     @"title":titleField.text,
                                     @"content":contentField.text,
                                     @"room":roomField.text,
                                     @"sittingRoom":roomSittingField.text,
                                     @"bathRoom":roomBathField.text,
                                     @"area":areaField.text,
                                     @"floor":floorField.text,
                                     @"totalFloor":totalField.text,
                                     @"houseOrientation":self.alertViewModel,
                                     @"houseType":self.alertViewModel,
                                     @"price":priceField.text
                                     };
        [Networking retrieveData:houseDeal_add parameters:parameters success:^(id responseObject) {
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        } addition:^{

        }];
    }
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
