//
//  PlayerViewController.swift
//  MusicApp
//
//  Created by Florian Cela on 16.10.20.
//  Copyright © 2020 Florian Cela. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [ViewController.Song] = []
    
    @IBOutlet var holder: UIView!
    
    var player: AVAudioPlayer?
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 //line wrap
        return label
    }()
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 //line wrap
        return label
    }()
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 //line wrap
        return label
    }()
    
    let playPauseButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0{
            configure()
        }
    }
    func configure(){
        // set up player
        
        let song = songs[position]
        
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else {return}
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            guard let player = player else {
                print("player is nil")
                return }
            player.play()
            player.volume = 0.5
        }
        
        catch{
            print("Error occured")
        }
        
        //set up user interface element
        
        //Labels
        albumImageView.frame = CGRect(x: 10, y: 10, width: holder.frame.size.width-20, height: holder.frame.size.width-20)
        
        songNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height + 10, width: holder.frame.size.width-20, height: 70)
        songNameLabel.font = UIFont(name: "Helvetica", size: 18)
        
        albumNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height + 10 + 70, width: holder.frame.size.width-20, height: 70)
        albumNameLabel.font = UIFont(name: "Helvetica-Bold", size: 17)
        
        artistNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height + 10 + 140, width: holder.frame.size.width-20, height: 70)
        artistNameLabel.font = UIFont(name: "Helvetica-Bold", size: 22)
        
        songNameLabel.text = song.name
        albumNameLabel.text = song.albumName
        artistNameLabel.text = song.artistName
        albumImageView.image = UIImage(named: song.imageName)
        
        holder.addSubview(albumImageView)
        holder.addSubview(songNameLabel)
        holder.addSubview(artistNameLabel)
        holder.addSubview(albumNameLabel)
        
        //player controls
        
        let nextButton = UIButton()
        let backButon = UIButton()
        
        //frame
        
        let yPosition = artistNameLabel.frame.origin.y + 70 + 20
        let size:CGFloat = 80
        
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) /  2.0, y: yPosition, width: size, height: size)
        
        nextButton.frame = CGRect(x: holder.frame.size.width - size - 20, y: yPosition, width: size, height: size)
        
        backButon.frame = CGRect(x: 20, y: yPosition, width: size, height: size)
        
        //actions
        
        playPauseButton.addTarget(self, action: #selector(didTapPlaykButton), for: .touchUpInside)
        backButon.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextkButton), for: .touchUpInside)
        //Images
        
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        backButon.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        playPauseButton.tintColor = .black
        backButon.tintColor = .black
        nextButton.tintColor = .black
        
        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButon)
        
        
        //slider
        let slider = UISlider(frame: CGRect(x: 20, y: holder.frame.size.height-60, width: holder.frame.size.width-40, height: 50))
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        holder.addSubview(slider)
    }
    @objc func didTapBackButton(){
        if position > 0 {
            position = position - 1
            player?.stop()
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
        }
//            if position <= 0{
//                position = songs.count - 1
//                player?.stop()
//
//                for subview in holder.subviews{
//                    subview.removeFromSuperview()
//
//            }
//                position = position - 1
//
//        }
        configure()
    }
    @objc func didTapNextkButton(){
        if position < (songs.count - 1) {
            position = position + 1
            player?.stop()
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
        }
//            if position >= songs.count - 1{
//                position = 0
//                player?.stop()
//                for subview in holder.subviews{
//                    subview.removeFromSuperview()
//            }
//                position = position + 1
//
//
//        }
        configure()
    
    }
    
    @objc func didTapPlaykButton(){
        if player?.isPlaying == true {
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            UIView.animate(withDuration: 0.2) {
                self.albumImageView.frame = CGRect(x: 30, y: 30, width: self.holder.frame.size.width-60, height: self.holder.frame.size.width-60)
            }
        }
        else{
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            UIView.animate(withDuration: 0.2) {
                self.albumImageView.frame = CGRect(x: 10, y: 10, width: self.holder.frame.size.width-20, height: self.holder.frame.size.width-20)
            }
        }
    }
    @objc func didSlideSlider(_ slider: UISlider){
        let value = slider.value
        player?.volume = value
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }
   
}
