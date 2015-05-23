//
//  TDConfigureData.m
//  TDResourceManager
//
//  Created by Robin Hsu on 2015/5/20.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "Foundation+TechD.h"
#import "TDConfigureData.h"


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDConfigureData

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDConfigureData ()
{
    /**
     *  prefix path name in zipped file.
     */
    NSString                      * prefixDirectory;
    
    /**
     *  character set encode of configure file.
     */
    NSStringEncoding                configureFileEncode;
    
    /**
     *  the container of configure data.
     */
    //NSMutableDictionary           * configureData;      //  json struct.
    NSMutableArray                * configureData;      //  json struct.
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
@interface TDConfigureData (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for check.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check a filename is format of update file or not.
 *  check a filename is format of update file or not.
 *
 *  @param filename                 a filename for check.
 *
 *  @return YES|NO                  is update format or not.
 */
+ ( BOOL ) _IsUpdateFileName:(NSString *)filename;

////  ------------------------------------------------------------------------------------------------
///**
// *  @brief get a file's full path with check the state of update.
// *  get a file's full path with check the state of update.
// *
// *  @param filename                 file name (without Extension part).
// *  @param extension                extension port of filename.(sub filename)
// *  @param directory                enumeration for directory.
// *  @param subpath                  resource's sub directory name of configure
// *  @param updateFile               pointer of extensioin result of method, to express file exist is update or default.
// *
// *  @return full path|nil           the file's full path or nil.
// */
//+ ( NSString *) _GetFileFullPath:(NSString *)filename extension:(NSString *)extension
//                  forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
//                        isUpdate:(BOOL *)updateFile;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for json data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a configure data from in unzipped object's data source file.
 *  get a configure data from in unzipped object's data source file.
 *
 *  @param filename                 configure file name (without Extension part).
 *  @param fileType                 data source type of file.
 *  @param rootKey                  key of root of configure file.
 *  @param updateKey                key for update data.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _GetConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType
                   configure:(NSString *)rootKey with:(NSString *)updateKey;

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
- ( BOOL ) _ParseJsonStruct:(NSMutableDictionary *)json configure:(NSString *)rootKey with:(NSString *)updateKey;

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
/**
 *  @brief get character set encode of configure file.
 *  get character set encode of configure file.
 *
 *  @return                         character set encode.
 */
- ( NSStringEncoding ) _GetConfigureFileEncode;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set the character set encode of configure file.
 *  set the character set encode of configure file.
 *
 *  @param encode                   character set encode.
 */
- ( void ) _SetConfigureFileEncode:(NSStringEncoding)encode;

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDConfigureData (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    prefixDirectory                 = nil;

    configureFileEncode             = NSASCIIStringEncoding;
    
    configureData                   = nil;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for check.
//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) _IsUpdateFileName:(NSString *)filename
{
    if ( nil == filename )
    {
        return NO;
    }
    
    NSArray                       * fileSeparated;
    
    fileSeparated                   = [filename componentsSeparatedByString: @"."];
    //  check file name for appended timpstamp.
    if ( ( [fileSeparated count] >= 2 ) && ( [[filename pathExtension] isNumeric] == YES ) )
    {
        return YES;
    }
    return NO;
}

////  ------------------------------------------------------------------------------------------------
//+ ( NSString *) _GetFileFullPath:(NSString *)filename extension:(NSString *)extension
//                  forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
//                        isUpdate:(BOOL *)updateFile
//{
//    NSArray                       * fileSeparated;
//    
//    fileSeparated                   = [filename componentsSeparatedByString: @"."];
//    //  check file name for appended timpstamp.
//    if ( ( [fileSeparated count] >= 2 ) && ( [[filename pathExtension] isNumeric] == YES ) )
//    {
//        if ( NULL != updateFile )
//        {
//            *updateFile             = YES;
//        }
//        extension                   = nil;
//    }
//    return TDGetPathForDirectories( directory, filename, extension, subpath, YES );
//}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for json data.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _GetConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType
                   configure:(NSString *)rootKey with:(NSString *)updateKey
{
    if ( nil == filename )
    {
        return NO;
    }
    
    NSString                      * key;
    NSString                      * extension;
    NSDictionary                  * dataContainer;
    
    extension                       = nil;
    dataContainer                   = nil;
    if ( [[self class] _IsUpdateFileName: filename] == YES )
    {
        filename                    = [filename stringByDeletingPathExtension];
    }
    
    switch ( fileType )
    {
        case TDConfigureDataSourceFileTypePList:
        {
            extension               = @"plist";
            dataContainer           = [self propertyList: filename ofType: extension inDirectory: prefixDirectory encoding: configureFileEncode];
            break;
        }
        case TDConfigureDataSourceFileTypeJSON:
        default:
        {
            extension               = @"json";
            dataContainer           = [self JSON: filename ofType: extension inDirectory: prefixDirectory encoding: configureFileEncode];
            break;
        }
    }
    
    if ( nil == dataContainer )
    {
        return NO;
    }
    
    if ( [self _ParseJsonStruct: (NSMutableDictionary *)dataContainer configure: rootKey with: updateKey] == NO )
    {
        NSLog( @"parse json warning." );
        return NO;
    }
    
    //  after get the configure, remove the data from container. (for release memory.)
    if ( [self currentEnvironment] == TDResourceManageSourceTypeInZipped )
    {
        key                         = [NSString stringWithFormat: @"%@/%@.%@", prefixDirectory, filename, extension];
        [[self                      unzipDataContainer] removeObjectForKey: key];
    }
    
    SAFE_ARC_RELEASE( dataContainer );
    dataContainer                   = nil;
    
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
    
    
    id                              idData;
    NSMutableArray                * removeObject;
    
    //  compare object when new data's key is equal older.
    if ( ( nil != updateKey ) && ( [updateKey length] != 0 ) )
    {
        removeObject                = [[NSMutableArray alloc] initWithCapacity: [configureData count]];
        for ( int i = 0; i < [configureData count]; ++i )
        {
            for ( NSDictionary * infoData in tabData )
            {
                if ( nil == infoData )
                {
                    continue;
                }
                
                //  compare.
                idData              = [configureData objectAtIndex:i];
                if ( ( nil == idData ) || ( [idData isKindOfClass: [NSDictionary class]] == NO ) || ( [idData objectForKey: updateKey] == nil ) || ( [infoData objectForKey: updateKey] == nil ) )
                {
                    continue;
                }
                if ( [[[configureData objectAtIndex:i] objectForKey: updateKey] isEqualToString: [infoData objectForKey: updateKey]] == NO )
                {
                    continue;
                }
                [removeObject       addObject: [configureData objectAtIndex:i]];
            }
        }
    }
    
    //  remove from contaner on here.
    if ( nil != removeObject )
    {
        for ( int i = 0; i < [removeObject count]; ++i )
        {
            [configureData          removeObject: [removeObject objectAtIndex: i]];
        }
    }
    
    //  replace all data.
    if ( ( ( nil == updateKey ) || ( [updateKey length] == 0 ) ) && ( ( [configureData count] != 0 ) && ( [tabData count] != 0 ) ) )
    {
        [configureData              removeAllObjects];
    }
    
    //  finish, insert into container.
    //[configureData                  addEntriesFromDictionary: tabData];
    [configureData                  addObjectsFromArray: (NSArray *)tabData];
    
    
    if ( nil != removeObject )
    {
        SAFE_ARC_RELEASE( removeObject );
        removeObject                = nil;
    }
    
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
- ( NSStringEncoding ) _GetConfigureFileEncode
{
    return configureFileEncode;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _SetConfigureFileEncode:(NSStringEncoding)encode
{
    configureFileEncode             = encode;
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
@implementation TDConfigureData

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init
{
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
    
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
//  * override this parent method for create a singleton object.
+ (instancetype) defaultManager
{
    static TDConfigureData        * _defaultManager = nil;
    static dispatch_once_t          oneToken;
    
    dispatch_once( &oneToken, ^
    {
        _defaultManager             = [[self alloc] init];
    });
    return _defaultManager;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType encoding:(NSStringEncoding)encode
                       withConfigure:(NSString *)rootKey
                                from:(TDGetPathDirectory)defaultDirectory inDirectory:(NSString *)subpath onSingleton:(BOOL)singleton
{
    NSParameterAssert( nil != filename );
    
    TDConfigureData               * configureData;
    
    
    configureData                   = [[self class] defaultEnvironment: defaultDirectory onSingleton: singleton];
    NSParameterAssert( nil != configureData );
    
    [configureData                  _SetConfigureFileEncode: encode];
    [configureData                  _SetPrefixDirectory: ( ( nil == subpath ) ? @"" : subpath ) ];
    if ( [configureData _GetConfigureData: filename type: fileType configure: rootKey with: nil] == NO )
    {
        NSLog( @"get configure data has warning. ");
        return configureData;
    }
    
    return configureData;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType encoding:(NSStringEncoding)encode
                       withConfigure:(NSString *)rootKey
                                from:(NSString *)assetsBundleName with:(Class)aClass
                         inDirectory:(NSString *)subpath onSingleton:(BOOL)singleton
{
    NSParameterAssert( nil != filename );
    NSParameterAssert( nil != assetsBundleName );
    NSParameterAssert( nil != aClass );
    
    TDConfigureData               * configureData;
    
    configureData                   = [[self class] assetsBundleEnvironment: assetsBundleName with: aClass onSingleton: singleton];
    NSParameterAssert( nil != configureData );
    
    [configureData                  _SetConfigureFileEncode: encode];
    [configureData                  _SetPrefixDirectory: ( ( nil == subpath ) ? @"" : subpath ) ];
    if ( [configureData _GetConfigureData: filename type: fileType configure: rootKey with: nil] == NO )
    
    {
        NSLog( @"get configure data has warning. ");
        return configureData;
    }
    
    return configureData;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType encoding:(NSStringEncoding)encode
                       withConfigure:(NSString *)rootKey
                                from:(NSString *)zippedFilename forDirectories:(TDGetPathDirectory)directory inDirectory:(NSString *)subpath
                        inZippedPath:(NSString *)prefix with:(NSString *)password onSingleton:(BOOL)singleton
{
    NSParameterAssert( nil != filename );
    NSParameterAssert( nil != zippedFilename );
    
    TDConfigureData               * configureData;
    NSString                      * filePath;
    
    filePath                        = TDGetPathForDirectories( directory, zippedFilename, @"zip", subpath, YES );
    if ( nil == filePath )
    {
        NSLog( @"file %s no exist.", [filePath UTF8String] );
        return nil;
    }
    
    configureData                   = [[self class] zippedFileEnvironment: filePath with: password onSingleton: singleton];
    if ( nil == configureData )
    {
        return nil;
    }
    
    [configureData                  _SetConfigureFileEncode: encode];
    [configureData                  _SetPrefixDirectory: ( ( nil == prefix ) ? @"" : prefix ) ];
    if ( [configureData _GetConfigureData: filename type: fileType configure: rootKey with: nil] == NO )
    {
        NSLog( @"get configure data has warning. ");
        return configureData;
    }
    
    return configureData;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType encoding:(NSStringEncoding)encode
                       withConfigure:(NSString *)rootKey
                                from:(NSString *)zippedFullPath
                        inZippedPath:(NSString *)prefix with:(NSString *)password onSingleton:(BOOL)singleton
{
    NSParameterAssert( nil != filename );
    NSParameterAssert( nil != zippedFullPath );
    
    TDConfigureData               * configureData;
    
    configureData                   = [[self class] zippedFileEnvironment: zippedFullPath with: password onSingleton: singleton];
    if ( nil == configureData )
    {
        return nil;
    }
    
    [configureData                  _SetConfigureFileEncode: encode];
    [configureData                  _SetPrefixDirectory: ( ( nil == prefix ) ? @"" : prefix ) ];
    if ( [configureData _GetConfigureData: filename type: fileType configure: rootKey with: nil] == NO )
    {
        NSLog( @"get configure data has warning. ");
        return configureData;
    }
    
    return configureData;
}

//  --------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method for update the object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType encoding:(NSStringEncoding)encode
                 withConfigure:(NSString *)rootKey and:(NSString *)updateKey
                          from:(TDGetPathDirectory)defaultDirectory inDirectory:(NSString *)subpath
{
    NSParameterAssert( nil != filename );
    
    
    if ( [self changeDirectory: defaultDirectory] == NO )
    {
        NSLog( @"update configure data have error of change Directory." );
        return NO;
    }
    
    [self                           _SetConfigureFileEncode: encode];
    [self                           _SetPrefixDirectory: ( ( nil == subpath ) ? @"" : subpath ) ];
    if ( [self _GetConfigureData: filename type: fileType configure: rootKey with: updateKey] == NO )
    {
        NSLog( @"get configure data has warning. ");
        return NO;
    }
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType encoding:(NSStringEncoding)encode
                 withConfigure:(NSString *)rootKey and:(NSString *)updateKey
                          from:(NSString *)assetsBundleName with:(Class)aClass inDirectory:(NSString *)subpath
{
    NSParameterAssert( nil != filename );
    NSParameterAssert( nil != assetsBundleName );
    NSParameterAssert( nil != aClass );

    if ( [self changeAssetsBundle: assetsBundleName with: aClass] == NO )
    {
        NSLog( @"update configure data have error of change Assets Bundle." );
        return NO;
    }
    
    
    [self                           _SetConfigureFileEncode: encode];
    [self                           _SetPrefixDirectory: ( ( nil == subpath ) ? @"" : subpath ) ];
    if ( [self _GetConfigureData: filename type: fileType configure: rootKey with: updateKey] == NO )
    {
        NSLog( @"get configure data has warning. ");
        return NO;
    }
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType encoding:(NSStringEncoding)encode
                 withConfigure:(NSString *)rootKey and:(NSString *)updateKey
                          from:(NSString *)zippedFilename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                  inZippedPath:(NSString *)prefix with:(NSString *)password
{
    NSParameterAssert( nil != filename );
    NSParameterAssert( nil != zippedFilename );

    NSString                      * filePath;
    
    filePath                        = TDGetPathForDirectories( directory, zippedFilename, @"zip", subpath, YES );
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
    
    [self                           _SetConfigureFileEncode: encode];
    [self                           _SetPrefixDirectory: ( ( nil == prefix ) ? @"" : prefix ) ];
    if ( [self _GetConfigureData: filename type: fileType configure: rootKey with: updateKey] == NO )
    {
        NSLog( @"get configure data has warning. ");
        return NO;
    }
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType encoding:(NSStringEncoding)encode
                 withConfigure:(NSString *)rootKey and:(NSString *)updateKey
                          from:(NSString *)zippedFullPath
                  inZippedPath:(NSString *)prefix with:(NSString *)password
{
    NSParameterAssert( nil != filename );
    NSParameterAssert( nil != zippedFullPath );
    
    if ( [self updateZippedFileContainer: zippedFullPath with: password] == NO )
    {
        NSLog( @"update zipped file container failed." );
        return NO;
    }
    
    [self                           _SetConfigureFileEncode: encode];
    [self                           _SetPrefixDirectory: ( ( nil == prefix ) ? @"" : prefix ) ];
    if ( [self _GetConfigureData: filename type: fileType configure: rootKey with: updateKey] == NO )
    {
        NSLog( @"get configure data has warning. ");
        return NO;
    }
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get data container.
//  ------------------------------------------------------------------------------------------------
- ( NSMutableArray *) configureData
{
    return configureData;
}

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------















