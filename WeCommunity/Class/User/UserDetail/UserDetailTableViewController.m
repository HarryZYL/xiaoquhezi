//
//  UserDetailTableViewController.m
//  WeCommunity
//
//  Created by Harry on 8/31/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "UserDetailTableViewController.h"

@interface UserDetailTableViewController ()

@end

@implementation UserDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.tableView registerClass:[BasicTableViewCell class] forCellReuseIdentifier:@"cell"];

   
    [self setupUserData];
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    self.loadingView.titleLabel.text = @"正在更新";


}

-(void)viewWillAppear:(BOOL)animated{
    if (!self.stopLogin) {
        [self login];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupUserData{
    User *user = [[User alloc] initWithData];
    self.titleArray = @[@"头像",@"昵称",@"性别",@"职业",@"爱好"];
    self.detailArray = @[[NSString stringWithFormat:@"%@",user.headPhoto],user.nickName,user.sexName,user.job,user.hobby];
    self.messageArray = @[@"headPhoto",@"nickName",@"sex",@"job",@"hobby"];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell configureUserDetailCell:self.titleArray[indexPath.row] detail:self.detailArray[indexPath.row]];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 80;
    }else{
        return 50;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row != 0 && indexPath.row !=2) {
        EditDetailTableViewController *editVC = [[EditDetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        editVC.titleMessage = self.titleArray[indexPath.row];
        editVC.message = self.detailArray[indexPath.row];
        editVC.updateMessage = self.messageArray[indexPath.row];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:editVC];
        [self presentViewController:navVC animated:YES completion:nil];
        
    }else if (indexPath.row == 0){
        self.actionStr = @"headImage";
        [self setupActionSheet];
        
    }else if (indexPath.row == 2){
         self.actionStr = @"sex";
        [self setupActionSheet];
       
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}


#pragma action sheet

-(void)setupActionSheet{
    
    if ([self.actionStr isEqualToString:@"headImage"]) {
        self.actionSheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取", nil];
    }else if ([self.actionStr isEqualToString:@"sex"]){
        self.actionSheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
    }
    
    
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    if ([window.subviews containsObject:self.view]) {
        [self.actionSheet showInView:self.view];
    } else {
        [self.actionSheet showInView:window];
    }
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([self.actionStr isEqualToString:@"headImage"]) {
        if (buttonIndex==0) {
            self.sourceType =@"Camera";
            [self takePhoto];
        }else if (buttonIndex==1) {
            self.sourceType =@"Photo";
            [self takePhoto];
        } else{
            [self.actionSheet dismissWithClickedButtonIndex:-1 animated:YES];
            
        }
    }else if ([self.actionStr isEqualToString:@"sex"]){
        if (buttonIndex==0) {
             self.sex = @"Male";
            [self retrireveData:@"sex"];
            [self.actionSheet dismissWithClickedButtonIndex:-1 animated:YES];
            
        }else if (buttonIndex==1) {
            self.sex = @"Female";
            [self.actionSheet dismissWithClickedButtonIndex:-1 animated:YES];
            [self retrireveData:@"sex"];
            
        } else{
            [self.actionSheet dismissWithClickedButtonIndex:-1 animated:YES];
            
        }
        
    }
}


#pragma mark - UIImagePicker
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType =[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        // a photo was taken/selected
        self.headImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            //save image
            UIImageWriteToSavedPhotosAlbum(self.headImage, nil, nil, nil);
        }
        self.stopLogin = YES;
        [self upload];
        
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

-(void) takePhoto{
    if (self.headImage == nil ) {
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = YES;
        self.imagePicker.mediaTypes=[[NSArray alloc] initWithObjects: (NSString *)  kUTTypeImage  , nil];
        
        if ([self.sourceType isEqualToString:@"Camera"]) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }
    
    
}

#pragma mark networking

-(void)retrireveData:(NSString*)type{
    
    
    [self.view addSubview:self.loadingView];
    NSDictionary *parameters = @{};
    if ([type isEqualToString:@"sex"]) {
        parameters = @{@"token":[User getUserToken],@"sex":self.sex};
    }else if([type isEqualToString:@"headPhoto"]){
        parameters = @{@"token":[User getUserToken],@"headPhoto":self.headImageString};

    }
    
    [Networking retrieveData:updateBasicInfo parameters:parameters success:^(id responseObject) {
        [self login];
    }];
    
}


-(void)login{
 
    NSDictionary *username = [FileManager getData:@"MyAppCache"];
    NSDictionary *password = [FileManager getData:@"Password"];
    NSDictionary *parameters = @{@"phoneNumber":username[@"user"][@"userName"],@"password":password[@"password"]};
    [Networking retrieveData:phoneLogin parameters:parameters success:^(id responseObject) {
        NSDictionary *userData = [Util removeNullInDictionary:responseObject[@"user"]];
        NSDictionary *data = @{@"token":responseObject[@"token"],@"user":userData};
        [FileManager saveDataToFile:data filePath:@"MyAppCache"];
        [self setupUserData];
        [self.tableView reloadData];
    } addition:^{
        [self.loadingView removeFromSuperview];
    }];
    self.stopLogin = NO;
    
}

-(void)upload{
    
    [Networking uploadOne:self.headImage success:^(id responseObject) {
        self.headImageString = responseObject;
        NSLog(@"%@",self.headImageString);
        [self retrireveData:@"headPhoto"];
    }];
    
}



@end
