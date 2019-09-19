//
//  ViewController.swift
//  StormImages
//
//  Created by Mihai Leonte on 8/22/19.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        performSelector(inBackground: #selector(loadImages), with: nil)
    }
    
    @objc func loadImages() {
        let fm = FileManager.default
        let path = Bundle.main.bundlePath
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        pictures.sort { $0 < $1 }
        
        collectionView.performSelector(onMainThread: #selector(UICollectionView.reloadData), with: nil, waitUntilDone: false)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Storm", for: indexPath) as? StormCell else { fatalError("Unable to dequeue a Storm cell.") }
        
        cell.nameLabel.text = pictures[indexPath.row]
        cell.imageView.image = UIImage(named: pictures[indexPath.row])
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 3
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
        
            let image = pictures[indexPath.row]
            detailVC.selectedImage = image
            detailVC.currentIndex = indexPath.row
            detailVC.arrayCount = pictures.count
            navigationController?.pushViewController(detailVC, animated: true)
        
        }
    }


}

