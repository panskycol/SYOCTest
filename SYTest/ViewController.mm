//
//  ViewController.m
//  SYTest
//
//  Created by Pan skycol on 2024/2/28.
//

#import "ViewController.h"
#import "Sample.h"
#import "AFNetworking.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "MSAvatarSampleView.h"
#import "LiveAdWebView.h"
#import "SYGestureViewController.h"
#import "SYThread.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "NSObject+WOSwizzle.h"
#import "SYStudentModel.h"
#import "NSDictionary+JZValueString.h"
#import "JZHelpInfoAlertView.h"
#import "JZPopupViewPlaceHolder.h"
#import "NSString+HTML.h"
#import "SYPersonModel.h"
#import <Aspects/Aspects.h>
#import "NSObject+KVO.h"

#import <malloc/malloc.h>
#import <objc/runtime.h>
#import "SYTestView.h"

typedef enum : NSUInteger {
    LoganTypeAction = 1,  //用户行为日志
    LoganTypeNetwork = 2, //网络级日志
} LoganType;

//extern "C" {
//    #import <Logan/Logan.h>
//}

@interface ViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WCTDatabase* database;
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *btn2;

@property (nonatomic, assign) BOOL isHiddenTabbar;

@property (nonatomic, strong) JZPopupScheduler *Scheduler;
@property (nonatomic, assign) NSInteger count;
@end

