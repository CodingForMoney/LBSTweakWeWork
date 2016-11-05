#import "XMLocationSettingViewController.h"

@implementation XMLocationSettingViewController
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wobjc-method-access"

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"设置定位信息";
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat screenwidth = self.view.bounds.size.width;
    CGFloat scrennheight = self.view.bounds.size.height;
    
    CGRect rect = CGRectMake(10, 10, 80, 25);
    // 中心
    UILabel *centerLabel = [self addLable];
    centerLabel.text = @"位置中心 : ";
    [self.view addSubview:centerLabel];
    centerLabel.font = [UIFont boldSystemFontOfSize:17];
    centerLabel.frame = rect;
    
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationBtn setTitle:@"定位当前位置" forState:UIControlStateNormal];
    [locationBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    locationBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    locationBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    rect.origin.x = screenwidth - 100;
    [self.view addSubview:locationBtn];
    locationBtn.frame = CGRectMake(screenwidth - 200, 10, 180, 25);
    [locationBtn addTarget:self action:@selector(clickLocation) forControlEvents:UIControlEventTouchUpInside];
    // 经度
    UILabel *jinduLabel = [self addLable];
    jinduLabel.text = @"经度(东):";
    [self.view addSubview:jinduLabel];
    jinduLabel.frame = CGRectMake(25, 50, 80, 35);
    
    UITextField *jinduText = [self addTextfield];
    [self.view addSubview:jinduText];
    jinduText.frame = CGRectMake(120, 50, screenwidth - 130, 35);
    jinduText.tag = 1;
    // 维度
    UILabel *weiduLabel = [self addLable];
    weiduLabel.text = @"纬度(北):";
    [self.view addSubview:weiduLabel];
    weiduLabel.frame = CGRectMake(25, 95, 80, 35);
    
    UITextField *weiduText = [self addTextfield];
    [self.view addSubview:weiduText];
    weiduText.frame = CGRectMake(120, 95, screenwidth - 130, 35);
    weiduText.tag = 2;
    
    UIView *spec1View = [[UIView alloc] init];
    spec1View.backgroundColor = [UIColor colorWithRed:(128)/255.f green:(128)/255.f blue:(128)/255.f alpha:1.f];
    [self.view addSubview:spec1View];
    spec1View.frame = CGRectMake(10, 135, screenwidth - 20, 0.5);
    
    
    
    // 范围, 圆 .
    UILabel *ruleLabel = [self addLable];
    ruleLabel.text = @"范围设置 : ";
    [self.view addSubview:ruleLabel];
    ruleLabel.font = [UIFont boldSystemFontOfSize:17];
    ruleLabel.frame =  CGRectMake(10, 140, 80, 25);
    
    UILabel *banjinLabel = [self addLable];
    banjinLabel.text = @"半径(米):";
    [self.view addSubview:banjinLabel];
    banjinLabel.frame = CGRectMake(25, 179, 80, 35);
    
    UITextField *banjinText = [self addTextfield];
    [self.view addSubview:banjinText];
    banjinText.frame = CGRectMake(120, 179, screenwidth - 130, 35);
    banjinText.tag = 3;
    
    UILabel *infoLabel = [self addLable];
    infoLabel.numberOfLines = 2;
    infoLabel.textColor = [UIColor colorWithRed:(166)/255.f green:(166)/255.f blue:(166)/255.f alpha:1.f];
    infoLabel.font = [UIFont systemFontOfSize:15];
    infoLabel.text = @"不设置范围, 表示每次以固定经纬度返回, 设定范围, 如这里的半径,表示以当前位置为圆心画圆,每次返回圆内的随机点.";
    [self.view addSubview:infoLabel];
    infoLabel.frame = CGRectMake(10, 210, screenwidth, 60);
    
    UIView *spec2View = [[UIView alloc] init];
    spec2View.backgroundColor = [UIColor colorWithRed:(128)/255.f green:(128)/255.f blue:(128)/255.f alpha:1.f];
    [self.view addSubview:spec2View];
    spec2View.frame = CGRectMake(10, 275, screenwidth - 20, 0.5);
    
    // 确认按键 :
    UIButton *settingBtn = [self addButton];
    settingBtn.backgroundColor = [UIColor colorWithRed:(96)/255.f green:(177)/255.f blue:(246)/255.f alpha:1.f];
    [settingBtn setTitle:@"确认设置" forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(clickConfirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBtn];
    settingBtn.frame = CGRectMake(15, scrennheight - 190, screenwidth - 30, 44);
    
    // 取消设置 :
    UIButton *cancleBtn = [self addButton];
    cancleBtn.backgroundColor = [UIColor colorWithRed:(251)/255.f green:(124)/255.f blue:(137)/255.f alpha:1.f];
    [cancleBtn setTitle:@"取消设置" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancleBtn];
    cancleBtn.frame = CGRectMake(15, scrennheight - 120, screenwidth - 30, 44);
    
    
    // 获取当前设置中的属性.
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *jingdu = [userInfo objectForKey:@"XMLocationJindu"];
    NSString *weidu = [userInfo objectForKey:@"XMLocationWeidu"];
    NSString *radius = [userInfo objectForKey:@"XMLocationRadius"];
    jinduText.text = jingdu;
    weiduText.text = weidu;
    banjinText.text = radius;
    
    // 键盘取消
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    UITextField *text = [self.view viewWithTag:1];
    [text resignFirstResponder];
    text = [self.view viewWithTag:2];
    [text resignFirstResponder];
    text = [self.view viewWithTag:3];
    [text resignFirstResponder];
}

- (UIButton *)addButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6] forState:UIControlStateHighlighted];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 4;
    return button;
}

