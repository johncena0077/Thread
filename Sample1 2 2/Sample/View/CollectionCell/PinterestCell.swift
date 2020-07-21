//
//  PinterestCell.swift
//  PinterestLayout
//
//  Created by Khrystyna Shevchuk on 7/7/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


let pinterestCellIdentifier = "PinterestLayout.PinterestCell"


public class PinterestCell: UICollectionViewCell {
    
    static let annotationPadding: CGFloat = 10

    
    private var _roundedCornersView: UIView?
    public var roundedCornersView: UIView {
        get {
            if let roundedCornersView = _roundedCornersView {
                return roundedCornersView
            }
            let roundedCornersView = UIView(frame: bounds)
            _roundedCornersView = roundedCornersView
            
            contentView.addSubview(roundedCornersView)
            roundedCornersView.addConstraintsAlignedToSuperview()

            
            return roundedCornersView
        }
    }
    
    private var _imageView: UIImageView?
    public var imageView: UIImageView {
        get {
            if let imageView = _imageView {
                return imageView
            }
            let imageView = UIImageView(frame: roundedCornersView.bounds)
            _imageView = imageView
            
            roundedCornersView.addSubview(imageView)
            self.addConstraintsForImageView()
            
            imageView.contentMode = .scaleAspectFit
            
            return imageView
        }
    }
   
    
    fileprivate var imageViewHeightLayoutConstraint: NSLayoutConstraint?
    fileprivate var imageHeight: CGFloat!
    
    override public func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
            imageHeight = attributes.imageHeight
            if let imageViewHeightLayoutConstraint = self.imageViewHeightLayoutConstraint {
                imageViewHeightLayoutConstraint.constant = attributes.imageHeight
            }
        }
    }
}


extension PinterestCell {
    
    func addConstraintsForImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        roundedCornersView.addConstraint(
            NSLayoutConstraint(
                item: imageView,
                attribute: .top,
                relatedBy: .equal,
                toItem: roundedCornersView,
                attribute: NSLayoutConstraint.Attribute.top,
                multiplier: 1,
                constant: 10
            )
        )
        roundedCornersView.addConstraint(
            NSLayoutConstraint(
                item: imageView,
                attribute: .leading,
                relatedBy: .equal,
                toItem: roundedCornersView,
                attribute: .leading,
                multiplier: 1,
                constant: 0
            )
        )
        roundedCornersView.addConstraint(
            NSLayoutConstraint(
                item: imageView,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: roundedCornersView,
                attribute: .trailing,
                multiplier: 1,
                constant: 0
            )
        )
        
        let imageViewHeightLayoutConstraint =
            NSLayoutConstraint(
                item: imageView,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: imageHeight
        )
        imageView.addConstraint(imageViewHeightLayoutConstraint)
        self.imageViewHeightLayoutConstraint = imageViewHeightLayoutConstraint
    }
    
}
