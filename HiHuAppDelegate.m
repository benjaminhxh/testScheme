//
//  HiHuAppDelegate.m
//  TestScheme
//
//  Created by zhxf on 14-6-20.
//  Copyright (c) 2014年 hxh. All rights reserved.
//

#import "HiHuAppDelegate.h"
//#import "WXBackTestViewController.h"

@implementation HiHuAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    long long x = 0x8c4e07092500;
    long long y = func(x);
//    NSLog(@"十进制：%lld",y);   // 用十进制输出y;
    
//    unsigned long long int aa = strtoull(0x8c, char *a, 32)
    NSString *macAddr = @"1002509074e8c";
    //字符串转char*
    int isLow;
    NSString *deviceID;
    if (13 == macAddr.length) {
        isLow = 1;
       deviceID = [macAddr substringFromIndex:1];
    }else
    {
        isLow = 0;
        deviceID = macAddr;
    }
    NSLog(@"deviceID:%@",deviceID);
    const char* a = [deviceID cStringUsingEncoding:NSASCIIStringEncoding];
    int64_t addr = MacAddr2DecDeviceID(a, isLow);//
   int flag = (addr >> 48);
    NSLog(@"flag:%d",flag);
    NSLog(@"%lld",addr);
    
    [WXApi registerApp:@"wx70162e2c344d4c79"];
    return YES;
}

 int64_t MacAddr2DecDeviceID(const char* pMacAddr, int iDeviceType)
{
	if (NULL == pMacAddr)
		return 0;
    
	int i = 0;
	int iMacAddrDecValue[12];
	int iSegDecValue[6];
	int iValidInputFlag = 1;
	int64_t i64RetValue = 0;
	
	for (i = 0; i < 12; i++)
	{
		if (pMacAddr[i] >= 0x30 && pMacAddr[i] <= 0x39)
			iMacAddrDecValue[i] = pMacAddr[i] - 0x30;
		else if (pMacAddr[i] >= 0x41 && pMacAddr[i] <= 0x46)
			iMacAddrDecValue[i] = 10 + pMacAddr[i] - 0x41;
		else if (pMacAddr[i] >= 0x61 && pMacAddr[i] <= 0x66)
			iMacAddrDecValue[i] = 10 + pMacAddr[i] - 0x61;
		else
		{
			iValidInputFlag = 0;
			break;
		}
	}
	if (0 == iValidInputFlag)
		return 0;
    
	for (i = 0; i < 6; i++)
	{
		iSegDecValue[i] = (iMacAddrDecValue[2*i]<<4) + iMacAddrDecValue[2*i+1];
	}
    
	if (iDeviceType)
		i64RetValue += 1;
    
	for (i = 5; i >= 0; i--)
	{
		i64RetValue = (i64RetValue<<8);
		i64RetValue	+= iSegDecValue[i];
	}
    
	return i64RetValue;
}


//普通字符串转换为十六进制的。
- (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr]; 
    } 
    return hexStr; 
}

long long func(long long x)
{
    long long sum = 0;
    for(int i = 0 ; x!= 0; i++)
    {
        sum = (x %16) * pow(16,i)+ sum;
        x = x/ 16;
    }
    return sum;
}

unsigned long long int strtoull(const char *ptr, char **end, int base)
{
    unsigned long long ret = 0;
    
    if (base > 36)
        goto out;
    
    while (*ptr) {
        int digit;
        
        if (*ptr >= '0' && *ptr <= '9' && *ptr < '0' + base)
            digit = *ptr - '0';
        else if (*ptr >= 'A' && *ptr < 'A' + base - 10)
            digit = *ptr - 'A' + 10;
        else if (*ptr >= 'a' && *ptr < 'a' + base - 10)
            digit = *ptr - 'a' + 10;
        else
            break;
        
        ret *= base;
        ret += digit;
        ptr++;
    }
    
    out:
    if (end)
        *end = (char *)ptr;
    
    return ret;  
}

//点击回到应用的时候回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

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
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n URL:%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.url, obj.extInfo, msg.thumbData.length];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
//        [alert release];
//        WXBackTestViewController *wxbackVC = [[WXBackTestViewController alloc] init];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:wxbackVC];
//        self.window.rootViewController = nav;
//        [self.window makeKeyAndVisible];
        NSDictionary *weixinInfo = [NSDictionary dictionaryWithObjectsAndKeys:obj.url,@"weixinInfo", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shareToWeixinNotif" object:self userInfo:weixinInfo];

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

//点击回调的时候(取消分享)
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d,%@", resp.errCode,resp.errStr];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
//        [alert release];
    }
}
@end
