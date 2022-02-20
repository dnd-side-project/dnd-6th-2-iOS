//
//  SelectingTagCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/15.
//

import UIKit
import Then
import SnapKit

class SelectingTagCell: UICollectionViewCell {

    static let selectingTagCellIdentifier = "SelectingTagCellIdentifier"

    let tagView = TagView(top: 17, bottom: -17, leading: 0, trailing: 0)
        .then {
            $0.categoryLabel.font = UIFont.pretendard(weight: .semibold, size: 16)
            $0.categoryLabel.textColor = .white
            $0.backgroundColor = .black
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(rgb: 0x393939).cgColor
            $0.layer.cornerRadius = 26.5
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView(top: 17, bottom: -17, leading: 0, trailing: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView(top: CGFloat, bottom: CGFloat, leading: CGFloat, trailing: CGFloat) {
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

    private func configureSelected() {
      if isSelected {
          self.tagView.backgroundColor = UIColor(rgb: Color.tagGreen)
          self.tagView.categoryLabel.textColor = .white
          return
      }

        self.tagView.backgroundColor = .black
        self.tagView.categoryLabel.textColor = UIColor(rgb: Color.tagText)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        configureSelected()
    }
}
