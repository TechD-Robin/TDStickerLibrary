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
    /**
     *  the container of section's states.
     */
    NSMutableArray                * sectionStates;
    
    /**
     *  the current data of section's state for new a record.
     */
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
#pragma mark declare for state information.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a state information at index.
 *  get a state information at index.
 *
 *  @param index                    index of state information.
 *
 *  @return data|nil                the state data or nil.
 */
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
#pragma mark method for state information.
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
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) sectionStates
{
    return [[[self class] alloc] init];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for i/o a state data.
//  ------------------------------------------------------------------------------------------------
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
- ( NSInteger ) numberOfSections
{
    if ( nil == sectionStates )
    {
        return 0;
    }
    return [sectionStates count];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for i/o the state data in section.
//  ------------------------------------------------------------------------------------------------
//  mini state.
- ( BOOL ) miniState:(BOOL *)miniState inSection:(NSInteger)section;
{
    NSDictionary                  * stateInfo;
    BOOL                            state;
    
    stateInfo                       = [self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return NO;
    }
    
    state                           = [[stateInfo objectForKey: kTDSectionStateKeyMiniState] boolValue];
    if ( NULL != miniState )
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
//  image's count.
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
//  preview image's size.
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















