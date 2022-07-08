//
//  GalleryCollectionCell.swift
//  KiliaroAssesment
//
//  Created by tanaz on 14/04/1401 AP.
//


import Foundation
import Kingfisher
import UIKit
import DataModels

class GalleryCollectionCell: UICollectionViewCell {

  private let galleryImage : UIImageView = {
      let img = UIImageView()
    img.translatesAutoresizingMaskIntoConstraints = false
    img.contentMode = .scaleAspectFill
    img.clipsToBounds = true
    return img
  }()

  private let imageSizeLabel : UILabel = {
      let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.contentMode = .scaleAspectFill
    lbl.clipsToBounds = true
    lbl.backgroundColor = .gray.withAlphaComponent(0.3)
    return lbl
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
      prepareUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func prepareUI() {
    contentView.addSubview(galleryImage)
    contentView.addSubview(imageSizeLabel)
    galleryImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    galleryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    galleryImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    galleryImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    imageSizeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    imageSizeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    imageSizeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    let heightConstraint = imageSizeLabel.heightAnchor.constraint(equalToConstant: 24)
    contentView.addConstraint(heightConstraint)
  }

  func configure(with item: GalleryImagesModel) {
    let thumbnailSize = setImageSize()
    let urlString = (item.thumbnailURL ?? "") + thumbnailSize
    guard let url = URL(string: urlString) else {
      return
    }
    galleryImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(1))], completionHandler: nil)

      // set file size label
    imageSizeLabel.text = ReadableUnitConverter(bytes: item.size!).getReadableUnit()
  }

  private func setImageSize() -> String {
      let size = configCellSize()
    let resize = ThumbnailModel(mode: .md, height: size.height, width: size.width)
      return resize.configQuery()
  }

  func configCellSize() -> CGSize {
    let width = UIScreen.main.bounds.width / 3 - 1
    return CGSize(width: width, height: width)

  }
}
