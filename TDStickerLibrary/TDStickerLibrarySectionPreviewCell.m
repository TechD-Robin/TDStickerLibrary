//
//  TDStickerLibrarySectionPreviewCell.m
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

#import "TDMath.h"

#import "TDStickerLibrarySectionPreviewCell.h"
#import "TDTexturePakcerXMLReader.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibrarySectionPreviewCell

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  declare property for private category()
//  ------------------------------------------------------------------------------------------------
#pragma mark declare property ()
@interface TDStickerLibrarySectionPreviewCell ()
{
    TDTexturePakcerXMLReader      * xmlReader;
    NSData                        * framesData;
    
}

//  --------------------------------
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
@interface TDStickerLibrarySectionPreviewCell(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create tap gesture recognizer.
 *  create tap gesture recognizer for self (cell object).
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _CreateTapAction;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate the scale of size.
 *  calculate the scale of size that is change for texture(original image) assign to the object's background view.
 *
 *  @return value| 0.0f               calculated value for scale or 0.0f.
 */
- ( CGFloat ) _CalculateScaleOfSize;


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
@implementation TDStickerLibrarySectionPreviewCell(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    xmlReader                       = nil;
    framesData                      = nil;
    
    
    [self                           setMiniState: YES];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateTapAction
{
    UITapGestureRecognizer        * tap;
    
    tap                             = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector( _TapAction: )];
    if ( nil == tap )
    {
        return NO;
    }
    
    [self                           addGestureRecognizer: tap];
    SAFE_ARC_RELEASE( tap );
    SAFE_ARC_ASSIGN_POINTER_NIL( tap );
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _TapAction:(UITapGestureRecognizer *) sender
{
    if ( nil == framesData )
    {
        return;
    }
    
    if ( nil == xmlReader )
    {
        xmlReader                   = [TDTexturePakcerXMLReader loadFromData: framesData];
    }
    if ( nil == xmlReader )
    {
        return;
    }
    
    CGRect                          stickerFrame;
    CGRect                          stickerNewFrame;
    CGPoint                         touchPoint;
    NSString                      * stickerName;
    NSString                      * textureName;
    CGFloat                         scale;
    
    stickerFrame                    = CGRectZero;
    stickerNewFrame                 = CGRectZero;
    touchPoint                      = [sender locationInView: self];
    scale                           = [self _CalculateScaleOfSize];
    textureName                     = [xmlReader textureName];
    if ( ( nil == xmlReader ) || ( [xmlReader spriteDataCount] == 0 ) )
    {
        return;
    }
    
    for ( int i = 0; i < [xmlReader spriteDataCount]; ++i )
    {
        stickerFrame                = [xmlReader spriteFrameAtIndex: i];
        stickerName                 = [xmlReader sprinteNameAtIndex: i];
        if ( CGRectEqualToRect( stickerFrame,  CGRectZero ) == true )
        {
            continue;
        }
        
        stickerNewFrame             = calculateNewRectByScaled( stickerFrame, scale );
        if ( CGRectContainsPoint( stickerNewFrame,  touchPoint ) == false )
        {
            continue;
        }
        

        //  set touch origin(OnScreen).
        stickerNewFrame.origin      = [self convertPoint: stickerNewFrame.origin toView: nil];
        
        if ( [self idDelegate] == nil )
        {
            NSLog( @"!!!!Warning!!!! maybe lose to assign delegate of the class: %s ", [NSStringFromClass( [self class] ) UTF8String] );
            NSParameterAssert( [self idDelegate] );
        }
        
        if ( [[self idDelegate] respondsToSelector: @selector( collectionView: didSelectCell: preview: sticker: original: onScreen: )] == YES )
        {
            [[self                  idDelegate] collectionView: (UICollectionView *)[self superview] didSelectCell: self preview: textureName
                                                       sticker: stickerName original: stickerFrame onScreen: stickerNewFrame];
        }
        
        return;
    }
    
    return;
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( CGFloat ) _CalculateScaleOfSize
{
    if ( ( [self backgroundView] == nil ) || ( nil == xmlReader ) )
    {
        return 0.0f;
    }
    
    CGSize                          nowSize;
    CGSize                          originalSize;
    
    nowSize                         = [[self backgroundView] bounds].size;
    originalSize                    = [xmlReader textureSize];
    if ( ( CGSizeEqualToSize( nowSize, CGSizeZero ) == true ) || ( CGSizeEqualToSize( originalSize, CGSizeZero ) == true ) )
    {
        return 0.0f;
    }
        
    //  don't use height to calculate, because when image view setClipsToBounds at tab page, will change image height.
    return ( originalSize.width / nowSize.width );
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  public method implementation.
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public method
@implementation TDStickerLibrarySectionPreviewCell

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.
@synthesize miniState               = _miniState;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithFrame:(CGRect)frame
{
    self                            = [super initWithFrame: frame];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    
    [self                           _CreateTapAction];
    return self;
}

//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithCoder:(NSCoder *)aDecoder
{
    self                            = [super initWithCoder: aDecoder];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    
    [self                           _CreateTapAction];
    return self;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != framesData )
    {
        SAFE_ARC_ASSIGN_POINTER_NIL( framesData );
    }
    
    if ( nil != xmlReader )
    {
        SAFE_ARC_RELEASE( xmlReader );
        SAFE_ARC_ASSIGN_POINTER_NIL( xmlReader );
    }

    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) loadFrames:(NSData *)confgureData
{
    framesData                      = confgureData;
    
    //  don't load & parse on here, delay to touch action.
    return YES;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of UICollectionViewCell.
//  ------------------------------------------------------------------------------------------------
- ( void ) setBackgroundView:(UIView *)backgroundView
{
    if ( nil == backgroundView )
    {
        return;
    }
    [super                          setBackgroundView: backgroundView];
    
    //  init background view's properties.
    [backgroundView                 setContentMode: UIViewContentModeTop];
    [backgroundView                 setClipsToBounds: [self miniState]];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite properties of the class
//  ------------------------------------------------------------------------------------------------
- ( void ) setMiniState:(BOOL)miniState
{
    _miniState                      = miniState;
    if ( [self backgroundView] == nil )
    {
        return;
    }
    [[self                          backgroundView] setClipsToBounds: [self miniState]];
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------









