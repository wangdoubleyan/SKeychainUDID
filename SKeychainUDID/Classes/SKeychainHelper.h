//
//  SKeychainHelper.h
//  SKeychainUDID
//
//  Created by duola on 2017/1/6.
//  Copyright © 2017年 sgabg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKeychainHelper : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;
@end
