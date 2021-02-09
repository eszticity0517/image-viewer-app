//
//  ViewController.swift
//  Image Viewer App
//
//  Created by Eszter Szabó on 2021. 02. 09..
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Injection
      let viewModel = PhotoViewModel(dataService: DataService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: add another function for every photo's fetching.
        attemptFetchPhoto(withId: 8)
    }
    
    // MARK: - Networking
       private func attemptFetchPhoto(withId id: Int) {
           viewModel.fetchPhoto(withId: id)
           
           viewModel.updateLoadingStatus = {
               let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
           }
           
           viewModel.showAlertClosure = {
               if let error = self.viewModel.error {
                   print(error.localizedDescription)
               }
           }
           
           viewModel.didFinishFetch = {
               // TODO: fill the table with objects.
           }
       }
       
       // MARK: - UI Setup
       private func activityIndicatorStart() {
           // Code for show activity indicator view
           // ...
           print("start")
       }
       
       private func activityIndicatorStop() {
           // Code for stop activity indicator view
           // ...
           print("stop")
       }
}

