//
//  SKeychainUDID.m
//  SKeychainUDID
//
//  Created by duola on 2017/1/6.
//  Copyright © 2017年 sgabg. All rights reserved.
//

#import "SKeychainUDID.h"
#import "SKeychainHelper.h"
@import AdSupport;

#define kIsStringValid(text) (text && text!=NULL && text.length>0)

@implementation SKeychainUDID

+ (void)deleteUDID
{
    [SKeychainHelper delete:UDID_STRING];
}

+ (NSString*)UDID
{
    //0.读取keychain的缓存
    NSString *deviceID = [self getIdfaString];
    if (kIsStringValid(deviceID))
    {
        return deviceID;
    }
    else
    {
        //1.取IDFA,可能会取不到,如用户关闭IDFA
        if ([ASIdentifierManager sharedManager].advertisingTrackingEnabled)
        {
            deviceID = [[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] lowercaseString];
            [self setIdfaString:deviceID];
            return deviceID;
        }
        else
        {
            //2.如果取不到,就生成UUID,当成IDFA
            deviceID = [self getUUID];
            [self setIdfaString:deviceID];
            if (kIsStringValid(deviceID))
            {
                return deviceID;
            }
        }
    }
    return nil;
}

#pragma mark - Keychain
+ (NSString*)getIdfaString
{
    NSString *idfaStr = [SKeychainHelper load:UDID_STRING];
    if (kIsStringValid(idfaStr))
    {
        return idfaStr;
    }
    else
    {
        return nil;
    }
}

+ (BOOL)setIdfaString:(NSString *)secValue
{
    if (kIsStringValid(secValue))
    {
        [SKeychainHelper save:UDID_STRING data:secValue];
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - UUID
+ (NSString*)getUUID
{
    CFUUIDRef uuid_ref = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef uuid_string_ref= CFUUIDCreateString(kCFAllocatorDefault, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    if (!kIsStringValid(uuid))
    {
        uuid = @"";
    }
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}
@end
