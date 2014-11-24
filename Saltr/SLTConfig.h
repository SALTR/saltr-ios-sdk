/*
 * @file SLTConfig.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#ifndef Saltr_Config_h
#define Saltr_Config_h

#define ACTION_GET_APP_DATA @"getAppData"
#define ACTION_ADD_PROPERTIES @"addProperties"
#define ACTION_DEV_SYNC_DATA @"sync"
#define ACTION_DEV_REGISTER_IDENTITY @"registerIdentity"

#define SALTR_API_URL @"https://api.saltr.com/call"
#define SALTR_DEVAPI_URL @"https://devapi.saltr.com/call"

//used to
#define APP_DATA_URL_CACHE @"app_data_cache.json"
#define LOCAL_LEVELPACK_PACKAGE_URL @"saltr/level_packs.json"
#define LOCAL_LEVEL_CONTENT_PACKAGE_URL_TEMPLATE(value1, value2) ([NSString stringWithFormat:@"saltr/pack_%ld/level_%ld.json", value1, value2])
#define LOCAL_LEVEL_CONTENT_CACHE_URL_TEMPLATE(value1, value2) ([NSString stringWithFormat:@"pack_%ld_level_%ld.json", value1, value2])

#define RESULT_SUCCEED @"SUCCEED"
#define RESULT_ERROR @"FAILED"

#define DEVICE_TYPE_IPAD @"ipad"
#define DEVICE_TYPE_IPHONE @"iphone"
#define DEVICE_TYPE_IPOD @"ipod"
#define DEVICE_PLATFORM_IOS @"ios"

#endif
