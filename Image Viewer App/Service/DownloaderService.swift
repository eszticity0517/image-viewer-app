//
//  DownloaderService.swift
//  Image Viewer App
//
//  Created by Eszter Szabó on 2021. 02. 10..
//

import Foundation
import Alamofire

typealias CompletionHandler = (_ success:Bool) -> Void

// A separate service for non view-related downloading and file saving.
struct DownloaderService {
    // MARK: - Singleton instance.
    static let shared = DownloaderService()
    
    // TODO: add another function for every photo's fetching.
    // MARK: - Services
    func dowloadThumbnailIntoStorage(with url: String) {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent("file.png")
            return (documentsURL, [.removePreviousFile])
        }
        
        
        Alamofire.download(url, to: destination).responseData { response in
            if response.result.isSuccess, let imagePath = response.destinationURL?.path {
                print("Image successfully saved here:", imagePath)
            }
        }
    }
}
