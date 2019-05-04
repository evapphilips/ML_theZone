//
//  ZoomAndSnapUICollectionViewFlowLayout.swift
//  theZone
//
//  Created by Eva Philips on 4/21/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit

class ZoomAndSnapUICollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    let activeDistance: CGFloat = 200
    let zoomFactor: CGFloat = 0.3
    
    // initialize collection view
    override init() {
        super.init()
        
        scrollDirection = .horizontal
        minimumLineSpacing = 70
        // itemSize = CGSize(width: 150, height: 150)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // prepare collection view
    override func prepare() {
        guard let collectionView = collectionView else { fatalError() }
        
        itemSize = CGSize(width: 250, height: 250)
        
        let verticalInsets = (collectionView.frame.height - collectionView.adjustedContentInset.top - collectionView.adjustedContentInset.bottom - itemSize.height) / 2
        let horizontalInsets = (collectionView.frame.width - collectionView.adjustedContentInset.right - collectionView.adjustedContentInset.left - itemSize.width) / 2
        sectionInset = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
        
        // dont animate when keyboard raises
        collectionView.contentInsetAdjustmentBehavior = .never
        
        // set paging
        collectionView.isPagingEnabled = true;
        
        super.prepare()
    }
    
    // collection view attribute layout
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)
        
        // Make the cells be zoomed when they reach the center of the screen
        for attributes in rectAttributes where attributes.frame.intersects(visibleRect) {
            let distance = visibleRect.midX - attributes.center.x
            let normalizedDistance = distance / activeDistance
            
            if distance.magnitude < activeDistance {
                let zoom = 1 + zoomFactor * (1 - normalizedDistance.magnitude)
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
                attributes.zIndex = Int(zoom.rounded())
            }
        }
        
        return rectAttributes
    }
    
    // collection view target content offset
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }
        let dragOffset = collectionView.frame.width / 2
        let itemIndex = round(proposedContentOffset.x / dragOffset)
        let xOffset = itemIndex * dragOffset
        return CGPoint(x: xOffset, y: 0)
    }
        
        
//        guard let collectionView = collectionView else { return .zero }
//
//        // Add some snapping behaviour so that the zoomed cell is always centered
//        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
//        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
//
//        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
//        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
//
//
//        for layoutAttributes in rectAttributes {
//            let itemHorizontalCenter = layoutAttributes.center.x
//            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
//                offsetAdjustment = itemHorizontalCenter - horizontalCenter
//            }
//        }
//
//        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
//    }
    
    // only validate main cell of collection view
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // Invalidate layout so that every cell get a chance to be zoomed when it reaches the center of the screen
        return true
    }
    
    // only validate main context of collection view
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }

}
