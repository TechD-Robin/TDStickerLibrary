//
//  NSPropertyListSerialization+TechD.h
//  Foundation+TechD
//
//  Created by Robin Hsu on 2015/4/27.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import <Foundation/Foundation.h>

@interface NSPropertyListSerialization (TechD)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief save a projerty list data from container of data into file.
 *  save a projerty list data from container of data into file.
 *
 *  @param container                the property list data container.
 *  @param filepath                 the file path (full path).
 *  @param error                    assign pointer of a error object when method has error.
 *
 *  @return YES|NO                  method success or failure
 */
+ ( BOOL ) savePropertyList:(NSDictionary *)container toFileAtPath:(NSString *)filepath error:(NSError * __autoreleasing *)error;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief load a property list data from file path.
 *  load a property list data from file path. 
 *
 *  @param filepath                 the file path (full path).
 *  @param encode                   charset encode.
 *  @param error                    assign pointer of a error object when method has error.
 *
 *  @return container|nil           a container object or nil.
 */
+ ( NSMutableDictionary * ) loadPropertyList:(NSString *)filepath encoding:(NSStringEncoding)encode error:(NSError * __autoreleasing *)error;


//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