- (UILabel *)addLable {
    UILabel *label = [[UILabel alloc]init];
    label.adjustsFontSizeToFitWidth = YES;
    label.numberOfLines = 1;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.backgroundColor = [UIColor clearColor];
    label.textColor =  [UIColor colorWithRed:(128)/255.f green:(128)/255.f blue:(128)/255.f alpha:1.f];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

- (UITextField *)addTextfield {
    UITextField *field = [[UITextField alloc] init];
    field.clearButtonMode  = UITextFieldViewModeWhileEditing;
    field.textAlignment = NSTextAlignmentRight;
    field.font = [UIFont systemFontOfSize:16];
    field.layer.borderWidth = 0.5;
    field.textColor = [UIColor colorWithRed:(51)/255.f green:(51)/255.f blue:(51)/255.f alpha:1.f];
    field.keyboardType = UIKeyboardTypeDecimalPad;
    return field;
}

- (void)clickLocation {
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = (id<CLLocationManagerDelegate> )self;
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.9) {
            [locationManager requestWhenInUseAuthorization];
        }
        return;
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied ){
        [self promoteMessage:@"请打开定位权限"];
        return;
    }
    
    [locationManager startUpdatingLocation];
    self.manager = locationManager;
    Class cls = NSClassFromString(@"MBProgressHUD");
    MBProgressHUD *hud = [[cls alloc] initWithView:self.view];
    hud.removeFromSuperViewOnHide = YES;
    [self.view addSubview:hud];
    [hud show:YES];
    hud.mode = 0;
    hud.labelText = @"获取经纬度";
    hud.margin = 10.f;
    self.hud = hud;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.9) {
        if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {// 更改权限后.
            [manager startUpdatingLocation];
        }
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation * currLocation = [locations lastObject];
    [manager stopUpdatingLocation];
    UITextField *text = [self.view viewWithTag:1];
    NSString *jindu =  [@(currLocation.coordinate.longitude) stringValue];
    NSString *weidu =  [@(currLocation.coordinate.latitude) stringValue];
    text.text = jindu;
    text = [self.view viewWithTag:2];
    text.text = weidu;
    [self.hud hide:YES];
}

- (void)clickConfirm {
    UITextField *jinduText = [self.view viewWithTag:1];
    if (![self checkIsNumber:jinduText.text]) {
        [self promoteMessage:@"请输入正确的经度"];
        return;
    }
    float f = [jinduText.text floatValue];
    if (f < 0 || f > 180) {
        [self promoteMessage:@"请输入正确的经度 , 只能在东半球."];
        return;
    }
    
    UITextField *weiduText = [self.view viewWithTag:2];
    if (![self checkIsNumber:weiduText.text]) {
        [self promoteMessage:@"请输入正确的维度"];
        return;
    }
    f = [weiduText.text floatValue];
    if (f < 0 || f > 80) {
        [self promoteMessage:@"请输入正确的经度 , 只能在北半球."];
        return;
    }
    UITextField *banjinText = [self.view viewWithTag:3];
    if (![banjinText.text isEqualToString:@""] && ![self checkIsNumber:banjinText.text]) {
        [self promoteMessage:@"请输入正确的半径"];
        return;
    }
    f = [weiduText.text floatValue];
    if (f < 0 || f > 10000) {
        [self promoteMessage:@"请输入正确的半径, 不能超过 10,000 米"];
        return;
    }
    
    // 存放数据 :
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setObject:jinduText.text forKey:@"XMLocationJindu"];
    [userInfo setObject:weiduText.text forKey:@"XMLocationWeidu"];
    [userInfo setObject:banjinText.text forKey:@"XMLocationRadius"];
    [userInfo synchronize];
    [self promoteMessage:@"设置完成."];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)promoteMessage:(NSString *)message {
    Class cls = NSClassFromString(@"MBProgressHUD");
    MBProgressHUD *hud = [[cls alloc] initWithView:self.view];
    hud.removeFromSuperViewOnHide = YES;
    [self.view addSubview:hud];
    [hud show:YES];
    hud.mode = 5;
    hud.labelText = message;
    hud.margin = 10.f;
    [hud hide:YES afterDelay:2.f];
}

// 检测数字是否合法.
- (BOOL)checkIsNumber:(NSString *)text {
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"^[0-9]+(.[0-9]+)?$"
                                                                        options:NSRegularExpressionDotMatchesLineSeparators
                                                                          error:nil];
    return [regular numberOfMatchesInString:text options:0 range:NSMakeRange(0,text.length)];
}

- (void)clickCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma clang diagnostic pop

@end
