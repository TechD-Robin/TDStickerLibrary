//
//  TDStickerLibrarySectionStates.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/2/5.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "TDStickerLibrarySectionStates.h"


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
static  NSString  * const kTDSectionStateKeyID                      = @"ID";
static  NSString  * const kTDSectionStateKeyMiniState               = @"MiniState";
static  NSString  * const kTDSectionStateKeyTotalImagesCount        = @"TotalImagesCount";
static  NSString  * const kTDSectionStateKeyShowImagesCount         = @"ShowImagesCount";
static  NSString  * const kTDSectionStateKeyPreviewImageSize        = @"PreviewImageSize";
static  NSString  * const kTDSectionStateKeyNowPreviewImageSize     = @"NowPreviewImagesize";


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibrarySectionStates

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibrarySectionStates ()
{
    NSMutableArray                * sectionStates;
    
    NSMutableDictionary           * currentState;
    
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
@interface TDStickerLibrarySectionStates (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) _GetStateInfoAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDStickerLibrarySectionStates (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    sectionStates                   = nil;
    
    currentState                    = nil;
    
    sectionStates                   = [NSMutableArray new];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) _GetStateInfoAtIndex:(NSInteger)index
{
    if ( ( nil == sectionStates ) || ( [sectionStates count] == 0 ) )
    {
        return nil;
    }
    return [sectionStates objectAtIndex: index];
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
@implementation TDStickerLibrarySectionStates

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.

//  --------------------------------
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    [self                           _InitAttributes];
    return self;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != sectionStates )
    {
        SAFE_ARC_RELEASE( sectionStates );
        SAFE_ARC_ASSIGN_POINTER_NIL( sectionStates );
    }
    
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method create the object.
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) sectionStates
{
    return [[[self class] alloc] init];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( BOOL ) insertStateDataForKey:(NSString *)aKey
{
    if ( nil == aKey )
    {
        return NO;
    }
    
    currentState                    = nil;
    currentState                    = [NSMutableDictionary new];
    if ( nil == currentState )
    {
        return NO;
    }
    
    [currentState                   setValue: aKey forKey: kTDSectionStateKeyID];
    

    [sectionStates                  addObject: currentState];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateImagesCountOfStateData:(NSInteger)count with:(NSInteger)miniCount
{
    if ( nil == currentState )
    {
        return NO;
    }
    [currentState                   setValue: [NSNumber numberWithInteger: count] forKey: kTDSectionStateKeyTotalImagesCount];
    [currentState                   setValue: [NSNumber numberWithInteger: miniCount] forKey: kTDSectionStateKeyShowImagesCount];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updatePreviewImageSizeOfStateData:(CGSize)size with:(CGSize)miniSize
{
    if ( nil == currentState )
    {
        return NO;
    }
    [currentState                   setValue: [NSValue valueWithCGSize: size] forKey: kTDSectionStateKeyPreviewImageSize];
    [currentState                   setValue: [NSValue valueWithCGSize: miniSize] forKey: kTDSectionStateKeyNowPreviewImageSize];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateMiniStateOfStateData:(BOOL)miniState
{
    if ( nil == currentState )
    {
        return NO;
    }
    [currentState                   setValue: [NSNumber numberWithBool: miniState] forKey: kTDSectionStateKeyMiniState];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) numberOfSections
{
    if ( nil == sectionStates )
    {
        return 0;
    }
    return [sectionStates count];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) miniState:(BOOL *)miniState inSection:(NSInteger)section;
{
    NSDictionary                  * stateInfo;
    BOOL                            state;
    
    stateInfo                       = [self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return NO;
    }
    
//    return [[stateInfo objectForKey: kTDSectionStateKeyNowPreviewImageSize] CGSizeValue];
  
    state                           = [[stateInfo objectForKey: kTDSectionStateKeyMiniState] boolValue];
    if ( nil != miniState )
    {
        *miniState                  = state;
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateMiniState:(BOOL)miniState inSection:(NSInteger)section
{
    NSMutableDictionary           * stateInfo;
    
    stateInfo                       = (NSMutableDictionary *)[self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return NO;
    }
    
    [stateInfo                      setValue: [NSNumber numberWithBool: miniState] forKey: kTDSectionStateKeyMiniState];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) numberOfImagesInSection:(NSInteger)section
{
    NSDictionary                  * stateInfo;
    
    stateInfo                       = [self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return 0;
    }
    return [[stateInfo objectForKey: kTDSectionStateKeyShowImagesCount] integerValue];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateNumberOfImages:(NSInteger)count inSection:(NSInteger)section
{
    NSMutableDictionary           * stateInfo;
    
    stateInfo                       = (NSMutableDictionary *)[self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return NO;
    }
    
    //  system cover old data at the same key.
    //[stateInfo                      removeObjectForKey: kTDSectionStateKeyShowImagesCount];
    [stateInfo                      setValue: [NSNumber numberWithInteger: count] forKey: kTDSectionStateKeyShowImagesCount];
    return YES;
}


//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) numberOfTotalImagesInSection:(NSInteger)section
{
    NSDictionary                  * stateInfo;
    
    stateInfo                       = [self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return 0;
    }
    return [[stateInfo objectForKey: kTDSectionStateKeyTotalImagesCount] integerValue];
}

//  ------------------------------------------------------------------------------------------------
- (CGSize) normalSizeOfPreviewImageInSection:(NSInteger)section
{
    NSDictionary                  * stateInfo;
    
    stateInfo                       = [self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return CGSizeZero;
    }
    return [[stateInfo objectForKey: kTDSectionStateKeyPreviewImageSize] CGSizeValue];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateNowSizeOfPreviewImage:(CGSize)size inSection:(NSInteger)section;
{
    NSMutableDictionary           * stateInfo;
    
    stateInfo                       = (NSMutableDictionary *)[self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return NO;
    }
    
    [stateInfo                      setValue: [NSValue valueWithCGSize: size] forKey: kTDSectionStateKeyNowPreviewImageSize];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( CGSize ) nowSizeOfPreviewImageInSection:(NSInteger)section
{
    NSDictionary                  * stateInfo;
    
    stateInfo                       = [self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return CGSizeZero;
    }
    return [[stateInfo objectForKey: kTDSectionStateKeyNowPreviewImageSize] CGSizeValue];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------















