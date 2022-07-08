//
//  MediaViewController.swift
//  KiliaroAssesment
//
//  Created by tanaz on 14/04/1401 AP.
//

import Foundation
import UIKit
import Network
import DataModels
import Kingfisher


protocol MediaDisplayLogic: AnyObject {
  func displayPopulate(viewModel: MediaItem.Populate.ViewModel)
  func displayShowError(viewModel: MediaItem.ShowError.ViewModel)
}

class MediaViewController : UIViewController, MediaDisplayLogic {


  var displayedItems: GalleryImagesModels = []
  func displayPopulate(viewModel: MediaItem.Populate.ViewModel) {
    self.displayedItems = viewModel.items
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }

  func displayShowError(viewModel: MediaItem.ShowError.ViewModel) {
    let alert = UIAlertController(title: "Something went wrong",
                                  message: viewModel.message,
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true)
  }

  var interactor: MediaBusinessLogic?
  var router: (NSObjectProtocol & MediaRoutingLogic & MediaDataPassing)?

  fileprivate let collectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 1
    layout.minimumInteritemSpacing = 1

    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.register(GalleryCollectionCell.self, forCellWithReuseIdentifier: "cell")
    collection.translatesAutoresizingMaskIntoConstraints = false
    collection.backgroundColor = .white
    return collection
  }()

  // MARK: Setup

  private func setup() {
    let viewController = self
    let interactor = MediaInteractor()
    let presenter = MediaPresenter()
    let router = MediaRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }

  override func viewDidLoad() {
    self.title = "Gallery"
    setup()
    setupView()
    setupConstraints()
    populate()
  }

  // MARK: - Populate
  public func populate() {
    let request = MediaItem.Populate.Request()
    self.interactor?.populate(request: request)
  }

  func setupView() {
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.dataSource = self
  }

  func setupConstraints() {
    collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
  }
}

extension MediaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return displayedItems.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GalleryCollectionCell
    cell.configure(with: displayedItems[indexPath.row])
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    router?.routeToFullScreenImage(index: indexPath.row)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width / 3 - 1
    return CGSize(width: width, height: width)
  }
}
