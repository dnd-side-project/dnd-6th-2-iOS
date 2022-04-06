//
//  CategoryFilterCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/06.
//

import UIKit
import SnapKit

final class CategoryFilterCell: UICollectionViewCell {

    static let categoryFilterCellIdentifier = "CategoryFilterCellIdentifier"

    var selectCount: Int = 0

    let tagView = TagView(top: 10.0,
                          bottom: -10.0,
                          leading: 16.0,
                          trailing: -16.0)

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.layer.cornerRadius = 18.0

        self.addSubview(tagView)

        tagView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 18.0

        self.addSubview(tagView)

        tagView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override var isSelected: Bool {
        didSet {
            configureSelected()
        }
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes)
    -> UICollectionViewLayoutAttributes {

        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()
        let size = tagView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.width = ceil(size.width)
        layoutAttributes.frame = frame

        return layoutAttributes
    }

    override func prepareForReuse() {
        // super 꼭 부르기
        super.prepareForReuse()
        tagView.categoryLabel.text = nil
        configureSelected()
    }

    private func configureSelected() {
        if isSelected {
            self.tagView.backgroundColor = UIColor(rgb: Color.tagGreen)
            self.tagView.categoryLabel.textColor = .white

        } else {
            self.tagView.backgroundColor = UIColor(rgb: Color.tag)
            self.tagView.categoryLabel.textColor = UIColor(rgb: Color.tagText)
        }
    }

}
