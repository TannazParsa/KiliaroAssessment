//
//  SingleMediaViewController.swift
//  KiliaroAssesment
//
//  Created by tanaz on 15/04/1401 AP.
//

import Foundation
import UIKit
import DataModels

class SingleMediaViewController: UIViewController, UIScrollViewDelegate {
  
  var selectedIndex = 0
  var galleryImages: GalleryImagesModels = []
  
  
  fileprivate let scrollView: UIScrollView  = {
    let sv = UIScrollView()
    sv.contentMode = .scaleAspectFit
    sv.showsVerticalScrollIndicator = false
    sv.showsHorizontalScrollIndicator = false
    sv.backgroundColor = .black
    sv.minimumZoomScale = 1
    sv.maximumZoomScale = 8
    return sv
  }()
  
  fileprivate let imageView: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFit
    img.clipsToBounds = true
    img.isUserInteractionEnabled = true
    return img
  }()
  
  fileprivate let closeButton: UIButton = {
    let button = UIButton(type: .custom)
    let image = UIImage(named: "ic_close")?.withRenderingMode(.alwaysTemplate)
    button.setImage(image, for: .normal)
    button.tintColor = .white
    button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    return button
  }()
  
  fileprivate let countLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .white
    lbl.textAlignment = .center
    return lbl
  }()
  
  fileprivate let createTimeLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .white
    lbl.textAlignment = .left
    return lbl
  }()
  
  override func viewDidLoad() {
    setupView()
    setupConstraint()
    setupGesture()
    loadImage()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  func setupView() {
    view.backgroundColor = .black
    scrollView.delegate = self
    view.addSubview(scrollView)
    scrollView.addSubview(imageView)
    view.addSubview(countLabel)
    view.addSubview(closeButton)
    view.addSubview(createTimeLabel)
  }
  
  func setupConstraint() {
    scrollView.frame = view.bounds
    imageView.frame = scrollView.bounds
    countLabel.frame = CGRect(x: 20, y: view.frame.height - 50, width: view.frame.width - 40, height: 21)
    createTimeLabel.frame = CGRect(x: 20, y: view.frame.height - 82, width: view.frame.width - 40, height: 21)
    closeButton.frame = CGRect(x: 20, y: (self.navigationController?.navigationBar.frame.height)!, width: 25, height: 25)
  }
  
  func loadImage() {
    let thumbnailSize = setImageSize()
    let urlString = (galleryImages[selectedIndex].thumbnailURL ?? "") + thumbnailSize
    guard let url = URL(string: urlString) else {
      return
    }
    imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(1))], completionHandler: nil)
    countLabel.text = String(format: "%1d / %1d", selectedIndex + 1, galleryImages.count)
    createTimeLabel.text = galleryImages[selectedIndex].createdAt?.toDate()
  }
  
  private func setImageSize() -> String {
    let size = configBoundSize()
    let resize = ThumbnailModel(mode: .crop, height: size.height, width: size.width)
    return resize.configQuery()
  }
  
  func configBoundSize() -> CGSize {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    return CGSize(width: width, height: height)
  }
  
  @objc func closeButtonTapped() {
    dismissView()
  }
  
  // -- MARK: -- Add gestures to scrollView
  func setupGesture() {
    let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTapOnScrollView(recognizer:)))
    singleTapGesture.numberOfTapsRequired = 1
    scrollView.addGestureRecognizer(singleTapGesture)
    
    let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapOnScrollView(recognizer:)))
    doubleTapGesture.numberOfTapsRequired = 2
    scrollView.addGestureRecognizer(doubleTapGesture)
    singleTapGesture.require(toFail: doubleTapGesture)
    
    let rightSWipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSWipeFrom(recognizer:)))
    let leftSWipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSWipeFrom(recognizer:)))
    
    rightSWipe.direction = .right
    leftSWipe.direction = .left
    
    scrollView.addGestureRecognizer(rightSWipe)
    scrollView.addGestureRecognizer(leftSWipe)
  }
  
  @objc func handleSingleTapOnScrollView(recognizer: UITapGestureRecognizer ) {
    if closeButton.isHidden {
      closeButton.isHidden = false
      countLabel.isHidden = false
    } else {
      closeButton.isHidden = true
      countLabel.isHidden = true
    }
  }
  
  @objc func handleDoubleTapOnScrollView(recognizer: UITapGestureRecognizer ) {
    if scrollView.zoomScale == 1 {
      scrollView.zoom(to: zoomRectForScale(scale: scrollView.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
      closeButton.isHidden = true
      countLabel.isHidden = true
    } else {
      scrollView.setZoomScale(1, animated: true)
      closeButton.isHidden = false
      countLabel.isHidden = false
    }
  }
  
  @objc func handleSWipeFrom(recognizer: UISwipeGestureRecognizer) {
    let direction: UISwipeGestureRecognizer.Direction = recognizer.direction
    switch direction {
    case UISwipeGestureRecognizer.Direction.left:
      self.selectedIndex -= 1
    case UISwipeGestureRecognizer.Direction.right:
      self.selectedIndex += 1
    default:
      break
    }
    
    self.selectedIndex = (self.selectedIndex < 0) ? (self.galleryImages.count - 1) : self.selectedIndex %  self.galleryImages.count
    loadImage()
  }
  
  func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
    var zoomRect = CGRect.zero
    zoomRect.size.height = imageView.frame.size.height / scale
    zoomRect.size.width = imageView.frame.size.width / scale
    
    let newCenter = imageView.convert(center, from: scrollView)
    zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
    zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
    return zoomRect
  }
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }
  
  func scrollViewDidZoom(_ scrollView: UIScrollView) {
    if scrollView.zoomScale > 1 {
      if let image = self.imageView.image {
        let ratioW = self.imageView.frame.width / image.size.width
        let ratioH = self.imageView.frame.height / image.size.height
        
        let ratio = ratioW < ratioH ? ratioW: ratioH
        let newWidth = image.size.width * ratio
        let newHeight = image.size.height * ratio
        
        let left = 0.5 * (newWidth * scrollView.zoomScale > imageView.frame.width ? (newWidth - self.imageView.frame.width):(scrollView.frame.width - scrollView.contentSize.width))
        
        let top = 0.5 * (newHeight * scrollView.zoomScale > imageView.frame.height ? (newHeight - self.imageView.frame.height):(scrollView.frame.height - scrollView.contentSize.height))
        
        scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
      }
    } else {
      scrollView.contentInset = UIEdgeInsets.zero
    }
  }
}
