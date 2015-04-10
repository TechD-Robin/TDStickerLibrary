//
//  TDJSONReader.m
//  TDFoundation
//
//  Created by Robin Hsu on 2015/4/9.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.


#import "TDJSONReader.h"
#import "Foundation+TechD.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDJSONReader

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDJSONReader ()
{
    /**
     *  the container type, when type of container is array then the value is YES, otherwise it's NO.
     *  (type is dictionary, value is NO)
     */
    BOOL                            topObjectIsArray;
    
    /**
     *  the container of JSON data.
     */
    id                              dataContainer;    
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
@interface TDJSONReader (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;


//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDJSONReader (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    topObjectIsArray                = NO;
    dataContainer                   = nil;
    
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
@implementation TDJSONReader


//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init
{
    return [self initWithFile: nil forDirectories: TDTemporaryDirectory inDirectory: nil encoding: NSASCIIStringEncoding];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != dataContainer )
    {
        [dataContainer removeAllObjects];
        SAFE_ARC_RELEASE( dataContainer );
        SAFE_ARC_ASSIGN_POINTER_NIL( dataContainer );
    }
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithFile:(NSString *)filename forDirectories:(TDGetPathDirectory)directory inDirectory:(NSString *)subpath
                       encoding:(NSStringEncoding)encode
{
    NSParameterAssert( nil != filename );
    
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    
    id                              container;
    NSString                      * fullPath;
    NSError                       * error;
    
    error                           = nil;
    fullPath                        = TDGetPathForDirectories( directory, [filename stringByDeletingPathExtension], [filename pathExtension], subpath, NO );
    container                       = [NSJSONSerialization loadJSON: fullPath encoding: encode error: &error];
    if ( nil != error )
    {
        NSLog( @"init error : %@", error );
        return nil;
    }
    
    if ( [container isKindOfClass: [NSDictionary class]] == YES )
    {
        dataContainer               = container;
        topObjectIsArray            = NO;
    }
    else if ( [container isKindOfClass: [NSArray class]] == YES )
    {
        dataContainer               = container;
        topObjectIsArray            = YES;
    }
    else
    {
        NSLog( @"container of data is unknow type : %@", container );
    }
    return self;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadData:(NSString *)filename forDirectories:(TDGetPathDirectory)directory inDirectory:(NSString *)subpath
                   encoding:(NSStringEncoding)encode
{
    return [[[self class] alloc] initWithFile: filename forDirectories: directory inDirectory: subpath encoding: encode];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get root data (array/dictionary).
//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) rootDataCount
{
    NSParameterAssert( nil != dataContainer );
    
    if ( YES == topObjectIsArray )
    {
        return [(NSArray *)dataContainer count];
    }
    return [(NSDictionary *)dataContainer count];
}

//  ------------------------------------------------------------------------------------------------
- ( id ) rootObjectAtIndex:(NSInteger)index
{
    NSParameterAssert( nil != dataContainer );
    
    if ( YES == topObjectIsArray )
    {
        if ( [(NSArray *)dataContainer count] < index )
        {
            return nil;
        }
        return [(NSArray *)dataContainer objectAtIndex: index];
    }
    
    id                              idObject;
    NSArray                       * allKeys;
    NSDictionary                  * container;
    
    container                       = dataContainer;
    if ( [container count] < index )
    {
        return nil;
    }
    
    allKeys                         = [container allKeys];
    if ( [allKeys count] < index )
    {
        return nil;
    }
    
    for ( int i = 0; i < [allKeys count]; ++i )
    {
        if ( [allKeys objectAtIndex: i] == nil )
        {
            continue;
        }

        idObject                    = [container objectForKey: [allKeys objectAtIndex: i]];
        if ( nil == idObject )
        {
            continue;
        }
        if ( index == i )
        {
            return idObject;
        }
    }
    return nil;
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) dataAtIndex:(NSInteger)index stringValueForKey:(NSString *)aKey
{
    NSParameterAssert( nil != dataContainer );
    if ( [self rootDataCount] < index )
    {
        return nil;
    }
    
    id                              dataObject;
    NSString                      * string;
    
    dataObject                      = [self rootObjectAtIndex: index];
    if ( ( nil == dataObject ) || ( [dataObject isKindOfClass: [NSDictionary class]] == NO ) )
    {
        return nil;
    }
    
    string                          = [dataObject objectForKey: aKey];
    if ( ( nil == string ) || ( [string length] == 0 ) )
    {
        return nil;
    }
    return string;
}

//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) dataAtIndex:(NSInteger)index integerValueForKey:(NSString *)aKey isSuccess:(BOOL *)success
{
    NSString                      * string;
    
    string                          = [self dataAtIndex: index stringValueForKey: aKey];
    if ( nil == string )
    {
        if ( nil != success )
        {
            *success                = NO;
        }
        return -1;
    }
    
    if ( nil != success )
    {
        *success                    = YES;
    }
    return [string integerValue];
}

//  ------------------------------------------------------------------------------------------------
- ( float ) dataAtIndex:(NSInteger)index floatValueForKey:(NSString *)aKey isSuccess:(BOOL *)success
{
    NSString                      * string;
    
    string                          = [self dataAtIndex: index stringValueForKey: aKey];
    if ( nil == string )
    {
        if ( nil != success )
        {
            *success                = NO;
        }
        return -1.0f;
    }
    
    if ( nil != success )
    {
        *success                    = YES;
    }
    return [string floatValue];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get data (dictionary).
//  ------------------------------------------------------------------------------------------------
- ( id ) rootObjectForKey:(NSString *)aKey
{
    NSParameterAssert( nil != dataContainer );
    NSParameterAssert( YES != topObjectIsArray );
    NSParameterAssert( nil != aKey );
    
    return [dataContainer objectForKey: aKey];
}

//  ------------------------------------------------------------------------------------------------
- ( NSArray * ) rootAllKeys
{
    NSParameterAssert( nil != dataContainer );
    NSParameterAssert( YES != topObjectIsArray );

    return [dataContainer allKeys];
}

//  ------------------------------------------------------------------------------------------------
- ( NSArray * ) rootAllValues
{
    NSParameterAssert( nil != dataContainer );
    NSParameterAssert( YES != topObjectIsArray );
    
    return [dataContainer allValues];
}

//  ------------------------------------------------------------------------------------------------
- ( id ) objectForKeyPath:(NSString *)keyPath
{
    NSParameterAssert( nil != dataContainer );
    NSParameterAssert( YES != topObjectIsArray );
    
    NSInteger                       index;
    NSArray                       * keySeparated;
    id                              dataObject;
    
    keySeparated                    = [keyPath componentsSeparatedByString: @"/"];
    if ( ( nil == keySeparated ) || ( [keySeparated count] == 0 ) )
    {
        return nil;
    }
    
    index                           = 0;
    dataObject                      = dataContainer;
    do
    {
        dataObject                  = [dataObject objectForKey: [keySeparated objectAtIndex: index]];
        if ( nil == dataObject )
        {
            return nil;
        }
        index++;
    } while ( [keySeparated count] > index );
    
    return dataObject;
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) stringValueForKeyPath:(NSString *)keyPath
{
    id                              dataObject;
    
    dataObject                      = [self objectForKeyPath: keyPath];
    if ( nil == dataObject )
    {
        return nil;
    }
    
    if ( [(NSString *)dataObject length] == 0 )
    {
        return nil;
    }
    return dataObject;
}

//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) integerValueForKeyPath:(NSString *)keyPath isSuccess:(BOOL *)success
{
    NSString                      * string;
    
    string                          = [self stringValueForKeyPath: keyPath];
    if ( nil == string )
    {
        if ( nil != success )
        {
            *success                = NO;
        }
        return -1;
    }
    
    if ( nil != success )
    {
        *success                    = YES;
    }
    return [string integerValue];
}

//  ------------------------------------------------------------------------------------------------
- ( float ) floatValueForKeyPath:(NSString *)keyPath isSuccess:(BOOL *)success
{
    NSString                      * string;
    
    string                          = [self stringValueForKeyPath: keyPath];
    if ( nil == string )
    {
        if ( nil != success )
        {
            *success                = NO;
        }
        return -1.0f;
    }
    
    if ( nil != success )
    {
        *success                    = YES;
    }
    return [string floatValue];
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
















