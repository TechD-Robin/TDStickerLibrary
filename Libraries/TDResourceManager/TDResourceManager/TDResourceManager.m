//
//  TDResourceManager.m
//  TDResourceManager
//
//  Created by Robin Hsu on 2015/4/25.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "TDResourceManager.h"
#import "Foundation+TechD.h"
#import "ZipArchive.h"


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDResourceManager

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
@interface TDResourceManager ()
{
    /**
     *  the resource type of current.
     */
    TDResourceManageSourceType      currentSourceType;
    
    /**
     *  flags of state.
     */
    struct {
        unsigned int                initiatedDefault:1;             //  set it when default be initiated.
        unsigned int                initiatedAssetsBundle:1;        //  set it when assets bundle be initiated.
        unsigned int                initiatedInZipped:1;            //  set it when zipped be initiated.
        
    } stateFlags;
    
    
    //  default.
    /**
     *  the enumeration for directory.
     */
    TDGetPathDirectory              defaultResourceDirectory;
    
    
    //  asset bundle.
    /**
     *  the table name of localized string.
     */
    NSString                      * localizedStringTableName;
    
    /**
     *  the localization identifier.
     */
    NSString                      * assetLocalizationName;
    
    /**
     *  the assets boundle object.
     */
    NSBundle                      * assetsBundle;
    

