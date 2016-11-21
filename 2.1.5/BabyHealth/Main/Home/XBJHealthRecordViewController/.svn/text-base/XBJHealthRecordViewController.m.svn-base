//
//  XBJHealthRecordViewController.m
//  ChartDemo
//
//  Created by jxmac2 on 16/6/29.
//  Copyright © 2016年 jxmac2. All rights reserved.
//

#import "XBJHealthRecordViewController.h"
#import "XBJGrowView.h"
#import "XBJShitView.h"
#import "XBJDrugView.h"
#import "XBJAddGrowRecordViewController.h"
#import "XBJAddShitRecordViewController.h"
#import "XBJAddDrugRecordViewController.h"
#import "XBJGrowRecordModel.h"
#import "XBJInfoView.h"

#define TOPVIEW_HEIGHT (80)
#define TOLINE_WIDTH (50)

@interface XBJHealthRecordViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIView *topLine;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) XBJGrowView *growView;
@property (nonatomic, strong) XBJShitView *shitView;
@property (nonatomic, strong) XBJDrugView *drugView;
@property (nonatomic, strong) XBJInfoView *infoView;

@property (nonatomic,assign) XBJAddRecordStyle addType;

@end

@implementation XBJHealthRecordViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_growView requestData];
    [_shitView requestData];
    [_drugView requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"健康记录";
    [self addRightBarButtonWithTitle:nil color:nil normal:@"info" highLight:@"info" action:@selector(infoAction) target:self];
    [self addRightBarButtonWithTitle:nil color:nil normal:@"share" highLight:@"share" action:@selector(shareAction) target:self];

    [self configureView];
    
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
}

- (void)configureView{
    
    [self.view addSubview:self.topView];
    
    NSArray *titles = @[@"生长",@"便便",@"用药"];
    for(int i=0; i<titles.count; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i+10;
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:ChartLine_COLOR forState:UIControlStateNormal];
        [btn setTitleColor:BG_COLOR2 forState:UIControlStateSelected];
        
        float centerX = CGRectGetWidth(self.topView.bounds)/2;
        float centerY = CGRectGetHeight(self.topView.bounds)/2;
        if(i==0){
            btn.selected = YES;
            btn.bounds = CGRectMake(0, 0, TOLINE_WIDTH, CGRectGetHeight(self.topView.frame));
            btn.center = CGPointMake(centerX-TOLINE_WIDTH, centerY);
        }else if(i==1){
            btn.bounds = CGRectMake(0, 0, TOLINE_WIDTH, CGRectGetHeight(self.topView.frame));
            btn.center = CGPointMake(centerX, centerY);
        }else{
            btn.bounds = CGRectMake(0, 0, TOLINE_WIDTH, CGRectGetHeight(self.topView.frame));
            btn.center = CGPointMake(centerX+TOLINE_WIDTH, centerY);
        }
        [btn addTarget:self action:@selector(segmentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:btn];
    }
    
    [self.topView addSubview:self.topLine];
    [self.view addSubview:self.scrollView];
    
    // 添加记录按钮
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(SCREEN_WIDTH-88, SCREEN_HEIGHT-88, 56, 56);
    [self.addBtn setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(pushToAddRecord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addBtn];
}

#pragma mark Action Method --

- (void)segmentBtnClick:(UIButton *)btn{
    self.addType = btn.tag-10;
    if (btn.selected==NO) {
        _growView.isBig=NO;
        _drugView.isBig=NO;
        _shitView.isBig=NO;
        
        [_growView chartChangeSize];
        [_drugView chartChangeSize];
        [_shitView chartChangeSize];
        self.addBtn.hidden = NO;
    }
    btn.selected = YES;
    for(UIView *view in self.topView.subviews){
        if([view isKindOfClass:[UIButton class]]){
            UIButton *button = (UIButton *)view;
            if(button!=btn){
                button.selected = NO;
            }
        }
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.topLine.center = CGPointMake(btn.center.x, _topView.bounds.size.height-1.5);
    }];
    
    NSInteger index = btn.tag-10;
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH *index, 0) animated:YES];
}

- (void)pushToAddRecord{
    UIViewController *vc;
    switch (self.addType) {
        case XBJAddRecordStyleGrow:
            vc = [XBJAddGrowRecordViewController new];
            break;
        case XBJAddRecordStyleShit:
            vc = [XBJAddShitRecordViewController new];
            break;
        case XBJAddRecordStyleDrug:
            vc = [XBJAddDrugRecordViewController new];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)infoAction{
    NSLog(@"info Action！！");
    [self.infoView showWithBlock:nil];
    self.infoView.textView.contentOffset = CGPointZero;
}

- (void)shareAction{
    NSLog(@"share Action！！");
    [XBJAppHelper shareIn:self shareText:@"你好，健康记录"];
}

#pragma mark UIScrollView delegate --

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/SCREEN_WIDTH;
    NSInteger tag = index+10;
    for(UIView *view in self.topView.subviews){
        if([view isKindOfClass:[UIButton class]]){
            UIButton *btn = (UIButton*)view;
            if(btn.tag==tag && btn.selected==NO){
                [self segmentBtnClick:btn];
            }
        }
    }
}

