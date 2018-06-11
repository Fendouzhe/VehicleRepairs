//
//  LRLoginViewController.m
//  AntCarsRepair
//
//  Created by 雷路荣 on 2018/6/9.
//  Copyright © 2018年 广州宇中网络科技有限公司. All rights reserved.
//

#import "LRLoginViewController.h"

@interface LRLoginViewController ()<UITextFieldDelegate>

/**
 *  输入手机号码的textField
 */
@property (nonatomic ,strong)UITextField *phoneField;

/**
 *  输入验证码的textField
 */
@property (nonatomic ,strong)UITextField *testCodeField;

/**
 *  输入密码的textField
 */
//获取验证码按钮
@property (nonatomic ,strong)UIButton *getNumBtn;

//剩下的时间
@property(nonatomic ,assign)int leftTime;

@property(nonatomic,strong) NSTimer *timer;


@end

@implementation LRLoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"忘记密码";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;

    [self setupUI];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)setupUI{
    
    
    CGFloat leftMargin = 30*LRMatch;
    CGFloat width = LRScreenWidth - 2 * leftMargin;
    NSNumber *widthNum = [NSNumber numberWithFloat:width];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.height.equalTo(@(80*LRMatch));
        if (isIPhoneX) {
            make.top.equalTo(self.view.mas_top).with.offset(60*LRMatchHeight);
        }else{
            make.top.equalTo(self.view.mas_top).with.offset(30*LRMatchHeight);
        }
    }];
    
    //输入手机号码的textField
    UITextField *phoneField = [[UITextField alloc] init];
    phoneField.returnKeyType = UIReturnKeyNext;
    phoneField.delegate = self;
    phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.font = LRFont(12);
    [self.view addSubview:phoneField];
    phoneField.placeholder = @"请输入手机号码";
    [phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(imageView.mas_bottom).with.offset(20*LRMatch);
        make.width.equalTo(widthNum);
        make.height.equalTo(@30);
    }];
    self.phoneField = phoneField;
    
    //输入手机号码下面的横线
    UILabel *phoneUnderLine = [[UILabel alloc] init];
    phoneUnderLine.backgroundColor = LRSystermCellSepLineColor;
    [self.view addSubview:phoneUnderLine];
    [phoneUnderLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(phoneField.mas_bottom);
        make.width.equalTo(widthNum);
        make.height.equalTo(@1);
    }];
    
    //输入验证码的field   secretField
    UITextField *testCodeField = [[UITextField alloc] init];
    testCodeField.delegate = self;
    [self.view addSubview:testCodeField];
    testCodeField.returnKeyType = UIReturnKeyDone;
    testCodeField.placeholder = @"请输入验证码";
    testCodeField.font = LRFont(12);
    [testCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(phoneUnderLine.mas_bottom).offset(20*LRMatch);
        make.width.equalTo(widthNum);
        make.height.equalTo(@30);
    }];
    self.testCodeField = testCodeField;
    
    //输入验证码下面的横线
    UILabel *testCodeUnderLine = [[UILabel alloc] init];
    testCodeUnderLine.backgroundColor = LRSystermCellSepLineColor;
    [self.view addSubview:testCodeUnderLine];
    [testCodeUnderLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(testCodeField.mas_bottom);
        make.width.equalTo(widthNum);
        make.height.equalTo(@1);
    }];
    
    //下一步  按钮
    UIButton *nextStepBtn = [[UIButton alloc] init];
    [self.view addSubview:nextStepBtn];
    [nextStepBtn setTitle:@"登录" forState:UIControlStateNormal];
    nextStepBtn.layer.cornerRadius = 2;
    nextStepBtn.clipsToBounds = YES;
    nextStepBtn.titleLabel.font = LRFont(14);
    [nextStepBtn setBackgroundColor:KMainColor];
    [nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(testCodeUnderLine.mas_bottom).offset(44*LRMatch);
        make.width.equalTo(widthNum);
        make.height.equalTo(@40);
    }];
    [nextStepBtn addTarget:self action:@selector(nextStepClick) forControlEvents:UIControlEventTouchUpInside];
    
    //获取验证码按钮
    UIButton *getNumBtn = [[UIButton alloc] init];
    self.getNumBtn = getNumBtn;
    [self.view addSubview:getNumBtn];
    getNumBtn.layer.cornerRadius = 6;
    getNumBtn.clipsToBounds = YES;
    
    NSMutableAttributedString *getNumStr = [[NSMutableAttributedString alloc] initWithString:@"获取验证码"];
    NSRange GetNumStrRange = {0,[getNumStr length]};
    [getNumStr addAttribute:NSFontAttributeName value:LRFont(12) range:GetNumStrRange];
    [getNumStr addAttribute:NSForegroundColorAttributeName value:KMainColor range:GetNumStrRange];
    [getNumBtn setAttributedTitle:getNumStr forState:UIControlStateNormal];
    
    
    //    [getNumBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getNumBtn setBackgroundColor:[UIColor whiteColor]];
    [getNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(testCodeUnderLine.mas_top).with.offset(-5);
        make.right.equalTo(testCodeUnderLine.mas_right);
        make.width.equalTo(@(80*LRMatch));
        make.height.equalTo(@(24*LRMatch));
    }];
    getNumBtn.layer.cornerRadius = 6;
    getNumBtn.layer.masksToBounds = YES;
    getNumBtn.layer.borderColor = KMainColor.CGColor;
    getNumBtn.layer.borderWidth = 1.3;
    [getNumBtn addTarget:self action:@selector(getNumBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

#pragma mark -- 定时器60秒衰减代码
- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timePass) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        _leftTime = 60;
    }
    return _timer;
}

