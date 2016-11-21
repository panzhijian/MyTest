//
//  MeInformation.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/7.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "MeInformation.h"
#import "InformationCell.h"
#import "InformationHeaderCell.h"
#import "QIAODBMangerEx.h"
#import "UIImageView+AFNetworking.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "ActionSheetDatePicker.h"
#import "ActionSheetCustomPicker.h"
#import "MJExtension.h"
#import "ActionSheetCustomPicker.h"
#import "MBProgressHUD.h"

@implementation MeInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    self.users = [[qiao selectAllFromTable] lastObject];
    
    [self.meTableView reloadData];
    self.view.backgroundColor = BG_COLOR;
    
    self.isUpdateValue = YES;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"个人信息";
    self.titleArray = [NSArray arrayWithObjects:@"头像",@"手机号",@"昵称",@"生日",@"地区", nil];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"保存" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.frame = CGRectMake(0,0,AUTO_MATE_WIDTH(100),AUTO_MATE_HEIGHT(30));
    [addBtn addTarget:self action:@selector(addMeInformationClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = addBtnItem;
    
    self.meTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_SIZE.width, VIEW_SIZE.height) style:UITableViewStyleGrouped];
    self.meTableView.delegate = self;
    self.meTableView.dataSource = self;
    self.meTableView.backgroundColor = BG_COLOR;
    [self.view addSubview:self.meTableView];
    
    self.updateMe = [[UpdateMeInformation alloc] init];
    self.updateMe.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //读取数据库
 
}

#pragma mark -- 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

#pragma mark -- 返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return AUTO_MATE_HEIGHT(180);
    }
    else
    {
        return AUTO_MATE_HEIGHT(100);
    }
}

#pragma mark -- 返回头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return AUTO_MATE_HEIGHT(10);
}

#pragma mark -- 返回每个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        static NSString *meCell = @"informationCell";
        InformationHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:meCell];
        if(!cell)
        {
            cell = [[InformationHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:meCell];
        }
        
        if(self.headerImage)
        {
            cell.headerImage.image  = self.headerImage;
        }
        else
        {
            [cell.headerImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_IP_2,self.users.avatarImg]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
            self.headerImage = cell.headerImage.image;
        }
        
        cell.titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else
    {
        static NSString *meCell = @"informationCell";
        InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:meCell];
        if(!cell)
        {
            cell = [[InformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:meCell];
        }
        
        cell.titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
        
        switch (indexPath.row) {
            case 1:
                cell.rightLabel.text = self.users.mobile;
                break;
            case 2:
                cell.rightLabel.text = [NSString stringWithFormat:@"%@",self.users.nickName];
                break;
            case 3:
                cell.rightLabel.text = self.users.birthday;
                break;
            case 4:
                cell.rightLabel.text = self.users.province;
                break;
            default:
                break;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

#pragma mark -- cell被点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [self performSelector:@selector(openPhotoClick)];
        }
            break;
        case 1:
        {
        }
            break;
        case 2:
        {
            self.updateMe.updateTitle = @"修改昵称";
            self.updateMe.updateValue = self.users.nickName;
        }
            break;
        case 3:
        {
            NSDate *date = [NSDate date];
            NSTimeZone *zone = [NSTimeZone systemTimeZone];
            NSInteger interval = [zone secondsFromGMTForDate:date];
            NSDate *localeDate = [date dateByAddingTimeInterval:interval];
            
            self.updateMe.updateValue = self.users.birthday;
            ActionSheetDatePicker *datePicker = [ActionSheetDatePicker showPickerWithTitle:@"我的生日" datePickerMode:UIDatePickerModeDate selectedDate:localeDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {

                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
                [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
                [dateFormatter setDateFormat:@"YYYY-MM-dd"];
                
                self.users.birthday = [dateFormatter stringFromDate:selectedDate];
                
                [self.meTableView reloadData];
                
            } cancelBlock:^(ActionSheetDatePicker *picker) {
            } origin:tableView];
            
            [datePicker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"确 定"  style:UIBarButtonItemStylePlain target:nil action:nil]];
            [datePicker setCancelButton:[[UIBarButtonItem alloc] initWithTitle:@"取 消"  style:UIBarButtonItemStylePlain target:nil action:nil]];
            
            datePicker = nil;
        }
            break;
        case 4:
        {            
            [self calculateFirstData];
            
            [self performSelector:@selector(loadFirstData)];
            
            self.customPicker = [[ActionSheetCustomPicker alloc] initWithTitle:@"设置地址" delegate:self showCancelButton:YES origin:tableView initialSelections:nil];
            [self.customPicker showActionSheetPicker];
            
        }
            break;
        default:
            break;
    }
    
    if(indexPath.row != 0 && indexPath.row != 1 && indexPath.row != 3 && indexPath.row != 4)
    {
        self.updateMe.updateIndex = indexPath.row;
        [self.navigationController pushViewController:self.updateMe animated:YES];
    }
}

