//
//  NSPropertyListSerialization+TechD.m
//  Foundation+TechD
//
//  Created by Robin Hsu on 2015/4/27.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import "NSPropertyListSerialization+TechD.h"

//  ------------------------------------------------------------------------------------------------
#pragma mark define constant string.
//  ------------------------------------------------------------------------------------------------
static NSString   * const NSPropertyListSerialization_TechD             = @"NSPropertyListSerialization+TechD";
static NSString   * const NSPropertyListSerialization_TechDErrorDomain  = @"com.techd.ns.plist.serialization.error";

//  ------------------------------------------------------------------------------------------------
#pragma mark declare enumeration.
//  ------------------------------------------------------------------------------------------------

typedef NS_ENUM( NSInteger, NSPropertyListSerialization_TechDErrorCode )
{
    /**
     *  maybe unknow how to define the error.
     */
    NSPropertyListSerialization_TechDErrorCodeUndefined                 = -1,
    
    /**
     *  when has error, file not exist.
     */
    NSPropertyListSerialization_TechDErrorCodeFileNotExist              = -2,
    
    /**
     *  when has error, the file name is directory.
     */
    NSPropertyListSerialization_TechDErrorCodeFileIsDir,
    
    /**
     *  when has error, allocate data object.
     */
    NSPropertyListSerialization_TechDErrorCodeAllocDataObject,
    
};

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare private category (_Techd)
//  ------------------------------------------------------------------------------------------------
@interface NSPropertyListSerialization (_Techd)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for error output
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
+ ( NSError * ) _ErrorMessage:(id)relationObject with:(NSPropertyListSerialization_TechDErrorCode)errorCode;

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (_Techd)
//  ------------------------------------------------------------------------------------------------
@implementation NSPropertyListSerialization (_Techd)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for error output
//  ------------------------------------------------------------------------------------------------
+ ( NSError * ) _ErrorMessage:(id)relationObject with:(NSPropertyListSerialization_TechDErrorCode)errorCode
{
    NSString                      * errorMessage;
    NSMutableDictionary           * errorInfos;
    
    errorMessage                    = nil;
    switch ( errorCode )
    {
        case NSPropertyListSerialization_TechDErrorCodeFileNotExist:
        {
            //  is equal NSCocoaErrorDomain Code=260.
            errorMessage            = [NSString stringWithFormat: @"file(%@) is not exist.", relationObject];
            break;
        }
        case NSPropertyListSerialization_TechDErrorCodeFileIsDir:
        {
            errorMessage            = [NSString stringWithFormat: @"file name(%@) is directory.", relationObject];
            break;
        }
        case NSPropertyListSerialization_TechDErrorCodeAllocDataObject:
        {
            errorMessage            = [NSString stringWithFormat: @"cannot allocate data object from strng(%@)", relationObject];
            break;
        }
            
        default:
        {
            errorMessage            = @"error code undefined.";
            break;
        }
    }
    
    errorInfos                      = [@{
                                         NSLocalizedDescriptionKey: NSLocalizedStringFromTable( errorMessage, NSPropertyListSerialization_TechD, nil ),
                                         } mutableCopy];
    
    return [NSError errorWithDomain: NSPropertyListSerialization_TechDErrorDomain code: errorCode userInfo: errorInfos];
}

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation public category (Techd)
//  ------------------------------------------------------------------------------------------------
@implementation NSPropertyListSerialization (TechD)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) savePropertyList:(NSDictionary *)container toFileAtPath:(NSString *)filepath error:(NSError * __autoreleasing *)error
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
    [NSPropertyListSerialization writePropertyList: container toStream: outputStream format: NSPropertyListXMLFormat_v1_0 options: 0 error: &saveError];
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
+ ( NSMutableDictionary * ) loadPropertyList:(NSString *)filepath encoding:(NSStringEncoding)encode error:(NSError * __autoreleasing *)error
{
    NSParameterAssert( nil != filepath );
    
    BOOL                            isDir;
    
    NSError                       * loadError;
    NSFileManager                 * manager;
    NSMutableDictionary           * dataContainer;
    
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
            *error                  = [[self class] _ErrorMessage: filepath with: NSPropertyListSerialization_TechDErrorCodeFileNotExist];
        }
        return nil;
    }
    
    if ( YES == isDir )
    {
        if ( NULL != error )
        {
            *error                  = [[self class] _ErrorMessage: filepath with: NSPropertyListSerialization_TechDErrorCodeFileIsDir];
        }
        return nil;
    }
    
    NSData                        * plistData;
    NSString                      * plistString;
    NSPropertyListFormat            format;
    
    plistString                     = [NSString stringWithContentsOfFile: filepath encoding: encode error: &loadError];
    if ( nil != loadError )
    {
        if ( ( nil != loadError ) && ( NULL != error ) )
        {
            *error                  = loadError;
        }
        return nil;
    }

    plistData                       = [plistString dataUsingEncoding: encode];
    if ( nil == plistData )
    {
        if ( NULL != error )
        {
            *error                  = [[self class] _ErrorMessage: plistString with: NSPropertyListSerialization_TechDErrorCodeAllocDataObject];
        }
        return nil;
    }
    
    loadError                       = nil;
    dataContainer                   = [NSPropertyListSerialization propertyListWithData: plistData options: NSPropertyListMutableContainersAndLeaves
                                                                                 format: &format error: &loadError];
    if ( nil != loadError )
    {
        if ( ( nil != loadError ) && ( NULL != error ) )
        {
            *error                  = loadError;
        }
        return nil;
    }
    return dataContainer;
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