@implementation ViewController
{
    dispatch_semaphore_t sem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
    
    _database = [[WCTDatabase alloc] initWithPath:@"~/Intermediate/Directories/Will/Be/Created/sample.db"];
    // 以下代码等效于 SQL：CREATE TABLE IF NOT EXISTS sampleTable(identifier INTEGER, description TEXT)
    
    NSData* password = [@"12345" dataUsingEncoding:NSUTF8StringEncoding];

    // 设置加密接口应在其他所有调用之前进行，否则会因无法解密而出错
//    [_database setCipherKey:password];
//    [_database setCipherKey:password andCipherPageSize:4096];
//    [_database enableAutoBackup:YES];
    BOOL ret = [_database createTable:@"sampleTable" withClass:Sample.class];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(100, 100, 100, 50);
    _btn.backgroundColor = [UIColor grayColor];
    [_btn setTitle:@"测试1" forState:UIControlStateNormal];
    [self.view addSubview:_btn];
    [_btn addTarget:self action:@selector(onClick1) forControlEvents:UIControlEventTouchUpInside];
    
    _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn2.frame = CGRectMake(100, 200, 100, 50);
    _btn2.backgroundColor = [UIColor grayColor];
    [_btn2 setTitle:@"测试2" forState:UIControlStateNormal];
    [self.view addSubview:_btn2];
    [_btn2 addTarget:self action:@selector(onClick2) forControlEvents:UIControlEventTouchUpInside];
    
    [_btn2 addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self setState:JZPopupSchedulerStrategyPriority];
    
    YYLabel *contetLb = [[YYLabel alloc] initWithFrame:CGRectMake(0, 400, UI_SCREEN_WIDTH, 100)];
    [self.view addSubview:contetLb];
    
    NSData *keydata = [@"0123456789012345" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *ivdata = [@"0123456789012345" dataUsingEncoding:NSUTF8StringEncoding];
    uint64_t file_max = 10 * 1024 * 1024;
    // logan初始化，传入16位key，16位iv，写入文件最大大小(byte)
//    loganInit(keydata, ivdata, file_max);
    // 将日志输出至控制台
//    loganUseASL(YES);
    
//    [self wo_instanceSwizzleMethod:@selector(sy_Test2) replaceMethod:@selector(sy_Test3)];
//    [self aspect_hookSelector:@selector(sy_Test2) withOptions:AspectOptionAutomaticRemoval usingBlock:^(void){
//        NSLog(@"=====aspect");
//    } error:nil];
    
    SYTestView *testView = [[SYTestView alloc] initWithFrame:CGRectMake(200, 100, 200, 300)];
    testView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:testView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSLog(@"");
}

void printProperties(Class cls) {
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(cls, &propertyCount);
    
    for (unsigned int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        
        // Property name
        const char *name = property_getName(property);
        printf("Property: %s\n", name);
        
        // Property attributes
//        const char *attributes = property_getAttributes(property);
//        printf("Attributes: %s\n", attributes);
        
        // To get more detailed info about attributes, we can parse the attribute string.
        // Here is a basic breakdown of attribute string components
//        unsigned int attributeCount;
//        objc_property_attribute_t *attrs = property_copyAttributeList(property, &attributeCount);
//        
//        for (unsigned int j = 0; j < attributeCount; j++) {
//            printf(" - Attribute name: %s, value: %s\n", attrs[j].name, attrs[j].value);
//        }
        
//        free(attrs);
        printf("\n");
    }
    
    free(properties);
}


- (void)onClick1{
    [SYPersonModel shareInstance].age = 1;
    dispatch_semaphore_signal(sem);
}

- (void)onClick2{
    SYGestureViewController *vc = [[SYGestureViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    SYPersonModel *model = [[SYPersonModel alloc] init];
}

+ (void)onClickA{
    
    NSLog(@"AAAA");
}

+ (void)onClickB{
    
    NSLog(@"BBBBBB");
}

- (void)setState:(JZPopupSchedulerStrategy)pss{
    JZPopupScheduler *Scheduler = [JZPopupScheduler JZPopupSchedulerGetForPSS:pss];
    self.Scheduler = Scheduler;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


- (void)runThread{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self share];
    });
}

- (void)share{
    
    NSLog(@"111111");
}


- (void)sy_Test2{
//    {"c":"clogan header","f":1,"l":1716356048817,"n":"clogan","i":1,"m":true}
    NSLog(@"======22222");
}


- (void)sy_Test3{
    
    NSLog(@"======3333");
}


/**
 用户行为日志

 @param eventType 事件类型
 @param label 描述
 */
- (void)eventLogType:(NSInteger)eventType forLabel:(NSString *)label {
    NSMutableString *s = [NSMutableString string];
    [s appendFormat:@"事件类型%d\t", (int)eventType];
    [s appendFormat:@"点击次数%@\t", label];
//    logan(eventType, s);
//    loganFlush();
}



- (void)startRequest{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    [manager GET:@"http://192.168.1.49:8800/get_time" parameters:@{@"change":@"我是测试参数：",@"text":@"1111"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *jsonStr = [[NSString alloc] initWithData:responseObject
                                                  encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [SYToolManager getDictOrArrByJsonStr:jsonStr];
        NSString *year = dict[@"year"];
        
        NSDictionary *strDict = dict.safeStringsDictionary;
        NSString *year2 = strDict[@"year"];
        SYStudentModel *model = [SYStudentModel modelWithDictionary:dict];
        NSLog(@"网络请求结果：%@",jsonStr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"");
    }];
    
//    [manager GET:@"http://192.168.1.29:8800/get_time" parameters:@{@"change":@"我是测试参数：",@"text":@"1111"} headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSString *jsonStr = [[NSString alloc] initWithData:responseObject
//                                                      encoding:NSUTF8StringEncoding];
//            NSLog(@"网络请求结果：%@",jsonStr);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"");
//        }];
}


- (IBAction)Request:(id)sender {
    
    [self startRequest];
}



- (IBAction)onClick:(UIButton *)sender {
    //插入
    //Prepare data
    Sample* object = [[Sample alloc] init];
    object.identifier = 33333;
    object.content = @"sample_insert00";
    
    NSUInteger hash2 = object.content.hash;
    
    //Insert
    BOOL ret = [_database insertObject:object intoTable:@"sampleTable"];
    [_database backup];
    NSLog(@"");
}


- (IBAction)check:(id)sender {
    
    NSArray<Sample*>* objects = [_database getObjectsOfClass:Sample.class fromTable:@"sampleTable"];
    
    NSArray<Sample*>* objects1 = [_database getObjectsOfClass:Sample.class 
                                                    fromTable:@"sampleTable"
                                                        where:Sample.content == @"sample_insert00" & Sample.identifier > 1];
    
    // 返回 sampleTable 中的所有identifier字段，返回结果中的content属性则都是nil
    NSArray<Sample*>* allObjects = [_database getObjectsOnResultColumns:Sample.identifier fromTable:@"sampleTable"];
    
    NSLog(@"");
}

- (IBAction)Change:(id)sender {
    
    //Prepare data
    Sample* object = [[Sample alloc] init];
    object.content = @"sample_update";
    //Update
    BOOL ret = [_database updateTable:@"sampleTable"
                setProperties:Sample.content
                toObject:object
                where:Sample.identifier > 0];
    
    NSLog(@"");
}


- (IBAction)Delete:(id)sender {
    
    BOOL ret = [_database deleteFromTable:@"sampleTable"];
    
    NSLog(@"");
}

- (IBAction)onClickRecovery:(id)sender {
    
//    //[view startLoading];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        double score = [_database retrieve:^(double percentage, double increment) {
//            // [view updateProgress: percentage];
//            NSLog(@"Reparing progress: %f", percentage);
//        }];
//        NSLog(@"Database repair %@ with score %f", score > 0 ? @"succeeded" : @"failed", score);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //[view stopLoading];
//        });
//    });
    
    SYGestureViewController *vc = [[SYGestureViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)clickTest:(id)sender {
    
    // Create a WKWebView
//        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(10, 100, UI_SCREEN_WIDTH-20, UI_SCREEN_HEIGHT - 200) configuration:configuration];
//        self.webView.navigationDelegate = self;
//        [self.view addSubview:self.webView];
//        
//        // Load a website
        NSString *urlString = @"https://m.pinlian520.com/activity/live_redpacket/index.php?act_id=186&roomid=lcyxr7159154088-MNBYQN&version=5.9.2";
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [self.webView loadRequest:request];
//    IMYWebView *webView = [[IMYWebView alloc] initWithFrame:CGRectMake(10, 100, UI_SCREEN_WIDTH-20, UI_SCREEN_HEIGHT - 200)];
//    webView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:webView];
//    [webView loadRequest:request];
    
    LiveAdWebView *webView = [[LiveAdWebView alloc] initWithFrame:self.view.bounds];
    webView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:webView];
    webView.detailUrlStr = urlString;
    [webView loadWebView];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    // Show loading indicator or perform any other tasks
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // Hide loading indicator or perform any other tasks
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    // Handle error
}

@end
