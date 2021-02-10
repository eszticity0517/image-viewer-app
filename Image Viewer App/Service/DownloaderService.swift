//
//  DownloaderService.swift
//  Image Viewer App
//
//  Created by Eszter Szabó on 2021. 02. 10..
//

import Foundation
import Alamofire

// A separate service for non view-related downloading and file saving.
struct DownloaderService {
    // MARK: - Singleton instance.
    static let shared = DownloaderService()
    
    // TODO: add another function for every photo's fetching.
    // MARK: - Services
    func dowloadThumbnailIntoStorage(with url: String, completion: @escaping (Bool?, Error?) -> ()) {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent("file.png")
            return (documentsURL, [.removePreviousFile])
        }
        
        Alamofire.download(url, to: destination).responseData { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if response.result.isSuccess {
                completion(true, nil)
                return
            }
        }
    }
}
