//
//  NSJSONSerialization+TechD.h
//  Foundation+TechD
//
//  Created by Robin Hsu on 2015/3/20.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import <Foundation/Foundation.h>

@interface NSJSONSerialization (TechD)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief save a JSON data from container of data into file.
 *  save a JSON data from container of data into file.
 *
 *  @param container                the JSON data container.
 *  @param filepath                 the file path (full path).
 *  @param error                    assign pointer of a error object when method has error.
 *
 *  @return YES|NO                  method success or failure
 */
+ ( BOOL ) saveJSONContainer:(NSDictionary *)container toFileAtPath:(NSString *)filepath error:(NSError * __autoreleasing *)error;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief load a JSON data from file path.
 *  load a JSON data from file path, the data container is an NSArray or NSDictionary.
 *
 *  @param filepath                 the file path (full path).
 *  @param encode                   charset encode.
 *  @param error                    assign pointer of a error object when method has error.
 *
 *  @return container|nil           a container object or nil.
 */
+ ( id ) loadJSON:(NSString *)filepath encoding:(NSStringEncoding)encode error:(NSError * __autoreleasing *)error;

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
