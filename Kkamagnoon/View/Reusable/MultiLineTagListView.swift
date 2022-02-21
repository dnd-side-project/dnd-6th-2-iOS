//
//  MultiLineTagListView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/19.
//

import UIKit
import Then
import SnapKit

class MultiLineTagListView: UIView {

    var tagList: [String] = []

    let verticalStackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.spacing = 7
            $0.alignment = .leading
            $0.distribution = .fill
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.addSubview(verticalStackView)

        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }

    func setTags() {

        let margin = 5.3
        let maxWidth = UIScreen.main.bounds.width - 137
        var nowWidth: CGFloat = 0

        let horizontalStackView = UIStackView()
            .then {
                $0.axis = .horizontal
                $0.spacing = margin
                $0.alignment = .fill
                $0.distribution = .fill
            }

        var nowAddingStack = horizontalStackView
        verticalStackView.addArrangedSubview(nowAddingStack)

        for keyword in tagList {

            let tagView = TagView(top: 7, bottom: -7, leading: 14, trailing: -14)
            tagView.setContentHuggingPriority(.required, for: .horizontal)
            tagView.categoryLabel.text = keyword

            let width = keyword.width(forHeight: 20, font: UIFont.pretendard(weight: .medium, size: 12))

            let tagViewWidth = 14 + width + 14

            if nowWidth + (tagViewWidth + margin) < maxWidth {
                nowAddingStack.addArrangedSubview(tagView)
                nowWidth += (tagViewWidth + margin)
            } else {
                let horizontalStackView = UIStackView()
                    .then {
                        $0.axis = .horizontal
                        $0.spacing = margin
                        $0.alignment = .fill
                        $0.distribution = .fill
                    }
                nowAddingStack = horizontalStackView
                verticalStackView.addArrangedSubview(nowAddingStack)
                nowAddingStack.addArrangedSubview(tagView)
                nowWidth = (tagViewWidth + margin)
            }

        }
    }

    func removeTags() {
        // 제대로 메모리 해제되는게 맞는지...
        while let first = verticalStackView.arrangedSubviews.first {
            verticalStackView.removeArrangedSubview(first)
            first.removeFromSuperview()
        }
    }
}
