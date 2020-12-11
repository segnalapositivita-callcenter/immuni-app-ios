// UploadDataAutonomousCallCenter.swift
// Copyright (C) 2020 Presidenza del Consiglio dei Ministri.
// Please refer to the AUTHORS file for more information.
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

import BonMot
import Extensions
import Foundation
import Katana
import PinLayout
import Tempura

struct UploadDataAutonomousCallCenterVM: ViewModel {
}

final class UploadDataAutonomousCallCenter: UICollectionViewCell, ModellableView, ReusableView {
  typealias VM = UploadDataAutonomousCallCenterVM
  private static let textHorizontalPadding: CGFloat = 25.0
  private static let imageToTextPadding: CGFloat = 17.0

  private var title = UILabel()
  private var textContent = UILabel()
  private var imageContent = UIImageView()
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
    self.style()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setup()
    self.style()
  }

  func setup() {
    self.contentView.addSubview(self.textContent)
    self.contentView.addSubview(self.title)
    self.contentView.addSubview(self.imageContent)
  }

  func style() {
    Self.Style.textualContent(self.textContent)
    Self.Style.title(self.title)
    Self.Style.imageContent(self.imageContent)
  }

  func update(oldModel: VM?) {
    guard let _ = model else {
        return
    }
    self.setNeedsLayout()

  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let imageSize = self.imageContent.image?.size ?? .zero

    self.title.pin
      .right(Self.textHorizontalPadding)
      .left(Self.textHorizontalPadding + imageSize.width + Self.imageToTextPadding)
      .sizeToFit(.width)
    
    self.textContent.pin
      .below(of: self.title)
      .right(Self.textHorizontalPadding)
      .left(Self.textHorizontalPadding + imageSize.width + Self.imageToTextPadding)
      .sizeToFit(.width)
      .marginTop(5)

    self.imageContent.pin
      .before(of: self.textContent, aligned: .center)
      .left(Self.textHorizontalPadding)
      .sizeToFit()
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    let imageSize = self.imageContent.intrinsicContentSize

    let labelSpace = CGSize(
      width: size.width - Self.textHorizontalPadding * 2 - imageSize.width - Self.imageToTextPadding,
      height: .infinity
    )
    let labelSize = self.textContent.sizeThatFits(labelSpace)

    return CGSize(width: size.width, height: labelSize.height)
  }
}

private extension UploadDataAutonomousCallCenter {
  enum Style {
    static func textualContent(_ label: UILabel) {
      let content = "Numero attivo h24"
      let textStyle = TextStyles.p.byAdding(
        .color(Palette.grayNormal),
        .xmlRules([
          .style("b", TextStyles.pSemibold)
        ])
      )

      TempuraStyles.styleStandardLabel(
        label,
        content: content,
        style: textStyle
      )
    }
    static func title(_ label: UILabel) {
      let content = "Chiama il call center"
      let textStyle = TextStyles.pSemibold.byAdding(
        .color(Palette.grayDark),
        .alignment(.left)
      )

      TempuraStyles.styleStandardLabel(
        label,
        content: content,
        style: textStyle
      )
    }

    static func imageContent(_ imageView: UIImageView) {
      imageView.image = Asset.Settings.UploadData.phone.image
      imageView.contentMode = .scaleAspectFit
    }
  }
}
