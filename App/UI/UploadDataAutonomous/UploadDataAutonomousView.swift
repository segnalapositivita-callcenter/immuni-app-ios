// UploadDataAutonomousView.swift
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
import Models
import Tempura

struct UploadDataAutonomousVM: ViewModelWithLocalState {

  var headerVM: UploadDataAutonomousHeaderVM {
    return UploadDataAutonomousHeaderVM()
  }

  var messageVM: UploadDataMessageVM {
    return UploadDataMessageVM(order: 2)
  }
}

extension UploadDataAutonomousVM {
  init?(state: AppState?, localState: UploadDataAutonomousLS) {
    guard let _ = state else {
      return nil
    }
  }
}

// MARK: - View

class UploadDataAutonomousView: UIView, ViewControllerModellableView {
  typealias VM = UploadDataAutonomousVM

  private static let horizontalSpacing: CGFloat = 30.0
  static let cellSpacing: CGFloat = 25
  static let orderLeftMargin: CGFloat = UIDevice.getByScreen(normal: 70, narrow: 50)

  private let backgroundGradientView = GradientView()
  private let title = UILabel()
  private var backButton = ImageButton()
  let scrollView = UIScrollView()
  private let headerView = UploadDataAutonomousHeaderView()
  private let cunCell = UploadDataAutonomousCun()
  private let healthCardCell = UploadDataAutonomousHealthCard()
  private let callCenterCell = UploadDataAutonomousCallCenter()
  private let symptomsDateCell = UploadDataAutonomousSymptomsDate()
  private let messageCard = UploadDataMessageView()
  private var actionButton = ButtonWithInsets()
    
  private var contactButton = TextButton()

  var didTapBack: Interaction?
  var didTapAction: Interaction?
  var didTapCallCenter: Interaction?

  // MARK: - Setup

  func setup() {
    self.addSubview(self.backgroundGradientView)
    self.addSubview(self.scrollView)
    self.addSubview(self.title)
    self.addSubview(self.backButton)
    self.addSubview(self.actionButton)
    self.addSubview(self.contactButton)
        
    self.scrollView.addSubview(self.headerView)
    self.scrollView.addSubview(self.cunCell)
    self.scrollView.addSubview(self.healthCardCell)
    self.scrollView.addSubview(self.symptomsDateCell)
    self.scrollView.addSubview(self.callCenterCell)
    self.scrollView.addSubview(self.contactButton)

    self.backButton.on(.touchUpInside) { [weak self] _ in
      self?.didTapBack?()
    }
    self.actionButton.on(.touchUpInside) { [weak self] _ in
        self?.didTapAction?()
    }
    self.contactButton.on(.touchUpInside) { [weak self] _ in
        self?.didTapCallCenter?()
    }

  }

  // MARK: - Style

  func style() {
    Self.Style.background(self)
    Self.Style.backgroundGradient(self.backgroundGradientView)
    Self.Style.scrollView(self.scrollView)
    Self.Style.title(self.title)

    SharedStyle.navigationBackButton(self.backButton)
    SharedStyle.primaryButton(actionButton, title: L10n.UploadData.Verify.button)
    Self.Style.contactButton(self.contactButton, content: "800 91 24 91")

  }

  // MARK: - Update

  func update(oldModel: VM?) {
    guard let _ = self.model else {
      return
    }
    self.setNeedsLayout()
  }

  // MARK: - Layout

  override func layoutSubviews() {
    super.layoutSubviews()

    self.backgroundGradientView.pin.all()

    self.backButton.pin
      .left(Self.horizontalSpacing)
      .top(self.universalSafeAreaInsets.top + 20)
      .sizeToFit()

    self.title.pin
      .vCenter(to: self.backButton.edge.vCenter)
      .horizontally(Self.horizontalSpacing + self.backButton.intrinsicContentSize.width + 5)
      .sizeToFit(.width)

    self.scrollView.pin
      .horizontally()
      .below(of: self.title)
      .marginTop(5)
      .bottom(self.universalSafeAreaInsets.bottom)

    self.headerView.pin
      .horizontally()
      .sizeToFit(.width)
      .top(30)
    
    self.cunCell.pin
        .horizontally()
        .sizeToFit(.width)
        .below(of: self.headerView)
        .marginTop(Self.cellSpacing)
    
    self.healthCardCell.pin
        .horizontally()
        .sizeToFit(.width)
        .below(of: self.cunCell)
        .marginTop(Self.cellSpacing)
    
    self.symptomsDateCell.pin
        .horizontally()
        .sizeToFit(.width)
        .below(of: self.healthCardCell)
        .marginTop(Self.cellSpacing)
    
    self.callCenterCell.pin
        .horizontally()
        .sizeToFit(.width)
        .below(of: self.symptomsDateCell)
        .marginTop(Self.cellSpacing)
    
    self.contactButton.pin
        .horizontally(Self.horizontalSpacing + self.backButton.intrinsicContentSize.width + 20)
        .sizeToFit(.width)
        .below(of: self.callCenterCell)
        .marginTop(Self.cellSpacing)

    
    self.actionButton.pin
        .horizontally(35)
        .sizeToFit(.width)
        .minHeight(55)
        .below(of: self.contactButton)
        .marginTop(50)

    self.scrollView.contentSize = CGSize(width: self.scrollView.bounds.width, height: self.actionButton.frame.maxY)
  }
}

// MARK: - Style

private extension UploadDataAutonomousView {
  enum Style {
    static func background(_ view: UIView) {
      view.backgroundColor = Palette.grayWhite
    }

    static func backgroundGradient(_ gradientView: GradientView) {
      gradientView.isUserInteractionEnabled = false
      gradientView.gradient = Palette.gradientBackgroundBlueOnBottom
    }

    static func scrollView(_ scrollView: UIScrollView) {
      scrollView.backgroundColor = .clear
      scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
      scrollView.showsVerticalScrollIndicator = false
    }

    static func title(_ label: UILabel) {
      let content = L10n.Settings.Setting.LoadDataAutonomous.title
        
      TempuraStyles.styleShrinkableLabel(
        label,
        content: content,
        style: TextStyles.navbarSmallTitle.byAdding(
          .color(Palette.grayDark),
          .alignment(.center)
        ),
        numberOfLines: 1
      )
    }
    static func contactButton(_ button: TextButton, content: String) {
        let textStyle = TextStyles.pLink.byAdding(
        .color(Palette.primary),
        .underline(.single, Palette.primary)
        )
        button.contentHorizontalAlignment = .left
        button.attributedTitle = content.styled(with: textStyle)
        }
    
  }
}
