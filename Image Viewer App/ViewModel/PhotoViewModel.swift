//
//  PhotoViewModel.swift
//  Image Viewer App
//
//  Created by Eszter Szabó on 2021. 02. 09..
//

import Foundation
import RxSwift

class PhotoViewModel {
    
    // MARK: - Properties
    var image: PublishSubject<Data> = PublishSubject()
    var error: PublishSubject<Error?> = PublishSubject()
    var isLoading: PublishSubject<Bool> = PublishSubject()
    
    private var dataService: DataService?
    private var downloaderService: DownloaderService?
    
    // MARK: - Constructor
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // MARK: - Network call
    func downloadPhoto(withUrl url: String) {
        self.dataService?.requestDownloadPhoto(imageURL: url, completion: { (image, error) in
            if let error = error {
                self.error.onNext(error)
                self.isLoading.onNext(false)
                return
            }
            self.error.onNext(nil)
            self.isLoading.onNext(false)
            self.image.onNext(image!)
        })
    }
}
