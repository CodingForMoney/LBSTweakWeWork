#import "XMLocationSettingViewController.h"


%hook CLLocation
- (CLLocationCoordinate2D)coordinate {
	CLLocationCoordinate2D ret =  %orig;
	NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *jingdu = [userInfo objectForKey:@"XMLocationJindu"];
    if (jingdu) { // 如果存在, 则表示当前有设置.
        NSString *weidu = [userInfo objectForKey:@"XMLocationWeidu"];
        NSString *radius = [userInfo objectForKey:@"XMLocationRadius"];
        CLLocationDegrees longitude = [jingdu doubleValue];
        CLLocationDegrees latitude = [weidu doubleValue];
        if (![radius isEqualToString:@""]) { // 如果半径不为空, 则要计算一个圆内的随机值.
            double ra = [radius doubleValue];
            // 以纬度为标准, 不计算经度与纬度的区别.所以这里不是一个精确的圆.
            double miperweidu = 111000 * cos(latitude * M_PI / 180);
            double randHudu = arc4random() % 36000 / (double)100 *M_PI / 180;
            double randVector = arc4random() % 10000 /(double)10000 * ra / miperweidu;
            double newLo = longitude + sin(randHudu) * randVector;
            double newLa = latitude + cos(randHudu) * randVector;
            if (newLo > 0 && newLo < 180) {
                longitude = newLo;
            }
            if (newLa > 0 && newLa < 80) {
                latitude = newLa;
            }
        }
        ret.longitude = longitude;
        ret.latitude = latitude;
    }
	return ret;
}
%end

%hook WWKMessageListController

- (void)p_rightBarItemClick:(id)sender {

    static NSInteger clickTimes = 0;
    clickTimes ++;
    if(clickTimes > 9) {
        clickTimes = 0;
        UIActionSheet *action =[[UIActionSheet alloc] initWithTitle:@"选择定位地址"
                                                           delegate:(id<UIActionSheetDelegate>)self
                                                  cancelButtonTitle:@"禁用修改"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"定位设置", nil];
        [action showInView:self.view];
    }else {
        %orig;
    }
}


%new
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:{
            // 弹出设置界面 .
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                XMLocationSettingViewController *vc = [[XMLocationSettingViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            });
        }
            break;
        case 1:{
            // 取消定位设置.
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"XMLocationJindu"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
            break;
            break;
        default:
            break;
    }
}

%end