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
#import "Foundation+TechD.h"

#import "TDStickerLibraryUnzip.h"


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryUnzip

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryUnzip ()

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare private category (Private)
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryUnzip (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get data in Zipped file.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a data in zipped file for key.
 *  get a data in zipped file for key.
 *
 *  @param aKey                     a key of data.
 *
 *  @return data|nil                the data for key or nil.
 */
- ( NSData * ) _UnzipDataForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get information data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a information data at index.
 *  get a information data at index.
 *
 *  @param index                    index of information data.
 *
 *  @return data|nil                the container of information data.
 */
- ( NSDictionary * ) _GetInfoDataAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief remove informatioin data from other information data list.
 *  remove informatioin data from other information data list.
 *
 *  @param infoDataList             a information data list.
 */
- ( void ) _RemoveInfoData:(NSArray *)infoDataList;

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDStickerLibraryUnzip (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get data in Zipped file.
//  ------------------------------------------------------------------------------------------------
- ( NSData * ) _UnzipDataForKey:(NSString *)aKey
{
    if ( ( nil == aKey ) || ( nil == [self unzipDataContainer] ) || ( [[self unzipDataContainer] count] == 0 ) )
    {
        return nil;
    }
    return [[self unzipDataContainer] objectForKey: aKey];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get information data.
//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) _GetInfoDataAtIndex:(NSInteger)index;
{
    if ( ( 0 > index ) || ( [self configureData] == nil ) || ( [[self configureData] count] == 0 ) )
    {
        return nil;
    }
    return [[self configureData] objectAtIndex: index];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _RemoveInfoData:(NSArray *)infoDataList
{
    if ( ( nil == infoDataList ) || ( [infoDataList count] == 0 ) )
    {
        return;
    }
    [[self                          configureData] removeObjectsInArray: infoDataList];
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
@implementation TDStickerLibraryUnzip

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init
{
    //  ※ 這邊這個 [super init] 其實在宣告的地方被我用 NS_UNAVAILABLE 停止被呼叫了，可是程式還是能運作
    //    之後， release 或是其他狀況導致有問題，這邊可以嘗試回去把 super class 的 NS_UNAVAILABLE 拿掉。
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    return self;
}

////  ------------------------------------------------------------------------------------------------
//- ( void ) dealloc
//{
//    SAFE_ARC_SUPER_DEALLOC();
//}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get data in Zipped file.
//  ------------------------------------------------------------------------------------------------
- ( NSData * ) unzipDataForKey:(NSString *)aKey
{
    return [self _UnzipDataForKey: aKey];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for get information data.
//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) infoDataAtIndex:(NSInteger)index
{
    return [self _GetInfoDataAtIndex: index];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) removeInfoData:(NSArray *)infoDataList
{
    return [self _RemoveInfoData: infoDataList];
}

//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) infoDataCount
{
    if ( [self configureData] == nil )
    {
        return 0;
    }
    return [[self configureData] count];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) infoDataAtIndex:(NSInteger)index stringValueForKey:(NSString *)aKey
{
    NSDictionary                  * infoData;
    NSString                      * string;
    
    string                          = nil;
    infoData                        = [self infoDataAtIndex: index];
    if ( nil == infoData )
    {
        return nil;
    }
    
    string                          = [infoData objectForKey: aKey];
    if ( ( nil == string ) || ( [string length] == 0 ) )
    {
        return nil;
    }
    return string;
}

//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) infoDataAtIndex:(NSInteger)index integerValueForKey:(NSString *)aKey
{
    NSString                      * string;
    
    string                          = [self infoDataAtIndex: index stringValueForKey: aKey];
    if ( nil == string )
    {
        return -1;
    }
    return [string integerValue];
}


//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------















