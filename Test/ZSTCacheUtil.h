//
//  TTCacheUtil.h
//  EBCCard
//
//  Created by guligei on 2/17/13.
//  Copyright (c) 2013 totemtec.com. All rights reserved.
//

#import <Foundation/Foundation.h>


#define CACHE_LOGIN_INFO            @"cache_login_info.plist"
#define CACHE_MESSAGES_INFO         @"cache_messages_info.plist"
#define CACHE_DISCLOSE_LIST         @"discloseList"

@interface ZSTCacheUtil: NSObject

+ (NSString*)documentDirectory;

//把数据写成文件缓存起来，根据文件后缀判断数据存储格式，支持.json和.plist
//支持的数据类型包含NSDictionary和NSArray，其中包含自定义对象的话，必须实现<NSCoding>协议，并且只支持plist格式
+ (BOOL)writeObject:(id)object toFile:(NSString*)fileName;

//返回NSDictionary和NSArray对象
+ (id)objectFromFile:(NSString*)fileName;

+ (BOOL)removeObjectForName:(NSString*)aName;


+ (BOOL)cacheObject:(id)object toFile:(NSString*)fileName;
+ (id)objectsFromFile:(NSString *)fileName;
+ (id)objectsFromUserFile:(NSString *)fileName;


@end