- (void)loadFirstData
{
    // 注意JSON后缀的东西和Plist不同，Plist可以直接通过contentOfFile抓取，Json要先打成字符串，然后用工具转换
    NSString *path = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"json"];
    NSLog(@"%@",path);
    NSString *jsonStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
    self.addressArr = [jsonStr JSONObject];
    
    NSMutableArray *firstName = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.addressArr)
    {
        NSString *name = dict.allKeys.firstObject;
        [firstName addObject:name];
    }
    // 第一层是省份 分解出整个省份数组
    self.provinceArr = firstName;
}

// 根据传进来的下标数组计算对应的三个数组
- (void)calculateFirstData
{
    // 拿出省的数组
    [self loadFirstData];
    
    NSMutableArray *cityNameArr = [[NSMutableArray alloc] init];
    // 根据省的index1，默认是0，拿出对应省下面的市
    for (NSDictionary *cityName in [self.addressArr[self.index1] allValues].firstObject)
    {
        NSString *name1 = cityName.allKeys.firstObject;
        [cityNameArr addObject:name1];
    }
    // 组装对应省下面的市
    self.countryArr = cityNameArr;
    //index1对应省的字典    市的数组 index2市的字典   对应县的数组
    self.districtArr = [[self.addressArr[self.index1] allValues][0][self.index2] allValues][0];
}

#pragma mark - UIPickerViewDataSource Implementation
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // Returns
    switch (component)
    {
        case 0: return self.provinceArr.count;
        case 1: return self.countryArr.count;
        case 2:return self.districtArr.count;
        default:break;
    }
    return 0;
}
#pragma mark UIPickerViewDelegate Implementation
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0: return self.provinceArr[row];
        case 1: return self.countryArr[row];
        case 2:return self.districtArr[row];
        default:break;
    }
    return nil;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* label = (UILabel*)view;
    if (!label)
    {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:14]];
    }
    
    NSString * title = @"";
    switch (component)
    {
        case 0: title = self.provinceArr[row];break;
        case 1: title = self.countryArr[row];break;
        case 2: title = self.districtArr[row];break;
        default:break;
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.text=title;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
        {
            self.index1 = row;
            self.index2 = 0;
            self.index3 = 0;
            
            // 滚动的时候都要进行一次数组的刷新
            [self calculateFirstData];
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
            
        case 1:
        {
            self.index2 = row;
            self.index3 = 0;
            
            [self calculateFirstData];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            [pickerView reloadComponent:2];
        }
            break;
        case 2:
            self.index3 = row;
            break;
        default:break;
    }
}

- (void)configurePickerView:(UIPickerView *)pickerView
{
    pickerView.showsSelectionIndicator = NO;
}
// 点击done的时候回调
- (void)actionSheetPickerDidSucceed:(ActionSheetCustomPicker *)actionSheetPicker origin:(id)origin
{
    NSMutableString *detailAddress = [[NSMutableString alloc] init];
    if (self.index1 < self.provinceArr.count) {
        NSString *firstAddress = self.provinceArr[self.index1];
        [detailAddress appendString:firstAddress];
    }
    if (self.index2 < self.countryArr.count) {
        NSString *secondAddress = self.countryArr[self.index2];
        [detailAddress appendString:secondAddress];
    }
    if (self.index3 < self.districtArr.count) {
        NSString *thirfAddress = self.districtArr[self.index3];
        [detailAddress appendString:thirfAddress];
    }
    
    self.users.province = detailAddress;
    self.isUpdateValue = NO;
    [self.meTableView reloadData];
}

