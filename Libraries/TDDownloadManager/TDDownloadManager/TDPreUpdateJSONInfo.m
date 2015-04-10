//
//  TDPreUpdateJSONInfo.m
//  TDDownloadManager
//
//  Created by Robin Hsu on 2015/4/10.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import "TDPreUpdateJSONInfo.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
static  NSString  * const kTDPreUpdateJSONInfoKeyName               = @"Name";
static  NSString  * const kTDPreUpdateJSONInfoKeyTimestamp          = @"Timestamp";
static  NSString  * const kTDPreUpdateJSONInfoKeyDataLink           = @"DataLink";

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDPreUpdateJSONInfo


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public
//  ------------------------------------------------------------------------------------------------
@implementation TDPreUpdateJSONInfo


//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method for get information data.
//  ------------------------------------------------------------------------------------------------
- ( NSString * ) nameForKey:(NSString *)aKey
{
    NSParameterAssert( nil != aKey );
    
    NSString                      * keyPath;
    
    keyPath                         = [aKey stringByAppendingPathComponent: kTDPreUpdateJSONInfoKeyName];
    NSParameterAssert( nil != keyPath );
    
    return [self stringValueForKeyPath: keyPath];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) timestampForKey:(NSString *)aKey
{
    NSParameterAssert( nil != aKey );
    
    NSString                      * keyPath;
    
    keyPath                         = [aKey stringByAppendingPathComponent: kTDPreUpdateJSONInfoKeyTimestamp];
    NSParameterAssert( nil != keyPath );
    
    return [self stringValueForKeyPath: keyPath];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) dataLinkForKey:(NSString *)aKey
{
    NSParameterAssert( nil != aKey );
    
    NSString                      * keyPath;
    
    keyPath                         = [aKey stringByAppendingPathComponent: kTDPreUpdateJSONInfoKeyDataLink];
    NSParameterAssert( nil != keyPath );
    
    return [self stringValueForKeyPath: keyPath];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get extension information data.
//  ------------------------------------------------------------------------------------------------
- ( NSString * ) updateConfigureFilenameForKey:(NSString *)aKey
{
    NSParameterAssert( nil != aKey );
    
    return [[self nameForKey: aKey] stringByAppendingPathExtension: [self timestampForKey: aKey]];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) updateConfigureFullPathForKey:(NSString *)aKey forDirectories:(TDGetPathDirectory)directory inDirectory:(NSString *)subpath
{
    NSParameterAssert( nil != aKey );
    
    NSString                      * name;
    NSString                      * timestamp;
    
    name                            = [self nameForKey: aKey];
    timestamp                       = [self timestampForKey: aKey];
    
    NSParameterAssert( nil != name );
    return  TDGetPathForDirectoriesWithTimestamp( directory, [name stringByDeletingPathExtension], timestamp, [name pathExtension], subpath, NO );
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
















