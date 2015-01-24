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
    NSString                      * prefixDirectory;
    
    NSMutableDictionary           * unzipDataContainer;
    
    //NSMutableDictionary           * configureData;      //  json struct.
    NSMutableArray                * configureData;      //  json struct.
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
- ( BOOL ) _ParseJsonStruct:(NSMutableDictionary *)json;

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
    prefixDirectory                 = nil;
    
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
    
    if ( [zip UnzipOpenFile: filename ] == NO )
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
    
    if ( nil == unzipDataContainer )
    {
        unzipDataContainer              = [[NSMutableDictionary alloc] initWithDictionary: zipFiles copyItems: YES];
    }
    else
    {
        [unzipDataContainer             addEntriesFromDictionary: zipFiles];
    }
    
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
    key                             = [NSString stringWithFormat: @"%s/%s.json", [prefixDirectory UTF8String], [filename UTF8String]];
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
    
    if ( [self _ParseJsonStruct: (NSMutableDictionary *)json] == NO )
    {
        NSLog( @"parse json warning." );
        return NO;
    }
    
    //if ( nil == configureData )
    //{
    //    configureData                   = [[NSMutableDictionary alloc] initWithDictionary: json copyItems: YES];
    //}
    //else
    //{
    //    [configureData                  addEntriesFromDictionary: json];
    //}
    
    //  after get the configure, remove the data from container. (for release memory.)
    [unzipDataContainer             removeObjectForKey: key];
    
    SAFE_ARC_RELEASE( json );
    SAFE_ARC_ASSIGN_POINTER_NIL( json );
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _ParseJsonStruct:(NSMutableDictionary *)json
{
    if ( nil == json )
    {
        return NO;
    }
    
    NSDictionary                  * tabData;
    
    tabData                         = [json objectForKey: @"Tab"];
    if ( nil == tabData )
    {
        return NO;
    }
    
    if ( nil == configureData )
    {
        //configureData                   = [[NSMutableDictionary alloc] initWithDictionary: tabData copyItems: YES];
        configureData               = [[NSMutableArray alloc] initWithArray: (NSArray *)tabData];
    }
    else
    {
        //[configureData                  addEntriesFromDictionary: tabData];
        [configureData              addObjectsFromArray: (NSArray *)tabData];
    }

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
    return [self initWithZipFile: nil inZippedPath: nil inDirectory: nil];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil == prefixDirectory )
    {
        SAFE_ARC_ASSIGN_POINTER_NIL( prefixDirectory );
    }
    
    if ( nil != unzipDataContainer )
    {
        [unzipDataContainer         removeAllObjects];
        SAFE_ARC_RELEASE( unzipDataContainer );
        SAFE_ARC_ASSIGN_POINTER_NIL( unzipDataContainer );
    }
    
    if ( nil != configureData )
    {
        [configureData              removeAllObjects];
        SAFE_ARC_RELEASE( configureData );
        SAFE_ARC_ASSIGN_POINTER_NIL( configureData );
    }
    
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method create the object.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithZipFile:(NSString *)filename inZippedPath:(NSString*)prefix inDirectory:(NSString *)subpath
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
    
    prefixDirectory                 = prefix;
    if ( nil == prefixDirectory )
    {
        prefixDirectory             = @"";
    }
    
    NSString                      * filePath;
    
    filePath                        = [[NSBundle mainBundle] pathForResource: filename ofType: @"zip" inDirectory: subpath];
    if ( [[NSFileManager defaultManager] fileExistsAtPath: filePath] == NO )
    {
        NSLog( @"file %s no exist.", [filePath UTF8String] );
        return self;
    }
    
    if ( [self _UnZipConfigureFile: filePath] == NO )
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
+ ( instancetype ) loadDataFromZip:(NSString *)filename inZippedPath:(NSString*)prefix inDirectory:(NSString *)subpath
{
    return [[[self class] alloc] initWithZipFile: filename inZippedPath: prefix inDirectory: subpath];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) infoDataCount
{
    if ( nil == configureData )
    {
        return 0;
    }
    return [configureData count];
}

//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) infoDataAtIndex:(NSInteger)index
{
    if ( 0 > index )
    {
        return nil;
    }
    [[configureData objectAtIndex: index] objectForKey: nil];
    return [configureData objectAtIndex: index];
}

//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) infoDataForKey:(NSString *)aKey
{
    if ( nil == aKey )
    {
        return nil;
    }
    
    for ( NSDictionary * info in configureData )
    {
        if ( nil == info )
        {
            continue;
        }
        
        if ( [[info objectForKey: @"Name"] isEqualToString: aKey] == YES )
        {
            return info;
        }
    }
    return nil;
}

//  ------------------------------------------------------------------------------------------------
- ( NSData * ) imageDataForKey:(NSString *)aKey
{
    if ( ( nil == aKey ) || ( nil == unzipDataContainer ) )
    {
        return nil;
    }
    
    NSString                      * key;
    
    key                             = [NSString stringWithFormat: @"%s/%s", [prefixDirectory UTF8String], [aKey UTF8String]];
    return [unzipDataContainer objectForKey: key];
}

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
















