//
//  TDTexturePackerXMLReader.m
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


#import "TDTexturePackerXMLReader.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
static  NSString  * const kTDXMLReaderKeyFrames                     = @"frames";
static  NSString  * const kTDXMLReaderKeyMeta                       = @"meta";

static  NSString  * const kTDXMLReaderKeyMetaImage                  = @"image";
static  NSString  * const kTDXMLReaderKeyMetaWidth                  = @"width";
static  NSString  * const kTDXMLReaderKeyMetaHeight                 = @"height";

static  NSString  * const kTDXMLReaderKeyFramesW                    = @"w";
static  NSString  * const kTDXMLReaderKeyFramesH                    = @"h";
static  NSString  * const kTDXMLReaderKeyFramesX                    = @"x";
static  NSString  * const kTDXMLReaderKeyFramesY                    = @"y";
static  NSString  * const kTDXMLReaderKeyFramesOffsetX              = @"oX";
static  NSString  * const kTDXMLReaderKeyFramesOffsetY              = @"oY";


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDTexturePackerXMLReader

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDTexturePackerXMLReader ()
{
    /**
     *  the container of sprite's frame data.
     */
    NSDictionary                      * framesContanier;
    
    /**
     *  the containe of texture's information data.
     */
    NSDictionary                      * metaContainer;
    
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
@interface TDTexturePackerXMLReader (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for load procedure.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief load procedure for read & parse a XML file.
 *  load procedure for read & parse a XML file.
 *
 *  @param filename                 XML file name (without Extension part).
 *  @param directory                enumeration for directory.
 *  @param subpath                  resource's sub directory name of configure
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _LoadProcedure:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief load procedure for read & parse a data.
 *  load procedure for read & parse a data.
 *
 *  @param source                   the source data.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _LoadProcedure:(NSData *)source;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the configure data from source data.
 *  get the configure data(texture & sprites) from source data and assign to this object's container.
 *
 *  @param xmlData                  the source data. (XML format)
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _GetConfigure:(NSData *)xmlData;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief translate source data's character set.
 *  translate source data's character set
 *
 *  @param xmlData                  the source data. (XML format)
 *
 *  @return data|nil                be translate data or nil.
 */
+ ( NSDictionary * ) _TranslateCharSet:(NSData *)source;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get texture data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the file name of texture.
 *  get the file name of texture
 *
 *  @return name|nil                the texture's file name or nil.
 */
- ( NSString * ) _GetTextureName;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the size of texture.
 *  get the size of texture.
 *
 *  @return size|ZeroSize           the texture's size or ZeroSize.
 */
- ( CGSize ) _GetTextureSize;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for convert format.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief convert format from sprite information to CGRect.
 *  convert format from sprite information to CGRect.
 *
 *  @param spriteInfo               the sprite's information.
 *
 *  @return frame|ZeroRect          the sprite's frame or ZeroRect.
 */
+ ( CGRect ) _ConvertSpriteInfoToCGRect:(NSDictionary *)spriteInfo;

//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDTexturePackerXMLReader (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    framesContanier                 = nil;
    metaContainer                   = nil;
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for load procedure.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _LoadProcedure:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
{
    if ( nil == filename )
    {
        NSLog( @"filename is nil(%s).", __FUNCTION__ );
        return NO;
    }
    
    NSString                      * filePath;
    
    filePath                        = TDGetPathForDirectories( directory, filename, @"plist", subpath );
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
    if ( ( currentXML = [[self class] _TranslateCharSet: xmlData] ) == nil )
    {
        return NO;
    }
    
    frames                          = [currentXML objectForKey: kTDXMLReaderKeyFrames];
    meta                            = [currentXML objectForKey: kTDXMLReaderKeyMeta];
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
+ ( NSDictionary * ) _TranslateCharSet:(NSData *)source
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
#pragma mark method for get texture data.
//  ------------------------------------------------------------------------------------------------
- ( NSString * ) _GetTextureName
{
    if ( nil == metaContainer )
    {
        return nil;
    }
    return [metaContainer objectForKey: kTDXMLReaderKeyMetaImage];
}

//  ------------------------------------------------------------------------------------------------
- ( CGSize ) _GetTextureSize
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
    width                           = [metaContainer objectForKey: kTDXMLReaderKeyMetaWidth];
    height                          = [metaContainer objectForKey: kTDXMLReaderKeyMetaHeight];
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
#pragma mark method for convert format.
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
    width                           = [spriteInfo objectForKey: kTDXMLReaderKeyFramesW];
    height                          = [spriteInfo objectForKey: kTDXMLReaderKeyFramesH];
    originX                         = [spriteInfo objectForKey: kTDXMLReaderKeyFramesX];
    originY                         = [spriteInfo objectForKey: kTDXMLReaderKeyFramesY];
    offsetX                         = [spriteInfo objectForKey: kTDXMLReaderKeyFramesOffsetX];
    offsetY                         = [spriteInfo objectForKey: kTDXMLReaderKeyFramesOffsetY];
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
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public
//  ------------------------------------------------------------------------------------------------
@implementation TDTexturePackerXMLReader

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
- ( void ) dealloc
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
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
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
    if ( [self _LoadProcedure: xmlData] == NO )
    {
        SAFE_ARC_RELEASE( self );
        SAFE_ARC_ASSIGN_POINTER_NIL( self );
        return nil;
    }
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
#pragma mark method for get texture data.
//  ------------------------------------------------------------------------------------------------
- ( NSString * ) textureName
{
    return [self _GetTextureName];
}

//  ------------------------------------------------------------------------------------------------
- ( CGSize ) textureSize
{
    return [self _GetTextureSize];
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for get sprite data.
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
    NSArray                       * allKeys;
    
    count                           = 0;
    allKeys                         = nil;
    allKeys                         = [framesContanier  allKeys];
    if ( ( nil == allKeys ) || ( [allKeys count] == 0 ) )
    {
        return nil;
    }
    return [allKeys objectAtIndex: index];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
















