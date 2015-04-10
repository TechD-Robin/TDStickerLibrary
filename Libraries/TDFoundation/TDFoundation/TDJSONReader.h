//
//  TDJSONReader.h
//  TDFoundation
//
//  Created by Robin Hsu on 2015/4/9.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import "TDFoundation.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  a data object for read JSON data.
 *  porvide several methods to get the data.
 */
@interface TDJSONReader : NSObject

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief load a JSON data from file path.
 *  load a JSON data from file path, assign the data into a container of this object.
 *
 *  @param filename                 a JSON file name.
 *  @param directory                enumeration for directory.
 *  @param subpath                  resource's sub directory name of configure
 *  @param encode                   charset encode.
 *
 *  @return object|nil              the JSON Reader object or nil.
 */
+ ( instancetype ) loadData:(NSString *)filename forDirectories:(TDGetPathDirectory)directory inDirectory:(NSString *)subpath
                   encoding:(NSStringEncoding)encode;


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get root data (array/dictionary).
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief count of root data.
 *  count of root data.
 *
 *  @return count| 0                the count of root data or 0.
 */
- ( NSInteger ) rootDataCount;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a data at index.
 *  get a data from container(array or dictionary) of data at index.
 *
 *  @param index                    index of data.
 *
 *  @return data|nil                the data or nil.
 */
- ( id ) rootObjectAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get data type is string data at index and for the data key.
 *  get data type is string data at index and for the data key.
 *  the data structure like 'array(index)/dictionary(key)'
 *
 *  @param index                    index of data.
 *  @param aKey                     key of the data container.
 *
 *  @return data|nil                the data for key or nil.
 */
- ( NSString * ) dataAtIndex:(NSInteger)index stringValueForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get data type is integer data at index and for the data key.
 *  get data type is integer data at index and for the data key.
 *  the data structure like 'array(index)/dictionary(key)'
 *
 *  @param index                    index of data.
 *  @param aKey                     key of the data container.
 *  @param success                  pointer of the result of method, to express method is success or failure.
 *
 *  @return data| -1                the data for key or -1.
 */
- ( NSInteger ) dataAtIndex:(NSInteger)index integerValueForKey:(NSString *)aKey isSuccess:(BOOL *)success;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get data type is float data at index and for the data key.
 *  get data type is float data at index and for the data key.
 *  the data structure like 'array(index)/dictionary(key)'
 *
 *  @param index                    index of data.
 *  @param aKey                     key of the data container.
 *  @param success                  pointer of the result of method, to express method is success or failure.
 *
 *  @return data| -1.0f             the data for key or -1.0f.
 */
- ( float ) dataAtIndex:(NSInteger)index floatValueForKey:(NSString *)aKey isSuccess:(BOOL *)success;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get data (dictionary).
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a data for key.
 *  get a data from container(dictionary) of data for the data key.
 *
 *  @param aKey                     key of data.
 *
 *  @return data|nil                the data or nil.
 */
- ( id ) rootObjectForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get all keys of root data.
 *  get all keys of root data(dictionary).
 *
 *  @return data|nil                all keys of root's data or nil.
 */
- ( NSArray * ) rootAllKeys;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get all values of root data.
 *  get all values of root data.
 *
 *  @return data|nil                all values of root's data or nil.
 */
- ( NSArray * ) rootAllValues;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a data for key path.
 *  get a data from containers(nested's dictionary structure) for key path.
 *  the data structure like 'dictionary(key)/dictionary(key)/...'
 *
 *  @param keyPath                  a key path of data. use the character '/' to separate these keys
 *
 *  @return data|nil                the data or nil.
 */
- ( id ) objectForKeyPath:(NSString *)keyPath;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get data type is string data for key path.
 *  get a string data from containers(nested's dictionary structure) for key path.
 *  the data structure like 'dictionary(key)/dictionary(key)/...'
 *
 *  @param keyPath                  a key path of data. use the character '/' to separate these keys
 *
 *  @return data|nil                the data for key path or nil.
 */
- ( NSString * ) stringValueForKeyPath:(NSString *)keyPath;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get data type is integer data for key path.
 *  get a integer data from containers(nested's dictionary structure) for key path.
 *  the data structure like 'dictionary(key)/dictionary(key)/...'
 *
 *  @param keyPath                  a key path of data. use the character '/' to separate these keys
 *  @param success                  pointer of the result of method, to express method is success or failure.
 *
 *  @return data| -1                the data for key or -1.
 */
- ( NSInteger ) integerValueForKeyPath:(NSString *)keyPath isSuccess:(BOOL *)success;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get data type is float data for key path.
 *  get a float data from containers(nested's dictionary structure) for key path.
 *  the data structure like 'dictionary(key)/dictionary(key)/...'
 *
 *  @param keyPath                  a key path of data. use the character '/' to separate these keys
 *  @param success                  pointer of the result of method, to express method is success or failure.
 *
 *  @return data| -1.0f             the data for key or -1.0f.
 */
- ( float ) floatValueForKeyPath:(NSString *)keyPath isSuccess:(BOOL *)success;

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


