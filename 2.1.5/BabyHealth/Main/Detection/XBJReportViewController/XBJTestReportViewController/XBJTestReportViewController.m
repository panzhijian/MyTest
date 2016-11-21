//
//  XBJTestReportViewController.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/8.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJTestReportViewController.h"

#import "XBJTestReportCell.h"
#import "XBJDownloadPopView.h"
#import "XBJTestDepictPopView.h"
#import "XBJNetWork.h"

@interface XBJTestReportViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *downLoadBtn;

@property (strong, nonatomic) XBJDownloadPopView *downloadPopView;
@property (strong, nonatomic) XBJTestDepictPopView *depictPopView;
@property (assign, nonatomic) NSInteger openRow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewHeight;

@end

@implementation XBJTestReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.9569 green:0.9373 blue:0.9490 alpha:1.0];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XBJTestReportCell" bundle:nil] forCellReuseIdentifier:@"XBJTestReportCell"];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;

    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    self.openRow = -1;

    
}

#pragma public method
- (void)showDepictPopView{
    MMPopupCompletionBlock completeBlock1 = ^(MMPopupView *popupView, BOOL finished){
        NSLog(@"animation complete");
    };
//    self.depictPopView.model = self.model;
    [self.depictPopView.tableView reloadData];
    [self.depictPopView showWithBlock:completeBlock1];
}

#pragma mark btn Action

- (void)requestImageList{
    [[XBJNetWork sharedInstance] getImagesByReportId:self.model.reportId block:^(NSArray *array, NSError *error) {
        if(array.count){
            self.downloadPopView.images = array;
        }else{
            self.downLoadBtn.hidden = YES;
        }
    }];
}

- (IBAction)showDonloadImageTipsView:(id)sender {

    [self.downloadPopView showWithBlock:^(MMPopupView *popupView, BOOL finished){
        NSLog(@"animation complete");
    }];
}

#pragma mark - tableView delegate/dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XBJTestReportCell *cell=(XBJTestReportCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
//    XBJTestReportCell *cell =(XBJTestReportCell *)[tableView cellForRowAtIndexPath:self.indexPath];
    
    if(indexPath.row==self.openRow){
        cell.open = YES;
        NSString *contentText;
        
        switch (indexPath.row) {
            case 0:{
                contentText=@"正常颜色:\n 1)黄褐色。婴儿的便便呈现黄绿色或金黄色，随着宝宝消化能力的提升，便便颜色逐渐加深呈现黄褐色。\n异常颜色：\n 1)绿色：常见于小儿肠炎，或食用大量绿色蔬菜。此外，有些吃富含铁质配方奶的宝宝，排出的粪便会呈暗绿色。\n 2)白色、灰白色：常见于阻塞性黄疸。\n 3)红色便：常见于肛裂及痔疮等，或食用大量番茄、西瓜等\n 4)果酱色：常见于肠套叠，或食用大量巧克力等；\n 5)黑色（柏油色）：常见于上消化道出血。如果进食动物血、猪肝等含铁多的食物也可使粪便呈黑色，但一般为灰黑色无光泽，做隐血试验阴性可帮助鉴别。";
                
                
                break;
            }
            case 1:{
                contentText=@"正常形态:\n 1)成形软便。婴儿便便呈现糊状，随着宝宝肠道功能逐步成熟，便便逐步为成形软 \n异常形态：\n 1)泡沫样大便：常见于偏食淀粉或糖类食物过多时。\n 2)奇臭难闻大便：常见于偏食含蛋白质的食物过多时。\n 3)蛋花汤样大便：粘液性或脓血性便，常见于病毒性肠炎和致病性大肠杆菌性肠炎等。\n 4)豆腐渣样大便：常见于霉菌引起的肠炎。\n 5)粥样或水样稀便：见于急性肠炎、食物中毒等。\n 6)乳凝乳块便：见于婴儿消化不良、婴儿腹泻、脂肪或酪蛋白消化不全等。\n 7)球形硬便：见于便秘、偏食等。";
                
                break;
            }
            case 2:{
                contentText=@"正常参考值:\n 1)未见（-）\n异常情况：\n 1)（+）的多少代表便便中红细胞的数量情况。红细胞的出现和增多，常见于下消化道炎症或出血。上消化道出血时，由于胃液的消化作用，红细胞已破坏，粪便中难见到，可配合隐血检测结果分析。";
                
                break;
            }
            case 3:{
                contentText=@"正常参考值：\n 1)未见（-）或少许\n异常情况：\n 1)（+）的多少代表便便中白细胞的数量情况。白细胞数量与炎症轻重及部位有关。若是细菌感染，除了可见大便中含有脓性物质，会检测出较多白细胞或脓细胞，同时也可检测出红细胞。若是病毒感染，以稀水便为主，会检测出少许白、红细胞。";
                
                break;
            }
            case 4:{
                contentText=@"正常参考值：\n 1)未检出（-）\n异常情况：\n 1)检出（+）表示粪便中存在脂肪球。粪便脂肪检测可作为了解消化功能和胃肠道吸收功能的参考指标。宝宝消化不良、吸收能力减退时，便便中可能会检出脂肪球。";
                
                break;
            }
            case 5:{
                contentText=@"正常参考值：\n 1)未检出（-）\n异常情况：\n 1)检出（+）表示宝宝肠道感染寄生虫。大多数肠道寄生虫感染与卫生条件、生活习惯、健康意识和家庭聚集性等因素有关。肠道寄生虫感染可能引起腹泻、腹痛、营养吸收不良等症状。肠道寄生虫种类较多，如检出，建议咨询正规医院专科医生，使用对应的驱虫药治疗。";
                
                break;
            }
            case 6:{
                contentText=@"正常参考值：\n 1)未检出（-）\n异常情况：\n 1)检出（+）表示宝宝肠道感染寄生虫。虫卵容易漏检，如怀疑感染寄生虫，建议多次检查。肠道寄生虫种类较多，如检出，建议咨询正规医院专科医生，使用对应的驱虫药治疗。";
                
                break;
            }
            case 7:{
                contentText=@"正常参考值：\n 1)阴性（-）\n异常情况：\n 1)阳性（+）表示宝宝消化道出现少量出血现象。肠道隐性出血可能引起宝宝黑便、便血等症状。";
                
                break;
            }
            case 8:{
                contentText=@"正常参考值：\n 1)未检出（-）\n异常情况：\n 1)检出（+）表示宝宝肠道感染霉菌。宝宝腹泻、红屁屁、大便豆渣样等，可能与霉菌感染相关。抗生素或消毒剂滥用、过于干净养育宝宝等可造成肠道菌群失调，就容易出现霉菌感染。";
                
                break;
            }
            case 9:{
                contentText=@"正常参考值：\n 1)阴性（-）\n异常情况：\n 1)阳性（+）表示A群轮状病毒感染。轮状病毒引起的胃肠炎俗称“秋季腹泻”，发热、呕吐、便便成蛋花汤样，一般与轮状病毒感染相关。轮状病毒性胃肠炎对宝宝造成的危害就是呕吐及腹泻后的脱水，建议提供充足水分、适当添加电解质、服用益生菌。";
                
                break;
            }
                
            default:
                break;
        }
            return  [XBJTestReportCell rowheight:contentText];
    }else{
        cell.open = NO;
        return 35;
    }
   
        
    
    
    
    
    
    
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择 ");
    
    
    if(self.openRow==indexPath.row){
        self.openRow = -1;
    }else{
        self.openRow = indexPath.row;
    }