#pragma mark Set Method --

- (XBJInfoView *)infoView{
    if(!_infoView){
        float width = SCREEN_WIDTH - 60;
        float height = SCREEN_HEIGHT-160;
        _infoView = [[[UINib nibWithNibName:@"XBJInfoView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        _infoView.frame = CGRectMake(0, 0, width, height);
    }
    return _infoView;
}

- (UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, AUTO_MATE_HEIGHT(TOPVIEW_HEIGHT))];
        _topView.backgroundColor = NAV_COLOR;
        _topView.alpha=0.85;
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,AUTO_MATE_HEIGHT(TOPVIEW_HEIGHT)-1,SCREEN_WIDTH,1)];
//        line.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
//        [_topView addSubview:line];
    }
    return _topView;
}

- (UIView *)topLine{
    if(!_topLine){
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TOLINE_WIDTH, 2)];
        _topLine.backgroundColor = [UIColor whiteColor];
        _topLine.center = CGPointMake(_topView.center.x-TOLINE_WIDTH, _topView.bounds.size.height-1.5);
    }
    return _topLine;
}

- (UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(self.topView.frame))];
        _scrollView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, CGRectGetHeight(_scrollView.frame));
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        __weak __typeof__(self) weakSelf = self;
        {
            _growView = [[[UINib nibWithNibName:@"XBJGrowView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
            _growView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(_scrollView.frame));
            _growView.isBig=NO;
        
            
            [_growView setToastBlock:^(NSString *msg){
                __strong __typeof__(weakSelf) strongSelf = weakSelf;
                [strongSelf showToastWith:msg];
            }];
            [_growView setEditBlock:^(XBJGrowRecordModel *model){
                __strong __typeof__(weakSelf) strongSelf = weakSelf;
                XBJAddGrowRecordViewController *vc = [XBJAddGrowRecordViewController new];
                vc.model = model;
                [strongSelf.navigationController pushViewController:vc animated:YES];
            }];
            [_growView  setBlock:^(BOOL isHide){
                __strong __typeof__(weakSelf) strongSelf = weakSelf;
                if (isHide) {
                    strongSelf.addBtn.hidden = YES;
                    strongSelf.scrollView.scrollEnabled = NO;
                }
                else
                {
                    strongSelf.addBtn.hidden = NO;
                    strongSelf.scrollView.scrollEnabled = YES;
                }
                
            }];
            
            [_growView configureView];
            _growView.s_index = self.s_index;
            [_scrollView addSubview:_growView];
        }
        
        {
            _shitView = [[[UINib nibWithNibName:@"XBJShitView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
            _shitView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, CGRectGetHeight(_scrollView.frame));
            _shitView.isBig=NO;
            [_shitView setToastBlock:^(NSString *msg){
                __strong __typeof__(weakSelf) strongSelf = weakSelf;
                [strongSelf showToastWith:msg];
            }];
            [_shitView setEditBlock:^(XBJShitRecordModel *model){
                __strong __typeof__(weakSelf) strongSelf = weakSelf;
                XBJAddShitRecordViewController *vc = [XBJAddShitRecordViewController new];
                vc.model = model;
                [strongSelf.navigationController pushViewController:vc animated:YES];
            }];
            [_shitView setBlock:^(BOOL isHide){
                __strong __typeof__(weakSelf) strongSelf = weakSelf;
                if (isHide) {
                    strongSelf.addBtn.hidden = YES;
                    strongSelf.scrollView.scrollEnabled = NO;
                }
                else
                {
                    strongSelf.addBtn.hidden = NO;
                    strongSelf.scrollView.scrollEnabled = YES;
                }
                
            }];
            
            [_shitView configureView];
            [_scrollView addSubview:_shitView];
        }
        
        {
            _drugView = [[[UINib nibWithNibName:@"XBJDrugView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
            _drugView.frame = CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, CGRectGetHeight(_scrollView.frame));
            _drugView.isBig=NO;
            
            [_drugView setToastBlock:^(NSString *msg){
                __strong __typeof__(weakSelf) strongSelf = weakSelf;
                [strongSelf showToastWith:msg];
            }];
            
            [_drugView setEditBlock:^(XBJDrugRecordModel *model){
                __strong __typeof__(weakSelf) strongSelf = weakSelf;
                XBJAddDrugRecordViewController *vc = [XBJAddDrugRecordViewController new];
                vc.model = model;
                [strongSelf.navigationController pushViewController:vc animated:YES];
            }];
            
            [_drugView setBlock:^(BOOL isHide){
                __strong __typeof__(weakSelf) strongSelf = weakSelf;
                if (isHide) {
                    strongSelf.addBtn.hidden = YES;
                    strongSelf.scrollView.scrollEnabled = NO;
                }
                else
                {
                    strongSelf.addBtn.hidden = NO;
                    strongSelf.scrollView.scrollEnabled = YES;
                }
                
            }];
            
            
            [_drugView configureView];
            [_scrollView addSubview:_drugView];
        }
        
    }
    return _scrollView;
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
