//
//  TDTexturePakcerXMLReader.m
//  TDFoundation
//
//  Created by Robin Hsu on 2015/1/29.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.


#import "TDTexturePakcerXMLReader.h"

//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryTabInfo

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  declare property for private category()
//  ------------------------------------------------------------------------------------------------
#pragma mark declare property ()
@interface TDTexturePakcerXMLReader()
{
    NSDictionary                      * framesContanier;
    NSDictionary                      * metaContainer;
    
}

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  method declare for Private of category
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare for Private
@interface TDTexturePakcerXMLReader(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) _TranslateCharSet:(NSData *)source;

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _LoadProcedure:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath;
- ( BOOL ) _LoadProcedure:(NSData *)source;

- ( BOOL ) _GetConfigure:(NSData *)xmlData;

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) _GetOriginalImageName;
- ( CGSize ) _GetOriginalImageSize;

//  ------------------------------------------------------------------------------------------------
+ ( CGRect ) _ConvertSpriteInfoToCGRect:(NSDictionary *)spriteInfo;
//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  method implementation for Private of category
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for Private method
@implementation TDTexturePakcerXMLReader(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    framesContanier                 = nil;
    metaContainer                   = nil;
}


//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) _TranslateCharSet:(NSData *)source
{
    if ( nil == source )
    {
        return nil;
    }
    
    NSPropertyListFormat            format;
    NSString                      * errorString;
    NSDictionary                  * currentXML;
    
    errorString                     = nil;
    currentXML                      = nil;
    currentXML                      = [NSPropertyListSerialization propertyListFromData: source mutabilityOption: NSPropertyListMutableContainersAndLeaves format: &format errorDescription: &errorString];
    if ( nil != errorString )
    {
        NSLog( @"error string : %@", errorString );
        return nil;
    }
    return currentXML;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _LoadProcedure:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
{
    if ( nil == filename )
    {
        NSLog( @"filename is nil(%s).", __FUNCTION__ );
        return NO;
    }
    
    NSString                      * filePath;
    
    filePath                        = TDGetPathForDirectories( directory, filename, @"zip", subpath );
    if ( [[NSFileManager defaultManager] fileExistsAtPath: filePath] == NO )
    {
        NSLog( @"file %s no exist.", [filePath UTF8String] );
        return NO;
    }
    
    NSData                        * xmlData;
    NSString                      * xmlString;
    NSError                       * error;
    
    xmlData                         = nil;
    xmlString                       = nil;
    error                           = nil;
    xmlString                       = [NSString stringWithContentsOfFile: filePath encoding: NSUTF8StringEncoding error: &error];
    if ( nil != error )
    {
        NSLog( @"error : %@", error );
        return NO;
    }
    
    xmlData                         = [xmlString dataUsingEncoding: NSUTF8StringEncoding];
    if ( nil == xmlData )
    {
        return NO;
    }
    
    if ( [self _GetConfigure: xmlData] == NO )
    {
        return NO;
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _LoadProcedure:(NSData *)source
{
    if ( nil == source )
    {
        NSLog( @"source data is nil(%s).", __FUNCTION__ );
        return NO;
    }
    
    NSData                        * xmlData;
    NSString                      * xmlString;
    
    xmlData                         = nil;
    xmlString                       = nil;
    xmlString                       = [[NSString alloc] initWithData: source encoding: NSUTF8StringEncoding];
    if ( nil == xmlString )
    {
        return NO;
    }
    
    xmlData                         = [xmlString dataUsingEncoding: NSUTF8StringEncoding];
    if ( nil == xmlData )
    {
        return NO;
    }
    
    if ( [self _GetConfigure: xmlData] == NO )
    {
        return NO;
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _GetConfigure:(NSData *)xmlData
{
    if ( nil == xmlData )
    {
        NSLog( @"xml data is nil(%s).", __FUNCTION__ );
        return NO;
    }
    
    
    NSDictionary                  * meta;
    NSDictionary                  * frames;
    NSDictionary                  * currentXML;
    
    meta                            = nil;
    frames                          = nil;
    currentXML                      = nil;
    currentXML                      = [self _TranslateCharSet: xmlData];
    if ( ( currentXML = [self _TranslateCharSet: xmlData] ) == nil )
    {
        return NO;
    }
    
    frames                          = [currentXML objectForKey: @"frames"];
    meta                            = [currentXML objectForKey: @"meta"];
    if ( nil != frames )
    {
        framesContanier             = frames;
    }
    if ( nil != meta )
    {
        metaContainer               = meta;
    }
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( NSString * ) _GetOriginalImageName
{
    if ( nil == metaContainer )
    {
        return nil;
    }
    return [metaContainer objectForKey: @"image"];
}

//  ------------------------------------------------------------------------------------------------
- ( CGSize ) _GetOriginalImageSize
{
    if ( nil == metaContainer )
    {
        return CGSizeZero;
    }
    
    CGSize                          originalSize;
    NSString                      * width;
    NSString                      * height;
    
    width                           = nil;
    height                          = nil;
    originalSize                    = CGSizeZero;
    width                           = [metaContainer objectForKey: @"width"];
    height                          = [metaContainer objectForKey: @"height"];
    if ( nil != width )
    {
        originalSize.width          = [width floatValue];
    }
    if ( nil != height )
    {
        originalSize.height         = [height floatValue];
    }
    return originalSize;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
+ ( CGRect ) _ConvertSpriteInfoToCGRect:(NSDictionary *)spriteInfo;
{
    if ( nil == spriteInfo )
    {
        return CGRectZero;
    }
    
    CGRect                          spriteFrame;
    CGPoint                         spriteOffset;
    
    NSString                      * width;
    NSString                      * height;
    NSString                      * originX;
    NSString                      * originY;
    NSString                      * offsetX;
    NSString                      * offsetY;
    
    width                           = nil;
    height                          = nil;
    originX                         = nil;
    originY                         = nil;
    offsetX                         = nil;
    offsetY                         = nil;
    spriteFrame                     = CGRectZero;
    spriteOffset                    = CGPointZero;
    width                           = [spriteInfo objectForKey: @"w"];
    height                          = [spriteInfo objectForKey: @"h"];
    originX                         = [spriteInfo objectForKey: @"x"];
    originY                         = [spriteInfo objectForKey: @"y"];
    offsetX                         = [spriteInfo objectForKey: @"oX"];
    offsetY                         = [spriteInfo objectForKey: @"oY"];
    spriteFrame.size.width          = ( ( nil != width ) ? [width floatValue] : spriteFrame.size.width );
    spriteFrame.size.height         = ( ( nil != height ) ? [height floatValue] : spriteFrame.size.height );
    spriteFrame.origin.x            = ( ( nil != originX ) ? [originX floatValue] : spriteFrame.origin.x );
    spriteFrame.origin.y            = ( ( nil != originY ) ? [originY floatValue] : spriteFrame.origin.y );
    spriteOffset.x                  = ( ( nil != offsetX ) ? [offsetX floatValue] : spriteOffset.x );
    spriteOffset.y                  = ( ( nil != offsetY ) ? [offsetY floatValue] : spriteOffset.y );
    spriteFrame.origin.x            += spriteOffset.x;
    spriteFrame.origin.y            += spriteOffset.y;
    return spriteFrame;
}


//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


// ※ 環境設定新建一個 default class 之類的方式, 把一些相關設定值都預設進去裡頭, 如果開發人員讓 object = nil 帶入, 就自建一個 default 的 出來傳遞,
//  如果有 new 這個 class 就帶入這個 new 出來的 class 的值... 這樣應該不錯用才是 @@~

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  public method implementation.
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public method
@implementation TDTexturePakcerXMLReader

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init
{
    return [self initWithFile: nil forDirectories: TDTemporaryDirectory inDirectory: nil];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) deallocb
{
    if ( nil != framesContanier )
    {
        SAFE_ARC_RELEASE( framesContanier );
        SAFE_ARC_ASSIGN_POINTER_NIL( framesContanier );
    }
    if ( nil != metaContainer )
    {
        SAFE_ARC_RELEASE( metaContainer );
        SAFE_ARC_ASSIGN_POINTER_NIL( metaContainer );
    }
    
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method create the object.
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( instancetype ) initWithFile:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    if ( [self _LoadProcedure: filename forDirectories: directory inDirectory: subpath] == NO )
    {
        SAFE_ARC_RELEASE( self );
        SAFE_ARC_ASSIGN_POINTER_NIL( self );
        return nil;
    }
    return self;
}

//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithData:(NSData *)source
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    
    
    NSData                        * xmlData;
    
    xmlData                         = [NSData dataWithData: source];
    
    return self;
}


//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadData:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
{
    return [[[self class] alloc] initWithFile: filename forDirectories: directory inDirectory: subpath];
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) loadFromData:(NSData *)source
{
    return [[[self class] alloc] initWithData: source];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) spriteDataCount
{
    if ( nil == framesContanier )
    {
        return 0;
    }
    return [framesContanier count];
}

//  ------------------------------------------------------------------------------------------------
- ( CGRect ) spriteFrameAtIndex:(NSInteger)index
{
    if ( 0 > index )
    {
        return CGRectZero;
    }
    
    NSString                      * aKey;
    NSDictionary                  * infoData;

    aKey                            = nil;
    infoData                        = nil;
    aKey                            = [self sprinteNameAtIndex: index];
    if ( nil == aKey )
    {
        return CGRectZero;
    }
    
    infoData                        = [framesContanier objectForKey: aKey];
    if ( nil == infoData )
    {
        return CGRectZero;
    }
    return [[self class] _ConvertSpriteInfoToCGRect: infoData];
}

//  ------------------------------------------------------------------------------------------------
- ( NSString * ) sprinteNameAtIndex:(NSInteger)index
{
    if ( 0 > index )
    {
        return nil;
    }
    
    NSInteger                       count;
    
    count                           = 0;
    for ( NSString * aKey in [framesContanier  allKeys] )
    {
        if ( nil == aKey )
        {
            ++count;
            continue;
        }
        if ( count == index )
        {
            return aKey;
        }
    }
    return nil;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
















