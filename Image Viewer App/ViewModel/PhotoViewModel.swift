//
//  PhotoViewModel.swift
//  Image Viewer App
//
//  Created by Eszter Szabó on 2021. 02. 09..
//

import Foundation

class PhotoViewModel {
    
    // MARK: - Properties
    private var photo: Photo? {
        didSet {
            guard let p = photo else { return }
            self.didFinishFetch?()
        }
    }
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    var titleString: String?
    var albumIdString: String?
    var photoUrl: URL?
    
    private var dataService: DataService?
    private var downloaderService: DownloaderService?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // MARK: - Network call
    func fetchPhoto(withId id: Int) {
        self.dataService?.requestFetchPhoto(with: id, completion: { (photo, error) in
            if let error = error {
                self.error = error
                self.isLoading = false
                return
            }
            self.error = nil
            self.isLoading = false
            self.photo = photo
        })
    }
}
