//
//  DataService.swift
//  Image Viewer App
//
//  Created by Eszter Szabó on 2021. 02. 09..
//

import Foundation
import Alamofire

struct DataService {
    
    // MARK: - Singleton instance.
    static let shared = DataService()
    
    // MARK: - URL
    private var photoUrl = "https://jsonplaceholder.typicode.com/photos"
    
    // TODO: add another function for every photo's fetching.
    // MARK: - Services
    func requestFetchPhoto(with id: Int, completion: @escaping (Photo?, Error?) -> ()) {
        let url = "\(photoUrl)/\(id)"
        Alamofire.request(url).responsePhoto { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let photo = response.result.value {
                completion(photo, nil)
                return
            }
        }
    }
    
    func requestDownloadPhoto(imageURL: String, completion: @escaping (Data?, Error?) -> ()) {
        Alamofire.download(imageURL).responseData { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let data = response.result.value {
                completion(data, nil)
                return
            }
        }
    }
    
    // MARK: - fetch all existing photos
    func requestFetchAllPhotos(completion: @escaping (Array<Photo>?, Error?) -> ()) {
        let url = "\(photoUrl)/"
        Alamofire.request(url).responseAllPhotos{ response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let photos = response.result.value {
                completion(photos, nil)
                return
            }
        }
    }
}


