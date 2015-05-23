//
//  TDResourceManager.h
//  TDResourceManager
//
//  Created by Robin Hsu on 2015/4/25.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TDUtilities.h"


#define TD_UNSTABLE_DEVELOPING      DEBUG

//  ------------------------------------------------------------------------------------------------
#pragma mark declare enumeration.
//  ------------------------------------------------------------------------------------------------
/**
 *  enumeration for resource manager's source type.
 */
typedef NS_ENUM( NSInteger, TDResourceManageSourceType ){
    /**
     *  resource type is defulat. ( in file system )
     */
    TDResourceManageSourceTypeDefault           = 0,
    /**
     *  resource type is assets bundle. ( in assets bundle )
     */
    // in resource path
    TDResourceManageSourceTypeInAssetsBundle,
    /**
     *  resource type is zipped file. ( in zipped file )
     */
    TDResourceManageSourceTypeInZipped,
};


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  the Resource Manager provide the same method to get resources,
 *  can get resources from resourcePath(normal file system), assets bundle object and zipped file.
 */
@interface TDResourceManager : NSObject

//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
- (instancetype)init NS_UNAVAILABLE;

//  ------------------------------------------------------------------------------------------------
//  TODO : special release in ARC mode.
//.- ( void ) Release;

//  ------------------------------------------------------------------------------------------------
// Returns the default singleton instance.
/**
 *  @brief create a singleton object of resource manager or get the created.
 *  create a singleton object of resource manager or get the created;
 *  when just use this method to create a manager object, the object will have not any type;
 *  well, this method usually call after other creator; that's easy to get the manager object by this method.
 *
 *  @return object|nil              manager object or nil.
 */
+ ( instancetype ) defaultManager;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a object of resource manager object of default type.
 *  create a object of resource manager object of default type.
 *
 *  @param directory                enumeration for directory.
 *  @param singleton                create a singleton object or normal object.
 *
 *  @return object|nil              manager object or nil.
 */
+ ( instancetype ) defaultEnvironment:(TDGetPathDirectory)directory onSingleton:(BOOL)singleton;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a object of resource manager object of assets bundle type.
 *  create a object of resource manager object of assets bundle type.
 *
 *  @param bundleName               a bundle name.
 *  @param aClass                   a class.(is view controller usually)
 *  @param singleton                create a singleton object or normal object.
 *
 *  @return object|nil              manager object or nil.
 */
+ ( instancetype ) assetsBundleEnvironment:(NSString *)bundleName with:(Class)aClass onSingleton:(BOOL)singleton;

//  ------------------------------------------------------------------------------------------------
#ifdef TD_UNSTABLE_DEVELOPING
//  TODO: unused localizationName now.
/**
 *  @brief create a object of resource manager object of assets bundle type for localization.
 *  create a object of resource manager object of assets bundle type for localization.
 *
 *  @param bundleName               a bundle name.
 *  @param aClass                   a class.(is view controller usually)
 *  @param localizationName         a locale identifier string.
 *  @param singleton                create a singleton object or normal object.
 *
 *  @return object|nil              manager object or nil.
 */
+ ( instancetype ) assetsBundleEnvironment:(NSString *)bundleName with:(Class)aClass forLocalization:(NSString *)localizationName onSingleton:(BOOL)singleton;
#endif

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a object of resource manager object of zipped file type.
 *  create a object of resource manager object of zipped file type.
 *
 *  @param fullPathName             zipped file name (full path).
 *  @param password                 password of zipped file.
 *  @param singleton                create a singleton object or normal object.
 *
 *  @return object|nil              manager object or nil.
 */
+ ( instancetype ) zippedFileEnvironment:(NSString *)fullPathName with:(NSString *)password onSingleton:(BOOL)singleton;


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for change data source.
//  ------------------------------------------------------------------------------------------------
//  change method notice : if change from other type then the environment of old type will not remove, else will cover by new.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief change environment of resources manager to a new directory (default environment).
 *  change environment of resources manager to a new directory (default environment).
 *
 *  @param directory                a new enumeration for directory.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) changeDirectory:(TDGetPathDirectory)directory;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief change environment of resources manager to a new assests bundle.
 *  change environment of resources manager to a new assests bundle.
 *
 *  @param bundleName               a new bundle name.
 *  @param aClass                   a class.(is view controller usually)
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) changeAssetsBundle:(NSString *)bundleName with:(Class)aClass;

//  ------------------------------------------------------------------------------------------------
#ifdef TD_UNSTABLE_DEVELOPING
//  TODO: unused localizationName now.
/**
 *  @brief change environment of resources manager to a new assests bundle.
 *  change environment of resources manager to a new assests bundle.
 *
 *  @param bundleName               a new bundle name.
 *  @param aClass                   a class.(is view controller usually)
 *  @param localizationName         a locale identifier string.
 *
 *  @return YES|NO                  method success or failure.
 */
