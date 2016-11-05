#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface MBProgressHUD : UIView

@property (assign) NSInteger mode;

@property (assign) float margin;

@property (copy) NSString *labelText;

//+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated ;

- (void)show:(BOOL)animated ;

- (id)initWithView:(UIView *)view;

@property (assign) BOOL removeFromSuperViewOnHide;

@end

@interface XMLocationSettingViewController : UIViewController

@property (nonatomic,strong) MBProgressHUD *hud;

@property (nonatomic,strong) CLLocationManager *manager;

@end


@interface WWKMessageListController : UIViewController

@property(nonatomic,strong) UIView *view;

@property(nonatomic,readonly,strong) UINavigationController *navigationController;

@end