    //  zipped.
    /**
     *  the container of unzipped's data.
     */
    NSMutableDictionary           * unzipDataContainer;
    
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
@interface TDResourceManager (Private)

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
 *  @brief check the type of manager have be initiated or not.
 *  check the type of manager  have be initiated or not.
 *
 *  @param sourceType               resource type.
 *
 *  @return YES|NO                  the type be initiated or not.
 */
- ( BOOL ) _CheckInitiatedState:(TDResourceManageSourceType)sourceType;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for load procedure.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief procedure of unzip file.
 *  procedure of unzip file.
 *
 *  @param fullPath                 zipped file name (full path).
 *  @param password                 password of zipped file.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _UnzipFile:(NSString *)fullPath with:(NSString *)password;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get resource full path in resource manager.
 *  get resource full path in resource manager.
 *
 *  @param name                     resource's file name.
 *  @param ext                      file name's extension
 *  @param subpath                  sub path.
 *  @param checkFileExist           use this method to check file exist or not.
 *
 *  @return full path|nil           the file's full path or nil.
 */
- ( NSString * ) _GetResourcePath:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath withCheck:(BOOL)checkFileExist;

//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDResourceManager (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( void ) _InitAttributes
{
    currentSourceType               = TDResourceManageSourceTypeDefault;
    
    //  default.
    defaultResourceDirectory        = TDHomeDirectory;
    
    
    //  asset bundle.
    localizedStringTableName        = nil;
    assetLocalizationName           = nil;
    assetsBundle                    = nil;
    
    
    //  zipped.
    unzipDataContainer              = nil;
    
    
    //  flags of state.
    stateFlags.initiatedDefault     = NO;
    stateFlags.initiatedAssetsBundle= NO;
    stateFlags.initiatedInZipped    = NO;
    
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for check.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CheckInitiatedState:(TDResourceManageSourceType)sourceType
{
    switch ( sourceType )
    {
        case TDResourceManageSourceTypeDefault:
        {
            return (BOOL)stateFlags.initiatedDefault;
        }
        case TDResourceManageSourceTypeInAssetsBundle:
        {
            return (BOOL)stateFlags.initiatedAssetsBundle;
        }
        case TDResourceManageSourceTypeInZipped:
        {
            return (BOOL)stateFlags.initiatedInZipped;
        }
        default:
            break;
    }
    return NO;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for load procedure.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _UnzipFile:(NSString *)fullPath with:(NSString *)password
{
    NSParameterAssert( fullPath );
    
    BOOL                            result;
    ZipArchive                    * zip;
    NSDictionary                  * unzipData;
    
    result                          = NO;
    unzipData                       = nil;
    zip                             = [[ZipArchive alloc] init];
    NSParameterAssert( nil != zip );
    
    if ( nil == password )
    {
        result                      = [zip UnzipOpenFile: fullPath];
    }
    else
    {
        result                      = [zip UnzipOpenFile: fullPath Password: password];
    }
    
    if ( result == NO )
    {
        NSLog( @"cannot open zip file %s.", __FUNCTION__ );
        [zip                        UnzipCloseFile];
        return NO;
    }
    
    unzipData                       = [zip UnzipFileToMemory];
    if ( nil == unzipData )
    {
        NSLog( @"cannot unzip file to memory");
        [zip                        UnzipCloseFile];
        return NO;
    }
    
    if ( nil == unzipDataContainer )
    {
        unzipDataContainer          = [[NSMutableDictionary alloc] initWithDictionary: unzipData copyItems: YES];
    }
    else
    {
        [unzipDataContainer         addEntriesFromDictionary: unzipData];
    }
    
    [zip                            UnzipCloseFile];
    
    SAFE_ARC_RELEASE( unzipData );
    unzipData                       = nil;
    
    SAFE_ARC_RELEASE( zip );
    zip                             = nil;
    return YES;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get.
//  ------------------------------------------------------------------------------------------------
- ( NSString * ) _GetResourcePath:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath withCheck:(BOOL)checkFileExist
{
    NSParameterAssert( nil != name );
    
    NSString                      * fullPath;
    
    fullPath                        = nil;
    switch ( currentSourceType )
    {
        case TDResourceManageSourceTypeDefault:
        {
            fullPath                = TDGetPathForDirectories( defaultResourceDirectory, name, ext, subpath, checkFileExist );
            break;
        }
        case TDResourceManageSourceTypeInAssetsBundle:
        {
            NSParameterAssert( nil != assetsBundle );
            if ( nil != subpath )
            {
                name                = [subpath stringByAppendingPathComponent: name];
            }
            fullPath                = [[assetsBundle bundlePath] stringByAppendingPathComponent: name];
            
            if ( nil != ext )
            {
                fullPath            = [fullPath stringByAppendingPathExtension: ext];
            }
            break;
        }
        case TDResourceManageSourceTypeInZipped:
        {
            fullPath                = ( ( nil != ext ) ? [name stringByAppendingPathExtension: ext] : name );
            if ( nil != subpath )
            {
                fullPath            = [subpath stringByAppendingPathComponent: fullPath];
            }
            break;
        }
        default:
            break;
    }
    return fullPath;
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
@implementation TDResourceManager


//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.

//  ------------------------------------------------------------------------------------------------
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
    
    [self                           _InitAttributes];
    return self;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != localizedStringTableName )
    {
        localizedStringTableName    = nil;
    }
    
    if ( nil != assetLocalizationName )
    {
        assetLocalizationName       = nil;
    }
    
    if ( nil != assetsBundle )
    {
        assetsBundle                = nil;
    }
    
    if ( nil != unzipDataContainer )
    {
        [unzipDataContainer         removeAllObjects];
        SAFE_ARC_RELEASE( unzipDataContainer );
        unzipDataContainer          = nil;
    }
    SAFE_ARC_SUPER_DEALLOC();
}

////  ------------------------------------------------------------------------------------------------
//- ( void ) dealloc
//{
//    NSLog( @"" );
//}
//
//- ( void ) Release
//{
////    [super                          Release];
//    if ( nil != _defaultManager )
//    {
//        SAFE_ARC_RELEASE( _defaultManager );
////        _defaultManager             = nil;
//    }
//}
//

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
+ (instancetype) defaultManager
{
    static TDResourceManager      * _defaultManager = nil;
    static dispatch_once_t          oneToken;
    
    dispatch_once( &oneToken, ^
    {
        _defaultManager             = [[self alloc] init];
        if ( [NSStringFromClass( [_defaultManager class] ) isEqualToString: @"TDResourceManager"] == NO )
        {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason: [NSString stringWithFormat:@"%s must be overridden in a subclass/category",
                                                                                      __PRETTY_FUNCTION__] userInfo:nil];
        }
        
    });
    return _defaultManager;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) initDefaultEnvironment:(TDGetPathDirectory)directory
{
    defaultResourceDirectory        = directory;
    
    //  ... set flag default to yes.
    currentSourceType               = TDResourceManageSourceTypeDefault;
    stateFlags.initiatedDefault     = YES;
    return YES;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) defaultEnvironment:(TDGetPathDirectory)directory onSingleton:(BOOL)singleton
{
    TDResourceManager             * manager;
    
    manager                         = ( ( YES == singleton ) ? [[self class] defaultManager] : [[self  alloc] init] );
    NSParameterAssert( nil != manager );
    
    if ( [manager initDefaultEnvironment: directory] == NO )
    {
        return nil;
    }
    return manager;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) initAssetsBundleEnvironment:(NSString *)bundleName with:(Class)aClass forLocalization:(NSString *)localizationName
{
    NSParameterAssert( nil != bundleName );
    NSParameterAssert( nil != aClass );
    
    assetsBundle                    = [NSBundle assetBundle: bundleName with: aClass];
    NSParameterAssert( nil != assetsBundle );
    
    currentSourceType               = TDResourceManageSourceTypeInAssetsBundle;
    assetLocalizationName           = localizationName;
    stateFlags.initiatedAssetsBundle= YES;
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) assetsBundleEnvironment:(NSString *)bundleName with:(Class)aClass onSingleton:(BOOL)singleton
{
    return [[self class] assetsBundleEnvironment: bundleName with: aClass forLocalization: nil onSingleton: singleton];
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) assetsBundleEnvironment:(NSString *)bundleName with:(Class)aClass forLocalization:(NSString *)localizationName onSingleton:(BOOL)singleton
{
    TDResourceManager             * manager;
    
    manager                         = ( ( YES == singleton ) ? [[self class] defaultManager] : [[self  alloc] init] );
    NSParameterAssert( nil != manager );
    if ( [manager initAssetsBundleEnvironment: bundleName with: aClass forLocalization: localizationName] == NO )
    {
        return nil;
    }
    return manager;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) initZippedFileEnvironment:(NSString *)fullPathName with:(NSString *)password
{
    NSParameterAssert( nil != fullPathName );
    
    BOOL                            result;
    
    result                          = NO;
    result                          = [self _UnzipFile: fullPathName with: password];
    if ( NO == result )
    {
        return NO;
    }
    currentSourceType               = TDResourceManageSourceTypeInZipped;
    stateFlags.initiatedInZipped    = YES;
    return YES;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) zippedFileEnvironment:(NSString *)fullPathName with:(NSString *)password onSingleton:(BOOL)singleton
{
    TDResourceManager             * manager;
    
    manager                         = ( ( YES == singleton ) ? [[self class] defaultManager] : [[self  alloc] init] );
    NSParameterAssert( nil != manager );
    if ( [manager initZippedFileEnvironment: fullPathName with: password] == NO )
    {
        return nil;
    }
    return manager;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for change data source.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) changeDirectory:(TDGetPathDirectory)directory
{
    if ( YES == stateFlags.initiatedDefault )
    {
        stateFlags.initiatedDefault = NO;
    }
    return [self initDefaultEnvironment: directory];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) changeAssetsBundle:(NSString *)bundleName with:(Class)aClass
{
    return [self changeAssetsBundle: bundleName with: aClass forLocalization: nil];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) changeAssetsBundle:(NSString *)bundleName with:(Class)aClass forLocalization:(NSString *)localizationName
{
    if ( YES == stateFlags.initiatedAssetsBundle )
    {
        if ( nil != assetsBundle )
        {
            SAFE_ARC_RELEASE( assetsBundle )
            assetsBundle            = nil;
        }
        stateFlags.initiatedAssetsBundle = NO;
    }
    return [self initAssetsBundleEnvironment: bundleName with: aClass forLocalization: localizationName];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) changeZippedFile:(NSString *)fullPathName with:(NSString *)password
{
    if ( YES == stateFlags.initiatedInZipped )
    {
        if ( nil != unzipDataContainer )
        {
            [unzipDataContainer     removeAllObjects];
            SAFE_ARC_RELEASE( unzipDataContainer );
            unzipDataContainer      = nil;
        }
        stateFlags.initiatedInZipped= NO;
    }
    return [self initZippedFileEnvironment: fullPathName with: password];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get resource data.
//  ------------------------------------------------------------------------------------------------
- ( NSData * ) data:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath
{
    return [self data: name ofType: ext inDirectory: subpath fromData: currentSourceType];
}

//  ------------------------------------------------------------------------------------------------
- ( NSData * ) data:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath fromData:(TDResourceManageSourceType)sourceType
{
    NSParameterAssert( nil != name );
    NSParameterAssert( YES == [self _CheckInitiatedState: sourceType] );
    
    NSData                        * data;
    NSString                      * fullPath;
    
    data                            = nil;
    currentSourceType               = sourceType;
    fullPath                        = [self _GetResourcePath: name ofType: ext inDirectory: subpath withCheck: YES];
    NSParameterAssert( nil != fullPath );
    
    switch ( sourceType )
    {
        case TDResourceManageSourceTypeDefault:
        case TDResourceManageSourceTypeInAssetsBundle:
        {
            data                    = [NSData dataWithContentsOfFile: fullPath];
            break;
        }
        case TDResourceManageSourceTypeInZipped:
        {
            data                    = [unzipDataContainer objectForKey: fullPath];
            break;
        }
        default:
            break;
    }
    return data;
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) image:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath
{
    return [self image: name ofType: ext inDirectory: subpath fromData: currentSourceType];
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) image:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath fromData:(TDResourceManageSourceType)sourceType
{
    NSParameterAssert( nil != name );
    NSParameterAssert( YES == [self _CheckInitiatedState: sourceType] );
    
    UIImage                       * image;
    NSString                      * fullPath;
    
    image                           = nil;
    currentSourceType               = sourceType;
    fullPath                        = [self _GetResourcePath: name ofType: ext inDirectory: subpath withCheck: NO];
    NSParameterAssert( nil != fullPath );
    
    switch ( sourceType )
    {
        case TDResourceManageSourceTypeDefault:
        case TDResourceManageSourceTypeInAssetsBundle:
        {
            image                   = [UIImage imageWithContentsOfFile: fullPath];
            //  above the method cannot get the image object at iOS 7.1, but at iOS 8.1 is OK.
            //  so, re-get image from below.
            if ( nil == image )
            {
                if ( ( nil == ext ) || ( [ext length] == 0 ) )
                {
                    ext             = @"png";
                }
                if ( TDCheckFilenameWithAssetScale( name ) == NO )
                {
                    name            = TDGetFilenameWithAssetScale( name, (int)[[UIScreen mainScreen] scale] );
                }
                fullPath            = [self _GetResourcePath: name ofType: ext inDirectory: subpath withCheck: NO];
                NSParameterAssert( nil != fullPath );
                image               = [UIImage imageWithContentsOfFile: fullPath];
            }
            break;
        }
        case TDResourceManageSourceTypeInZipped:
        {
            NSData                * data;
            
            data                    = [unzipDataContainer objectForKey: fullPath];
            if ( nil == data )
            {
                if ( nil == ext )
                {
                    ext             = @"png";
                }
                
                if ( TDCheckFilenameWithAssetScale( name ) == NO )
                {
                    name            = TDGetFilenameWithAssetScale( name, (int)[[UIScreen mainScreen] scale] );
                }
                fullPath            = [self _GetResourcePath: name ofType: ext inDirectory: subpath withCheck: NO];
                NSParameterAssert( nil != fullPath );
                
                data                    = [unzipDataContainer objectForKey: fullPath];
                if ( nil == data )
                {
                    return nil;
                }
            }
            image                   = [UIImage imageWithData: data];
            break;
        }
        default:
            break;
    }
    return image;
}

//  ------------------------------------------------------------------------------------------------
- ( id ) JSON:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath encoding:(NSStringEncoding)encode
{
    return [self JSON: name ofType: ext inDirectory: subpath encoding: encode fromData: currentSourceType];
}

//  ------------------------------------------------------------------------------------------------
- ( id ) JSON:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath encoding:(NSStringEncoding)encode
                        fromData:(TDResourceManageSourceType)sourceType
{
    NSParameterAssert( nil != name );
    NSParameterAssert( YES == [self _CheckInitiatedState: sourceType] );
    
    id                              dataContainer;
    NSError                       * error;
    NSString                      * fullPath;
    
    error                           = nil;
    dataContainer                   = nil;
    currentSourceType               = sourceType;
    fullPath                        = [self _GetResourcePath: name ofType: ext inDirectory: subpath withCheck: YES];
    NSParameterAssert( nil != fullPath );
    
    switch ( sourceType )
    {
        case TDResourceManageSourceTypeDefault:
        case TDResourceManageSourceTypeInAssetsBundle:
        {
            
            dataContainer           = [NSJSONSerialization loadJSON: fullPath encoding: encode error: &error];
            if ( nil != error )
            {
                NSLog( @"load JSON error :%@", error );
                return nil;
            }
            break;
        }
        case TDResourceManageSourceTypeInZipped:
        {
            NSData                * data;
            
            data                    = [unzipDataContainer objectForKey: fullPath];
            if ( nil == data )
            {
                return nil;
            }
            
            error                   = nil;
            dataContainer           = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &error];
            if ( nil != error )
            {
                NSLog( @"create JSON object form data has error :%@", error );
                return nil;
            }
            break;
        }
        default:
            break;
    }
    return dataContainer;
}

//  ------------------------------------------------------------------------------------------------
- ( NSMutableDictionary * ) propertyList:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath encoding:(NSStringEncoding)encode
{
    return [self propertyList: name ofType: ext inDirectory: subpath encoding: encode fromData: currentSourceType];
}

//  ------------------------------------------------------------------------------------------------
- ( NSMutableDictionary * ) propertyList:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath encoding:(NSStringEncoding)encode
                                fromData:(TDResourceManageSourceType)sourceType
{
    NSParameterAssert( nil != name );
    NSParameterAssert( YES == [self _CheckInitiatedState: sourceType] );
    
    NSMutableDictionary           * plistContainer;
    NSError                       * error;
    NSString                      * fullPath;
    
    error                           = nil;
    plistContainer                  = nil;
    currentSourceType               = sourceType;
    fullPath                        = [self _GetResourcePath: name ofType: ext inDirectory: subpath withCheck: YES];
    NSParameterAssert( nil != fullPath );

    switch ( sourceType )
    {
        case TDResourceManageSourceTypeDefault:
        case TDResourceManageSourceTypeInAssetsBundle:
        {
            plistContainer          = [NSPropertyListSerialization loadPropertyList: fullPath encoding: encode error: &error];
            if ( nil != error )
            {
                NSLog( @"load Property list error :%@", error );
                return nil;
            }
            break;
        }
        case TDResourceManageSourceTypeInZipped:
        {
            NSData                * data;
            NSPropertyListFormat    format;
            
            data                    = [unzipDataContainer objectForKey: fullPath];
            if ( nil == data )
            {
                return nil;
            }
            error                   = nil;
            plistContainer          = [NSPropertyListSerialization propertyListWithData: data options: NSPropertyListMutableContainersAndLeaves format: &format error: &error];
            if ( nil != error )
            {
                NSLog( @"create property list object form data has error :%@", error );
                return nil;
            }
            break;
        }
        default:
            break;
    }
    return plistContainer;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get data of assets bundle type.
//  ------------------------------------------------------------------------------------------------
- ( void ) setLocalizedStringTable:(NSString *)tableName
{
    NSParameterAssert( YES == stateFlags.initiatedAssetsBundle );
    NSParameterAssert( nil != assetsBundle );
    NSParameterAssert( nil != tableName );
    localizedStringTableName        = tableName;
    return;
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) localizedStringForKey:(NSString *)aKey
{
    NSParameterAssert( nil != aKey );
    NSParameterAssert( YES == stateFlags.initiatedAssetsBundle );
    NSParameterAssert( nil != assetsBundle );
    NSParameterAssert( nil != localizedStringTableName );
    return NSLocalizedStringFromTableInBundle( aKey,  localizedStringTableName, assetsBundle,  nil );
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get data of zipped file type.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateZippedFileContainer:(NSString *)fullPathName with:(NSString *)password
{
    return [self _UnzipFile: fullPathName with: password];
}

//  ------------------------------------------------------------------------------------------------
- ( NSMutableDictionary * ) unzipDataContainer
{
    return unzipDataContainer;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get properties of object.
//  ------------------------------------------------------------------------------------------------
- ( TDResourceManageSourceType ) currentEnvironment
{
    return currentSourceType;
}

//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------









