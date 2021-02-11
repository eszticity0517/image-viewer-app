//
//  ViewController.swift
//  Image Viewer App
//
//  Created by Eszter Szabó on 2021. 02. 09..
//


import UIKit
import Alamofire
import RxSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let photoListViewModel = PhotoListViewModel(dataService: DataService())
    
    private var downloaderService: DownloaderService?
    public var disposeBag = DisposeBag()
    private var photoList: Array<Photo> = Array()
    
    @IBOutlet public weak var photosTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloaderService = DownloaderService()
        
        photosTable.dataSource = self
        photosTable.delegate = self
        photosTable.rowHeight = 60
        
        photoListViewModel.photos.observe(on: MainScheduler.instance).subscribe(onNext: { (photos) in
            self.photoList = photos
            self.photosTable.reloadData()
        })
        .disposed(by: disposeBag)
        
        attemptFetchAllPhotos()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photo = self.photoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! PhotoTableViewCell
        cell.photoTitle!.text = photo.title
        cell.downloadButton!.tag = photo.id!
        cell.tag = photo.id!
        cell.downloadButton!.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        return cell
    }
    
    @objc func buttonClicked(sender: AnyObject?) {
        let url = (photoList[sender!.tag - 1].thumbnailURL)!
        downloaderService?.dowloadThumbnailIntoStorage(with: url)
    }
    
    private func attemptFetchAllPhotos() {
        photoListViewModel.fetchAllPhotos()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print((sender as! PhotoTableViewCell).tag)
        if let destination = segue.destination as? DetailsViewController {
            destination.photoID = (sender as! PhotoTableViewCell).tag
            destination.photoText = photoList[(sender as! PhotoTableViewCell).tag - 1].title!
            destination.photoURL = photoList[(sender as! PhotoTableViewCell).tag - 1].url!
        }
    }
}

