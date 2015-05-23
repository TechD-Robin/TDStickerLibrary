//
//  TDPreUpdateProcedure.m
//  TDDownloadManager
//
//  Created by Robin Hsu on 2015/3/25.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import "TDPreUpdateProcedure.h"

#import "TDNetworkReachabilityManager.h"
#import "TDDownloadManager.h"
#import "ARCMacros.h"

//  ------------------------------------------------------------------------------------------------
#pragma mark define constant string.
//  ------------------------------------------------------------------------------------------------
static  NSString  * const TDPreUploadProcedureErrorDomain           = @"com.techd.pre-update.procedure.error";

//  ------------------------------------------------------------------------------------------------
#pragma mark declare enumeration.
//  ------------------------------------------------------------------------------------------------
/**
 *  enumeration for pre-update's procedure error.
 */
typedef NS_ENUM( NSInteger, TDPreUpdateProcedureErrorCode ){
    /**
     *  maybe unknow how to define the error.
     */
    TDPreUpdateProcedureErrorCodeUndefined                  = -1,
    /**
     *  when has error for search key of procedure's configure data.
     */
    TDPreUpdateProcedureErrorCodeSearchKeyError             = -2,
    /**
     *  when device's network status is unreachable.
     */
    TDPreUpdateProcedureErrorCodeNetworkUnreachable,
};


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDPreUpdateProcedure

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDPreUpdateProcedure ()
{
    
    //  for download data.
    /**
     *  configure of update's URL.
     */
    NSString                      * configureUpdateURL;
    
    /**
     *  download configure data, save to this filename. (filename with full path)
     */
    NSString                      * configureFilename;
    
    /**
     *  save file's directory's type.
     */
    TDGetPathDirectory              configureDirectory;
    
    /**
     *  save file's subpath of directory.
     */
    NSString                      * configureSubpath;
    
    /**
     *  the container of pre-update's configure data.
     */
    NSDictionary                  * configureData;
    
    
    //  for download asynchronous.
    /**
     *  a container for pre-update procedure's response of download.
     */
    NSMutableDictionary           * downloadResponse;
    
    /**
     *  pre-update procedure's counter of download.
     */
    NSInteger                       downloadCounter;
    
    /**
     *  assign a block's pointer for be executed when pre-update procedure is completed
     */
    TDPreUpdateCompletionBlock          preUpdateCompletionBlock;
    
    /**
     *  assign a block's pointer for be executed when pre-update procedure is running.
     */
    TDPreUpdateTaskDidWriteDataBlock    didWriteDataBlock;
    
    /**
     *  a progress view for a download task of pre-update procedure.
     */
    UIProgressView                    * preUpdateProgressView;
    
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
@interface TDPreUpdateProcedure (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for configure data's action
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief load configure data from local file(ios device).
 *  load configure data from local file(ios device).
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _LoadConfigureDataFromFile;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check device' network is reachable or not, with the device to the URL's 'domain'.
 *  check device' network is reachable or not, with the device to the URL's 'domain'.
 *
 *  @param reachableBlock           a reachable block section to be executed when check finish.
 */
- ( void ) _CheckNetworkReachable:(ReachableStatusBlock)reachableBlock;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief download configure data from the URL and assign the data into the container.
 *  download configure data from the URL and assign the data into the container.
 *
 *  @param completed                a completed block section to be executed when download finish.
 */
- ( void ) _PreDownloadSystemConfigure:(void(^)(BOOL finished) )completed;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for update from configure data
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief execute update procedure with configure data.
 *  execute update procedure with configure data when find the data of keys.
 *
 *  @param keyList                  a list of keys.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _UpdateProcedure:(NSArray *)keyList;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check and download data with the configure data.
 *  check and download data with the configure data.
 *
 *  @param updateInfo               a configure data for key.
 *  @param completed                a block section be executed when download completed.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _UpdateDataWith:(NSDictionary *)updateInfo completed:(TDDownloadCompletedCallbackBlock)completed;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a NSError object by error code, and execute method of callback block to return the error information.
 *  create a NSError object by error code, and execute method of callback block to return the error information,
 *  when error isn't nil, return the error object, skip create a new error object.
 *
 *  @param errorCode                a error code.
 *  @param error                    a error object from other procedure.
 */
- ( void ) _PreUpdateProcedureErrorCallback:(TDPreUpdateProcedureErrorCode)errorCode error:(NSError *)error;

//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDPreUpdateProcedure (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    configureUpdateURL              = nil;
    configureFilename               = nil;
    
    configureDirectory              = TDTemporaryDirectory;
    configureSubpath                = nil;
    
    configureData                   = nil;
    
    
    //  for download asynchronous.
    downloadResponse                = nil;
    downloadCounter                 = 0;
    
    preUpdateCompletionBlock        = nil;
    didWriteDataBlock               = nil;
    preUpdateProgressView           = nil;

}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for configure data's action
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _LoadConfigureDataFromFile
{
    NSString                      * json;
    NSError                       * error;
    
    error                           = nil;
    json                            = [NSString stringWithContentsOfFile: configureFilename encoding: NSUTF8StringEncoding error: &error];
    if ( nil != error )
    {
        [self                       _PreUpdateProcedureErrorCallback: 0 error: error];
        return NO;
    }
    
    error                           = nil;
    configureData                   = [NSJSONSerialization JSONObjectWithData: [json dataUsingEncoding: NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
    if ( nil != error )
    {
        [self                       _PreUpdateProcedureErrorCallback: 0 error: error];
        return NO;
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _CheckNetworkReachable:(ReachableStatusBlock)reachableBlock;
{
    ReachableStatusBlock            networkReachableBlock;
    ReachableStatusBlock            domainReachableBlock;

    
    //  third, return network reachable status.
    domainReachableBlock            = ^(BOOL isReachable)
    {
        if ( nil != reachableBlock )
        {
            reachableBlock( isReachable );
        }
    };
    
    //  second, check reachability from this device to URL.
    networkReachableBlock           = ^(BOOL isReachable)
    {
        if ( NO == isReachable )
        {
            if ( nil != reachableBlock )
            {
                reachableBlock( isReachable );
            }
            return;
        }
        
        NSURL                     * url;
        
        url                         = [NSURL URLWithString: configureUpdateURL];
        if ( nil == url )
        {
            return;
        }
        
        [TDNetworkReachabilityManager checkReachabilityStatusForDomain: [url host] result: domainReachableBlock];
    };
    
    //  first, check network reachability.
    [TDNetworkReachabilityManager  checkNetworkReachabilityStatus: networkReachableBlock];
    
    return;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _PreDownloadSystemConfigure:(void(^)(BOOL finished) )completed
{
    TDReadJSONCompletedCallbackBlock    readJSONCallbackBlock;
    
    //  get JSON data from container.
    readJSONCallbackBlock           = ^(NSDictionary * jsonContent, NSError * error, BOOL finished)
    {
        if ( NO == finished )
        {
            //  load confiure from local file.
            //[self                   _LoadConfigureDataFromFile];
            if ( nil != completed )
            {
                completed( finished );
            }
            [self                   _PreUpdateProcedureErrorCallback: 0 error: error];
            return;
        }
        
        //  get data from jsonContent.
        configureData               = jsonContent;
        if ( nil != completed )
        {
            completed( finished );
        }
    };
    
    [self                           _CheckNetworkReachable: ^(BOOL isReachable)
    {
        if ( NO == isReachable )
        {
            if ( nil != completed )
            {
                completed( isReachable );
            }
            [self                   _PreUpdateProcedureErrorCallback: TDPreUpdateProcedureErrorCodeNetworkUnreachable error: nil];
            return;
        }
        
        //  get json data from url.
        [TDDownloadManager          readJSONFile: configureUpdateURL withSaveInto: configureFilename completed: readJSONCallbackBlock];
    }];
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for update from configure data
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _UpdateProcedure:(NSArray *)keyList
{
    NSParameterAssert( nil != keyList );
    
    if ( [keyList count] == 0 )
    {
        [self                       _PreUpdateProcedureErrorCallback: TDPreUpdateProcedureErrorCodeSearchKeyError error: nil];
        return NO;
    }

    
    NSString                      * aKey;
    NSDictionary                  * infoData;
    
    __block dispatch_group_t        group;
    dispatch_queue_t                queue;
    
    group                           = dispatch_group_create();
    downloadResponse                = [[NSMutableDictionary alloc] initWithCapacity: [keyList count]];
    for ( int i = 0; i < [keyList count]; ++i )
    {
        aKey                        = [keyList objectAtIndex: i];
        if ( nil == aKey )
        {
            continue;
        }
        
        infoData                    = [configureData objectForKey: aKey];
        if ( nil == infoData )
        {
            continue;
        }
        
        if ( [infoData objectForKey: @"DataLink"] == nil )
        {
            continue;
        }
        
        queue                       = dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 );
        dispatch_group_async( group, queue, ^()
        {
            [self                   _UpdateDataWith: infoData completed: ^(NSError * error, NSString * fullPath, BOOL finished)
            {
                NSDictionary      * response;
                
                response            = @{ @"update infos": infoData, @"error": ( ( nil == error ) ? @"" : error ), @"filename" : ( ( nil == fullPath ) ? @"" : fullPath ) , @"finished" : @(finished) };
                //  forward code is like : setObject: forKey: when type is NSMutableDictionary.
                [downloadResponse   setObject: response forKey: aKey];
                
                //  check for all download procedure is callback.
                if ( [downloadResponse count] != downloadCounter )
                {
                    return;
                }
                
                if ( nil != preUpdateCompletionBlock )
                {
                    preUpdateCompletionBlock( downloadResponse, nil, YES );
                }
                
            }];
        });
        downloadCounter++;
        
    }   //  End of  for ( int i = 0; i < [keyList count]; ++i ).
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _UpdateDataWith:(NSDictionary *)updateInfo completed:(TDDownloadCompletedCallbackBlock)completed
{
    if ( ( nil == updateInfo ) || ( [updateInfo count] == 0 ) )
    {
        return NO;
    }
    
    NSString                      * name;
    NSString                      * timestamp;
    NSString                      * dataLink;
    TDDownloadManager             * downloadManager;
    
    name                            = [updateInfo objectForKey: @"Name"];
    timestamp                       = [updateInfo objectForKey: @"Timestamp"];
    dataLink                        = [updateInfo objectForKey: @"DataLink"];
    if ( ( nil == name ) || ( nil == dataLink ) )
    {
        return NO;
    }
    
    [NSThread                       sleepForTimeInterval: 0.1f];
    downloadManager                 = [TDDownloadManager download: name from: dataLink into: configureSubpath of: configureDirectory
                                                    updateCheckBy: timestamp completed: completed];

    //  just want to get bytes information of downloading.
    if ( nil == downloadManager )
    {
        return YES;
    }
    [downloadManager                setDownloadTaskDidWriteDataBlock:
     ^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite)
    {
        if ( nil != didWriteDataBlock )
        {
            didWriteDataBlock( name, timestamp, bytesWritten, totalBytesWritten, totalBytesExpectedToWrite );
        }
    }];
    
    [downloadManager                setDownloadTaskProgressView: preUpdateProgressView];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _PreUpdateProcedureErrorCallback:(TDPreUpdateProcedureErrorCode)errorCode error:(NSError *)error
{
    if ( nil == preUpdateCompletionBlock )
    {
        return;
    }
    
    if ( nil != error )
    {
        preUpdateCompletionBlock( nil, error, NO );
        return;
    }
    
    NSError                       * updateError;
    NSString                      * errorMessage;
    NSMutableDictionary           * errorInfos;
    
    updateError                     = nil;
    errorMessage                    = nil;
    switch ( errorCode )
    {
        case TDPreUpdateProcedureErrorCodeSearchKeyError:
        {
            errorMessage            = @"cannot find any search key in container of condition.";
            break;
        }
        case TDPreUpdateProcedureErrorCodeNetworkUnreachable:
        {
            errorMessage            = @"network status is unreachabe.";
            break;
        }
            
        default:
            return;
    }
    
    
    errorInfos                      = [@{
                                            NSLocalizedDescriptionKey: NSLocalizedStringFromTable( errorMessage, @"TDPreUpdateProcedure", nil ),
                                        } mutableCopy];
    
    updateError                     = [NSError errorWithDomain: TDPreUploadProcedureErrorDomain code: errorCode userInfo: errorInfos];
    preUpdateCompletionBlock( nil, updateError, NO );
    
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
@implementation TDPreUpdateProcedure


//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.
//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != configureData )
    {
        SAFE_ARC_RELEASE( configureData );
        configureData               = nil;
    }
    
    if ( nil != downloadResponse )
    {
        [downloadResponse           removeAllObjects];
        SAFE_ARC_RELEASE( downloadResponse );
        downloadResponse            = nil;
    }
    
    if ( nil != preUpdateCompletionBlock )
    {
        SAFE_ARC_RELEASE( preUpdateCompletionBlock );
        SAFE_ARC_ASSIGN_POINTER_NIL( preUpdateCompletionBlock );
    }
    
    if ( nil != didWriteDataBlock )
    {
        SAFE_ARC_RELEASE( didWriteDataBlock );
        didWriteDataBlock           = nil;
    }
        
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
- (instancetype ) initWithURL:(NSString *)configureURL
                     withSave:(NSString *)filename into:(NSString *)subpath of:(TDGetPathDirectory)directory
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    
    configureUpdateURL              = configureURL;
    configureSubpath                = subpath;
    configureDirectory              = directory;
    
    configureFilename               = TDGetPathForDirectories( directory, [filename stringByDeletingPathExtension], [filename pathExtension], subpath, NO );
    return self;
}


//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) preUpdate:(NSString *)configureURL
                    withSave:(NSString *)filename into:(NSString *)subpath of:(TDGetPathDirectory)directory
{
    return [[[self class] alloc] initWithURL: configureURL withSave: filename into: subpath of: directory];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for start procedure
//  ------------------------------------------------------------------------------------------------
- ( void ) startProcedure
{
    [self                           _PreDownloadSystemConfigure: ^(BOOL finished)
    {
        if ( NO == finished )
        {
            return;
        }
        
        NSArray                   * allKeys;
        
        allKeys                     = [configureData allKeys];
        [self                       _UpdateProcedure: allKeys];
        
    }];
    return;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) startProcedureWithKey:(NSString *)aKey
{
    if ( ( nil == aKey ) || ( [aKey length] == 0 ) )
    {
        return;
    }
    
    [self                           _PreDownloadSystemConfigure: ^(BOOL finished)
    {
        if ( NO == finished )
        {
            return;
        }
        
        NSArray                   * keyList;
        
        keyList                     = [NSArray arrayWithObject: aKey];
        [self                       _UpdateProcedure: keyList];
    }];
    return;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) startProcedureWithKeys:(NSArray *)keyList
{
    [self                           _PreDownloadSystemConfigure: ^(BOOL finished)
    {
        if ( NO == finished )
        {
            return;
        }
        
        [self                       _UpdateProcedure: keyList];
    }];
    
    return;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for base methods of procedure
//  ------------------------------------------------------------------------------------------------
- ( void ) stopProcedure
{
    if ( nil != downloadResponse )
    {
        [downloadResponse           removeAllObjects];
        SAFE_ARC_RELEASE( downloadResponse );
        downloadResponse            = nil;
    }
    
    if ( nil != preUpdateCompletionBlock )
    {
        SAFE_ARC_RELEASE( preUpdateCompletionBlock );
        preUpdateCompletionBlock    = nil;
    }
    
    if ( nil != didWriteDataBlock )
    {
        SAFE_ARC_RELEASE( didWriteDataBlock );
        didWriteDataBlock           = nil;
    }
    
    downloadCounter                 = 0;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setPreUpdateCompletionBlock:(TDPreUpdateCompletionBlock)completionBlock
{
    if ( nil == completionBlock )
    {
        return;
    }
    preUpdateCompletionBlock        = completionBlock;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setPreUpdateDidWriteDataBlock:(TDPreUpdateTaskDidWriteDataBlock)dataBlock
{
    if ( nil == dataBlock )
    {
        return;
    }
    didWriteDataBlock               = dataBlock;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setPreUpdateProgressView:(UIProgressView *)progressView
{
    if ( nil == progressView )
    {
        return;
    }
    preUpdateProgressView           = progressView;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------









