//
//  TDPreUpdateJSONInfo.h
//  TDDownloadManager
//
//  Created by Robin Hsu on 2015/4/10.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import "TDJSONReader.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  load a data from JSON file, and assign the data into this object.
 *  the data is update of system configure.
 */
@interface TDPreUpdateJSONInfo : TDJSONReader

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get information data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the configure's name for key.
 *  get the configure's name for key.
 *
 *  @param aKey                     a key of configure data.
 *
 *  @return name|nil                the name or nil.
 */
- ( NSString * ) nameForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the configure's timestamp for key.
 *  get the configure's timestamp for key.
 *
 *  @param aKey                     a key of configure data.
 *
 *  @return timestamp|nil           the timestamp or nil.
 */
- ( NSString * ) timestampForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the configure's data link(internet URL) for key.
 *  get the configure's data link(internet URL) for key.
 *
 *  @param aKey                     a key of configure data.
 *
 *  @return data link|nil           the data link or nil.
 */
- ( NSString * ) dataLinkForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get extension information data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the configure's name with timestamp for key.
 *  get the configure's name with timestamp for key
 *
 *  @param aKey                     a key of configure data.
 *
 *  @return filename|nil            the filename or nil.
 */
- ( NSString * ) updateConfigureFilenameForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the the configure's full path name for key.
 *  get the the configure's full path name for key.
 *
 *  @param aKey                     a key of configure data.
 *  @param directory                enumeration for directory.
 *  @param subpath                  file's sub directory name of configure
 *
 *  @return full path|nil           the full path or nil.
 */
- ( NSString * ) updateConfigureFullPathForKey:(NSString *)aKey forDirectories:(TDGetPathDirectory)directory inDirectory:(NSString *)subpath;

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
