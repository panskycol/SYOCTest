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
#import <UserNotifications/UserNotifications.h>

#import <AVFoundation/AVFoundation.h>
#import <AVFAudio/AVFAudio.h>

#import <malloc/malloc.h>
#import <objc/runtime.h>
#import "SYTestView.h"
#import "SharkfoodMuteSwitchDetector.h"
#import <CrashReporter/CrashReporter.h>
#import <FBRetainCycleDetector/FBRetainCycleDetector.h>

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

@property (nonatomic, strong) NSCondition *condition;
@property (nonatomic, strong) NSMutableArray *collector;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) SharkfoodMuteSwitchDetector *muteDetector;

@property (nonatomic, strong) SYGestureViewController *vc;

@end

@implementation ViewController
{
    dispatch_semaphore_t sem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
    
    //全局监控
    [WCTDatabase globalTraceError:^(WCTError *error) {
        assert(error.level != WCTErrorLevelFatal);
        NSLog(@"数据库WCDB错误=%@", error);
    }];
    
    //全局监控
    [WCTDatabase globalTraceSQL:^(WCTTag, NSString * path, uint64_t, NSString * sql) {
        
        NSLog(@"");
    }];
    
    NSString *docDir = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"JZDB"];
    NSString *dbFilePath = [docDir stringByAppendingPathComponent:@"sample.db"];
    
    _database = [[WCTDatabase alloc] initWithPath:dbFilePath];
    // 以下代码等效于 SQL：CREATE TABLE IF NOT EXISTS sampleTable(identifier INTEGER, description TEXT)
    
    NSData* password = [@"12345" dataUsingEncoding:NSUTF8StringEncoding];

    // 设置加密接口应在其他所有调用之前进行，否则会因无法解密而出错
    [_database setCipherKey:password];
    [_database setCipherKey:password andCipherPageSize:4096];
    [_database enableAutoBackup:YES];
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
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:@"http://192.168.1.35:8800/get_time" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        NSLog(@"");
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        NSLog(@"");
//    }];
    
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
    
    
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
//    [session setActive:YES error:nil];
    

//    [WCTDatabase globalTraceSQL:^(WCTTag tag, NSString *path, uint64_t handleId, NSString *sql, NSString *info) {
//        NSLog(@"The handle with id %llu at path %@ executed sql %@", handleId, path, sql);
//    }];
}

- (void)playAudio {
    // 获取音频文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"calll_ring" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];

    // 创建 AVAudioPlayer 实例
    NSError *error = nil;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    self.audioPlayer.numberOfLoops = 1;
    // 检查是否有错误
    if (error) {
        NSLog(@"Error creating audio player: %@", [error localizedDescription]);
    } else {
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
    }
    
}

- (void)addLocalNotice {
    
    @weakify(self);
    self.muteDetector.silentNotify = ^(BOOL silent){
        @strongify(self);
        [self playAudio];
    };
    // 开启静音检测
    [self.muteDetector startCheckMute];
    
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        // 标题
        content.title = @"测试标题";
        content.subtitle = @"测试通知副标题";
        // 内容
        content.body = @"测试通知的具体内容";
        // 添加自定义声音
        content.sound = [UNNotificationSound soundNamed:@"mute.caf"];
        // 角标 （我这里测试的角标无效，暂时没找到原因）
        content.badge = @1;

        NSString *identifier = @"noticeId2";
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:nil];
        
        [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
            if (error) {
                NSLog(@"添加推送失败");
            }else{
                NSLog(@"成功添加推送");
            }
           
        }];
        
//        for (NSInteger i = 1; i < 9; i++) {
//            [self performSelector:@selector(startScheduleNoti) withObject:nil afterDelay:i*6];
//        }
    }
}

- (void)startScheduleNoti{
    [[UNUserNotificationCenter currentNotificationCenter] getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *> * _Nonnull notifications) {
        for (UNNotification *noti in notifications) {
            if ([noti.request.identifier isEqualToString:@"noticeId2"]) {
                [self.muteDetector startCheckMute];
                [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:noti.request withCompletionHandler:nil];
                NSLog(@"重复发");
                break;
            }
        }
    }];
}

- (void)conditionLockTest {
    NSConditionLock *conditionLock = [[NSConditionLock alloc] initWithCondition:2];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
       [conditionLock lockWhenCondition:1];
       NSLog(@"线程1");
       [conditionLock unlockWithCondition:0];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
       [conditionLock lockWhenCondition:2];
       NSLog(@"线程2");
       [conditionLock unlockWithCondition:1];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       [conditionLock lock];
       NSLog(@"线程3");
       [conditionLock unlock];
    });
}

-(void)produce{
    while (self.count < 10) {
        NSLog(@"===准备生产:iPhone");
        [self.condition lock];
        if (self.collector.count > 0 ) {
            NSLog(@"===生产等待，库存：%ld",self.collector.count);
            [self.condition wait];
        }
        [self.collector addObject:@"iPhone"];
        NSLog(@"===生产:iPhone");
        [self.condition signal];
        [self.condition unlock];
        self.count ++;
        NSLog(@"===成功生产");
    }
}

-(void)consumer{
    while (self.count < 10) {
        NSLog(@"===准备买入iPhone");
        [self.condition lock];
        if (self.collector.count == 0 ) {
            NSLog(@"===没有库存");
            [self.condition wait];
        }
        
        NSString *item = [self.collector objectAtIndex:0];
        NSLog(@"===买入:%@",item);
        [self.collector removeObjectAtIndex:0];
        [self.condition signal];
        [self.condition unlock];
        NSLog(@"===成功买入");
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSLog(@"");
}

- (void)onClick1{
   
    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
    [detector addCandidate:_vc];
    NSSet *retainCycles = [detector findRetainCycles];
    NSLog(@"%@", retainCycles);
}

- (void)onClick2{
    SYGestureViewController *vc = [[SYGestureViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    _vc = vc;
}

- (void)tryTest{
    sleep(2);
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

- (SharkfoodMuteSwitchDetector *)muteDetector {
    if (!_muteDetector) {
        _muteDetector = [SharkfoodMuteSwitchDetector shared];
    }
    return _muteDetector;
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
