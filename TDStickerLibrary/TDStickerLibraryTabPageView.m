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

#import "UIKit+TechD.h"

#import "TDStickerLibraryTabPageView.h"
#import "TDStickerLibraryTabPageLayout.h"
#import "TDStickerLibrarySectionHeader.h"
#import "TDStickerLibrarySectionPreviewCell.h"

#import "TDStickerLibraryTabPageInfo.h"
#import "TDStickerLibrarySectionStates.h"

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
<TDSectionHeaderDelegate>
{
    
    TDStickerLibraryCustomization * customizationParam;
    
    
    TDStickerLibraryTabPageInfo   * pageConfigure;
    TDStickerLibrarySectionStates * sectionStates;
    
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

- ( void ) _InitSectionStates;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create layout of the collection view with customization.
 *  create layout of the collection view with customization.
 *
 *  @param customization            customization object for the Sticker Library.
 *
 *  @return layout|nil              the layout object or nil.
 */
+ ( UICollectionViewLayout * ) _CreateLayout:(TDStickerLibraryCustomization *)customization;


//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create header view of the collection view at index path.
 *  create header view of the collection view at index path.
 *
 *  @param collectionView           the collection view object( header's super view )
 *  @param indexPath                indexPath object of table(collectionView).
 *
 *  @return header|nil              the header object or nil.
 */
- (UICollectionReusableView *) _CreateSectionHeader:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create sticker view(a cell view) of the collection view at index path.
 *  create sticker view(a cell view) of the collection view at index path.
 *
 *  @param indexPath                indexPath object of table(collectionView).
 *
 *  @return sticker|nil             the sticker object or nil.
 */
- ( UIImageView * ) _CreateCommonSticker:(NSIndexPath *)indexPath;

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
    sectionStates                   = nil;
    
    
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
    
    
    [self                           _InitSectionStates];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _InitSectionStates
{
    if ( ( nil == pageConfigure ) || ( [pageConfigure infoDataCount] == 0 ) )
    {
        return;
    }
    
    sectionStates                   = [TDStickerLibrarySectionStates sectionStates];
    if ( nil == sectionStates )
    {
        return;
    }
    
    NSString                      * ID;
    NSInteger                       imageCount;
    
    ID                              = nil;
    imageCount                      = 0;
    for ( int i = 0; i < [pageConfigure infoDataCount]; ++i )
    {
        ID                          = [pageConfigure dataIDAtIndex: i];
        if ( nil != ID )
        {
            [sectionStates          insertStateDataForKey: ID];
        }
        
        imageCount                  = [pageConfigure countOfImageDataAtIndex: i];
        [sectionStates              updateImagesCountOfStateData: imageCount];
        
        
        
    }
    
    
    
    
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create object.
//  ------------------------------------------------------------------------------------------------
+ ( UICollectionViewLayout * ) _CreateLayout:(TDStickerLibraryCustomization *)customization
{
    TDStickerLibraryTabPageLayout * layout;
    
    layout                          = [TDStickerLibraryTabPageLayout new];
    if ( nil == layout )
    {
        return nil;
    }
    
    [layout                         setScrollDirection: UICollectionViewScrollDirectionVertical];
    //[layout                         setScrollDirection: UICollectionViewScrollDirectionHorizontal];
    
    [layout                         setItemSize: [customization tableCommonItemSize]];
    [layout                         setSectionInset: [customization tableCommonSectionInset]];
    [layout                         setHeaderReferenceSize: [customization tableCommonHeaderReferenceSize]];
    
    return layout;
}

//  ------------------------------------------------------------------------------------------------
- (UICollectionReusableView *) _CreateSectionHeader:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    if ( ( nil == collectionView ) || ( nil == indexPath ) )
    {
        return nil;
    }
    
    NSString                      * title;
    TDStickerLibrarySectionHeader * header;
    
    title                           = nil;
    header                          = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader
                                                                         withReuseIdentifier: NSStringFromClass( [TDStickerLibrarySectionHeader class] ) forIndexPath: indexPath];
    if ( nil == header )
    {
        return nil;
    }
    
    title                           = [pageConfigure dataTitleAtIndex: indexPath.section];
    if ( nil == title )
    {
        return header;
    }
    
    [header                         setIdDelegate: self];
    [header                         setSectionIndex: indexPath.section];
    [header                         setSectionTitle: title];
    return header;
}


//  ------------------------------------------------------------------------------------------------
- ( UIImageView * ) _CreateCommonSticker:(NSIndexPath *)indexPath
{
    
    NSString                      * imageName;
    NSData                        * imageData;
    UIImage                       * stickerImage;
    UIImageView                   * stickerView;
    
    stickerImage                    = nil;
    stickerView                     = nil;
    imageName                       = [pageConfigure imageNameAtIndex: indexPath.section inArray: indexPath.row];
    if ( nil == imageName )
    {
        return nil;
    }
    
    imageData                       = [pageConfigure imageDataForKey: imageName];
    if ( nil == imageName )
    {
        return nil;
    }
    
    stickerImage                    = [UIImage imageWithData: imageData];
    if ( nil == stickerImage )
    {
        return nil;
    }
    
    //stickerView                     = [[UIImageView alloc] initWithImage: stickerImage];
    stickerView                     = [UIImageView proportionalImageView: stickerImage reference: [customizationParam tableCommonItemSize] originWith: [customizationParam tableCommonItemSize]];
    if ( nil == stickerView )
    {
        SAFE_ARC_RELEASE( image );
        return nil;
    }
    
    SAFE_ARC_RELEASE( image );
    SAFE_ARC_ASSIGN_POINTER_NIL( image );
    return stickerView;
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
    
    layout                          = (TDStickerLibraryTabPageLayout *)[[self class] _CreateLayout: customization];
    if ( nil == layout )
    {
        NSLog( @"create table layout fail." );
        return nil;
    }
    [layout                         setIdDelegate: self];
    
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
    if ( nil == sectionStates )
    {
        return 0;
    }
    return [sectionStates numberOfImagesInSection: section];
}

//  ------------------------------------------------------------------------------------------------
- ( UICollectionViewCell * ) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell          * cell;
    UIImageView                   * stickerView;
    
    stickerView                     = nil;
    cell                            = [collectionView dequeueReusableCellWithReuseIdentifier: NSStringFromClass( [UICollectionViewCell class] ) forIndexPath: indexPath];
    
    

    
    stickerView                     = [self _CreateCommonSticker: indexPath];
    if ( nil == stickerView )
    {
        return cell;
    }
    
    [cell                           setBackgroundView: stickerView];
    return cell;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark protocol optional for UICollectionViewDataSource.
//  ------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ( nil == sectionStates )
    {
        return 0;
    }
    return [sectionStates numberOfSections];
}

