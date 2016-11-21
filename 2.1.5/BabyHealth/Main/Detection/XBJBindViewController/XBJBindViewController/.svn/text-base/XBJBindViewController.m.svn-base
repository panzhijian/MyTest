//
//  XBJBindViewController.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/6.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJBindViewController.h"
#import "XBJBindTableViewCell.h"
#import "XBJSampleInfoViewController.h"
#import "XBJBindModel.h"
#import "RegExpValidate.h"
#import "LBXScanViewStyle.h"
#import "SubLBXScanViewController.h"
#import"XBJAddShitRecordViewController.h"
#import "XBJNetWork.h"
#import "ActionSheetDatePicker.h"
#import "ActionSheetCustomPicker.h"
#import "MJExtension.h"

#import"BindHeadFlow.h"
@interface XBJBindViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIActionSheetDelegate,ActionSheetCustomPickerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property(nonatomic,strong)UsersModel *users;

@property(nonatomic,strong)ActionSheetCustomPicker *customPicker;
@property(nonatomic,strong)NSArray *provinceArr;

@property(nonatomic,strong)NSArray *countryArr;

@property(nonatomic,strong)NSArray *districtArr;

@property(nonatomic,strong)NSArray *addressArr;

@property(nonatomic,assign)NSInteger index1;

@property(nonatomic,assign)NSInteger index2;

@property(nonatomic,assign)NSInteger index3;
- (IBAction)clickLaterInputBut:(id)sender;

@end

@implementation XBJBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    self.users = [[qiao selectAllFromTable] lastObject];

    self.title = @"绑定送样";
    self.tableView.backgroundColor = [UIColor colorWithRed:0.9569 green:0.9373 blue:0.9490 alpha:1.0];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJBindTableViewCell" bundle:nil] forCellReuseIdentifier:@"XBJBindTableViewCell"];
    self.tableView.tableFooterView = [UIView new];
    
    BindHeadFlow *bindHeadFlowV=[[[NSBundle mainBundle] loadNibNamed:@"BindHeadFlow" owner:self options:nil] lastObject];
    
    
    self.tableView.tableHeaderView=bindHeadFlowV;

}

- (IBAction)nextBtnAction:(id)sender {
    
    XBJBindModel *bind_model = [XBJBindModel new];
    
    for(int i=0; i<5; i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        XBJBindTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        switch (i) {
            case 0:
                if(cell.textField.text.length==0){
                    [self showToastWith:@"样品编号不能为空"];
                    return;
                }else if(cell.textField.text.length!=10){
                    [self showToastWith:@"样品编号长度应为10"];
                    return;
                }else{
                    bind_model.code = cell.textField.text;
                }
                break;
            case 1:
                if(cell.textField.text.length==0){
                    [self showToastWith:@"联系人不能为空"];
                    return;
                }else{
                    bind_model.contactName = cell.textField.text;
                }
                break;
            case 2:
                if(cell.textField.text.length==0){
                    [self showToastWith:@"手机号码不能为空"];
                    return;
                }else{
                    BOOL validate = [RegExpValidate validateMobile:cell.textField.text];
                    if(!validate){
                        [self showToastWith:@"手机号码格式有误"];
                        return;
                    }else{
                        bind_model.mobile = cell.textField.text;
                    }
                }
                break;
            case 3:
                if(cell.textField.text.length==0){
                    [self showToastWith:@"所在地区不能为空"];
                    return;
                }else{
                    bind_model.province = cell.textField.text;
                }
                break;
            case 4:
                if(cell.textField.text.length==0){
                    [self showToastWith:@"详细地址不能为空"];
                    return;
                }else{
                    bind_model.address = cell.textField.text;
                }
                break;
            default:
                break;
        }
    }
//    XBJSampleInfoViewController *vc = [XBJSampleInfoViewController new];
//    vc.hidesBottomBarWhenPushed = YES;
//    vc.bind_model = bind_model;
//    [self.navigationController pushViewController:vc animated:YES];
//

    
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    self.users = [[qiao selectAllFromTable] lastObject];
    self.users.contactPerson=bind_model.contactName;
    self.users.contactPhone=bind_model.mobile;
    self.users.contactProvince=bind_model.province;
    self.users.contactAddress=bind_model.address;
    [qiao updateDataWithModel:self.users];


    
    XBJAddShitRecordViewController *vc = [XBJAddShitRecordViewController new];
    vc.isBindSample=YES;
    vc.bind_model=bind_model;
    [self.navigationController pushViewController:vc animated:YES];
 
    
}

#pragma mark - tableView delegate/dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XBJBindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJBindTableViewCell"];
    cell.textField.delegate=self;
    cell.textField.tag=100+indexPath.row;
    
    if(cell.textField.tag==100)
    {
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"samepleCode"])
        {
            cell.textField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"samepleCode"];
        }
    }else if (cell.textField.tag==101) {
        cell.textField.text=self.users.contactPerson;
    }else if (cell.textField.tag==102)
    {
        cell.textField.text=self.users.contactPhone;

    }else if (cell.textField.tag==103)
    {
        cell.textField.text=self.users.contactProvince;

    }else if (cell.textField.tag==104)
    {
        cell.textField.text=self.users.contactAddress;

    }
    [cell configureCellWith:indexPath.row];
    
    __weak __typeof__(self) weakSelf = self;
    [cell setScanBlock:^(){
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        [strongSelf qqStyle];
    }];

    return cell;
}

- (void)qqStyle{
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    
    vc.isQQSimulator = YES;
    vc.isVideoZoom = YES;
    
    [vc setCodeblock:^(NSString *code){
        
        
        [[NSUserDefaults standardUserDefaults] setObject:code forKey:@"samepleCode"];
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self  checkCode:code];
        
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)checkCode:(NSString *)code
{
    NSString *customerId = [XBJAppHelper SQLUser].customerId;
    
    [[XBJNetWork sharedInstance] checkCode:code customerId:customerId block:^(NSNumber * result,NSString *message, NSError *error) {
            [NSThread sleepForTimeInterval:0.5];
        if(error){
            [self.navigationController.view makeToast:error.localizedDescription
                                             duration:1.5
                                             position:CSToastPositionCenter];
        }else{
            
           if([result integerValue]==1)
           {
               NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
               XBJBindTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
               cell.textField.text = code;
               
               [self.navigationController.view makeToast:message
                                                               duration:1.5
                                                               position:CSToastPositionCenter];
               
           }else{
               [self.navigationController.view makeToast:message
                                                duration:1.5
                                                position:CSToastPositionCenter];
           }

        }
    }];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if(textField.tag==102)
    {
        [textField becomeFirstResponder];

        textField.keyboardType=UIKeyboardTypeNumberPad;
        
    }else  if(textField.tag==103)
    {
        
        
        [textField resignFirstResponder];
        
        
        [self calculateFirstData];
        
        [self performSelector:@selector(loadFirstData)];
        
        self.customPicker = [[ActionSheetCustomPicker alloc] initWithTitle:@"设置地址" delegate:self showCancelButton:YES origin:self.view initialSelections:nil];
        [self.customPicker showActionSheetPicker];

        NSLog(@"所在区");
    }else{
        [textField becomeFirstResponder];
        textField.keyboardType=UIKeyboardTypeDefault;

    }
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
    
NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    XBJBindTableViewCell *cell=(XBJBindTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
   cell.textField .text= detailAddress;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickLaterInputBut:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
