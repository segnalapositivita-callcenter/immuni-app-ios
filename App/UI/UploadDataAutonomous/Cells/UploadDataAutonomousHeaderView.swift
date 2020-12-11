// UploadDataAutonomousHeaderView.swift
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

import Foundation
import Lottie
import Tempura

struct UploadDataAutonomousHeaderVM: ViewModel {}

// MARK: - View

class UploadDataAutonomousHeaderView: UIView, ModellableView {
  static let horizontalMargin: CGFloat = 30.0
  static let textToDiscoverMore: CGFloat = 10.0

  typealias VM = UploadDataAutonomousHeaderVM

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
    self.style()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
    self.style()
  }

  private let message = UILabel()

  // MARK: - Setup

  func setup() {
    self.addSubview(self.message)
  }

  // MARK: - Style

  func style() {
    Self.Style.background(self)
    Self.Style.message(self.message)
  }

  // MARK: - Update

  func update(oldModel: VM?) {}

  // MARK: - Layout

  override func layoutSubviews() {
    super.layoutSubviews()

    self.message.pin
      .marginBottom(Self.textToDiscoverMore)
      .horizontally(Self.horizontalMargin)
      .sizeToFit(.width)
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    let availableWidth = size.width - 2 * Self.horizontalMargin
    let availableSize = CGSize(width: availableWidth, height: .infinity)

    let messageSize = self.message.sizeThatFits(availableSize)

    return CGSize(width: size.width, height: messageSize.height)
  }
}

// MARK: - Style

private extension UploadDataAutonomousHeaderView {
  enum Style {
    static func background(_ view: UIView) {
      view.backgroundColor = .clear
    }

    static func message(_ label: UILabel) {
      let content = "Contatta il call center per ricevere assistenza telefonicamente. Ricordati di avere a portata di mano"

      let textStyle = TextStyles.p.byAdding(
        .color(Palette.grayNormal),
        .alignment(.left)
      )

      TempuraStyles.styleStandardLabel(
        label,
        content: content,
        style: textStyle
      )
    }
  }
}
