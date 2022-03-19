//
//  SearchTabMenuCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/19.
//

import UIKit
import Then

class SearchTabMenuCell: UICollectionViewCell {

    static let identifier = "SearchTabMenuCellIdentifier"

    var textLabel = UILabel()
        .then {
            $0.textColor = UIColor(rgb: 0x767676)
            $0.font = UIFont.pretendard(weight: .regular, size: 16.0)
            $0.textAlignment = .center
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel.text = nil
        configureSelected()
    }

    override var isSelected: Bool {
        didSet {
            configureSelected()
        }
    }

}

extension SearchTabMenuCell {
    func setView() {
        self.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
    }

    private func configureSelected() {
        if isSelected {
            textLabel.textColor = .white
            textLabel.font = UIFont.pretendard(weight: .semibold, size: 16.0)
            return
        }

        textLabel.textColor = UIColor(rgb: 0x767676)
        textLabel.font = UIFont.pretendard(weight: .regular, size: 16.0)
    }
}
