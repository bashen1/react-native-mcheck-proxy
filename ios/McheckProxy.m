#import "McheckProxy.h"
// #import "ifaddrs.h"
@implementation McheckProxy

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

/**
 VPN检测
 */
RCT_EXPORT_METHOD(detectVPN:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    resolve(@([self isCheckVpn]));
}

/**
 代理IP检测
 */
RCT_EXPORT_METHOD(detectProxy:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    resolve(@([self isCheckProxy]));
}

/**
 VPN检测（同步）
 */
RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(detectVPNSync)
{
    return @([self isCheckVpn]);
}

/**
 代理IP检测（同步）
 */
RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(detectProxySync)
{
    return @([self isCheckProxy]);
}

- (BOOL)isCheckProxy
{
    NSDictionary *proxySettings = CFBridgingRelease(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"http://www.google.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = proxies[0];
    BOOL isConnected = NO;
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
        isConnected = NO;
    }
    else{
        isConnected = YES;
    }
  return isConnected;
}

- (BOOL)isCheckVpn
{
    CFDictionaryRef cfDict = CFNetworkCopySystemProxySettings();
    NSDictionary *nsDict = (__bridge NSDictionary*)cfDict;
    NSDictionary *keys = [nsDict valueForKey:@"__SCOPED__"];
    BOOL isConnected = NO;

    for (id key in keys) {
        if ([@"tap" isEqual: key] || [@"tun" isEqual: key] || [@"ppp" isEqual: key] || [@"ipsec" isEqual: key] || [@"ipsec0" isEqual: key] || [key containsString: @"utun"]) {
            isConnected = YES;
        }
    }
    return isConnected;
}


@end
