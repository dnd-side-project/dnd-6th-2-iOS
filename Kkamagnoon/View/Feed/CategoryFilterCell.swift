//
//  CategoryFilterCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/06.
//

import UIKit

final class CategoryFilterCell: UICollectionViewCell {
    var categoryLabel: UILabel = UILabel()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: Color.tag)
        setLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLabel() {
        categoryLabel.textColor = UIColor(rgb: Color.tagText)
        categoryLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(categoryLabel)

        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        categoryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        categoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes)
    -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()
        let size = categoryLabel.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.width = ceil(size.width + 32)
        layoutAttributes.frame = frame

        return layoutAttributes
    }

}
