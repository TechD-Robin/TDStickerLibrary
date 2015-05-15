//
//  TDStickerLibraryUnzip.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/2/4.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "ZipArchive.h"
#import "Foundation+TechD.h"

#import "TDStickerLibraryUnzip.h"


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryUnzip

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryUnzip ()
{
    /**
     *  prefix path name in zipped file.
     */
    NSString                      * prefixDirectory;
    
    /**
     *  the container of configure data.
     */
    //NSMutableDictionary           * configureData;      //  json struct.
    NSMutableArray                * configureData;      //  json struct.
    
    
    id                              swapSource;
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
@interface TDStickerLibraryUnzip (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a zipped file's full path with check the state of update.
 *  get a zipped file's full path with check the state of update.
 *
 *  @param filename                 zipped file name (without Extension part).
 *  @param directory                enumeration for directory.
 *  @param subpath                  resource's sub directory name of configure
 *  @param updateFile               pointer of extensioin result of method, to express file exist is update or default.
 *
 *  @return full path|nil           the file's full path or nil.
 */
+ ( NSString *) _GetZippedFileFullPath:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                             isUpdate:(BOOL *)updateFile;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for json data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a configure json data from unzipped object.
 *  get a configure json data from unzipped object.
 *
 *  @param filename                 configure file name (without Extension part).
 *  @param rootKey                  key of root of configure file.
 *  @param updateKey                key for update data.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _GetConfigureJsonData:(NSString *)filename configure:(NSString *)rootKey with:(NSString *)updateKey;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief parse the structure of json data.
 *  parse the structure of json data, and assign to container of configure data.
 *
 *  @param json                     the container of json data.
 *  @param rootKey                  key of root of configure file.
 *  @param updateKey                key for update data.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _ParseJsonStruct:(NSMutableDictionary *)json  configure:(NSString *)rootKey with:(NSString *)updateKey;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for i/o properties.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the prefix path name in zipped file.
 *  get the prefix path name in zipped file.
 *
 *  @return prefix|nil              the prefix path name or nil
 */
- ( NSString * ) _GetPrefixDirectory;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set a prefix path name in zipped file.
 *  set a prefix path name in zipped file.
 *
 *  @param prefix                   a prefix path name.
 */
- ( void ) _SetPrefixDirectory:(NSString *)prefix;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get data in Zipped file.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a data in zipped file for key.
 *  get a data in zipped file for key.
 *
 *  @param aKey                     a key of data.
 *
 *  @return data|nil                the data for key or nil.
 */
- ( NSData * ) _UnzipDataForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get information data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a information data at index.
 *  get a information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return data|nil                the container of information data.
 */
- ( NSDictionary * ) _GetInfoDataAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief remove informatioin data from other information data list.
 *  remove informatioin data from other information data list.
 *
 *  @param infoDataList             a information data list.
 */
- ( void ) _RemoveInfoData:(NSArray *)infoDataList;

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDStickerLibraryUnzip (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    prefixDirectory                 = nil;
    
    configureData                   = nil;
    
    swapSource                      = nil;
}

//  ------------------------------------------------------------------------------------------------
+ ( NSString *) _GetZippedFileFullPath:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                              isUpdate:(BOOL *)updateFile
{
    NSString                      * zipFileExtension;
    NSArray                       * fileSeparated;
    
    zipFileExtension                = @"zip";
    fileSeparated                   = [filename componentsSeparatedByString: @"."];
    //  check file name for appended timpstamp.
    if ( ( [fileSeparated count] >= 2 ) && ( [[filename pathExtension] isNumeric] == YES ) )
    {
        if ( NULL != updateFile )
        {
            *updateFile             = YES;
        }
        zipFileExtension            = nil;
    }
    return TDGetPathForDirectories( directory, filename, zipFileExtension, subpath, YES );
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for json data.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _GetConfigureJsonData:(NSString *)filename configure:(NSString *)rootKey with:(NSString *)updateKey
{
    if ( nil == filename )
    {
        return NO;
    }
    
    NSString                      * key;
    NSDictionary                  * json;
    NSError                       * jsonParsingError;
    
    json                            = nil;
    jsonParsingError                = nil;
    key                             = [NSString stringWithFormat: @"%s/%s.json", [prefixDirectory UTF8String], [filename UTF8String]];
    json                            = [self JSON: filename ofType: @"json" inDirectory: prefixDirectory encoding: NSUTF8StringEncoding];
    if ( nil == json )
    {
        if ( nil != jsonParsingError )
        {
            NSLog( @"%@", jsonParsingError );
        }
        return NO;
    }
    
    if ( [self _ParseJsonStruct: (NSMutableDictionary *)json configure: rootKey with: updateKey] == NO )
    {
        NSLog( @"parse json warning." );
        return NO;
    }
    
    //  after get the configure, remove the data from container. (for release memory.)
    [[self                          unzipDataContainer] removeObjectForKey: key];
    
    SAFE_ARC_RELEASE( json );
    json                            = nil;
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _ParseJsonStruct:(NSMutableDictionary *)json configure:(NSString *)rootKey with:(NSString *)updateKey
{
    if ( ( nil == json ) || ( nil == rootKey ) )
    {
        return NO;
    }
    
    NSDictionary                  * tabData;
    
    tabData                         = [json objectForKey: rootKey];
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
            if ( ( nil != updateKey ) && ( [updateKey length] != 0 ) )
            {
                if ( [[[configureData objectAtIndex:i] objectForKey: updateKey] isEqualToString: [infoData objectForKey: updateKey]] == NO )
                {
                    continue;
                }
                [removeObject       addObject: [configureData objectAtIndex:i]];
            }
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
    
    
    SAFE_ARC_RELEASE( removeObject );
    removeObject                    = nil;
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for i/o properties.
//  ------------------------------------------------------------------------------------------------
- ( NSString * ) _GetPrefixDirectory
{
    return prefixDirectory;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _SetPrefixDirectory:(NSString *)prefix
{
    prefixDirectory                 = prefix;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get data in Zipped file.
//  ------------------------------------------------------------------------------------------------
- ( NSData * ) _UnzipDataForKey:(NSString *)aKey
{
    if ( ( nil == aKey ) || ( nil == [self unzipDataContainer] ) || ( [[self unzipDataContainer] count] == 0 ) )
    {
        return nil;
    }
    return [[self unzipDataContainer] objectForKey: aKey];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get information data.
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
- ( void ) _RemoveInfoData:(NSArray *)infoDataList
{
    if ( ( nil == infoDataList ) || ( [infoDataList count] == 0 ) )
    {
        return;
    }
    [configureData                  removeObjectsInArray: infoDataList];
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
@implementation TDStickerLibraryUnzip

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init
{
    //  ※ 這邊這個 [super init] 其實在宣告的地方被我用 NS_UNAVAILABLE 停止被呼叫了，可是程式還是能運作
    //    之後， release 或是其他狀況導致有問題，這邊可以嘗試回去把 super class 的 NS_UNAVAILABLE 拿掉。
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    return self;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil == prefixDirectory )
    {
        SAFE_ARC_ASSIGN_POINTER_NIL( prefixDirectory );
    }
    
    if ( nil != configureData )
    {
        [configureData              removeAllObjects];
        SAFE_ARC_RELEASE( configureData );
        configureData               = nil;
    }
    
    if ( nil != swapSource )
    {
        SAFE_ARC_RELEASE( swapSource );
        swapSource                  = nil;
    }
    
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) unzipFile:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                inZippedPath:(NSString *)prefix with:(NSString *)password
                   configure:(NSString *)rootKey
{
    NSParameterAssert( nil != filename );
    
    TDStickerLibraryUnzip         * unziper;
    BOOL                            isUpdate;
    NSString                      * filePath;
    
    isUpdate                        = NO;
    filePath                        = [[self class] _GetZippedFileFullPath: filename forDirectories: directory inDirectory: subpath isUpdate: &isUpdate];
    if ( nil == filePath )
    {
        NSLog( @"file %s no exist.", [filePath UTF8String] );
        return NO;
    }
    
    unziper                         = [[self class] zippedFileEnvironment: filePath with: password onSingleton: NO];
    if ( nil == unziper )
    {
        return nil;
    }
    
    if ( YES == isUpdate )
    {
        filename                    = [filename stringByDeletingPathExtension];
    }
    
    [unziper                        _SetPrefixDirectory: ( ( nil == prefix ) ? @"" : prefix ) ];
    if ( [unziper _GetConfigureJsonData: filename configure: rootKey with: nil] == NO )
    {
        NSLog( @"get configure data has warning. ");
        return unziper;
    }
    
    return unziper;
}

//  ------------------------------------------------------------------------------------------------
+( instancetype ) unzipFile:(NSString *)fullPath
               inZippedPath:(NSString *)prefix with:(NSString *)password
                  configure:(NSString *)rootKey
{
    NSParameterAssert( nil != fullPath );
    
    TDStickerLibraryUnzip         * unziper;
    NSString                      * filename;
    NSArray                       * fileSeparated;
    
    filename                        = [fullPath lastPathComponent];
    fileSeparated                   = [filename componentsSeparatedByString: @"."];
    if ( ( [fileSeparated count] >= 2 ) && ( [[filename pathExtension] isNumeric] == YES ) )
    {
        filename                    = [filename stringByDeletingPathExtension];
    }
    
    unziper                         = [[self class] zippedFileEnvironment: fullPath with: password onSingleton: NO];
    if ( nil == unziper )
    {
        return nil;
    }
    [unziper                        _SetPrefixDirectory: ( ( nil == prefix ) ? @"" : prefix ) ];
    
    if ( [unziper _GetConfigureJsonData: filename configure: rootKey with: nil] == NO )
    {
        NSLog( @"get configure data has warning. ");
        return unziper;
    }

    return unziper;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for update this object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                inZippedPath:(NSString *)prefix with:(NSString *)password
                   configure:(NSString *)rootKey with:(NSString *)updateKey

{
    NSParameterAssert( nil != filename );
    
    BOOL                            isUpdate;
    NSString                      * filePath;
    
    isUpdate                        = NO;
    filePath                        = [[self class] _GetZippedFileFullPath: filename forDirectories: directory inDirectory: subpath isUpdate: &isUpdate];
    if ( nil == filePath )
    {
        NSLog( @"file %s no exist.", [filePath UTF8String] );
        return NO;
    }
    
    if ( [self updateZippedFileContainer: filePath with: password] == NO )
    {
        NSLog( @"update zipped file container failed." );
        return NO;
    }
    [self                           _SetPrefixDirectory: ( ( nil == prefix ) ? @"" : prefix ) ];
    
    if ( YES == isUpdate )
    {
        filename                    = [filename stringByDeletingPathExtension];
    }
    
    if ( [self _GetConfigureJsonData: filename configure: rootKey with: updateKey] == NO )
    {
        NSLog( @"get configure data has warning. ");
        return NO;
    }
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get data in Zipped file.
//  ------------------------------------------------------------------------------------------------
- ( NSData * ) unzipDataForKey:(NSString *)aKey
{
    return [self _UnzipDataForKey: aKey];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for special i/o information data.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) swapInfoDataWithIndex:(NSInteger)index
{
    if ( ( 0 > index ) || ( nil == configureData ) || ( [configureData count] == 0 ) )
    {
        return NO;
    }
    
    id                              infoData;
    
    infoData                        = [configureData objectAtIndex: index];
    if ( nil == infoData )
    {
        return NO;
    }
    
    swapSource                      = configureData;
    configureData                   = [NSMutableArray arrayWithObjects: infoData, nil] ;
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) reverseInfoData
{
    if ( nil == swapSource )
    {
        return NO;
    }
    
    configureData                   = swapSource;
    swapSource                      = nil;
    return YES;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get information data.
//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) infoDataAtIndex:(NSInteger)index
{
    return [self _GetInfoDataAtIndex: index];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) removeInfoData:(NSArray *)infoDataList
{
    return [self _RemoveInfoData: infoDataList];
}

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
- ( NSString * ) infoDataAtIndex:(NSInteger)index stringValueForKey:(NSString *)aKey
{
    NSDictionary                  * infoData;
    NSString                      * string;
    
    string                          = nil;
    infoData                        = [self infoDataAtIndex: index];
    if ( nil == infoData )
    {
        return nil;
    }
    
    string                          = [infoData objectForKey: aKey];
    if ( ( nil == string ) || ( [string length] == 0 ) )
    {
        return nil;
    }
    return string;
}

//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) infoDataAtIndex:(NSInteger)index integerValueForKey:(NSString *)aKey
{
    NSString                      * string;
    
    string                          = [self infoDataAtIndex: index stringValueForKey: aKey];
    if ( nil == string )
    {
        return -1;
    }
    return [string integerValue];
}


//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------















