

//
//  ModifyMobliePhoneController.m
//  BabyHealth
//
//  Created by USER on 16/10/19.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "ModifyMobliePhoneController.h"
#import "NSString+IMBExtension.h"
#import "XBJNetWork.h"


@interface ModifyMobliePhoneController ()
@property (weak, nonatomic) IBOutlet UITextField *mobilePhoneTextF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextF;
@property(weak,nonatomic)NSTimer *counTimer;
@property(assign,nonatomic)NSInteger count;

- (IBAction)clickCodeBut:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *codeBut;

@end

@implementation ModifyMobliePhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mobilePhoneTextF becomeFirstResponder];
    

    
    UIBarButtonItem *right= [[UIBarButtonItem   alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickSaveBut)];
    self.navigationItem.rightBarButtonItem=right;
    


}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickCodeBut:(id)sender {
    
    
    if([self.mobilePhoneTextF.text isPhoneNum])
    {
        
        
        [self   getCode:self.mobilePhoneTextF.text];
        
    }else
    {
        [self.navigationController.view makeToast:@"请输入合法的手机号"
                                         duration:1.0
                                         position:CSToastPositionCenter];
    }
    
    
}

-(void)getCode:(NSString*)mobile{
    
    
    [[XBJNetWork sharedInstance] getModiflyMobilePhoneCode:mobile  block:^(NSNumber * result,NSString *message, NSError *error) {
        if(error){
            [self.navigationController.view makeToast:error.localizedDescription
                                             duration:1.0
                                             position:CSToastPositionCenter];
        }else{
            
            if([result integerValue]==1)
            {
                NSLog(@"%d",[NSThread isMainThread]);
                NSTimer *timeer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
                self.counTimer=timeer;
                self.count=60;
                [[NSRunLoop currentRunLoop] addTimer:self.counTimer forMode:NSRunLoopCommonModes];
                [self.codeBut setTitle:@"60s后可重发"forState:UIControlStateNormal];
                [self.codeBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

            }else{
               
                
            }
            
            [self.navigationController.view makeToast:message
                                             duration:1.0
                                             position:CSToastPositionCenter];
            
        }
    }];

}

-(void)countTime
{
    self.count--;
    self.codeBut.userInteractionEnabled=NO;
    NSString *titleStr=[[NSString stringWithFormat:@"%ld",self.count] stringByAppendingString:@"s后可重发"];
    [self.codeBut setTitle:titleStr forState:UIControlStateNormal];
    if(self.count==0){
        [self.counTimer invalidate];
        self.counTimer=nil;
        self.codeBut.userInteractionEnabled=YES;
        [self.codeBut setTitle:@"获取验证码"forState:UIControlStateNormal];
        [self.codeBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
}


-(void)clickSaveBut
{
    NSString *customerId = [XBJAppHelper SQLUser].customerId;

    [[XBJNetWork sharedInstance] ModiflyMobilePhone:self.mobilePhoneTextF.text customerId:customerId smsVerifCode:self.passWordTextF.text block:^(NSNumber *result, NSString *message, NSError *error) {
        if(error){
            [self.navigationController.view makeToast:error.localizedDescription
                                             duration:1.0
                                             position:CSToastPositionCenter];
        }else{
            
            if([result integerValue]==1)
            {
                
                self.modifyMobilePhoneBlock(self.mobilePhoneTextF.text);
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                
     
            }
            
            [self.navigationController.view makeToast:message
                                             duration:1.0
                                             position:CSToastPositionCenter];
            
        }
    }];
    
    

}

@end
