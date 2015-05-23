//
//  TDStickerLibraryUpdate.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/4/13.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import "TDStickerLibraryUpdate.h"

#import "TDDownloadManager.h"
#import "TDPreUpdateProcedure.h"
#import "TDStickerLibraryTabInfo.h"
#import "ARCMacros.h"


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryUpdate

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryUpdate ()
{
    //  configure.
    /**
     *  a pointer for the customization object, reference some properties.
     */
    TDStickerLibraryCustomization * customizationParam;
    
    //  for download asynchronous.
    /**
     *  a container for update procedure's response of download.
     */
    NSMutableDictionary           * downloadResponse;
    
    /**
     *  update procedure's counter of download.
     */
    NSInteger                       downloadCounter;
    
    /**
     *  assign a block's pointer for be executed when update procedure is completed
     */
    UpdateCompletionBlock           updateCompletionBlock;
    
}

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare private category (Private)
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryUpdate (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get configure data
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get update child's configure information from parent's configure update responses object for keys.
 *  get update child's configure information from parent's configure update responses object for keys.
 *  the child's configure is tab information on here.
 *
 *  @param preUpdateResponses       responses object of parent's configure update.
 *  @param updateKey                key of data (parent's configure update's responses).
 *
 *  @return object|nil              the Sticker Libaray Tab Info object or nil.
 */
- ( TDStickerLibraryTabInfo * ) _GetConfigureInfo:(NSDictionary *)preUpdateResponses forKey:(NSString *)updateKey;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for update from configure data
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief execute update procedure with responses object.
 *  execute update procedure with responses object of parent's update when find the data of keys.
 *
 *  @param preUpdateResponses       response object of parent's configure update.
 *  @param keyList                  keys of data (parent's configure update's responses).
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _UpdateConfigure:(NSDictionary *)preUpdateResponses forSearch:(NSArray *)keyList;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check and download data with the configure data.
 *  check and download data with the configure data.
 *
 *  @param name                     save filename of configure data.
 *  @param dataLink                 the URL of file at internet.
 *  @param timestamp                the file update condition that was check for integer type.
 *  @param completed                a block section be executed when download completed.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _UpdateProcedure:(NSString *)name from:(NSString *)dataLink updateCheckBy:(NSString *)timestamp completed:(TDDownloadCompletedCallbackBlock)completed;

//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDStickerLibraryUpdate (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------

- ( void ) _InitAttributes
{
    //  configure.
    customizationParam              = nil;
    
    //  for download asynchronous.
    downloadResponse                = nil;
    downloadCounter                 = 0;
    
    updateCompletionBlock           = nil;

}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get configure data
//  ------------------------------------------------------------------------------------------------
- ( TDStickerLibraryTabInfo * ) _GetConfigureInfo:(NSDictionary *)preUpdateResponses forKey:(NSString *)updateKey
{
    NSParameterAssert( nil != preUpdateResponses );
    NSParameterAssert( nil != updateKey );

    NSDictionary                  * response;
    NSString                      * prefix;
    NSArray                       * fileSeparated;
    
    NSString                      * fullPath;
    
    response                        = [preUpdateResponses objectForKey: updateKey];
    if ( nil == response )
    {
        return nil;
    }
    
    //  when this pre-update procedure is finished.
    if ( [[response objectForKey: @"finished"] boolValue] == NO )
    {
        return nil;
    }
    
    fullPath                        = [response objectForKey: @"filename"];
    if ( nil == fullPath )
    {
        return nil;
    }
    
    prefix                          = [fullPath lastPathComponent];
    fileSeparated                   = [prefix componentsSeparatedByString: @"."];
    if ( [fileSeparated count] > 1 )
    {
        prefix                      = [fileSeparated objectAtIndex: 0];
    }
    
    return [TDStickerLibraryTabInfo loadDataFromzip: fullPath inZippedPath: prefix with: @"StickerLibrary"];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for update from configure data
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _UpdateConfigure:(NSDictionary *)preUpdateResponses forSearch:(NSArray *)keyList
{
    NSParameterAssert( nil != preUpdateResponses );
    NSParameterAssert( nil != keyList );
    
    NSString                      * pageName;
    NSString                      * pageConfigure;
    NSString                      * pageLink;
    NSString                      * pageTimestamp;
    
    TDStickerLibraryTabInfo       * configure;
    __block dispatch_group_t        group;
    dispatch_queue_t                queue;
    
    group                           = dispatch_group_create();
    downloadResponse                = [[NSMutableDictionary alloc] initWithCapacity: [keyList count]];
    for ( NSString * updateKey in keyList )
    {
        if ( nil == updateKey )
        {
            continue;
        }
        
        configure                   = [self _GetConfigureInfo: preUpdateResponses forKey: updateKey];
        if ( nil == configure )
        {
            continue;
        }
        
        for ( int i = 0; i < [configure infoDataCount]; ++i )
        {
            if ( [configure isInfoDataEnabledAtIndex: i] == NO )
            {
                continue;
            }
            
            pageName                = [configure configureKeyAtIndex: i];
            pageConfigure           = [configure configureNameAtIndex: i];
            pageLink                = [configure dataLinkAtIndex: i];
            pageTimestamp           = [configure timestampAtIndex: i];
            if ( ( nil == pageName ) || ( nil == pageConfigure ) || ( nil == pageLink ) || ( nil == pageTimestamp ) )
            {
                continue;
            }
            
            queue                   = dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 );
            dispatch_group_async( group, queue, ^()
            {
                [self               _UpdateProcedure: pageConfigure from: pageLink updateCheckBy: pageTimestamp completed: ^(NSError * error, NSString * fullPath, BOOL finished)
                 {
                     NSDictionary         * response;
                     
                     response               = @{ @"error": ( ( nil == error ) ? @"" : error ), @"filename" : ( ( nil == fullPath ) ? @"" : fullPath ) , @"finished" : @(finished) };
                     [downloadResponse      setObject: response forKey: pageName];
                     
                     //  check for all download procedure is callback.
                     if ( [downloadResponse count] != downloadCounter )
                     {
                         return;
                     }
                     
                     if ( nil != updateCompletionBlock )
                     {
                         updateCompletionBlock( downloadResponse, nil, YES );
                     }
                 }];
                
                
                
            });
            downloadCounter++;
        }   //  End of  for ( int i = 0; i < [configure infoDataCount]; ++i ).
    }   //  End of  for ( NSString * updateKey in keylist ).
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _UpdateProcedure:(NSString *)name from:(NSString *)dataLink updateCheckBy:(NSString *)timestamp completed:(TDDownloadCompletedCallbackBlock)completed
{
    NSParameterAssert( nil != name );
    NSParameterAssert( nil != dataLink );
    
    [NSThread                       sleepForTimeInterval: 0.1f];
    [TDDownloadManager              download: name from: dataLink into: [customizationParam systemConfigureUpdateSubpath] of: [customizationParam systemConfigureUpdateDirectory] updateCheckBy: timestamp completed: completed];
    
    return YES;
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public
//  ------------------------------------------------------------------------------------------------
@implementation TDStickerLibraryUpdate

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init
{
    return [self initWithCustomization: nil];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    [self                           stopProcedure];
    if ( nil != customizationParam )
    {
        SAFE_ARC_RELEASE( customizationParam );
        SAFE_ARC_ASSIGN_POINTER_NIL( customizationParam );
    }
    
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithCustomization:(TDStickerLibraryCustomization *)customization
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    [self                           _InitAttributes];
    
    //  when customization is nil, system create a default object.
    if ( nil == customization )
    {
        customization               = [[TDStickerLibraryCustomization alloc] init];
    }
    customizationParam              = customization;
    return self;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) stickerLibraryUpdate
{
    return [[[self class] alloc] initWithCustomization: nil];
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) stickerLibraryUpdateWithCustomization:(TDStickerLibraryCustomization *)customization
{
    return [[[self class] alloc] initWithCustomization: customization];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for start procedure
//  ------------------------------------------------------------------------------------------------
- ( void ) startUpdateSystemConfigure:(NSString *)updateURL forSearch:(NSArray *)keyList
{
    NSParameterAssert( nil != updateURL );
    NSParameterAssert( nil != keyList );
    
    TDPreUpdateProcedure          * procedure;
    
    procedure                       = [TDPreUpdateProcedure preUpdate: updateURL
                                                             withSave: [customizationParam systemConfigureUpdateFilename]
                                                                 into: [customizationParam systemConfigureUpdateSubpath]
                                                                   of: [customizationParam systemConfigureUpdateDirectory]];
    
    NSParameterAssert( nil != procedure );
    
    [procedure                      startProcedureWithKeys: keyList];
    
    __weak __typeof(procedure)      weakProcedure;
    weakProcedure                   = procedure;
    [procedure                      setPreUpdateCompletionBlock: ^(NSDictionary * updateResponses, NSError * error, BOOL finished)
    {
        //NSLog( @" %@, %@, %d ", updateResponses, error, finished );
        if ( NO == finished )
        {
            if ( nil != updateCompletionBlock )
            {
                updateCompletionBlock( updateResponses, error, finished );
            }
            [weakProcedure          stopProcedure];
            return;
        }
        
         //  must process next step to download 'update configure data'.
        [self                       _UpdateConfigure: updateResponses forSearch: keyList];
        
        [weakProcedure              stopProcedure];
    }];
    
    
    return;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for base methos of procedure
//  ------------------------------------------------------------------------------------------------
- ( void ) stopProcedure
{
    if ( nil != downloadResponse )
    {
        [downloadResponse           removeAllObjects];
        SAFE_ARC_RELEASE( downloadResponse );
        downloadResponse            = nil;
    }
    
    if ( nil != updateCompletionBlock )
    {
        SAFE_ARC_RELEASE( preUpdateCompletionBlock );
        updateCompletionBlock       = nil;
    }
    
    downloadCounter                 = 0;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setUpdateCompletionBlock:(UpdateCompletionBlock)completionBlock
{
    if ( nil == completionBlock )
    {
        return;
    }
    updateCompletionBlock           = completionBlock;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for check update file.
//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) checkConfigureFileExist:(NSString *)configure from:(NSString *)dataLink updateCheckBy:(NSString *)timestamp
                              with:(TDStickerLibraryCustomization *)customization extensionResult:(BOOL *)isUpdate;
{
    NSParameterAssert( nil != customization );
    
    NSString                      * fullPath;
    NSString                      * subpath;
    TDGetPathDirectory              directory;
    
    //  first, check update file exist or not.
    fullPath                        = nil;
    subpath                         = nil;
    if ( ( nil != configure ) && ( nil != dataLink ) && ( nil != dataLink ) )
    {
        subpath                     = [customization systemConfigureUpdateSubpath];
        directory                   = [customization systemConfigureUpdateDirectory];
        fullPath                    = TDGetPathForDirectoriesWithTimestamp( directory, [configure stringByDeletingPathExtension], timestamp, [configure pathExtension], subpath, YES );
        if ( nil != fullPath )
        {
            if ( NULL != isUpdate )
            {
                *isUpdate           = YES;
            }
            return YES;
        }
    }
    
    //  system default data, configure must append zip extension.
    NSString                      * extension;
    NSString                      * filename;
    
    extension                       = [configure pathExtension];
    filename                        = [configure stringByDeletingPathExtension];
    if ( [extension isEqualToString: @"zip"] == NO )
    {
        extension                   = @"zip";
        filename                    = configure;
    }
    
    //  second, check file in default.
    subpath                         = [customization systemConfigureDefaultSubpath];
    directory                       = [customization systemConfigureDefaultDirectory];
    fullPath                        = TDGetPathForDirectories( directory, filename, extension, subpath, YES );
    if ( nil == fullPath )
    {
        return NO;
    }
    
    if ( NULL != isUpdate )
    {
        *isUpdate                   = NO;
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------