#pragma mark -- 打开本地相册和相机功能
- (void)openPhotoClick
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"温馨提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取",nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        //调用拍照功能 一定要判断设备是否支持拍照
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            //如果是UIImagePickerControllerSourceTypeCamera 证明是拍照
            [self loadImageWithSourceType:UIImagePickerControllerSourceTypeCamera];
        }
        else
        {
           
            [self.navigationController.view makeToast:@"模拟器拍不了照片"
                                             duration:1.0
                                             position:CSToastPositionCenter];
        }
    }
    else if(buttonIndex == 1)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            NSLog(@"打开本地相册");
            [self loadImageWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        else
        {
          
            
            [self.navigationController.view makeToast:@"本地相册打开失败"
                                             duration:1.0
                                             position:CSToastPositionCenter];
        }
    }
    else
    {
        NSLog(@"取消");
    }
}

//拍照和取本地相册
- (void)loadImageWithSourceType:(UIImagePickerControllerSourceType)type
{
    //根据不同的资源类型加载不同的界面
    UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
    pickVC.delegate = self;
    //资源类型
    pickVC.sourceType = type;
    //允许编辑
    pickVC.allowsEditing = YES;
    //用模式跳转窗体
    [self presentViewController:pickVC animated:YES completion:^{}];
    
}

#pragma mark UIImagePikerControllerDelegate
//获取拍照或者相册选择的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //相册里面 会存放很多种资源 最少会由图片和视频 所以根据不同的资源有不同的操作
    
    self.headerImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    [self.meTableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//相册取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- updateMeinformationdelegate
- (void)returnUpdateMeinformationValue:(NSString *)updateValue updateIndex:(NSInteger)updateIndex
{
    switch (updateIndex) {
        case 1:
            self.users.mobile = updateValue;
            break;
        case 2:
            self.users.nickName = updateValue;
            break;
        case 3:
            self.users.birthday = updateValue;
            break;
        case 4:
            self.users.province = updateValue;
            break;
        default:
            break;
    }
    
    self.isUpdateValue = NO;
    [self.meTableView reloadData];
}

#pragma mark -- 添加个人信息传递给服务器和存储到本地
- (void)addMeInformationClick
{
    if(!self.users.nickName || !self.users.birthday || !self.users.province)
    {
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.bezelView.backgroundColor=Juhua_BackGround_COLOR;
    hud.label.text = @"正在保存";
    [hud.label setTextColor:[UIColor whiteColor]];
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.securityPolicy.allowInvalidCertificates = YES;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInteger:[self.users.customerId integerValue]] forKey:@"customerId"];
    [dict setObject:self.users.nickName forKey:@"nickName"];
    [dict setObject:self.users.birthday forKey:@"birthday"];
    [dict setObject:self.users.province forKey:@"province"];
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    
    [session POST:POST_UPDATE_CUSTOMER parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImagePNGRepresentation(self.headerImage);
        NSString *name = @"file";
        NSString *formKey = @"file";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        
        sleep(1);
        
        if([[responseObject objectForKey:@"result"] isEqualToString:@"SUCCESS"])
        {
            NSDictionary *responseDict = [responseObject objectForKey:@"data"];
            
            self.users.avatarImg = [responseDict objectForKey:@"avatarImg"];
            
            [qiao updateDataWithModel:self.users];
            
            [self.meTableView reloadData];
               [self.navigationController.view makeToast:@"保存成功!"                                             duration:1.0 position:CSToastPositionCenter];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self.navigationController.view makeToast:@"保存失败!"                                             duration:1.0 position:CSToastPositionCenter];
       
        }
        [hud hideAnimated:YES];
        
        self.isUpdateValue = YES;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.navigationController.view makeToast:error.localizedDescription
                                         duration:1.0
                                         position:CSToastPositionCenter];
        [hud hideAnimated:YES];
    }];
    
//    [session GET:POST_UPDATE_CUSTOMER parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if([responseObject objectForKey:@"result"])
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"消息提示" message:@"用户信息已更新!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alert show];
//            
//            //更新数据库信息
//            QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
//            [qiao updateDataWithModel:self.users];
//        }
//        
//        [hud hide:YES];
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"消息提示" message:@"网络错误!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        [hud hide:YES];
//    }];
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark goBack

- (void)goBack{
    
    if(!self.isUpdateValue){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"是否退出编辑" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
