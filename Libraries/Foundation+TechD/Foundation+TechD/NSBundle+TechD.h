//
//  NSBundle+TechD.h
//  Foundation+TechD
//
//  Created by Robin Hsu on 2015/4/23.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface NSBundle (TechD)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
/**
 *  @brief get a bundle object for asset for a class.
 *  get a bundle object for asset for a class.
 *
 *  @param bundleName               a bundle name.
 *  @param aClass                   a class.(is view controller usually)
 *
 *  @return object|nil              bundle object| nil.
 */
+ ( NSBundle *) assetBundle:(NSString *)bundleName with:(Class)aClass;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a localized version of the string designated by the specified key and residing in the specified table.
 *  get a localized version of the string designated by the specified key and residing in the specified table
 *
 *  @param akey                     a key for a string in the table.
 *  @param tableName                the table name.
 *  @param bundleName               a bundle name.
 *  @param aClass                   a class.(is view controller usually)
 *
 *  @return string|nil              the string or nil.
 */
+ ( NSString * ) localizedStringForKey:(NSString *)akey with:(NSString *)tableName inBundle:(NSString *)bundleName with:(Class)aClass;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
