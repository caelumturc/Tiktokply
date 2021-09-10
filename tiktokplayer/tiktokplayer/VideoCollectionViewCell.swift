//
//  VideoCollectionViewCell.swift
//  goktik
//
//  Created by goktan on 17.05.2021.
//  Copyright © 2021 goktan. All rights reserved.
//

import UIKit
import AVFoundation



protocol VideoCollectionViewCellDelegete: AnyObject {
    func didTapLikeButton(with core: VideoCore)
    func didTapCommentButton(with core: VideoCore)
    func didTapShareButton(with core: VideoCore)
    func didTapProfileButton(with core: VideoCore)
    
    
    
    
}



class VideoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cell"
    weak var delegate:VideoCollectionViewCellDelegete?
    
    var player: AVPlayer?
    
    private var core: VideoCore?

    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .cyan
        return label
    }()
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let auidioLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemPink
        return label
    }()
    
    private let videoContainer =  UIView()
    
    private let profileButton: UIButton = {
        let b = UIButton()
        
        
        b.setBackgroundImage(UIImage(named: "pic"), for: .normal)
        
        
        return b
    }()
    private let likeButton: UIButton = {
        
        let b = UIButton()
 b.setBackgroundImage(UIImage(named: "hea"), for: .normal)
        return b
        
        
    }()
    private let commentButton: UIButton = {
        let b = UIButton()
        b.setBackgroundImage(UIImage(named: "comment"), for: .normal)
        return b
    }()
    private let shareButton: UIButton = {
        
        let b = UIButton()
         b.setBackgroundImage(UIImage(named: "toh"), for: .normal)
        return b
    }()
    
    
    
    
    
    override init(frame:CGRect){
        super.init(frame: frame)
      //  contentView.backgroundColor = .cyan
        
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        AddSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func AddSubview(){
        contentView.addSubview(videoContainer)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(captionLabel)
        contentView.addSubview(auidioLabel)
        contentView.addSubview(profileButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
        
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchDown)
        
        shareButton.addTarget(self, action: #selector(didTapshareButton), for: .touchDown)
        
        
        profileButton.addTarget(self, action: #selector(didTapProfileButton), for: .touchDown)
        
        
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchDown)
        videoContainer.clipsToBounds = true
        contentView.sendSubviewToBack(videoContainer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoContainer.frame = contentView.bounds
        let size = contentView.frame.size.width/7
        let width = contentView.frame.size.width
        let heigt = contentView.frame.size.height - 100
        // kodu basitleştir  tiktok ikonlarını ekle ve alt paneli şeffaf yap instagrama ekle
        
        shareButton.frame = CGRect(x: width-size, y: heigt-(size)-140, width: size, height: size)
        
        likeButton.imageView?.tintColor = .white

        
        
        // comment -10
          commentButton.frame = CGRect(x: width-size, y: heigt-(size*2)-160, width: size, height: size)
              
              
        likeButton.frame = CGRect(x: width-size, y: heigt-(size*3)-180, width: size, height: size)
        
        //profile deney -10 du
        
        profileButton.frame = CGRect(x: width-size, y: heigt-(size*4)-200, width: size, height: size)
        
        auidioLabel.frame = CGRect(x: 5, y: heigt-120, width: width-size-30, height: 50)
        
        captionLabel.frame = CGRect(x: 5, y: heigt-140, width: width-size-60, height: 50)
        
        
        usernameLabel.frame = CGRect(x: 5, y: heigt-160, width: width-size-30, height: 50)
        
        
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        captionLabel.text = nil
        auidioLabel.text = nil
        usernameLabel.text = nil
    }
    
    
    public func configure(with core: VideoCore){
        self.core = core
        configureVideo()
        captionLabel.text = core.caption
        auidioLabel.text = core.audioTrackingName
        usernameLabel.text = core.username
        
        
        
    }
    
    func configureVideo(){
        
        guard let core = core else{
            return
        }
        
        
         guard  let path = Bundle.main.path(forResource: core.videoFileName, ofType: core.videoFileFormat) else{
            print("failed to find video")
            print(core.videoFileName)
            print(core.videoFileFormat)
             return
               }
              
               
        
      
               player = AVPlayer(url: URL(fileURLWithPath: path))
               let playerView = AVPlayerLayer()
               playerView.player = player
               playerView.frame = contentView.bounds
        playerView.videoGravity = .resizeAspectFill
            
               videoContainer.layer.addSublayer(playerView)
               player?.volume = 0
               player?.play()
        
    }
    
    
    
    
    
    
    @objc private func didTapLikeButton(){
         guard let core = core else {return}
                   
                   delegate?.didTapLikeButton(with: core)
        
    }
    
    
    
      
      
      @objc private func didTapCommentButton(){
           guard let core = core else {return}
                     
                     delegate?.didTapCommentButton(with: core)
        
    }
      
      
      @objc private func didTapshareButton(){
           guard let core = core else {return}
                     
                     delegate?.didTapShareButton(with: core)
        
    }
        
        
        @objc private func didTapProfileButton(){
            guard let core = core else {return}
            
            delegate?.didTapProfileButton(with: core)
        }
        
    
}