//    NSArray *arr=@[indexPath];
//
//    [self.tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadData];
    NSLog(@"%f",self.tableView.contentSize.height);
    
    self.tableviewHeight.constant=self.tableView.contentSize.height;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XBJTestReportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJTestReportCell"];
  
    if(indexPath.row==self.openRow){
        cell.open = YES;
    }else{
        cell.open = NO;
    }
    [cell setModel:self.model andIndex:indexPath.row];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.headView;
}

#pragma mark set method
- (XBJDownloadPopView *)downloadPopView{
    if(!_downloadPopView){
        float width = SCREEN_WIDTH - 60;
        float height = 200;
        _downloadPopView = [[[UINib nibWithNibName:@"XBJDownloadPopView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        _downloadPopView.frame = CGRectMake(0, 0, width, height);
        
        __weak __typeof__(self) weakSelf = self;
        [_downloadPopView setBlock:^(BOOL state){
            __strong __typeof__(weakSelf) strongSelf = weakSelf;
            if(state){
                [strongSelf showToastWith:@"保存图片成功"];
            }else{
                [strongSelf showToastWith:@"保存图片失败"];
            }
        }];
    }
    return _downloadPopView;
}

- (XBJTestDepictPopView *)depictPopView{
    if(!_depictPopView){
        float width = SCREEN_WIDTH - 60;
        float height = width*720/650.0;
        _depictPopView = [[[UINib nibWithNibName:@"XBJTestDepictPopView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        _depictPopView.frame = CGRectMake(0, 0, width, height);
    }
    return _depictPopView;
}

- (void)setModel:(XBJTestReportModel *)model
{
    _model = model;
    [self requestImageList];
    [self.tableView reloadData];
    
    NSString *nbsp = [model.remark stringByReplacingOccurrencesOfString:@"&nbsp" withString:@""];
    NSString *br = [nbsp stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
    self.textView.text = br;
    self.textView.textColor = CELL_TXT_COLOR;
    self.codeLabel.text = model.sampleCode;
    self.dateLabel.text = model.collectTime;
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
