//
//  HiHuViewController.m
//  TestScheme
//
//  Created by zhxf on 14-6-20.
//  Copyright (c) 2014年 hxh. All rights reserved.
//

#import "HiHuViewController.h"
#import "WXBackTestViewController.h"
#import "WXApi.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import "SelectViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "NSString+encode.h"

@interface HiHuViewController ()<WXApiDelegate,CLLocationManagerDelegate,UIImagePickerControllerDelegate>

@end

@implementation HiHuViewController

- (NSDateFormatter *)dateFormatterMMddHHmm {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd HH:mm"];
    return dateFormat;
}

- (void)receivesComeFromWeixin:(NSNotification *)notif
{
    NSLog(@"notif:%@",[notif userInfo]);
    NSDictionary *dict = (NSDictionary *)[notif userInfo];
    NSString *info = [dict objectForKey:@"weixinInfo"];
    NSLog(@"info come from weixin:%@",info);
    WXBackTestViewController *backVC = [[WXBackTestViewController alloc] init];
    [self presentViewController:backVC animated:YES completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesComeFromWeixin:) name:@"shareToWeixinNotif" object:nil];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *schemeBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 60, 110, 30)];
    schemeBtn.backgroundColor = [UIColor blueColor];
    [schemeBtn setTitle:@"震动" forState:UIControlStateNormal];
    [schemeBtn setTitle:@"刷新中" forState:UIControlStateHighlighted];
    [schemeBtn addTarget:self action:@selector(DidSchemAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:schemeBtn];
    
    UIButton *shareToweixin = [[UIButton alloc] initWithFrame:CGRectMake(160, 60, 140, 30)];
    shareToweixin.backgroundColor = [UIColor blueColor];
    [shareToweixin setTitle:@"shareToWeixin" forState:UIControlStateNormal];
    [shareToweixin addTarget:self action:@selector(shareToweixinAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareToweixin];
    
    UITextField *testF = [[UITextField alloc] initWithFrame:CGRectMake(40, 160, 160, 40)];
    testF.backgroundColor = [UIColor grayColor];
    [self.view addSubview:testF];
    
    NSString *str1 = @"hi你好";
    NSString *str1UTF8 = [str1 encodeChinese];
    NSLog(@"str1UTF8:%@",str1UTF8);
    
    NSString *strWithUTF8=(__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str1, NULL,  CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));

    NSLog(@"strWithUtf8:%@",strWithUTF8);
//    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
//    NSLog(@"datemow:%@",datenow);
//    NSLog(@"localeDate:%@",datenow);
//    NSString *nowTimeStr = [[self dateFormatterMMddHHmm] stringFromDate:datenow];
//    NSLog(@"nowTimeStr:%@", nowTimeStr);
    

//    float t = [[NSDate date] timeIntervalSince1970];
////    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
////    NSLog(@"timeSp:%@",timeSp); //时间戳的值
//    NSDate *currentTime = [NSDate dateWithTimeIntervalSince1970:t];
//    NSString *startT = [[self dateFormatterMMddHHmm] stringFromDate:currentTime];
//    NSLog(@"startT:%@",startT);
//
//    int mi = 3^2;
//    NSLog(@"mi:%d",mi);
//    CLLocationManager *locamange = [[CLLocationManager alloc] init];
//    locamange.delegate = self;
//    [locamange setDesiredAccuracy:kCLLocationAccuracyBest];
//    
//    [locamange startUpdatingLocation];
//    NSArray *arr = [NSArray arrayWithObjects:@1,@2,@3,@4,@5,@6, nil];
//    for (NSString *a in arr) {
//        NSLog(@"a:%@",a);
//    }
}

#pragma mark - locatoinDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",[error userInfo]);
}

- (void)DidSchemAction:(id)sender
{
//    NSURL *url = [NSURL URLWithString:@"Joyshow://http://m.taobao.com"];
//    if ([[UIApplication sharedApplication] canOpenURL:url]) {
//        [[UIApplication sharedApplication]openURL:url];
//
//    }else
//    {
//        NSLog(@"不能打开scheme");
//    }
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
//    SelectViewController *selectVC = [[SelectViewController alloc] init];
//    selectVC.index = 1;
//    [self presentViewController:selectVC animated:YES completion:nil];
}

- (void) shareToweixinAction:(id)sender
{
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
//        switch (buttonIndex) {
//            case 0:
//                // 取消
//                return;
//            case 1:
//                // 相机
//                sourceType = UIImagePickerControllerSourceTypeCamera;
//                break;
//                
//            case 2:
//                // 相册
//                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                break;
//        }
//    }
//    else {
//        if (buttonIndex == 0) {
//            
//            return;
//        } else {
//            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//        }
//    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}
//{
//    WXMediaMessage *message = [WXMediaMessage message];
//    message.title = @"中和讯飞--乐现";
//    message.description = @"乐现是由北京中和讯飞开发的一款家居类APP，它可以让你身在千里之外都能随时观看家中情况，店铺情况，看你所看。";
//    [message setThumbImage:[UIImage imageNamed:@"boy@2x.png"]];
//    
//    WXAppExtendObject *extedObj = [WXAppExtendObject object];
//    extedObj.url = @"http://tech.qq.com/zt2012/tmtdecode/252.htm";
////    extedObj.extInfo = @"hello ,I come from Joyshow";
//    Byte* pBuffer = (Byte *)malloc(BUFSIZ);
//    memset(pBuffer, 0, BUFSIZ);
//    NSData* data = [NSData dataWithBytes:pBuffer length:BUFSIZ];
//    free(pBuffer);
//    extedObj.fileData = data;
//    
//    message.mediaObject = extedObj;
//    
//    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.message = message;
////    req.scene = _scene;
//    
//    [WXApi sendReq:req];
//}

//从微信点击回到该APP的时候调用
-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
        //        [alert release];
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        //        [alert release];
        WXBackTestViewController *wxbackVC = [[WXBackTestViewController alloc] init];
        [self presentViewController:wxbackVC animated:YES completion:nil];
        
        
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //        [alert release];
    }
}

//点击回调的时候
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (NSString *)UTF8codeWithChinese:(NSString *)chinesesString
{
    return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)chinesesString, NULL,  CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //振动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    //播放声音
    static SystemSoundID soundIDTest = 0;
    NSString * path = [[NSBundle mainBundle] pathForResource:@"sendmsg" ofType:@"caf"];
    if (path) {
        AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDTest );
    }
    AudioServicesPlaySystemSound( soundIDTest );
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
