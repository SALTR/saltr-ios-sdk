
/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#ifndef Saltr_Config_h
#define Saltr_Config_h

#define SALTR_API_URL @"http://api.saltr.com/httpjson.action"
#define SALTR_URL @"http://saltr.com/httpjson.action"
#define COMMAND_APP_DATA @"APPDATA"
#define COMMAND_ADD_PROPERTY @"ADDPROP"
#define COMMAND_SAVE_OR_UPDATE_FEATURE @"SOUFTR"

#define PROPERTY_OPERATIONS_INCREMENT @"inc"
#define PROPERTY_OPERATIONS_SET @"set"


/**
 * @def APP_DATA_URL_CACHE
 * The filename of json file in application data cache
 */
#define APP_DATA_URL_CACHE @"app_data_cache.json"

/**
 * @def APP_DATA_URL_INTERNAL
 * The filename of json file in application internal directory
 */
#define APP_DATA_URL_INTERNAL @"saltr/app_data.json"

/**
 * @def LEVEL_CONTENT_DATA_URL_CACHE_TEMPLATE
 * The filename of level data json file in application cache directory
 */
#define LEVEL_CONTENT_DATA_URL_CACHE_TEMPLATE @"pack_{0}_level_{1}.json"

/**
 * @def LEVEL_PACK_URL_PACKAGE
 * The url of level pack package
 */
#define LEVEL_PACK_URL_PACKAGE @"saltr/level_packs.json"

/**
 * @def LEVEL_CONTENT_DATA_URL_PACKAGE_TEMPLATE
 * The filename of level data json file in application local directory
 */
#define LEVEL_CONTENT_DATA_URL_PACKAGE_TEMPLATE @"saltr/pack_{0}/level_{1}.json"



#define RESULT_SUCCEED @"SUCCEED"
#define RESULT_ERROR @"ERROR"

#endif