-
( BOOL ) changeAssetsBundle:(NSString *)bundleName with:(Class)aClass forLocalization:(NSString *)localizationName;
#endif

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief change environment of resources manager to a new zipped file.
 *  change environment of resources manager to a new zipped file;
 *  this method will clean up original file contents from the object.
 *
 *  @param fullPathName             zipped file name (full path).
 *  @param password                 password of zipped file.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) changeZippedFile:(NSString *)fullPathName with:(NSString *)password;


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get resource data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a data object by resource manager.
 *  get a data object by resource manager.
 *
 *  @param name                     filename of data.
 *  @param ext                      extension of filename
 *  @param subpath                  sub path in directory.
 *
 *  @return data|nil                data object or nil.
 */
- ( NSData * ) data:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a data object by resource manager.
 *  get a data object by resource manager.
 *
 *  @param name                     filename of data.
 *  @param ext                      extension of filename
 *  @param subpath                  sub path in directory.
 *  @param sourceType               resource type.
 *
 *  @return data|nil                data object or nil.
 */
- ( NSData * ) data:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath fromData:(TDResourceManageSourceType)sourceType;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a image object form resource manager.
 *  a image object form resource manager.
 *
 *  @param name                     filename of image.
 *  @param ext                      extension of filename
 *  @param subpath                  sub path in directory.
 *
 *  @return image|nil               image object or nil.
 */
- ( UIImage * ) image:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a image object form resource manager.
 *  a image object form resource manager.
 *
 *  @param name                     filename of image.
 *  @param ext                      extension of filename
 *  @param subpath                  sub path in directory.
 *  @param sourceType               resource type.
 *
 *  @return image|nil               image object or nil.
 */
- ( UIImage * ) image:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath fromData:(TDResourceManageSourceType)sourceType;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a JSON data by resource manager.
 *  get a JSON data by resource manager, the data container is an NSArray or NSDictionary.
 *
 *  @param name                     filename of JSON data.
 *  @param ext                      extension of filename
 *  @param subpath                  sub path in directory.
 *  @param encode                   charset encode.
 *
 *  @return container|nil           a container object or nil.
 */
- ( id ) JSON:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath encoding:(NSStringEncoding)encode;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a JSON data by resource manager.
 *  get a JSON data by resource manager, the data container is an NSArray or NSDictionary.
 *
 *  @param name                     filename of JSON data.
 *  @param ext                      extension of filename
 *  @param subpath                  sub path in directory.
 *  @param encode                   charset encode.
 *  @param sourceType               resource type.
 *
 *  @return container|nil           a container object or nil.
 */
- ( id ) JSON:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath encoding:(NSStringEncoding)encode
     fromData:(TDResourceManageSourceType)sourceType;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a property list data by resource manager.
 *  get a property list data by resource manager.
 *
 *  @param name                     filename of plist data.
 *  @param ext                      extension of filename
 *  @param subpath                  sub path in directory.
 *  @param encode                   charset encode.
 *
 *  @return container|nil           a container object or nil.
 */
- ( NSMutableDictionary * ) propertyList:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath encoding:(NSStringEncoding)encode;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a property list data by resource manager.
 *  get a property list data by resource manager.
 *
 *  @param name                     filename of plist data.
 *  @param ext                      extension of filename
 *  @param subpath                  sub path in directory.
 *  @param encode                   charset encode.
 *  @param sourceType               resource type.
 *
 *  @return container|nil           a container object or nil.
 */
- ( NSMutableDictionary * ) propertyList:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath encoding:(NSStringEncoding)encode
                        fromData:(TDResourceManageSourceType)sourceType;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get data of assets bundle type.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set the table name of localized string.
 *  set the table name of localized string.
 *
 *  @param tableName                table name of localized string.
 */
- ( void ) setLocalizedStringTable:(NSString *)tableName;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the localized string for key.
 *  get the localized string for key.
 *
 *  @param aKey                     a localized string's key.
 *
 *  @return string|nil              the localized string or nil.
 */
- ( NSString * ) localizedStringForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get data of zipped file type.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief unzipping another file then appending content of files into this object.
 *  unzipping another file then appending content of files into this container.
 *
 *  @param fullPathName             zipped file name (full path).
 *  @param password                 password of zipped file.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) updateZippedFileContainer:(NSString *)fullPathName with:(NSString *)password;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the container of zipped file.
 *  get the container of zipped file.
 *
 *  @return container|nil           the container or nil.
 */
- ( NSMutableDictionary * ) unzipDataContainer;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get properties of object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the resource type of current environment.
 *  get the resource type of current environment.
 *
 *  @return                         resource type.
 */
- ( TDResourceManageSourceType ) currentEnvironment;

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------





