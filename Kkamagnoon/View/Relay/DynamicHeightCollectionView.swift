//
//  DynamicHeightCollectionView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/14.
//

import UIKit

class DynamicHeightCollectionView: UICollectionView {
  override func layoutSubviews() {
    super.layoutSubviews()
    if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
      self.invalidateIntrinsicContentSize()
    }
  }
  override var intrinsicContentSize: CGSize {
    return contentSize
  }
}
