//
//  PhotoListViewModel.swift
//  Image Viewer App
//
//  Created by Eszter Szabó on 2021. 02. 10..
//

import Foundation

class PhotoListViewModel {
    
    // MARK: - Properties
    var photos: Array<Photo>? {
        didSet {
            guard let p = photos else { return }
            self.didFinishFetch?()
        }
    }
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    private var dataService: DataService?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // MARK: - Network call
    func fetchAllPhotos() {
        self.dataService?.requestFetchAllPhotos(completion: { (photos, error) in
            if let error = error {
                self.error = error
                self.isLoading = false
                return
            }
            self.error = nil
            self.isLoading = false
            self.photos = photos
        })
    }
    
    func numberOfRowsInSection() -> Int {
         return photos?.count ?? 0
     }
}
