//
//  GifAndCameraViewController.swift
//  ScrollViewDemo
//
//  Created by NTQ on 10/11/18.
//  Copyright © 2018 NguyenManh. All rights reserved.
//

import UIKit
import SwiftVideoGenerator
import AVFoundation
import AVKit

class GifAndCameraViewController: UIViewController {

    @IBOutlet weak var videogif: UIImageView!

    private let Audio1 = "audio1"
    private let Mp3Extension = "mp3"
    private let MissingAudioFiles = "Missing audio files"
    private let MultipleMovieFileName = "multipleVideo"

    var arrimageVideo:[UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        videogif.animationImages = arrimageVideo
        videogif.animationDuration = 5
    }
    
    @IBAction func disMiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func audioGif(_ sender: Any) {
         videogif.startAnimating()
    }
    @IBAction func stopAudioGif(_ sender: Any) {
        videogif.stopAnimating()
    }


    @IBAction func audioVideo(_ sender: Any) {
        if let audioURL1 = Bundle.main.url(forResource: Audio1, withExtension: Mp3Extension) {
            LoadingView.lockView()

            VideoGenerator.current.fileName = MultipleMovieFileName
            VideoGenerator.current.shouldOptimiseImageForVideo = true

            VideoGenerator.current.generate(withImages: arrimageVideo, andAudios: [audioURL1], andType: .singleAudioMultipleImage, { (progress) in
                print(progress)
            }, success: { (url) in
                LoadingView.unlockView()
                print(url)
                let video = AVPlayer(url: url)
                let videoPlayer = AVPlayerViewController()
                videoPlayer.player = video
                self.present(videoPlayer, animated: true) {
                    video.play()
                }
                //  self.createAlertView(message: self.FnishedMultipleVideoGeneration)
            }, failure: { (error) in
                LoadingView.unlockView()
                print(error)
            })
        } else {

        }

    }


}
