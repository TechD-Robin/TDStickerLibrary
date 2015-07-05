//
//  TDConfigureData.h
//  TDResourceManager
//
//  Created by Robin Hsu on 2015/5/20.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "TDResourceManager.h"


//  ------------------------------------------------------------------------------------------------
#pragma mark declare enumeration.
//  ------------------------------------------------------------------------------------------------
/**
 *  enumeration for configure data source file type.
 */
typedef NS_ENUM( NSInteger, TDConfigureDataSourceFileType ){
    /**
     *  file type is JSON.
     */
    TDConfigureDataSourceFileTypeJSON           = 1,
    /**
     *  file type is Property List.
     */
    TDConfigureDataSourceFileTypePList,
};

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  a data object it's inherit from Resource Manager.
 *  extension function for loaded configure data into a container.
 */
@interface TDConfigureData : TDResourceManager

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
- (instancetype)init NS_UNAVAILABLE;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a Configure Data object and loaded configure data from default environment into a container.
 *  create a Configure Data object and loaded configure data from default environment into a container.
 *
 *  @param filename                 a filename of configure data.
 *  @param fileType                 type of file..
 *  @param encode                   charset encode.
 *  @param rootKey                  key of root of configure file.
 *  @param defaultDirectory         enumeration for directory.
 *  @param subpath                  sub path in directory.
 *  @param singleton                create a singleton object or normal object.
 *
 *  @return object|nil              data(with resource manager) object or nil.
 */
+ ( instancetype ) loadConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType encoding:(NSStringEncoding)encode
                       withConfigure:(NSString *)rootKey
                                from:(TDGetPathDirectory)defaultDirectory inDirectory:(NSString *)subpath onSingleton:(BOOL)singleton;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a Configure Data object and load configure data from assets bundle into a container.
 *  create a Configure Data object and load configure data from assets bundle into a container.
 *
 *  @param filename                 a filename of configure data.
 *  @param fileType                 type of file..
 *  @param encode                   charset encode.
 *  @param rootKey                  key of root of configure file.
 *  @param assetsBundleName         a bundle name.
 *  @param aClass                   a class.(is view controller usually)
 *  @param subpath                  sub path in directory.
 *  @param singleton                create a singleton object or normal object.
 *
 *  @return object|nil              data(with resource manager) object or nil.
 */
+ ( instancetype ) loadConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType encoding:(NSStringEncoding)encode
                       withConfigure:(NSString *)rootKey
                                from:(NSString *)assetsBundleName with:(Class)aClass
                         inDirectory:(NSString *)subpath onSingleton:(BOOL)singleton;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a Configure Data object and loaded configure data from zipped file into a container.
 *  create a Configure Data object and loaded configure data from zipped file into a container.
 *
 *  @param filename                 a filename of configure data.
 *  @param fileType                 type of file..
 *  @param encode                   charset encode.
 *  @param rootKey                  key of root of configure file.
 *  @param zippedFilename           zipped file name (without Extension part).
 *  @param directory                enumeration for directory.
 *  @param subpath                  resource's sub directory name of configure
 *  @param prefix                   prefix path name in zipped file.
 *  @param password                 password of zipped file.
 *  @param singleton                create a singleton object or normal object.
 *
 *  @return object|nil              data(with resource manager) object or nil.
 */
+ ( instancetype ) loadConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType encoding:(NSStringEncoding)encode
                       withConfigure:(NSString *)rootKey
                                from:(NSString *)zippedFilename forDirectories:(TDGetPathDirectory)directory inDirectory:(NSString *)subpath
                        inZippedPath:(NSString *)prefix with:(NSString *)password onSingleton:(BOOL)singleton;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a Configure Data object and loaded configure data from zipped file into a container.
 *  create a Configure Data object and loaded configure data from zipped file into a container.
 *
 *  @param filename                 a filename of configure data.
 *  @param fileType                 type of file..
 *  @param encode                   charset encode.
 *  @param rootKey                  key of root of configure file.
 *  @param zippedFullPath           zipped file name (full path).
 *  @param prefix                   prefix path name in zipped file.
 *  @param password                 password of zipped file.
 *  @param singleton                create a singleton object or normal object.
 *
 *  @return object|nil              data(with resource manager) object or nil.
 */
