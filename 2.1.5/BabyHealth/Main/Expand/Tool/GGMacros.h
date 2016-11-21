// -------------------- Common Function --------------------------
#pragma mark - Common Function
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBF(r, g, b) [UIColor colorWithRed:r green:g blue:b alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//rgb converter（hex->dec）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define FONT(x) [UIFont systemFontOfSize:x]

//AppDelegate
#define GGappDelegate ((AppDelegate*)[UIApplication sharedApplication].delegate)

//NSString
#define STRING_OR_EMPTY(A)  ({ __typeof__(A) __a = (A); __a ? __a : @""; })

//NSLocalizedString
#define LS(string) NSLocalizedString(string,nil)

//NSUserDefault
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//[NSFileManager defaultManager]
#define FileManager [NSFileManager defaultManager]

//ReachNetWork
#define isInWifi [[Reachability reachabilityForInternetConnection] isReachableViaWiFi]
#define isOnline [[Reachability reachabilityForInternetConnection] isReachable]

//documents structure of application
#define APP_DOCUMENT                [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define APP_LIBRARY                 [NSSearchPathForDirectoriesInDomains (NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define APP_CACHES_PATH             [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]


#pragma mark - Device Information

#define is4Inches ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isRetina [UIScreen mainScreen].scale > 1
#define DeviceIsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)
#define NavigationBar_HEIGHT 44

#pragma mark - System Information

#define CurrentAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define isIOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")


//UI heights
#define STATUSBAR_HEIGHT 20.0
#define NAVBAR_HEIGHT 44.0
#define STATUS_NAV_HEIGHT 64.0


// -------------------- Debug Function --------------------------
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [File %s: Line %d] " fmt), __PRETTY_FUNCTION__, __FILE__, __LINE__, ##__VA_ARGS__)
#   define DLogRect(rect)  DLog(@"%@", NSStringFromCGRect(rect))
#   define DLogPoint(pt) DLog(@"%@", NSStringFromCGPoint(pt))
#   define DLogSize(size) DLog(@"%@", NSStringFromCGSize(size))
#   define DLogColor(_COLOR) DLog(@"%s h=%f, s=%f, v=%f", #_COLOR, _COLOR.hue, _COLOR.saturation, _COLOR.value)
#   define DLogSuperViews(_VIEW) { for (UIView* view = _VIEW; view; view = view.superview) { GBLog(@"%@", view); } }
#   define DLogSubViews(_VIEW) \
{ for (UIView* view in [_VIEW subviews]) { GBLog(@"%@", view); } }
#   else
#   define DLog(...)
#   define DLogRect(rect)
#   define DLogPoint(pt)
#   define DLogSize(size)
#   define DLogColor(_COLOR)
#   define DLogSuperViews(_VIEW)
#   define DLogSubViews(_VIEW)
#   endif


//weakself
#define WEAKSELF __weak __typeof(&*self)weakSelf = self;

//Block
typedef void(^voidBlock)();
typedef void(^stringBlock)(NSString *result);
typedef void(^boolBlock)(BOOL boolen);
typedef void(^errorBlock)(NSError *error);
typedef void(^numberBlock)(NSNumber *result);
typedef void(^arrayWithErrorBlock)(NSArray *results,NSError *error);
typedef void(^arrayBlock)(NSArray *results);

// 加载本名的Nib文件
#define SELF_NIB ([[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject])

// 当前视图控制器的视图的size
#define VIEW_SIZE (self.view.frame.size)

// 屏幕宽度和高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

// 自动适配宽度,width为原始iPhone4/5的宽度
#define AUTO_MATE_WIDTH(width) ((width) * SCREEN_WIDTH / 320.0)
#define AUTO_MATE_HEIGHT(height) ((height) * SCREEN_HEIGHT / 480.0)

// 判断是否iPhone4-5/iPhone6/plus
//#define IS_IPHONE4_5 (SCREEN_WIDTH==320)
//#define IS_IPHONE6 (SCREEN_WIDTH==375)
//#define IS_IPHONE6_PLUS (SCREEN_WIDTH==414)

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

// 获取目标视图的下面的间距
#define ON_VIEW_BOTTOM(targetView, margin) (targetView.frame.size.height + targetView.frame.origin.y + margin)

// 左视图表格的边框颜色
#define LEFT_VC_TABLE_BORDER_CGCOLOR (RGB(85, 85, 85).CGColor)

// 主调黄色
#define MAIN_YELLOW_COLOR (RGB(247, 176, 42))

// 载入Nib文件时候用到
#define NIB_NAMED(class) ([UINib nibWithNibName:NSStringFromClass(class) bundle:nil])

// 根视图高FrameScrollView的子类
#define ROOT_VIEW_FRMAE CGRectMake(0, 0, VIEW_SIZE.width, VIEW_SIZE.height-10)
#define ROOT_VIEW_FRAME2 (CGRectMake(0, 0, self.view.width, self.view.height - 49)) // 用于不自动调整的时候

// 价钱的Text
#define PRICE_TEXT(price, unit) [NSString stringWithFormat:@"￥%.2f %@",price,unit]

#define PRICE_STR(price) ([NSString stringWithFormat:@"￥%.2f",price])

// 自定义字体
#define MyFont(theSize) ([UIFont fontWithName:@"FZCuYuan-M03S" size:theSize])

// 获取状态栏的高度
#define STATUS_BAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)

#define JSON_TO_DICT(data)  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]

#define WAIT_LOADING_IMAGE ([UIImage imageNamed:@"coming_soon"])