//  ------------------------------------------------------------------------------------------------
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ( [kind isEqualToString: UICollectionElementKindSectionHeader] == NO )
    {
        return nil;
    }
    
    TDStickerLibrarySectionHeader * header;
    
    header                          = (TDStickerLibrarySectionHeader *)[self _CreateSectionHeader: collectionView atIndexPath: indexPath];
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
    if ( [(UICollectionViewFlowLayout *)collectionViewLayout scrollDirection] == UICollectionViewScrollDirectionHorizontal )
    {
        return CGSizeMake( [customizationParam tableCommonHeaderReferenceSize].height, [collectionView frame].size.height );
    }
    return CGSizeMake( [collectionView frame].size.width, [customizationParam tableCommonHeaderReferenceSize].height );
}

//  ------------------------------------------------------------------------------------------------
#pragma mark protocol optional for UICollectionViewDelegate.
//  ------------------------------------------------------------------------------------------------
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog( @"( %d, %d )", indexPath.section, indexPath.row );
    
//    NSLog( @"%@", [NSLocale availableLocaleIdentifiers]);
    
}

//  ------------------------------------------------------------------------------------------------
#pragma mark protocol required for TDSectionHeaderDelegate.
//  ------------------------------------------------------------------------------------------------
- ( void ) collectionView:(UICollectionView *)collectionView didSelectHeaderInSection:(NSInteger)section
{
    if  ( ( nil == sectionStates ) || ( [sectionStates numberOfSections] < section ) || ( nil == collectionView ) || ( [collectionView collectionViewLayout] == nil ) )
    {
        return;
    }
    
    NSInteger                       rowCapacity;
    NSInteger                       imageNowCount;
    NSInteger                       imageTotal;
    TDStickerLibraryTabPageLayout * layout;
    
    
    layout                          = (TDStickerLibraryTabPageLayout *)[collectionView collectionViewLayout];
    rowCapacity                     = [layout calculateFirstRowCapacityForSectionAtIndex: section];
    imageTotal                      = [sectionStates numberOfTotalImagesInSection: section];
    imageNowCount                   = [sectionStates numberOfImagesInSection: section];
    //  when image count less then row's capacity, skip change.
    if ( imageNowCount < rowCapacity )
    {
        return;
    }
    
    //  section content to max.
    if ( imageNowCount < imageTotal )
    {
        [sectionStates              updateNumberOfImages: imageTotal inSection: section];
    }
    else
    {
        [sectionStates              updateNumberOfImages: rowCapacity inSection: section];
    }
    
    //  section content to mini.
    
    [layout                         needUpdateLayoutAttributes: YES];
    [self                           reloadData];
    
    
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------






