+ ( instancetype ) loadConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType encoding:(NSStringEncoding)encode
                       withConfigure:(NSString *)rootKey
                                from:(NSString *)zippedFullPath
                        inZippedPath:(NSString *)prefix with:(NSString *)password onSingleton:(BOOL)singleton;


//  --------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare for update the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief change environment and update configure data.
 *  change environment and update configure data.
 *
 *  @param filename                 a filename of configure data.
 *  @param fileType                 type of file..
 *  @param encode                   charset encode.
 *  @param rootKey                  key of root of configure file.
 *  @param updateKey                key for update data.
 *  @param defaultDirectory         enumeration for directory.
 *  @param subpath                  sub path in directory.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) updateConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType encoding:(NSStringEncoding)encode
                 withConfigure:(NSString *)rootKey and:(NSString *)updateKey
                          from:(TDGetPathDirectory)defaultDirectory inDirectory:(NSString *)subpath;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief change enviroment of assets bundle and update configure data.
 *  change enviroment of assets bundle and update configure data.
 *
 *  @param filename                 a filename of configure data.
 *  @param fileType                 type of file..
 *  @param encode                   charset encode.
 *  @param rootKey                  key of root of configure file.
 *  @param updateKey                key for update data.
 *  @param assetsBundleName         a bundle name.
 *  @param aClass                   a class.(is view controller usually)
 *  @param subpath                  sub path in directory.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) updateConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType encoding:(NSStringEncoding)encode
                 withConfigure:(NSString *)rootKey and:(NSString *)updateKey
                          from:(NSString *)assetsBundleName with:(Class)aClass inDirectory:(NSString *)subpath;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief update data for the Configure Data object and configure data.
 *  update data for the Configure Data object and configure data.
 *
 *  @param filename                 a filename of update's configure data.
 *  @param fileType                 type of file..
 *  @param encode                   charset encode.
 *  @param rootKey                  key of root of configure file.
 *  @param updateKey                key for update data.
 *  @param zippedFilename           zipped file name (without Extension part).
 *  @param directory                enumeration for directory.
 *  @param subpath                  resource's sub directory name of configure
 *  @param prefix                   prefix path name in zipped file.
 *  @param password                 password of zipped file.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) updateConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType encoding:(NSStringEncoding)encode
                 withConfigure:(NSString *)rootKey and:(NSString *)updateKey
                          from:(NSString *)zippedFilename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                  inZippedPath:(NSString *)prefix with:(NSString *)password;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief update data for the Configure Data object and configure data.
 *  update data for the Configure Data object and configure data.
 *
 *  @param filename                 a filename of update's configure data.
 *  @param fileType                 type of file..
 *  @param encode                   charset encode.
 *  @param rootKey                  key of root of configure file.
 *  @param updateKey                key for update data.
 *  @param zippedFullPath           zipped file name (full path).
 *  @param prefix                   prefix path name in zipped file.
 *  @param password                 password of zipped file.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) updateConfigureData:(NSString *)filename type:(TDConfigureDataSourceFileType)fileType encoding:(NSStringEncoding)encode
                 withConfigure:(NSString *)rootKey and:(NSString *)updateKey
                          from:(NSString *)zippedFullPath
                  inZippedPath:(NSString *)prefix with:(NSString *)password;


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get data container.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the container of configure data.
 *  the container of configure data.
 *
 *  @return container|nil           the container or nil.
 */
- ( NSMutableArray *) configureData;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set a container of configure data.
 *  set a container of configure data, change contents at action special.
 *
 *  @param container                a contaiiner of data.
 */
- ( void ) setConfigureData:(NSMutableArray *)container;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief sort the configure data by sort key.
 *  sort the configure data by sort key.
 *
 *  @param sortKey                  a sort key.( a configure data's property or field. )
 *  @param isAscending              sorting use ascending or descending; Yes is ascending, No is descending.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) sortConfigureData:(NSString *)sortKey orderAscending:(BOOL)isAscending;

//  ------------------------------------------------------------------------------------------------



@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


