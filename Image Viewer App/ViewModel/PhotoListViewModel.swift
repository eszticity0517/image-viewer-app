//
//  PhotoListViewModel.swift
//  Image Viewer App
//
//  Created by Eszter Szabó on 2021. 02. 10..
//

import Foundation
import RxSwift

class PhotoListViewModel {
    
    // MARK: - Properties
    var photos: PublishSubject<Array<Photo>> = PublishSubject()
    var error: PublishSubject<Error?> = PublishSubject()
    var isLoading: PublishSubject<Bool> = PublishSubject()
    
    private var dataService: DataService?
    
    // MARK: - Constructor
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // MARK: - Network call
    func fetchAllPhotos() {
        self.dataService?.requestFetchAllPhotos(completion: { (photos, error) in
            if let error = error {
                self.error.onNext(error)
                self.isLoading.onNext(false)
                return
            }
            self.error.onNext(nil)
            self.isLoading.onNext(false)
            self.photos.onNext(photos!)
        })
    }
}
