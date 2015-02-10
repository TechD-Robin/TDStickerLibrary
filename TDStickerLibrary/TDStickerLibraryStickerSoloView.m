//
//  TDStickerLibraryStickerSoloView.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/2/11.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "TDMath.h"
#import "UIKit+TechD.h"
#import "TDStickerLibraryStickerSoloView.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibrarySectionHeader

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  declare property for private category()
//  ------------------------------------------------------------------------------------------------
#pragma mark declare property ()
@interface TDStickerLibraryStickerSoloView ()
{
    //  sticker image view.
    CGSize                          stickerOriginalSize;
    CGRect                          stickerOnScreenFrame;
    UIImageView                   * stickerImageView;
    
    
    /**
     *  assign the block method point than call the block method when the view show action is finish.(change to hidden)
     */
    FinishedCallbackBlock           finishCallbackBlock;
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
@interface TDStickerLibraryStickerSoloView(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create tap gesture recognizer.
 *  create tap gesture recognizer for self (header object).
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _CreateTapAction;

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateStickerImageView:(UIImage *)stickerImage;

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _BringTheViewToFront;
- ( BOOL ) _SendTheViewToBack;

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
@implementation TDStickerLibraryStickerSoloView(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    //  sticker image view.
    stickerOriginalSize             = CGSizeZero;
    stickerOnScreenFrame            = CGRectZero;
    stickerImageView                = nil;
    
    finishCallbackBlock             = nil;
    
    //  background. ( clear view )
    [self                           setBackgroundColor: [UIColor clearColor]];
    [self                           setUserInteractionEnabled: YES];
    [self                           setHidden: YES];
    [self                           _CreateTapAction];

}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for create object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateTapAction
{
    return [UIGestureRecognizer tapGestureRecognizer: self withTarget: self action: @selector( _TapAction: )];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _TapAction:(UITapGestureRecognizer *) sender
{
    NSLog( @"tap ..." );
    
    
    [self                           _SendTheViewToBack];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateStickerImageView:(UIImage *)stickerImage
{
    if ( nil == stickerImage )
    {
        return NO;
    }
    
    stickerImageView                = [[UIImageView alloc] initWithImage: stickerImage];
    if ( nil == stickerImage )
    {
        return NO;
    }

    [stickerImageView               setFrame: stickerOnScreenFrame];
    [self                           addSubview: stickerImageView];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _BringTheViewToFront
{
    CGSize                          mainSize;
    CGFloat                         stickerRatio;
    CGRect                          stickerMaxFrame;
    
    mainSize                        = [[UIScreen mainScreen] bounds].size;
    stickerRatio                    = ( stickerOriginalSize.height / stickerOriginalSize.width );
    stickerMaxFrame.size            = calculateProportionalMaxSizeWithLimit( stickerRatio, stickerOriginalSize, mainSize );
    stickerMaxFrame.origin          = CGPointMake( ( ( mainSize.width - stickerMaxFrame.size.width ) / 2.0f ) , ( ( mainSize.height - stickerMaxFrame.size.height ) / 2.0f ) );
    
    
    //  run animation.
    __weak id                       blockSelf;
    __weak id                       blockSticker;
    
    blockSelf                       = self;
    blockSticker                    = stickerImageView;
    [self                           setHidden: NO];
    [UIView animateWithDuration: 0.25f animations: ^
    {
        CGRect                      newFrame;
        
        newFrame                    = CGRectInset( stickerMaxFrame, -12.0f, -12.0f );
        [blockSticker               setFrame: newFrame];
    }
    completion: ^ ( BOOL finished )
    {
        
    }];
    
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _SendTheViewToBack
{
    __weak id                       blockSelf;
    __weak id                       blockSticker;
    
    blockSelf                       = self;
    blockSticker                    = stickerImageView;
    [UIView animateWithDuration: 0.25f animations: ^
    {
        [blockSticker               setFrame: stickerOnScreenFrame];
    }
    completion: ^ ( BOOL finished )
    {
        
        
        [blockSelf                 setHidden: YES];
        [blockSelf                 removeFromSuperview];
        
        if ( nil != finishCallbackBlock )
        {
            finishCallbackBlock( finished );
        }
        
    }];
    
    return YES;
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
@implementation TDStickerLibraryStickerSoloView

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( instancetype ) initWithStickerSoloView:(UIImage *)stickerImage original:(CGSize)stickerSize onScreen:(CGRect)nowFrame
                                      with:(UIWindow *)window customization:(TDStickerLibraryCustomization *)customization
{
    self                            = [super initWithFrame: [[UIScreen mainScreen] bounds]];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    
    //  sticker image view.
    stickerOriginalSize             = stickerSize;
    stickerOnScreenFrame            = nowFrame;
    [self                           _CreateStickerImageView: stickerImage];
    
    
    if ( nil != window )
    {
        [window                     addSubview: self];
    }
    return self;
    
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) stickerSoloView:(UIImage *)stickerImage original:(CGSize)stickerSize onScreen:(CGRect)nowFrame
                              with:(UIWindow *)window customization:(TDStickerLibraryCustomization *)customization
{
    return [[[self class] alloc] initWithStickerSoloView: stickerImage original: stickerSize onScreen: nowFrame with: window customization: customization];
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) showSoloView:(void (^)(void))showView completion:(FinishedCallbackBlock)completion
{
    [self                               _BringTheViewToFront];
    
    //  execute showView block pointer.
    if ( nil != showView )
    {
        showView();
    }
    
    //  set callback block pointer.
    if ( nil != completion )
    {
        finishCallbackBlock             = completion;
    }
}

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------









