// UploadDataAutonomousHealthCard.swift
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

struct UploadDataAutonomousHealthCardVM: ViewModel {}

final class UploadDataAutonomousHealthCard: UICollectionViewCell, ModellableView, ReusableView {
  typealias VM = UploadDataAutonomousHealthCardVM
  private static let textHorizontalPadding: CGFloat = 25.0
  private static let imageToTextPadding: CGFloat = 17.0

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
    self.contentView.addSubview(self.imageContent)
  }

  func style() {
    Self.Style.textualContent(self.textContent)
    Self.Style.imageContent(self.imageContent)
  }

  func update(oldModel: VM?) {
    guard let _ = self.model else {
      return
    }
      self.setNeedsLayout()
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let imageSize = self.imageContent.image?.size ?? .zero

    self.textContent.pin
      .right(Self.textHorizontalPadding)
      .top()
      .left(Self.textHorizontalPadding + imageSize.width + Self.imageToTextPadding)
      .sizeToFit(.width)

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

private extension UploadDataAutonomousHealthCard {
  enum Style {
    static func textualContent(_ label: UILabel) {
      let content = "Tessera Sanitaria per comunicare le ultime 8 cifre che permettono di salvaguardare la tua privacy"
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

    static func imageContent(_ imageView: UIImageView) {
      imageView.image = Asset.Settings.UploadData.id.image
      imageView.contentMode = .scaleAspectFit
    }
  }
}