//时间一秒一秒的流逝，按钮的60秒倒计时开始。（定时器回调方法）
- (void)timePass{
    if (self.leftTime == 0) {
        [self.timer invalidate];
        self.timer = nil;
        [self setupBtnState];
        return;
    }
    _leftTime--;
    self.getNumBtn.enabled = NO;
    NSString *timeStr = [NSString stringWithFormat:@"%d秒后重获",self.leftTime];
    
    NSMutableAttributedString *getNumStr = [[NSMutableAttributedString alloc] initWithString:timeStr];
    NSRange GetNumStrRange = {0,[getNumStr length]};
    [getNumStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:GetNumStrRange];
    [getNumStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:GetNumStrRange];
    [self.getNumBtn setAttributedTitle:getNumStr forState:UIControlStateNormal];
    [self.getNumBtn setTitle:timeStr forState:UIControlStateNormal];
}

//秒数减少到0 的时候，就重新设置 button的状态
- (void)setupBtnState{
    
    self.getNumBtn.enabled = YES;
    [self.getNumBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    NSMutableAttributedString *getNumStr = [[NSMutableAttributedString alloc] initWithString:@"获取验证码"];
    NSRange GetNumStrRange = {0,[getNumStr length]};
    [getNumStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:GetNumStrRange];
    [getNumStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:GetNumStrRange];
    [self.getNumBtn setAttributedTitle:getNumStr forState:UIControlStateNormal];
}

#pragma mark -- 点击事件
- (void)getNumBtnDidClick{
    LRLog(@"点击了 获取验证码 按钮");
    if (![self.phoneField.text trimmingWhitespace].length) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码！"];
        return;
    }
    if (![self.phoneField.text judgePhoneNumber]) {
        [SVProgressHUD showErrorWithStatus:@"手机号码有误，请重新输入！"];
        return;
    }
    /*
    [[SKAPI shared] forgetSecretWithPhone:self.phoneField.text block:^(id result, NSError *error) {
        if (!error) {
            SMLog(@"获取验证码成功   %@",result);
            [self.timer fire];
        }else{
            //NSString *errorText = error.userInfo[@"NSLocalizedDescription"];
            [SVProgressHUD showErrorWithStatus:error.localizedDescription duration:ShowErrorTime];
            SMLog(@"error===%@",error);
        }
    }];
     */
}

- (void)nextStepClick{
    LRLog(@"点击了 下一步 按钮");
    if (self.phoneField.text.trimmingWhitespace.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码!"];
        return;
    }else if (self.testCodeField.text.trimmingWhitespace.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"验证码不能为空!"];
        return;
    }
    //SMLog(@"self.phoneField.text = %@  self.testCodeField.text = %@",self.phoneField.text,self.testCodeField.text);
    /*
    [[SKAPI shared] smsVerifyWithPhone:self.phoneField.text andVefifyCode:self.testCodeField.text block:^(id result, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription duration:ShowErrorTime];
            SMLog(@"errorText == %@",error);
        }else{
            SMLog(@"result == %@",result);
            
            SMSetNewSecretViewController *setNewVc = [[SMSetNewSecretViewController alloc] init];
            setNewVc.phoneNumber = self.phoneField.text;
            setNewVc.verifyCode = self.testCodeField.text;
            [self.navigationController pushViewController:setNewVc animated:YES];
     
        }
    }];
     */
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.phoneField) {
        if ([string isEqualToString:@"\n"]) {
            [self.testCodeField becomeFirstResponder];
        }
    }else if (textField == self.testCodeField){
        if ([string isEqualToString:@"\n"]) {
            [self.testCodeField resignFirstResponder];
        }
    }
    return YES;
}

@end
