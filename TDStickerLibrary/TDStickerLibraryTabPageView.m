//
//  TDStickerLibraryTabPageView.m
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

#import "TDStickerLibraryTabPageView.h"
#import "TDStickerLibraryTabPageLayout.h"
#import "TDStickerLibrarySectionHeader.h"
#import "TDStickerLibrarySectionPreviewCell.h"

#import "TDStickerLibraryTabPageInfo.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryViewController

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  declare property for private category()
//  ------------------------------------------------------------------------------------------------
#pragma mark declare property ()
@interface TDStickerLibraryTabPageView ()
{
    
    TDStickerLibraryCustomization * customizationParam;
    
    
    TDStickerLibraryTabPageInfo   * pageConfigure;
    
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
@interface TDStickerLibraryTabPageView(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;
- ( void ) _RegisterClasses;

//  ------------------------------------------------------------------------------------------------
- ( void ) _LoadSystemConfigure:(NSString *)configure forKey:(NSString *)aKey;

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
@implementation TDStickerLibraryTabPageView(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    customizationParam              = nil;
    
    pageConfigure                   = nil;
    
    
    [self                           setDataSource: self];
    [self                           setDelegate: self];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _RegisterClasses
{
    [self                           registerClass: [UICollectionViewCell class]
                       forCellWithReuseIdentifier: NSStringFromClass( [UICollectionViewCell class] )];
    
    [self                           registerClass: [TDStickerLibrarySectionPreviewCell class]
                       forCellWithReuseIdentifier: NSStringFromClass( [TDStickerLibrarySectionPreviewCell class] )];
    
    [self                           registerClass: [TDStickerLibrarySectionHeader class]
                       forSupplementaryViewOfKind: UICollectionElementKindSectionHeader
                              withReuseIdentifier: NSStringFromClass( [TDStickerLibrarySectionHeader class] )];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _LoadSystemConfigure:(NSString *)configure forKey:(NSString *)aKey
{
    pageConfigure                   = [TDStickerLibraryTabPageInfo loadDataFromZip: configure forDirectories: TDResourcesDirectory inDirectory: [customizationParam configureResource] inZippedPath: configure configure: aKey];
    if ( nil == pageConfigure )
    {
        return;
    }
    
    
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
//  --------------------------------
#pragma mark -
#pragma mark implementation for public method
@implementation TDStickerLibraryTabPageView

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != customizationParam )
    {
        //  release by creator.
        SAFE_ARC_ASSIGN_POINTER_NIL( customizationParam );
    }
    
    if ( nil != pageConfigure )
    {
        SAFE_ARC_RELEASE( pageConfigure );
        SAFE_ARC_ASSIGN_POINTER_NIL( pageConfigure );
    }
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithFrame:(CGRect)frame customization:(TDStickerLibraryCustomization *)customization
                            data:(NSString *)configure forKey:(NSString *)aKey
{
    if ( nil == customization )
    {
        NSLog( @"customization parameter cannot nil." );
        return nil;
    }
    if ( ( nil == configure ) || ( nil == aKey ) )
    {
        NSLog( @"data parameter cannot nil." );
        return nil;
    }
    
    TDStickerLibraryTabPageLayout * layout;
    
    layout                          = [TDStickerLibraryTabPageLayout new];
    if ( nil == layout )
    {
        NSLog( @"create table layout fail." );
        return nil;
    }
    [layout                         setItemSize: [customization tableCommonItemSize]];
    [layout                         setSectionInset: [customization tableCommonSectionInset]];
    [layout                         setHeaderReferenceSize: [customization tableCommonHeaderReferenceSize]];
    
    self                            = [super initWithFrame: frame collectionViewLayout: layout];
    if ( nil == self )
    {
        return nil;
    }
    [self                           _InitAttributes];
    [self                           _RegisterClasses];
    customizationParam              = customization;
    
    [self                           _LoadSystemConfigure: configure forKey: aKey];
    return self;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) tabPageWithFrame:(CGRect)frame customization:(TDStickerLibraryCustomization *)customization
                               data:(NSString *)configure forKey:(NSString *)aKey
{
    return [[[self class] alloc] initWithFrame: frame customization: customization data: configure forKey: aKey];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark protocol required for UICollectionViewDataSource.
//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

//  ------------------------------------------------------------------------------------------------
- ( UICollectionViewCell * ) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell          * cell;
    
    cell                            = [collectionView dequeueReusableCellWithReuseIdentifier: NSStringFromClass( [UICollectionViewCell class] ) forIndexPath: indexPath];
    
    return cell;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark protocol optional for UICollectionViewDataSource.
//  ------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 0;
}

//  ------------------------------------------------------------------------------------------------
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ( [kind isEqualToString: UICollectionElementKindSectionHeader] == NO )
    {
        return nil;
    }
    
    TDStickerLibrarySectionHeader * header;
    
    header                          = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader
                                                                         withReuseIdentifier: NSStringFromClass( [TDStickerLibrarySectionHeader class] ) forIndexPath: indexPath];
    if ( nil == header )
    {
        return nil;
    }
    
    
    return header;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark protocol optional for UICollectionViewDelegateFlowLayout.
//  ------------------------------------------------------------------------------------------------
- ( CGSize ) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [customizationParam tableCommonItemSize];
}

//  ------------------------------------------------------------------------------------------------
- ( UIEdgeInsets ) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return [customizationParam tableCommonSectionInset];
}

//  ------------------------------------------------------------------------------------------------
- ( CGSize ) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return [customizationParam tableCommonHeaderReferenceSize];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------






























