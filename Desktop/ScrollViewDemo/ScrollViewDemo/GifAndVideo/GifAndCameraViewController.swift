//
//  GifAndCameraViewController.swift
//  ScrollViewDemo
//
//  Created by NTQ on 10/11/18.
//  Copyright © 2018 NguyenManh. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class GifAndCameraViewController: UIViewController {

    @IBOutlet weak var videogif: UIImageView!

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

    }


}
