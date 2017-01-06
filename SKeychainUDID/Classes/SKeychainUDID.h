//
//  SKeychainUDID.h
//  SKeychainUDID
//
//  Created by duola on 2017/1/6.
//  Copyright © 2017年 sgabg. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UDID_STRING @"com.sgabg.S.Udid"

@interface SKeychainUDID : NSObject

/**
 获取UDID

 @return <#return value description#>
 */
+ (NSString*)UDID;


/**
 删除UDID
 */
+ (void)deleteUDID;

@end
