//
//  TDDownloadManager.m
//  TDDownloadManager
//
//  Created by Robin Hsu on 2015/3/4.
//  Copyright (c) 2015年 TechD. All rights reserved.
//

#import "TDDownloadManager.h"

#import "AFNetworking.h"
#import "UIProgressView+AFNetworking.h"
#import "Foundation+TechD.h"

//  ------------------------------------------------------------------------------------------------
#pragma mark define constant string.
//  ------------------------------------------------------------------------------------------------
static  NSString  * const TDDownloadManagerErrorDomain              = @"com.techd.manager.download.error";
//static  NSString  * const TDDownloadManagerUpdateErrorKey           = @"com.techd.manager.download.update.error";

//  ------------------------------------------------------------------------------------------------
#pragma mark declare enumeration.
//  ------------------------------------------------------------------------------------------------
/**
 *  enumeration for download manager's procedure error.
 */
typedef NS_ENUM( NSInteger, TDDownloadManagerErrorCode ){
    /**
     *  maybe unknow how to define the error.
     */
    TDDownloadManagerErrorCodeUndefined                     = -1,
    /**
     *  when procedure has error for parameters of file
     */
    TDDownloadManagerErrorCodeFilenameParamError            = -2,
    /**
     *  when procedure has error path data.
     */
    TDDownloadManagerErrorCodePathError,
};

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method for get path.
//  ------------------------------------------------------------------------------------------------
NSString * TDGetCurrentFilePathWithUpdate( NSString * filename, NSString * subpath, TDGetPathDirectory directory, NSString * updateFilename, NSString * updateSubpath, TDGetPathDirectory updateDirectory, NSString * updateTimestamp )
{
    NSString                      * currentFilename;
    
    currentFilename                 = nil;
    //  first, search update file.
    if ( nil != updateFilename )
    {
        currentFilename             = TDGetPathForDirectoriesWithTimestamp( updateDirectory, [updateFilename stringByDeletingPathExtension], updateTimestamp, [updateFilename pathExtension], updateSubpath, NO );
        if ( nil != currentFilename )
        {
            BOOL                    isDir;
            
            isDir                   = YES;
            if ( [[NSFileManager defaultManager] fileExistsAtPath: currentFilename isDirectory: &isDir] == YES )
            {
                if ( NO == isDir )
                {
                    return currentFilename;
                }
            }
        }
    }
    
    //  second, search original file.
    if ( nil == filename )
    {
        return nil;
    }
    
    currentFilename                 = TDGetPathForDirectories( directory, [filename stringByDeletingPathExtension], [filename pathExtension], subpath,  YES );
    if ( nil == currentFilename )
    {
        return nil;
    }
    return currentFilename;
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark private method for TDDownload Manager Object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief search a update's file in directory with timestamp for download condition.
 *  search a update's file in directory with timestamp for download condition;
 *  if can find the update's file in the update's directory, and the file's timestamp more then the internet's then decision to skip download, otherwise download from internet.
 *
 *  @param destinationFile          a filename of update.
 *  @param path                     a file's full path of update.
 *  @param timestamp                the file update condition that was check for integer type.
 *
 *  @return YES|NO                  decision to download the update's file or not.
 */
BOOL _SearchUpdateFile( NSString * destinationFile, NSString * path, NSString * timestamp )
{
    if ( ( nil == destinationFile ) || ( nil == path ) )
    {
        return NO;
    }
    
    BOOL                            isDir;
    NSFileManager                 * manager;
    NSArray                       * list;
    NSArray                       * fileSeparated;
    NSArray                       * destFileSeparated;
    NSString                      * fileExtension;
    NSError                       * error;
    
    error                           = nil;
    fileSeparated                   = nil;
    destFileSeparated               = nil;
    fileExtension                   = nil;
    manager                         = [NSFileManager defaultManager];
    list                            = [manager contentsOfDirectoryAtPath: path error: &error];
    
    //NSLog( @"list: %@", list  );
    for ( NSString * file in list )
    {
        if ( nil == file )
        {
            continue;
        }
        
        //  if unuse timestamp to compare, when find the file then skip download the file.
        if ( ( nil == timestamp ) || ( [timestamp length] == 0 ) || ( [timestamp isNumeric] == NO ) )
        {
            //if ( [file isEqualToString: destinationFile] == NO )
            if ( [[file lowercaseString] isEqualToString: [destinationFile lowercaseString]] == NO )
            {
                continue;
            }
            
            isDir                   = NO;
            if ( [manager fileExistsAtPath: [path stringByAppendingPathComponent: file] isDirectory: &isDir] == YES )
            {
                if ( NO == isDir )
                {
                    //  when filename is equal and it isn't dir.
                    return NO;              //  skip to download.
                }
                
                //  when file is found in list, but it's dir
                return YES;                 //  must download.
            }
            continue;
        }
        
        
        fileSeparated               = [file componentsSeparatedByString: @"."];
        destFileSeparated           = [destinationFile componentsSeparatedByString: @"."];
        if ( ( ( nil == fileSeparated ) || ( nil == destFileSeparated ) ) || ( [fileSeparated count] != ( [destFileSeparated count] + 1 ) ) )
        {
            continue;
        }
        
        switch ( [fileSeparated count] )
        {
            case 0:
            {
                continue;                   //  maybe has error...
            }
                
            case 1:
            {
                //  because use timestamp to compare, must download the file in any case.
                continue;
            }
            default:
            {
                if ( [[[file stringByDeletingPathExtension] lowercaseString] isEqualToString: [destinationFile lowercaseString]] == NO )
                {
                    continue;
                }
                
                fileExtension       = [file pathExtension];
                if ( ( nil == fileExtension ) || ( [fileExtension length] == 0 ) || ( [fileExtension isNumeric] == NO ) )
                {
                    continue;
                }
                
                //  compare both timestamp, if can find a file's timestamp equal or more then input's timestamp, don't download.
                if ( [fileExtension integerValue] < [timestamp integerValue] )
                {
                    continue;
                }
                
                //  check file is dir ?
                isDir               = NO;
                if ( [manager fileExistsAtPath: [path stringByAppendingPathComponent: file] isDirectory: &isDir] == YES )
                {
                    if ( NO == isDir )
                    {
                        //  when filename is equal and it isn't dir.
                        return NO;              //  skip to download.
                    }
                }
                break;
            }
        }
    }   //  End of  for ( NSString * file in list ).
    
    return YES;         //  must download.
}

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief search the path of destination, if find the timestamp older then update's then remove it.
 *  search the path of destination, if find the timestamp older then update's then remove it.
 *
 *  @param destinationFile          a filename of update.
 *  @param path                     a file's full path of update.
 *  @param timestamp                the file update condition that was check for integer type.
 *
 *  @return YES|NO                  method success or failure.
 */
BOOL _RemoveUpdateOlderFile( NSString * destinationFile, NSString * path, NSString * timestamp )
{
    if ( ( nil == destinationFile ) || ( nil == path ) || ( nil == timestamp ) )
    {
        return NO;
    }

    NSFileManager                 * manager;
    NSArray                       * list;
    NSArray                       * fileSeparated;
    NSArray                       * destFileSeparated;
    NSString                      * fileExtension;
    NSError                       * error;
    
    error                           = nil;
    fileSeparated                   = nil;
    destFileSeparated               = nil;
    fileExtension                   = nil;
    manager                         = [NSFileManager defaultManager];
    list                            = [manager contentsOfDirectoryAtPath: path error: &error];
    
    for ( NSString * file in list )
    {
        if ( nil == file )
        {
            continue;
        }
        
        fileSeparated               = [file componentsSeparatedByString: @"."];
        destFileSeparated           = [destinationFile componentsSeparatedByString: @"."];
        if ( ( ( nil == fileSeparated ) || ( nil == destFileSeparated ) ) || ( [fileSeparated count] != ( [destFileSeparated count] + 1 ) ) )
        {
            continue;
        }
        
        if ( [[[file stringByDeletingPathExtension] lowercaseString] isEqualToString: [destinationFile lowercaseString]] == NO )
        {
            continue;
        }
        
        fileExtension               = [file pathExtension];
        if ( ( nil == fileExtension ) || ( [fileExtension length] == 0 ) || ( [fileExtension isNumeric] == NO ) )
        {
            continue;
        }
        
        //  compare both timestamp, if can find a file's timestamp equal or more then input's timestamp.
        if ( [fileExtension integerValue] >= [timestamp integerValue] )
        {
            continue;
        }
        
        //  when find older, delete it.
        if ( [manager fileExistsAtPath: [path stringByAppendingPathComponent: file]] == NO )
        {
            continue;
        }
        
        error                       = nil;
        if ( [manager removeItemAtPath: [path stringByAppendingPathComponent: file] error: &error] == NO )
        {
            NSLog( @"delete file error : %@", error );
            continue;
        }
        NSLog( @"remove older :%s", [[path stringByAppendingPathComponent: file] UTF8String] );
        
        
    }   //  End of  for ( NSString * file in list ).
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for AFNetwork's block of method of download.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief call the pre-save procedure when use the download method to download file is completed.
 *  call the pre-save procedure when use the download method to download file is completed ( the method download file to temporary).
 *  then change to new filename with path on here.
 *
 *  @param response                 the download's method's response.
 *  @param subpath                  the subpath of directory.
 *
 *  @return URL|nil                 a new file path's URL of download file or nil.
 */
NSURL * _PreSaveProcedure( NSURLResponse * response, NSString * subpath )
{
    if ( nil == response )
    {
        return nil;
    }
    
    NSString                      * downloadFile;
    NSString                      * downloadPath;
    NSURL                         * downloadURL;
    NSFileManager                 * manager;
    NSError                       * error;
    
    error                           = nil;
    downloadURL                     = nil;
    manager                         = [NSFileManager defaultManager];
    downloadFile                    = [response suggestedFilename];
    downloadPath                    = ( ( ( nil == subpath ) || ( [subpath length] == 0 ) ) ? @"downloads" :  [@"downloads" stringByAppendingPathComponent: subpath] );
    if ( nil == downloadFile )
    {
        return nil;
    }
    
    downloadFile                    = TDGetPathForDirectories( TDTemporaryDirectory, [downloadFile stringByDeletingPathExtension], [downloadFile pathExtension], downloadPath, NO );
    if ( nil == downloadFile )
    {
        return nil;
    }

    //  when file exist, delete it.
    if ( [manager fileExistsAtPath: downloadFile] == YES )
    {
        if ( [manager removeItemAtPath: downloadFile error: &error] == NO )
        {
            NSLog( @"remove file error : %@ ", error );
        }
    }
    
    //  pre-create subpath on here, because AFNetwork's  download task save the download's file without create subpath of temporary directory. That's failure for download.
    if ( [manager fileExistsAtPath: [downloadFile stringByDeletingLastPathComponent]] == NO )
    {
        error                       = nil;
        if ( [manager createDirectoryAtPath: [downloadFile stringByDeletingLastPathComponent] withIntermediateDirectories: YES attributes: nil error: &error] == NO )
        {
            NSLog( @"create sub path error : %@", error );
        }
    }

    //  set to NSURL.
    downloadFile                    = [@"file://" stringByAppendingString: downloadFile];
    downloadFile                    =  [downloadFile stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    downloadURL                     = [NSURL URLWithString: downloadFile];
    return downloadURL;
}

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief call this method when usee the download method to download file is completed.
 *  call this method when usee the download method to download file is completed ( the method move the file to new path already ).
 *  then change to new filename with path on here again ( move the file to current path for project used. ).
 *
 *  @param sourceURL                the file's source's URL.
 *  @param destinationFile          the file's destination filename.
 *  @param coverOldFile             decision to replace older file or not.
 *  @param error                    a NSError object for return error information to executor.
 *
 *  @return YES|NO                  method success or failure.
 */
BOOL _UpdateFileToCurrentDirectory( NSURL * sourceURL, NSString * destinationFile, BOOL coverOldFile, NSError *__autoreleasing * error )
{
    //  when destination data warning,  skip move file.
    if ( ( nil == destinationFile ) || ( [destinationFile length] == 0 ) )
    {
        if ( nil != error )
        {
            NSMutableDictionary   * errorInfos;
            
            errorInfos              = [@{
                                         NSLocalizedDescriptionKey: NSLocalizedStringFromTable( @"filename is nil or empty.", @"TDDownloadManager", nil )
                                         } mutableCopy];
            *error                  = [NSError errorWithDomain: TDDownloadManagerErrorDomain code: TDDownloadManagerErrorCodeFilenameParamError userInfo: errorInfos];
        }
        return NO;
    }
    
    NSURL                         * destinationURL;
    NSFileManager                 * manager;
    NSError                       * updateError;

    updateError                     = nil;
    manager                         = [NSFileManager defaultManager];
    //  create subpath on here, when path not exist.
    if ( [manager fileExistsAtPath: [destinationFile stringByDeletingLastPathComponent]] == NO )
    {
        if ( [manager createDirectoryAtPath: [destinationFile stringByDeletingLastPathComponent] withIntermediateDirectories: YES attributes: nil error: &updateError] == NO )
        {
            if ( nil != error )
            {
                *error              = updateError;
            }
            return NO;
        }
    }

    //  when must cover older file.
    if ( ( YES == coverOldFile ) && ( [manager fileExistsAtPath: destinationFile] == YES ) )
    {
        if ( [manager removeItemAtPath: destinationFile error: &updateError] == NO )
        {
            if ( nil != error )
            {
                *error              = updateError;
            }
            return NO;
        }
    }
    
    //  move file.
    //  iOS file system's letter is not to differentiate between lowercase and uppercase, so always set to lowercase.
    destinationFile                 = [destinationFile lowercaseString];
    destinationFile                 = [@"file://" stringByAppendingString: destinationFile];
    destinationFile                 =  [destinationFile stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    destinationURL                  = [NSURL URLWithString: destinationFile];
    if ( nil == destinationURL )
    {
        if ( nil != error )
        {
            NSMutableDictionary   * errorInfos;
        
            errorInfos              = [@{
                                            NSLocalizedDescriptionKey: [NSString stringWithFormat: NSLocalizedStringFromTable( @"(%@)file's URL is nil", @"TDDownloadManager", nil ), destinationFile ]
                                         } mutableCopy];
            *error                  = [NSError errorWithDomain: TDDownloadManagerErrorDomain code: TDDownloadManagerErrorCodePathError userInfo: errorInfos];
        }
        return NO;
    }
    
    if ( [manager moveItemAtURL: sourceURL toURL: destinationURL error: &updateError] == NO )
    {
        if ( nil != error )
        {
            *error                  = updateError;
        }
        return NO;
    }
    if ( nil != error )
    {
        *error                      = NULL;
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDDownloadManager

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDDownloadManager ()
{
    /**
     *  a download task of session; for set a progress view.
     */
    NSURLSessionDownloadTask      * sessionDownloadTask;
}

//  ------------------------------------------------------------------------------------------------
/**
 *  assign a block's pointer for be executed when download task is running.
 */
@property (readwrite, nonatomic, copy) TDDownloadTaskDidWriteDataBlock      didWriteDataBlock;

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare private category (Private)
//  ------------------------------------------------------------------------------------------------
@interface TDDownloadManager (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for download procedure.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a Download Manager object with AFManager for set some callback block section.
 *  create a Download Manager object with AFManager for set some callback block section.
 *
 *  @param afManager                a AF URL Session manager object.
 *
 *  @return object|nil              the download manager object or nil.
 */
+ ( instancetype ) _DownloadManagerTaskDidWriteDataBlockWith:(AFURLSessionManager *)afManager;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set a download task of session.
 *  set a download task of session; for set a progress view.
 *
 *  @param downloadTask             a download task.
 */
- ( void ) _SetDownloadManagerTask:(NSURLSessionDownloadTask *)downloadTask;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief download a file from URL and save the file to directory.
 *
 *  @param destinationFile          a file's destination filename (full path).
 *  @param fileURL                  the URL of file at internet.
 *  @param subpath                  the subpath of directory.
 *  @param coverOldFile             decision to replace older file or not.
 *  @param completed                a block section be executed when download completed.
 *
 
 *  @return YES|NO                  method success or failure.
 
 */
+ ( instancetype ) _DownloadProcedure:(NSString *)destinationFile from:(NSString *)fileURL into:(NSString *)subpath coverOlder:(BOOL)coverOlder
                            completed:(TDDownloadCompletedCallbackBlock)completed;

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDDownloadManager (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    [self                           setDidWriteDataBlock: nil];
    sessionDownloadTask             = nil;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for download procedure.
//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) _DownloadManagerTaskDidWriteDataBlockWith:(AFURLSessionManager *)afManager
{
    NSParameterAssert( nil != afManager );
    
    //  set callback block to get bytes information of downloading.
    TDDownloadManager             * downloadManager;
    
    downloadManager                 = [[[self class] alloc] init];
    [afManager                      setDownloadTaskDidWriteDataBlock:
     ^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite)
     {
         if ( ( nil != downloadManager) && ( nil != downloadManager.didWriteDataBlock ) )
         {
             downloadManager.didWriteDataBlock( bytesWritten, totalBytesWritten, totalBytesExpectedToWrite );
         }
     }];
    return downloadManager;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _SetDownloadManagerTask:(NSURLSessionDownloadTask *)downloadTask
{
    if ( nil == downloadTask )
    {
        return;
    }
    sessionDownloadTask             = downloadTask;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) _DownloadProcedure:(NSString *)destinationFile from:(NSString *)fileURL into:(NSString *)subpath coverOlder:(BOOL)coverOlder
                            completed:(TDDownloadCompletedCallbackBlock)completed
{
    NSParameterAssert( nil != destinationFile );
    NSParameterAssert( nil != fileURL );

    NSURL                         * url;
    NSURLRequest                  * urlRequest;
    NSURLSessionConfiguration     * configuration;
    NSURLSessionDownloadTask      * downloatTask;
    AFURLSessionManager           * manager;
    NSError                       * errorDownload;
    
    url                             = [NSURL URLWithString: fileURL];
    configuration                   = [NSURLSessionConfiguration defaultSessionConfiguration];
    downloatTask                    = nil;
    manager                         = nil;
    errorDownload                   = nil;
    NSParameterAssert( nil != url );
    NSParameterAssert( nil != configuration );
    
    urlRequest                      = [NSURLRequest requestWithURL: url];
    manager                         = [[AFURLSessionManager alloc] initWithSessionConfiguration: configuration];
    NSParameterAssert( nil != urlRequest );
    NSParameterAssert( nil != manager );
    
    downloatTask                    = [manager downloadTaskWithRequest: urlRequest progress: nil destination: ^NSURL * ( NSURL * targetPath, NSURLResponse * response )
    {
        //  這邊修正成, 在 tmp 目錄下產生一個 downloads 目錄, 然後先去檢查該目錄是否存在, 不存在則產生, 在檢查裡頭是否已經存在預定存放的檔案, 如果已經存在則移除.
        //    這樣就能完整控制下載後的檔案, 一定會是最新的 ... 因為會持續被刪除 ...
        return _PreSaveProcedure( response, subpath );
    }
    completionHandler:  ^( NSURLResponse * response, NSURL * filePath, NSError * error )
    {
        //  然後在這個地方, 再把已經存好的檔案, 移動到預定應該擺放的位置或目錄底下; 擺放的同時 一樣進行目錄產生 然後在移動剛剛下載完成的檔案.
        BOOL                        result;
        NSError                   * errorUpdate;
        
        if ( ( nil != completed ) && ( nil != error ) )
        {
            completed( error, destinationFile, NO );
            return;
        }
        
        errorUpdate                 = nil;
        result                      = _UpdateFileToCurrentDirectory( filePath, destinationFile, coverOlder, &errorUpdate );
        if ( nil != completed )
        {
            completed( errorUpdate, destinationFile, result );
        }
    }];
    
    [manager setDownloadTaskDidWriteDataBlock: ^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite)
    {
        NSLog( @"session : %@, download task : %@\nbytesWritten : %lld, totalBytesWritten : %lld, totalBytesExpectedToWrite : %lld.",
              session, downloadTask, bytesWritten, totalBytesWritten, totalBytesExpectedToWrite );
    }];
    
    [downloatTask                   resume];

    
    //  set callback block to get  bytes information of downloading.
    TDDownloadManager             * downloadManager;

    downloadManager                 = [[self class] _DownloadManagerTaskDidWriteDataBlockWith: manager];
    if ( nil != downloadManager )
    {
        [downloadManager            _SetDownloadManagerTask: downloatTask];
    }
    return downloadManager;
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
@implementation TDDownloadManager

//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    
    //  initial.
    [self                           _InitAttributes];
    return self;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != sessionDownloadTask )
    {
        sessionDownloadTask    = nil;
    }
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for download file.
//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) simpleDownload:(NSString *)downloadURL forDirectory:(NSSearchPathDirectory)directory
                        completed:(TDDownloadCompletedCallbackBlock)completed
{
    NSParameterAssert( nil != downloadURL );
    
    NSURL                         * url;
    NSURLRequest                  * urlRequest;
    NSURLSessionConfiguration     * configuration;
    AFURLSessionManager           * manager;
    NSURLSessionDownloadTask      * downloatTask;
    
    downloatTask                    = nil;
    manager                         = nil;
    url                             = [NSURL URLWithString: downloadURL];
    configuration                   = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSParameterAssert( nil != url );
    NSParameterAssert( nil != configuration );
    
    urlRequest                      = [NSURLRequest requestWithURL: url];
    manager                         = [[AFURLSessionManager alloc] initWithSessionConfiguration: configuration];
    NSParameterAssert( nil != urlRequest );
    NSParameterAssert( nil != manager );
    
    downloatTask                    = [manager downloadTaskWithRequest: urlRequest progress: nil destination: ^NSURL * ( NSURL * targetPath, NSURLResponse * response )
    {
        NSURL                     * directoryURL;
        
        directoryURL                = [[NSFileManager defaultManager] URLForDirectory: directory inDomain: NSUserDomainMask appropriateForURL: nil create: NO error: nil];
        if ( nil == directoryURL )
        {
            return nil;
        }
        return [directoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    }
    completionHandler:  ^( NSURLResponse * response, NSURL * filePath, NSError * error )
    {
        NSLog( @"finish download : %@", [filePath path] );
        if ( nil != completed )
        {
            completed( error, [filePath path], ( ( nil == error ) ? YES : NO ) );
        }
        
    }];
    
    [downloatTask                   resume];
    
    
    //  set callback block to get  bytes information of downloading.
    TDDownloadManager             * downloadManager;
    
    downloadManager                 = [[self class] _DownloadManagerTaskDidWriteDataBlockWith: manager];
    if ( nil != downloadManager )
    {
        [downloadManager            _SetDownloadManagerTask: downloatTask];
    }
    return downloadManager;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) download:(NSString *)filename from:(NSString *)fileURL into:(NSString *)subpath of:(TDGetPathDirectory)directory
      updateCheckBy:(NSString *)timestamp
          completed:(TDDownloadCompletedCallbackBlock)completed
{
    NSParameterAssert( nil != filename );
    NSParameterAssert( nil != fileURL );
    
    BOOL                            download;
    TDDownloadManager             * downloadManager;
    NSString                      * destinationFilename;
    
    
    download                        = NO;
    downloadManager                 = nil;
    destinationFilename             = nil;
    destinationFilename             = TDGetPathForDirectoriesWithTimestamp( directory, [filename stringByDeletingPathExtension], timestamp, [filename pathExtension], subpath, NO );
    NSParameterAssert( nil != destinationFilename );
    
    download                        = _SearchUpdateFile( filename, [destinationFilename stringByDeletingLastPathComponent], timestamp );
    if ( NO == download )
    {
        if ( nil != completed )
        {
            completed( nil, destinationFilename, YES );
        }
        NSLog( @"already have a latest file in the directory. %@", filename );
        return nil;
    }
    
    //  when download finish, delete update older files.    //  cover older's value change to set: YES, because maybe find the same filename in destination directory, but it's 'dir'.
    downloadManager                 = [TDDownloadManager _DownloadProcedure: destinationFilename from: fileURL into: subpath coverOlder: YES completed:
                                       ^ (NSError * error, NSString * fullPath, BOOL finished)
    {
        if ( nil != completed )
        {
            completed( error, destinationFilename, finished );
        }
        if ( NO == finished )
        {
            return;
        }
        _RemoveUpdateOlderFile( filename, [destinationFilename stringByDeletingLastPathComponent], timestamp );
    }];
    
    return downloadManager;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) replacementDownload:(NSString *)filename from:(NSString *)fileURL into:(NSString *)subpath of:(TDGetPathDirectory)directory
                     completed:(TDDownloadCompletedCallbackBlock)completed
{
    NSParameterAssert( nil != filename );
    NSParameterAssert( nil != fileURL );
    
    NSString                      * destinationFilename;
    
    destinationFilename             = nil;
    destinationFilename             = TDGetPathForDirectories( directory, [filename stringByDeletingPathExtension], [filename pathExtension], subpath, NO );
    if ( nil == destinationFilename )
    {
        return nil;
    }
    
    return [TDDownloadManager _DownloadProcedure: destinationFilename from: fileURL into: subpath coverOlder: YES completed: completed];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for download JSON data.
//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) readJSONFile:(NSString *)jsonURL completed:(TDReadJSONCompletedCallbackBlock)completed
{
    NSSet                         * contentTypes;
    NSURL                         * url;
    NSURLRequest                  * urlRequest;
    AFHTTPRequestOperationManager * manager;
    
    contentTypes                    = nil;
    manager                         = [AFHTTPRequestOperationManager manager];
    NSParameterAssert( nil != manager );
    
    url                             = [NSURL URLWithString: jsonURL];
    NSParameterAssert( nil != url );
    
    urlRequest                      = [NSURLRequest requestWithURL: url];
    NSParameterAssert( nil != urlRequest );
    
    contentTypes                    = [NSSet setWithObjects: @"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    [manager                        setResponseSerializer: [AFJSONResponseSerializer serializer]];
    [[manager                       responseSerializer] setAcceptableContentTypes: contentTypes];
    [manager                        GET: jsonURL parameters: nil success: ^( AFHTTPRequestOperation * operation, id responseObject )
    {
        if ( nil != completed )
        {
            completed( responseObject, nil, YES );
        }
    }
    failure: ^( AFHTTPRequestOperation * operation, NSError * error )
    {
        if ( nil != completed )
        {
            completed( nil, error, NO );
        }
    }];

    return YES;
}

//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) readJSONFile:(NSString *)jsonURL
               withSave:(NSString *)filename into:(NSString *)subpath of:(TDGetPathDirectory)directory extension:(NSString *)timestamp
             completed:(TDReadJSONCompletedCallbackBlock)completed
{
    NSParameterAssert( nil != jsonURL );
    NSParameterAssert( nil != filename );
    
    [TDDownloadManager              readJSONFile: jsonURL completed: ^( NSDictionary * jsonContent, NSError * error, BOOL finished )
    {
        //  when get json from URL have a error.
        if ( nil != error )
        {
            if ( nil != completed )
            {
                completed( nil, error, NO );
            }
            return;
        }
        

        //  save json data to file.
        BOOL                        result;
        NSError                   * outputError;
        NSString                  * destinationFilename;
        NSOutputStream            * outputStream;
        
        outputError                 = nil;
        outputStream                = nil;
        destinationFilename         = nil;
        result                      = NO;
        destinationFilename         = TDGetPathForDirectoriesWithTimestamp( directory, [filename stringByDeletingPathExtension], timestamp, [filename pathExtension], subpath, NO );
        NSParameterAssert( nil != destinationFilename );
        
        result                      = [NSJSONSerialization saveJSONContainer: jsonContent toFileAtPath: destinationFilename error: &outputError];
        if ( nil != completed )
        {
            completed( jsonContent, nil, result );
        }
        return;
    }];
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) readJSONFile:(NSString *)jsonURL withSaveInto:(NSString *)fullPath completed:(TDReadJSONCompletedCallbackBlock)completed
{
    NSParameterAssert( nil != jsonURL );
    NSParameterAssert( nil != fullPath );
    
    [TDDownloadManager              readJSONFile: jsonURL completed: ^( NSDictionary * jsonContent, NSError * error, BOOL finished )
     {
         //  when get json from URL have a error.
         if ( nil != error )
         {
             if ( nil != completed )
             {
                 completed( nil, error, NO );
             }
             return;
         }
                  
         BOOL                       result;
         NSError                  * saveError;
         
         saveError                  = nil;
         result                     = [NSJSONSerialization saveJSONContainer: jsonContent toFileAtPath: fullPath error: &saveError];
         if ( nil != completed )
         {
             completed( jsonContent, saveError, result );
         }
         return;
     }];
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for base methods of procedure
//  ------------------------------------------------------------------------------------------------
- ( void ) setDownloadTaskDidWriteDataBlock:(TDDownloadTaskDidWriteDataBlock)dataBlock
{
    if ( nil == dataBlock )
    {
        return;
    }
    [self                           setDidWriteDataBlock: dataBlock];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setDownloadTaskProgressView:(UIProgressView *)progressView
{
    if ( nil == progressView )
    {
        return;
    }
    
    if ( [progressView respondsToSelector: @selector( setProgressWithDownloadProgressOfTask: animated: )] == NO )
    {
        return;
    }
    [progressView setProgressWithDownloadProgressOfTask: sessionDownloadTask animated: YES];
}

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------













