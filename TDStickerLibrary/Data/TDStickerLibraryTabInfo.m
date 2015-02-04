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
#import "UIKit+TechD.h"
#import "TDStickerLibraryTabInfo.h"

//  ------------------------------------------------------------------------------------------------
static  NSString  * const kTDTabInfoKeyRoot                         = @"Tab";
static  NSString  * const kTDTabInfoKeyName                         = @"Name";
static  NSString  * const kTDTabInfoKeyEnabled                      = @"Enabled";
static  NSString  * const kTDTabInfoKeyImages                       = @"Images";
static  NSString  * const kTDTabInfoKeyConfigure                    = @"Configure";
static  NSString  * const kTDTabInfoKeyDataLink                     = @"DataLink";


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

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) _GetImageDataKeyForScreenScale:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------

- ( BOOL ) _UnzipProcedure:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath inZippedPath:(NSString*)prefix with:(NSString *)password;
- ( BOOL ) _UnZipConfigureFile:(NSString *)filename with:(NSString *)password;
- ( BOOL ) _GetConfigureJsonData:(NSString *)filename;
- ( BOOL ) _ParseJsonStruct:(NSMutableDictionary *)json;

//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) _GetInfoDataAtIndex:(NSInteger)index;

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
- ( NSString * ) _GetImageDataKeyForScreenScale:(NSString *)aKey
{
    if ( nil == aKey )
    {
        return nil;
    }
    
    // split & check aKey
    NSString                      * file;
    NSString                      * extension;
    
    file                            = aKey;
    extension                       = [aKey pathExtension];
    if ( [[extension lowercaseString] isEqualToString: @"png"] == YES )
    {
        return aKey;
    }
    if ( ( nil != extension ) && ( [extension length] != 0 ) )
    {
        file                            = [aKey substringToIndex: ( [aKey length] - 4 )];
    }

    file                            = [NSString stringWithFormat: @"%s@%dx", [file UTF8String], (int)[[UIScreen mainScreen] scaleMultiple]];
    aKey                            = [file stringByAppendingPathExtension: @"png"];
    return aKey;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _UnzipProcedure:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath inZippedPath:(NSString*)prefix with:(NSString *)password
{
    if ( nil == filename )
    {
        NSLog( @"filename is nil(%s).", __FUNCTION__ );
        return NO;
    }
    
    prefixDirectory                 = prefix;
    if ( nil == prefixDirectory )
    {
        prefixDirectory             = @"";
    }
    
    NSString                      * filePath;
    
    filePath                        = TDGetPathForDirectories( directory, filename, @"zip", subpath );
    if ( [[NSFileManager defaultManager] fileExistsAtPath: filePath] == NO )
    {
        NSLog( @"file %s no exist.", [filePath UTF8String] );
        return NO;
    }
    
    if ( [self _UnZipConfigureFile: filePath with: password] == NO )
    {
        NSLog( @"unzip configure file has warning." );
        return NO;
    }
    
    if ( [self _GetConfigureJsonData: filename] == NO )
    {
        NSLog( @"get configure data has warning. ");
        return NO;
    }
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _UnZipConfigureFile:(NSString *)filename with:(NSString *)password
{
    if ( nil == filename )
    {
        return NO;
    }
    
    BOOL                            result;
    ZipArchive                    * zip;
    NSDictionary                  * zipFiles;
    
    result                          = NO;
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
    
    if ( nil == password )
    {
        result                      = [zip UnzipOpenFile: filename];
    }
    else
    {
        result                      = [zip UnzipOpenFile: filename Password: password];
    }
    
    if ( result == NO )
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
    
    tabData                         = [json objectForKey: kTDTabInfoKeyRoot];
    if ( nil == tabData )
    {
        return NO;
    }
    
    if ( nil == configureData )
    {
        //configureData                   = [[NSMutableDictionary alloc] initWithDictionary: tabData copyItems: YES];
        configureData               = [[NSMutableArray alloc] initWithArray: (NSArray *)tabData];
        return YES;
    }
    
    
    NSMutableArray                * removeObject;
    
    //  compare object when new data's key is equal older.
    removeObject                     = [[NSMutableArray alloc] initWithCapacity: [configureData count]];
    for ( int i = 0; i < [configureData count]; ++i )
    {
        for ( NSDictionary * infoData in tabData )
        {
            if ( nil == infoData )
            {
                continue;
            }
        
            //  compare.
            if ( [[[configureData objectAtIndex:i] objectForKey: kTDTabInfoKeyName] isEqualToString: [infoData objectForKey: kTDTabInfoKeyName]] == NO )
            {
                continue;
            }
            [removeObject           addObject: [configureData objectAtIndex:i]];
        }
    }
    
    //  remove from contaner on here.
    for ( int i = 0; i < [removeObject count]; ++i )
    {
        [configureData              removeObject: [removeObject objectAtIndex: i]];
    }
    
    //  finish, insert into container.
    //[configureData                  addEntriesFromDictionary: tabData];
    [configureData                  addObjectsFromArray: (NSArray *)tabData];
    
    
    
    
    SAFE_ARC_RELEASE( removeIndex );
    SAFE_ARC_ASSIGN_POINTER_NIL( removeIndex );
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) _GetInfoDataAtIndex:(NSInteger)index;
{
    if ( ( 0 > index ) || ( nil == configureData ) || ( [configureData count] == 0 ) )
    {
        return nil;
    }
    return [configureData objectAtIndex: index];
}

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
    return [self initWithZipFile: nil forDirectories: TDTemporaryDirectory inDirectory: nil inZippedPath: nil with: nil];
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
- ( instancetype ) initWithZipFile:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath inZippedPath:(NSString*)prefix with:(NSString *)password
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    if ( [self _UnzipProcedure: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: password] == NO )
    {
        SAFE_ARC_RELEASE( self );
        SAFE_ARC_ASSIGN_POINTER_NIL( self );
        return nil;
    }
    
    
//    if ( nil == filename )
//    {
//        NSLog( @"filename is nil(%s).", __FUNCTION__ );
//        return self;
//    }
//    
//    prefixDirectory                 = prefix;
//    if ( nil == prefixDirectory )
//    {
//        prefixDirectory             = @"";
//    }
//    
//    NSString                      * filePath;
//    
//    filePath                        = TDGetPathForDirectories( directory, filename, @"zip", subpath );
//    if ( [[NSFileManager defaultManager] fileExistsAtPath: filePath] == NO )
//    {
//        NSLog( @"file %s no exist.", [filePath UTF8String] );
//        return self;
//    }
//    
//    if ( [self _UnZipConfigureFile: filePath with: password] == NO )
//    {
//        return self;
//    }
//    
//    if ( [self _GetConfigureJsonData: filename] == NO )
//    {
//        return self;
//    }
    
    return self;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath inZippedPath:(NSString *)prefix
{
    return [[[self class] alloc] initWithZipFile: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: nil];
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath inZippedPath:(NSString *)prefix with:(NSString *)password
{
    return [[[self class] alloc] initWithZipFile: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: password];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath inZippedPath:(NSString *)prefix with:(NSString *)password
{
    return [self _UnzipProcedure: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: password];
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
- ( BOOL ) isInfoDataEnabledAtIndex:(NSInteger)index
{
    NSDictionary                  * infoData;
    NSString                      * enabled;
    
    infoData                        = [self _GetInfoDataAtIndex: index];
    if ( nil == infoData )
    {
        return NO;
    }
    
    enabled                         = [infoData objectForKey: kTDTabInfoKeyEnabled];
    if ( nil == enabled )
    {
        return NO;
    }
    
    if ( [enabled integerValue] == 0 )
    {
        return NO;
    }
    return YES;     //  value is not equal 0, always Yes.
}

//  ------------------------------------------------------------------------------------------------
- ( NSArray * ) imagesNameAtIndex:(NSInteger)index
{
    NSDictionary                  * infoData;
    
    infoData                        = [self _GetInfoDataAtIndex: index];
    if ( nil == infoData )
    {
        return nil;
    }
    return [infoData objectForKey: kTDTabInfoKeyImages];
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
        
        if ( [[info objectForKey: kTDTabInfoKeyName] isEqualToString: aKey] == YES )
        {
            return info;
        }
    }
    return nil;
}

//  ------------------------------------------------------------------------------------------------
- ( NSData * ) imageDataForKey:(NSString *)aKey
{
    aKey                            = [self _GetImageDataKeyForScreenScale: aKey];
    if ( ( nil == aKey ) || ( nil == unzipDataContainer ) )
    {
        return nil;
    }
    return [unzipDataContainer objectForKey: aKey];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) configureNameAtIndex:(NSInteger)index
{
    NSDictionary                  * infoData;
    NSString                      * configure;
    
    configure                       = nil;
    infoData                        = [self _GetInfoDataAtIndex: index];
    if ( nil == infoData )
    {
        return nil;
    }
    
    configure                       = [infoData objectForKey: kTDTabInfoKeyConfigure];
    if ( ( nil == configure ) || ( [configure length] == 0 ) )
    {
        return nil;
    }
    return configure;
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) dataLinkAtIndex:(NSInteger)index
{
    NSDictionary                  * infoData;
    NSString                      * dataLink;
    
    dataLink                        = nil;
    infoData                        = [self _GetInfoDataAtIndex: index];
    if ( nil == infoData )
    {
        return nil;
    }
    
    dataLink                        = [infoData objectForKey: kTDTabInfoKeyDataLink];
    if ( ( nil == dataLink ) || ( [dataLink length] == 0 ) )
    {
        return nil;
    }
    return dataLink;
}


//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
















