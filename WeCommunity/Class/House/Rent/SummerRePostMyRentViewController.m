//
//  SummerRePostMyRentViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/21.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerRePostMyRentViewController.h"

@interface SummerRePostMyRentViewController ()<UzysAssetsPickerControllerDelegate ,MWPhotoBrowserDelegate>

@property(nonatomic ,strong) NSMutableArray *chosenImages;
@property(nonatomic ,strong) NSMutableArray *photosArrary;

@end

@implementation SummerRePostMyRentViewController

- (instancetype)init{
    if (self == [super init]) {
        UIBarButtonItem *pushItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(upLoadData)];
        self.navigationItem.rightBarButtonItem = pushItem;
        _chosenImages = [[NSMutableArray alloc] init];
        _photosArrary = [[NSMutableArray alloc] init];
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
    
    [self.alertViewModel.photoImage.addImageBtn addTarget:self action:@selector(imagePicker:) forControlEvents:UIControlEventTouchUpInside];
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
            [Networking retrieveData:get_HOUSE_DETAIL_EDITE parameters:parameters success:^(id responseObject) {
                
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
        [Networking retrieveData:get_HOUSE_DETAIL_EDITE parameters:parameters success:^(id responseObject) {
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        } addition:^{

        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imagePicker:(id)sender{
    
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    picker.maximumNumberOfSelectionMedia = 8 - self.chosenImages.count;
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)uzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    
    if([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAsset *representation = obj;
            
            UIImage *img = [UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
                                               scale:representation.defaultRepresentation.scale
                                         orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
            
            [self.chosenImages addObject:img];
//            [self.chosenImagesSmall addObject:[Util scaleToSize:img size:CGSizeMake(100, 100)]];
            
            if (idx==0 && self.chosenImages.count == 1) {
                
            }
            
        }];
        
        [self addPhotosOrMuteble];
        [self.alertViewModel.photoImage chuckSubViews];
        [self.alertViewModel.photoImage configureImage:self.chosenImages];
        [self.alertViewModel.photoImage.addImageBtn addTarget:self action:@selector(imagePicker:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addPhotosOrMuteble{
    if (self.chosenImages.count > 3) {
        self.alertViewModel.photoImage.frame = CGRectMake(0, 120, self.view.frame.size.width,330);
    }else{
        self.alertViewModel.photoImage.frame = CGRectMake(0, 120, self.view.frame.size.width,330 - 80);
    }
}

- (void)rentPostViewSelecteImageViewIndex:(NSInteger)index{
    if (!self.chosenImages) {
        [self.chosenImages removeAllObjects];
    }
    for (int i = 0; i<self.chosenImages.count; i++) {
        MWPhoto *photo = [MWPhoto photoWithImage:self.chosenImages[i]];
        [self.chosenImages addObject:photo];
    }
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser = [Util fullImageSetting:browser];
    browser.displayNavArrows = YES;
    [browser setCurrentPhotoIndex:index];
    [self.navigationController pushViewController:browser animated:YES];
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
