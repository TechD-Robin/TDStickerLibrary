//
//  TDStickerLibraryTabInfo.m
//  DemoStickerLibrary
//
//  Created by Robin Hsu on 2015/1/21.
//  Copyright (c) 2015年 TechD. All rights reserved.
//

#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "ZipArchive.h"
#import "TDStickerLibraryTabInfo.h"

//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryTabInfo

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  declare property for private category()
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
#pragma mark declare property ()
@interface TDStickerLibraryTabInfo()
{
    NSMutableDictionary           * unzipDataContainer;
    
    NSDictionary                  * configureData;      //  json struct.
}

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  method declare for Private of category
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare for Private
@interface TDStickerLibraryTabInfo(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

- ( BOOL ) _UnZipConfigureFile:(NSString *)filename;
- ( BOOL ) _GetConfigureJsonData:(NSString *)filename;

//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  method implementation for Private of category
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for Private method
@implementation TDStickerLibraryTabInfo(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( void ) _InitAttributes
{
    unzipDataContainer              = nil;
    
    configureData                   = nil;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _UnZipConfigureFile:(NSString *)filename
{
    if ( nil == filename )
    {
        return NO;
    }
    
    NSFileManager                 * fileManager;
    NSString                      * resourcePath;
    NSString                      * filePath;
    
    resourcePath                    = [[NSBundle mainBundle] resourcePath];
    fileManager                     = [NSFileManager defaultManager];
    filePath                        = [resourcePath stringByAppendingPathComponent: [NSString stringWithFormat: @"%s.zip", [filename UTF8String]]];
    if ( ( [fileManager fileExistsAtPath: resourcePath] == NO ) || ( [fileManager fileExistsAtPath: filePath] == NO ) )
    {
        NSLog( @"file %s no exist.", [filePath UTF8String] );
        return NO;
    }
    
    ZipArchive                    * zip;
    NSDictionary                  * zipFiles;
    
    zipFiles                        = nil;
    zip                             = [[ZipArchive alloc] init];
    if ( nil == zip )
    {
        NSLog( @"cannot create zip archive object!" );
        return NO;
    }
    
    ////  set process call back.
    //[zip                            setProgressBlock: ^(int percentage, int filesProcessed, unsigned long numFiles, NSString * filename )
    // {
    //     NSLog( @"[%d%%] %d/%ld  %s", percentage, filesProcessed, numFiles, [filename UTF8String] );
    // }];
    
    if ( [zip UnzipOpenFile: filePath ] == NO )
    {
        NSLog( @"cannot open zip file %s.", __FUNCTION__ );
        [zip                        UnzipCloseFile];
        return NO;
    }
    zipFiles                        = [zip UnzipFileToMemory];
    if ( nil == zipFiles )
    {
        NSLog( @"cannot unzip file to memory");
        [zip                        UnzipCloseFile];
        return NO;
    }
    
    unzipDataContainer              = [[NSMutableDictionary alloc] initWithDictionary: zipFiles copyItems: YES];
    
    //.NSLog( @"unzip file in memory : %@", zipFiles );
    [zip                            UnzipCloseFile];
    
    SAFE_ARC_RELEASE( zipFiles );
    SAFE_ARC_ASSIGN_POINTER_NIL( zipFiles );
    
    SAFE_ARC_RELEASE( zip );
    SAFE_ARC_ASSIGN_POINTER_NIL( zip );
    return YES;
}

//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( BOOL ) _GetConfigureJsonData:(NSString *)filename
{
    if ( nil == filename )
    {
        return NO;
    }
    
    NSString                      * key;
    NSDictionary                  * json;
    NSError                       * jsonParsingError;
    NSData                        * configure;
    
    json                            = nil;
    jsonParsingError                = nil;
    key                             = [NSString stringWithFormat: @"%s/%s.json", [filename UTF8String], [filename UTF8String]];
    configure                       = [unzipDataContainer objectForKey: key];
    if ( nil == configure )
    {
        NSLog( @"cannot get the configure from container." );
        return NO;
    }
    
    json                            = [NSJSONSerialization JSONObjectWithData: configure options:NSJSONReadingMutableContainers error: &jsonParsingError];
    if ( nil == json )
    {
        if ( nil != jsonParsingError )
        {
            NSLog( @"%@", jsonParsingError );
        }
        return NO;
    }
    
    configureData                   = [[NSDictionary alloc] initWithDictionary: json copyItems: YES];
    
    //  after get the configure, remove the data from container. (for release memory.)
    [unzipDataContainer             removeObjectForKey: key];
    
    SAFE_ARC_RELEASE( json );
    SAFE_ARC_ASSIGN_POINTER_NIL( json );
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


// ※ 環境設定新建一個 default class 之類的方式, 把一些相關設定值都預設進去裡頭, 如果開發人員讓 object = nil 帶入, 就自建一個 default 的 出來傳遞,
//  如果有 new 這個 class 就帶入這個 new 出來的 class 的值... 這樣應該不錯用才是 @@~

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  public method implementation.
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public method
@implementation TDStickerLibraryTabInfo

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init
{
    return [self initWithFilename: nil];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != unzipDataContainer )
    {
        SAFE_ARC_RELEASE( unzipDataContainer );
        SAFE_ARC_ASSIGN_POINTER_NIL( unzipDataContainer );
    }
    
    if ( nil != configureData )
    {
        SAFE_ARC_RELEASE( configureData );
        SAFE_ARC_ASSIGN_POINTER_NIL( configureData );
    }
    
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method create the object.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithFilename:(NSString *)filename
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    if ( nil == filename )
    {
        NSLog( @"filename is nil(%s).", __FUNCTION__ );
        return self;
    }

    if ( [self _UnZipConfigureFile: filename] == NO )
    {
        return self;
    }
    
    if ( [self _GetConfigureJsonData: filename] == NO )
    {
        return self;
    }
    
    
    
    
    
    return self;
}


//  ------------------------------------------------------------------------------------------------
+ (instancetype) loadData:(NSString *)filename
{
//    if ( nil == filename )
//    {
//        return nil;
//    }
//    
//    TDStickerLibraryTabInfo       * info;
//    
//    info                            = [[TDStickerLibraryTabInfo alloc] init];
//    if ( nil == info )
//    {
//        return nil;
//    }
//    if ( [info _UnZipConfigureFile: filename] == NO )
//    {
//        return info;
//    }
//    return info;
    
    return [[[self class] alloc] initWithFilename: filename];
}

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------















