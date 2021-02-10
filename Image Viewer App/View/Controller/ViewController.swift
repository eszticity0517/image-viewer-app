//
//  ViewController.swift
//  Image Viewer App
//
//  Created by Eszter Szabó on 2021. 02. 09..
//


import UIKit
import Alamofire
// The view controller no longer owns the model.
// It's the view model that owns the model, and the view controller asks the view model for the data it needs to display.
// We don´t need the UITableViewController inheritance, this extends from UIViewController already, but DataSource and ViewDelegate are needed.
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Injection
    let photoViewModel = PhotoViewModel(dataService: DataService())
    let photoListViewModel = PhotoListViewModel(dataService: DataService())
    
    // Not entirely sure where to put this, it is not related to the ViewModel nor the model actually ...
    // TODO: find out where to put DownloaderService instance.
    private var downloaderService: DownloaderService?
    
    @IBOutlet public weak var photosTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloaderService = DownloaderService()
        
        photosTable.dataSource = self
        photosTable.delegate = self
        photosTable.rowHeight = 60
        
        attemptFetchPhoto(withId: 8)
        attemptFetchAllPhotos()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photo = photoListViewModel.photos![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! PhotoTableViewCell
        cell.photoTitle!.text = photo.title
        cell.downloadButton!.tag = photo.id!
        cell.downloadButton!.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        return cell
    }
    
    @objc func buttonClicked(sender: AnyObject?) {
        let url = (photoListViewModel.photos?[sender!.tag ?? 0].thumbnailURL)!
        downloaderService?.dowloadThumbnailIntoStorage(with: url)
    }
    
    // MARK: - Networking
    private func attemptFetchPhoto(withId id: Int) {
        photoViewModel.fetchPhoto(withId: id)
        
        photoViewModel.updateLoadingStatus = {
            let _ = self.photoViewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        photoViewModel.showAlertClosure = {
            if let error = self.photoViewModel.error {
                print(error.localizedDescription)
            }
        }
        
        photoViewModel.didFinishFetch = {
            self.photosTable.reloadData()
        }
    }
    
    private func attemptFetchAllPhotos() {
        photoListViewModel.fetchAllPhotos()
        
        photoListViewModel.updateLoadingStatus = {
            let _ = self.photoListViewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        photoListViewModel.showAlertClosure = {
            if let error = self.photoListViewModel.error {
                print(error.localizedDescription)
            }
        }
        
        photoListViewModel.didFinishFetch = {
            self.photosTable.reloadData()
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

