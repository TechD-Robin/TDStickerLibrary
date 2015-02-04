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

#import "TDStickerLibraryUnzip.h"


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryUnzip

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  declare property for private category()
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
#pragma mark declare property ()
@interface TDStickerLibraryUnzip()
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
@interface TDStickerLibraryUnzip(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------

- ( BOOL ) _UnzipProcedure:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
              inZippedPath:(NSString*)prefix with:(NSString *)password
                 configure:(NSString *)rootKey with:(NSString *)updateKey;
- ( BOOL ) _UnZipConfigureFile:(NSString *)filename with:(NSString *)password;
- ( BOOL ) _GetConfigureJsonData:(NSString *)filename configure:(NSString *)rootKey with:(NSString *)updateKey;
- ( BOOL ) _ParseJsonStruct:(NSMutableDictionary *)json  configure:(NSString *)rootKey with:(NSString *)updateKey;

//  ------------------------------------------------------------------------------------------------
- ( NSData * ) _UnzipDataForKey:(NSString *)aKey;
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
@implementation TDStickerLibraryUnzip(Private)

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
- ( BOOL ) _UnzipProcedure:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
              inZippedPath:(NSString*)prefix with:(NSString *)password
                 configure:(NSString *)rootKey with:(NSString *)updateKey
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
    
    if ( [self _GetConfigureJsonData: filename configure: rootKey with: updateKey] == NO )
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
- ( BOOL ) _GetConfigureJsonData:(NSString *)filename configure:(NSString *)rootKey with:(NSString *)updateKey
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
    
    if ( [self _ParseJsonStruct: (NSMutableDictionary *)json configure: rootKey with: updateKey] == NO )
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
    
    
    
    
    SAFE_ARC_RELEASE( removeIndex );
    SAFE_ARC_ASSIGN_POINTER_NIL( removeIndex );
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( NSData * ) _UnzipDataForKey:(NSString *)aKey
{
    if ( ( nil == aKey ) || ( nil == unzipDataContainer ) || ( [unzipDataContainer count] == 0 ) )
    {
        return nil;
    }
    return [unzipDataContainer objectForKey: aKey];
}

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

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  public method implementation.
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public method
@implementation TDStickerLibraryUnzip

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init
{
    return [self initWithZipFile: nil forDirectories: TDTemporaryDirectory inDirectory: nil inZippedPath: nil with: nil configure: nil];
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
- ( instancetype ) initWithZipFile:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                      inZippedPath:(NSString*)prefix with:(NSString *)password
                         configure:(NSString *)rootKey;
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    if ( [self _UnzipProcedure: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: password configure: rootKey with: nil] == NO )
    {
        SAFE_ARC_RELEASE( self );
        SAFE_ARC_ASSIGN_POINTER_NIL( self );
        return nil;
    }
    
    return self;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateDataFromZip:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                inZippedPath:(NSString *)prefix with:(NSString *)password
                   configure:(NSString *)rootKey with:(NSString *)updateKey

{
    return [self _UnzipProcedure: filename forDirectories: directory inDirectory: subpath inZippedPath: prefix with: password configure: rootKey with: updateKey];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( NSData * ) unzipDataForKey:(NSString *)aKey
{
    return [self _UnzipDataForKey: aKey];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) infoDataAtIndex:(NSInteger)index
{
    if ( ( 0 > index ) || ( nil == configureData ) || ( [configureData count] == 0 ) )
    {
        return nil;
    }
    return [configureData objectAtIndex: index];
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


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------















