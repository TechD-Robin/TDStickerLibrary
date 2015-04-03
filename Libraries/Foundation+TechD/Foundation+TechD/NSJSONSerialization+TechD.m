//
//  NSJSONSerialization+TechD.m
//  Foundation+TechD
//
//  Created by Robin Hsu on 2015/3/20.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import "NSJSONSerialization+TechD.h"

//  ------------------------------------------------------------------------------------------------
#pragma mark define constant string.
//  ------------------------------------------------------------------------------------------------
static NSString   * const NSJSONSerialization_TechD                 = @"NSJSONSerialization+TechD";
static NSString   * const NSJSONSerialization_TechDErrorDomain      = @"com.techd.ns.json.serialization.error";

//  ------------------------------------------------------------------------------------------------
#pragma mark declare enumeration.
//  ------------------------------------------------------------------------------------------------

typedef NS_ENUM( NSInteger, NSJSONSerialization_TechDErrorCode )
{
    /**
     *  maybe unknow how to define the error.
     */
    NSJSONSerialization_TechDErrorCodeUndefined             = -1,
    
    /**
     *  when has error, file not exist.
     */
    NSJSONSerialization_TechDErrorCodeFileNotExist          = -2,
    
    /**
     *  when has error, the file name is directory.
     */
    NSJSONSerialization_TechDErrorCodeFileIsDir,

};

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark private method for NSJSONSerialization+TechD
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a error object by error code.
 *  create a error object by error code.
 *
 *  @param relationObject           a relation object for error message.
 *  @param errorCode                a error code.
 *
 *  @return object|nil              a error object or nil.
 */
NSError * _Error( id relationObject, NSJSONSerialization_TechDErrorCode errorCode )
{
    NSString                      * errorMessage;
    NSMutableDictionary           * errorInfos;
    
    errorMessage                    = nil;
    switch ( errorCode )
    {
        case NSJSONSerialization_TechDErrorCodeFileNotExist:
        {
            //  is equal NSCocoaErrorDomain Code=260.
            errorMessage            = [NSString stringWithFormat: @"file(%@) is not exist.", relationObject];
            break;
        }
        case NSJSONSerialization_TechDErrorCodeFileIsDir:
        {
            errorMessage            = [NSString stringWithFormat: @"file name(%@) is directory.", relationObject];
            break;
        }
            
        default:
        {
            errorMessage            = @"error code undefined.";
            break;
        }
    }
    
    errorInfos                      = [@{
                                            NSLocalizedDescriptionKey: NSLocalizedStringFromTable( errorMessage, NSJSONSerialization_TechD, nil ),
                                         } mutableCopy];
    
    return [NSError errorWithDomain: NSJSONSerialization_TechDErrorDomain code: errorCode userInfo: errorInfos];
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@implementation NSJSONSerialization (TechD)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) saveJSONContainer:(NSDictionary *)container toFileAtPath:(NSString *)filepath error:(NSError * __autoreleasing *)error
{
    NSParameterAssert( nil != container );
    NSParameterAssert( nil != filepath );
    
    NSError                       * saveError;
    NSFileManager                 * manager;
    NSOutputStream                * outputStream;
    
    saveError                       = nil;
    outputStream                    = nil;
    manager                         = [NSFileManager defaultManager];
    NSParameterAssert( nil != manager );

    //  pre-create subpath on here, because NSJSONSerialization's writeJSONObject: toStream: ..., save the JSON file without create subpath of the file path.
    if ( [manager fileExistsAtPath: [filepath stringByDeletingLastPathComponent]] == NO )
    {
        saveError                   = nil;
        if ( [manager createDirectoryAtPath: [filepath stringByDeletingLastPathComponent] withIntermediateDirectories: YES attributes: nil error: &saveError] == NO )
        {
            if ( nil != error )
            {
                *error              = saveError;
            }
            return NO;
        }
    }
    
    //  first, remove the exist file.
    saveError                       = nil;
    if ( [manager fileExistsAtPath: filepath] == YES )
    {
        if ( [manager removeItemAtPath: filepath error: &saveError] == NO )
        {
            NSLog( @"delete file error : %@", saveError );
        }
    }
    
    //  second, save container to file.
    outputStream                    = [NSOutputStream outputStreamToFileAtPath: filepath append: NO];
    NSParameterAssert( nil != outputStream );
    
    saveError                       = nil;
    [outputStream                   open];
    [NSJSONSerialization            writeJSONObject: container toStream: outputStream options: 0 error: &saveError];
    if ( nil != saveError )
    {
        if ( nil != error )
        {
            *error                  = saveError;
        }
        [outputStream               close];
        return NO;
    }
    
    //  finish.
    [outputStream                   close];
    if ( nil != error )
    {
        *error                      = NULL;
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
+ ( id ) loadJSON:(NSString *)filepath encoding:(NSStringEncoding)encode error:(NSError * __autoreleasing *)error
{
    NSParameterAssert( nil != filepath );
    
    BOOL                            isDir;
    NSString                      * json;
    NSError                       * loadError;
    NSFileManager                 * manager;
    id                              dataContainer;
    
    loadError                       = nil;
    dataContainer                   = nil;
    manager                         = [NSFileManager defaultManager];
    NSParameterAssert( nil != manager );
    
    // when file not exist.
    isDir                           = NO;
    if ( [manager fileExistsAtPath: filepath isDirectory: &isDir] == NO )
    {
        if ( NULL != error )
        {
            *error                  = _Error( filepath, NSJSONSerialization_TechDErrorCodeFileNotExist );
        }
        return nil;
    }
    
    if ( YES == isDir )
    {
        if ( NULL != error )
        {
            *error                  = _Error( filepath, NSJSONSerialization_TechDErrorCodeFileIsDir );
        }
        return nil;
    }
    
    json                            = [NSString stringWithContentsOfFile: filepath encoding: encode error: &loadError];
    if ( nil != loadError )
    {
        if ( ( nil != loadError ) && ( NULL != error ) )
        {
            *error                  = loadError;
        }
        return nil;
    }
    
    loadError                       = nil;
    dataContainer                   = [NSJSONSerialization JSONObjectWithData: [json dataUsingEncoding: encode] options: NSJSONReadingMutableContainers error: &loadError];
    if ( nil != loadError )
    {
        if ( ( nil != loadError ) && ( NULL != error ) )
        {
            *error                  = loadError;
        }
        return nil;
    }
    
    if ( nil != error )
    {
        *error                      = NULL;
    }
    return dataContainer;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

