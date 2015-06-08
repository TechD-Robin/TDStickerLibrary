//
//  TDTexturePackerXMLReader.h
//  TDFoundation
//
//  Created by Robin Hsu on 2015/1/29.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import "TDFoundation.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  a data object for read sprite data of texture image.
 *  include texture information and sprite information.
 */
@interface TDTexturePackerXMLReader : NSObject

//  ------------------------------------------------------------------------------------------------
#pragma mark property of variable.
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief load a XML file that is configure sprite frames about texture packer.
 *  load a XML file that is configure sprite frames about texture packer, the XML is iOS plist format.
 *
 *  @param filename                 XML file name (without Extension part).
 *  @param directory                enumeration for directory.
 *  @param subpath                  resource's sub directory name of configure
 *  @param encode                   charset encode.
 *
 *  @return object|nil              the Texture Packer XML Reader object or nil.
 */
+ ( instancetype ) loadData:(NSString *)filename forDirectories:(TDGetPathDirectory) directory inDirectory:(NSString *)subpath
                   encoding:(NSStringEncoding)encode;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief load a data that is configure sprite frames about texture packer.
 *  load a data that is configure sprite frames about texture packer, the data is iOS plist data format.
 *
 *  @param source                   the source data.
 *  @param encode                   charset encode.
 *
 *  @return object|nil              the Texture Packer XML Reader object or nil.
 */
+ ( instancetype ) loadFromData:(NSData *)source encoding:(NSStringEncoding)encode;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get texture data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the file name of texture.
 *  get the file name of texture
 *
 *  @return name|nil                the texture's file name or nil.
 */
- ( NSString * ) textureName;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the size of texture.
 *  get the size of texture.
 *
 *  @return size|ZeroSize           the texture's size or ZeroSize.
 */
- ( CGSize ) textureSize;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for get sprite data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the count of sprite data.
 *  get the count of sprite data.
 *
 *  @return count| 0                the count of sprite data or 0.
 */
- ( NSInteger ) spriteDataCount;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the frame of sprite at index.
 *  get the frame of sprite at index.
 *
 *  @param index                    index of sprite data.
 *
 *  @return frame|ZeroRect          the sprite's frame or ZeroRect.
 */
- ( CGRect ) spriteFrameAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the frame of sprite for key.
 *  get the frame of sprite for key.
 *
 *  @param aKey                     a key of frame.
 *
 *  @return frame|ZeroRect          the sprite's frame or ZeroRect.
 */
- ( CGRect ) spriteFrameForKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the file name of sprite at index.
 *  get the file name of sprite at index.
 *
 *  @param index                    index of sprite data.
 *
 *  @return name|nil                the sprite's name or nil.
 */
- ( NSString * ) sprinteNameAtIndex:(NSInteger)index;


//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


