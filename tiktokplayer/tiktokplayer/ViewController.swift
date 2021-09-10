//
//  ViewController.swift
//  tiktokplayer
//
//  Created by goktan on 4.07.2021.
//  Copyright © 2021 caelum. All rights reserved.
//
//

import UIKit




struct VideoCore {
    let caption:String
    let username:String
    let audioTrackingName: String
    let videoFileName: String
    let videoFileFormat: String
    
}


class ViewController: UIViewController {
    
    private var collectionview: UICollectionView?
    
    var data = [VideoCore]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        for _ in 0..<10{
            let core = VideoCore(caption: "caption", username: "username", audioTrackingName: "song", videoFileName: "video", videoFileFormat: "mp4")
            
            data.append(core)
        }
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionview =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview?.isPagingEnabled = true
        collectionview?.dataSource = self
        collectionview?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        view.addSubview(collectionview!)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        collectionview?.frame = view.bounds
        
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let core = data[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as! VideoCollectionViewCell
        cell.configure(with: core)
        cell.delegate = self
        return cell
    }
    
    
}
extension ViewController: VideoCollectionViewCellDelegete {
    func didTapLikeButton(with core: VideoCore) {
        print("tapped like")
    }
    
    func didTapCommentButton(with core: VideoCore) {
        print("tapped comment")
    }
    
    func didTapShareButton(with core: VideoCore) {
        print("tapped share")
    }
    
    func didTapProfileButton(with core: VideoCore) {
        print("tapped profile")
    }
    
    
}
