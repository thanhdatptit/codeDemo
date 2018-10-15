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
     var urlString = ""

    @IBOutlet weak var lblShowValueSlider: UILabel!
    @IBOutlet weak var viewPresent: UIView!
    @IBOutlet weak var lblTut: UILabel!
    let outputSize = CGSize(width: 1920, height: 1280)
    var imagesPerSecond: TimeInterval = 3 //each image will be stay for 3 secs
    var selectedPhotosArray = [UIImage]()
    var timerVideoGif = 0
    var imageArrayToVideoURL = NSURL()
    let audioIsEnabled: Bool = false //if your video has no sound
    var asset: AVAsset!
    var videoPlayerVc : AVPlayerViewController!
    @IBOutlet weak var videogif: UIImageView!

    var arrimageVideo:[UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        videogif.animationImages = arrimageVideo
        videogif.animationDuration = 5
        self.title = "Gif & Video"
    }
    
    @IBAction func disMiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func slideSpeed(_ sender: UISlider) {
        imagesPerSecond = TimeInterval(10.2 - sender.value)
        timerVideoGif = Int(sender.value)
        lblShowValueSlider.text = "\(sender.value)"
    }
    
    // MARK: CREATE GIF
    
    @IBAction func audioGif(_ sender: Any) {
         lblTut.isHidden = true
        if videoPlayerVc != nil {
          videoPlayerVc.view.isHidden = true
        }
   
         videogif.isHidden = false
        videogif.layer.speed = Float(2)
         videogif.startAnimating()
    }
    @IBAction func stopAudioGif(_ sender: Any) {
        videogif.stopAnimating()
    }

    @IBAction func playvideo(_ sender: Any) {
        print(urlString)
        
//        present(videoPlayer, animated: true) {
//
//                player.play()
//                        }
    
//        if let path = Bundle.main.path(forResource: urlString, ofType: "mp4") {
//            let video = AVPlayer(url: URL(fileURLWithPath: path))
//
//            videoPlayer.player = player
//            present(videoPlayer, animated: true) {
//                video.play()
//            }
//        }
    }

      // MARK: PLAY VIDEO
    //Edited By Manh Nguyen
    func playVideoWithUrl(strUrl : String) {
        
        lblTut.isHidden = true
         let playerItem = AVPlayerItem(url: URL.init(string: strUrl)!)
        if (videoPlayerVc == nil) {
           videoPlayerVc = AVPlayerViewController()
            //        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            
           
            let  player = AVPlayer(playerItem: playerItem)
            
            //play using layer
            //        videoPlayer.player = player
            //        let playerLayer = AVPlayerLayer(player: player)
            //        playerLayer.frame = self.videogif.frame
            //        self.view.layer.addSublayer(playerLayer)
            //
            //        player.play()
            
            
            
            //add controller as child
            videoPlayerVc.player = player
           
            self.addChildViewController(videoPlayerVc)
            self.view.addSubview(videoPlayerVc.view)
            videoPlayerVc.view.frame = self.viewPresent.frame
           
        }else{
            videoPlayerVc.player?.replaceCurrentItem(with: playerItem)
            
        }
        videogif.isHidden = true
        videoPlayerVc.view.isHidden = false
        videoPlayerVc.player?.play()
        
    }

    @IBAction func audioVideo(_ sender: Any) {
        buildVideoFromImageArray()
     
    }

    func buildVideoFromImageArray() {
        selectedPhotosArray = arrimageVideo

        imageArrayToVideoURL = NSURL(fileURLWithPath: NSHomeDirectory() + "/Documents/video1.MP4")
        removeFileAtURLIfExists(url: imageArrayToVideoURL)
        guard let videoWriter = try? AVAssetWriter(outputURL: imageArrayToVideoURL as URL, fileType: AVFileType.mp4) else {
            fatalError("AVAssetWriter error")
        }
        let outputSettings = [AVVideoCodecKey : AVVideoCodecH264, AVVideoWidthKey : NSNumber(value: Float(outputSize.width)), AVVideoHeightKey : NSNumber(value: Float(outputSize.height))] as [String : Any]
        guard videoWriter.canApply(outputSettings: outputSettings, forMediaType: AVMediaType.video) else {
            fatalError("Negative : Can't apply the Output settings...")
        }
        let videoWriterInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: outputSettings)
        let sourcePixelBufferAttributesDictionary = [kCVPixelBufferPixelFormatTypeKey as String : NSNumber(value: kCVPixelFormatType_32ARGB), kCVPixelBufferWidthKey as String: NSNumber(value: Float(outputSize.width)), kCVPixelBufferHeightKey as String: NSNumber(value: Float(outputSize.height))]
        let pixelBufferAdaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: videoWriterInput, sourcePixelBufferAttributes: sourcePixelBufferAttributesDictionary)
        if videoWriter.canAdd(videoWriterInput) {
            videoWriter.add(videoWriterInput)
        }
        if videoWriter.startWriting() {
            let timeMake = imagesPerSecond * 10000
            let zeroTime = CMTimeMake(Int64(timeMake), 10000)
//            let zeroTime = CMTimeMake(Int64(imagesPerSecond),Int32(1))
            videoWriter.startSession(atSourceTime: zeroTime)

            assert(pixelBufferAdaptor.pixelBufferPool != nil)
            let media_queue = DispatchQueue(label: "mediaInputQueue")
            videoWriterInput.requestMediaDataWhenReady(on: media_queue, using: { () -> Void in
                let fps: Int32 = 10000
                
                let framePerSecond: Int64 = Int64(self.imagesPerSecond * 10000)
                let frameDuration = CMTimeMake(Int64(self.imagesPerSecond * 10000), fps)
                var frameCount: Int64 = 0
                var appendSucceeded = true
                while (!self.selectedPhotosArray.isEmpty) {
                    if (videoWriterInput.isReadyForMoreMediaData) {
                        let nextPhoto = self.selectedPhotosArray.remove(at: 0)
                        let lastFrameTime = CMTimeMake(frameCount * framePerSecond, fps)
                        let presentationTime = frameCount == 0 ? lastFrameTime : CMTimeAdd(lastFrameTime, frameDuration)
                        var pixelBuffer: CVPixelBuffer? = nil
                        let status: CVReturn = CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, pixelBufferAdaptor.pixelBufferPool!, &pixelBuffer)
                        if let pixelBuffer = pixelBuffer, status == 0 {
                            let managedPixelBuffer = pixelBuffer
                            CVPixelBufferLockBaseAddress(managedPixelBuffer, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)))
                            let data = CVPixelBufferGetBaseAddress(managedPixelBuffer)
                            let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
                            let context = CGContext(data: data, width: Int(self.outputSize.width), height: Int(self.outputSize.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(managedPixelBuffer), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
                            context!.clear(CGRect(x: 0, y: 0, width: CGFloat(self.outputSize.width), height: CGFloat(self.outputSize.height)))
                            let horizontalRatio = CGFloat(self.outputSize.width) / nextPhoto.size.width
                            let verticalRatio = CGFloat(self.outputSize.height) / nextPhoto.size.height
                            //let aspectRatio = max(horizontalRatio, verticalRatio) // ScaleAspectFill
                            let aspectRatio = min(horizontalRatio, verticalRatio) // ScaleAspectFit
                            let newSize: CGSize = CGSize(width: nextPhoto.size.width * aspectRatio, height: nextPhoto.size.height * aspectRatio)
                            let x = newSize.width < self.outputSize.width ? (self.outputSize.width - newSize.width) / 2 : 0
                            let y = newSize.height < self.outputSize.height ? (self.outputSize.height - newSize.height) / 2 : 0
                            context?.draw(nextPhoto.cgImage!, in: CGRect(x: x, y: y, width: newSize.width, height: newSize.height))
                            CVPixelBufferUnlockBaseAddress(managedPixelBuffer, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)))
                            appendSucceeded = pixelBufferAdaptor.append(pixelBuffer, withPresentationTime: presentationTime)
                        } else {
                            print("Failed to allocate pixel buffer")
                            appendSucceeded = false
                        }
                    }
                    if !appendSucceeded {
                        break
                    }
                    frameCount += 1
                }
                videoWriterInput.markAsFinished()
                videoWriter.finishWriting { () -> Void in
                    print("-----video1 url = \(self.imageArrayToVideoURL)")
                    self.urlString = "\(self.imageArrayToVideoURL)"
                    self.asset = AVAsset(url: self.imageArrayToVideoURL as URL)
                    self.exportVideoWithAnimation()
                    DispatchQueue.main.async {
                        //code that caused error goes here
                         self.playVideoWithUrl(strUrl: self.urlString)
                    }
                   
                }
            })
        }
    }

    func removeFileAtURLIfExists(url: NSURL) {
        if let filePath = url.path {
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                do{
                    try fileManager.removeItem(atPath: filePath)
                } catch let error as NSError {
                    print("Couldn't remove existing destination file: \(error)")
                }
            }
        }
    }
    func exportVideoWithAnimation() {
        let composition = AVMutableComposition()

        let track =  asset?.tracks(withMediaType: AVMediaType.video)
        let videoTrack:AVAssetTrack = track![0] as AVAssetTrack
        let timerange = CMTimeRangeMake(kCMTimeZero, (asset?.duration)!)

        let compositionVideoTrack:AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: CMPersistentTrackID())!

        do {
            try compositionVideoTrack.insertTimeRange(timerange, of: videoTrack, at: kCMTimeZero)
            compositionVideoTrack.preferredTransform = videoTrack.preferredTransform
        } catch {
            print(error)
        }

        //if your video has sound, you don’t need to check this
        if audioIsEnabled {
            let compositionAudioTrack:AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: CMPersistentTrackID())!

            for audioTrack in (asset?.tracks(withMediaType: AVMediaType.audio))! {
                do {
                    try compositionAudioTrack.insertTimeRange(audioTrack.timeRange, of: audioTrack, at: kCMTimeZero)
                } catch {
                    print(error)
                }
            }
        }

        let size = videoTrack.naturalSize

        let videolayer = CALayer()
        videolayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        let parentlayer = CALayer()
        parentlayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        parentlayer.addSublayer(videolayer)

        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //this is the animation part
        var time = [0.00001, 3, 6, 9, 12] //I used this time array to determine the start time of a frame animation. Each frame will stay for 3 secs, thats why their difference is 3
        let temp = arrimageVideo.count
        for image in 0..<temp {
            let nextPhoto = arrimageVideo[image]

            let horizontalRatio = CGFloat(self.outputSize.width) / nextPhoto.size.width
            let verticalRatio = CGFloat(self.outputSize.height) / nextPhoto.size.height
            let aspectRatio = min(horizontalRatio, verticalRatio)
            let newSize: CGSize = CGSize(width: nextPhoto.size.width * aspectRatio, height: nextPhoto.size.height * aspectRatio)
            let x = newSize.width < self.outputSize.width ? (self.outputSize.width - newSize.width) / 2 : 0
            let y = newSize.height < self.outputSize.height ? (self.outputSize.height - newSize.height) / 2 : 0

            ///I showed 10 animations here. You can uncomment any of this and export a video to see the result.

            ///#1. left->right///
            let blackLayer = CALayer()
            blackLayer.frame = CGRect(x: -videoTrack.naturalSize.width, y: 0, width: videoTrack.naturalSize.width, height: videoTrack.naturalSize.height)
            blackLayer.backgroundColor = UIColor.black.cgColor

            let imageLayer = CALayer()
            imageLayer.frame = CGRect(x: x, y: y, width: newSize.width, height: newSize.height)
            imageLayer.contents = arrimageVideo[image].cgImage
            blackLayer.addSublayer(imageLayer)

            let animation = CABasicAnimation()
            animation.keyPath = "position.x"
            animation.fromValue = -videoTrack.naturalSize.width
            animation.toValue = 2 * (videoTrack.naturalSize.width)
            animation.duration = 3
            animation.beginTime = CFTimeInterval(3)
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            blackLayer.add(animation, forKey: "basic")
            parentlayer.addSublayer(blackLayer)
        }


        let layercomposition = AVMutableVideoComposition()
        layercomposition.frameDuration = CMTimeMake(1, 30)
        layercomposition.renderSize = size
        layercomposition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videolayer, in: parentlayer)
        let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRangeMake(kCMTimeZero, composition.duration)
        let videotrack = composition.tracks(withMediaType: AVMediaType.video)[0] as AVAssetTrack
        let layerinstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videotrack)
        instruction.layerInstructions = [layerinstruction]
        layercomposition.instructions = [instruction]

        let animatedVideoURL = NSURL(fileURLWithPath: NSHomeDirectory() + "/Documents/video2.mp4")
        removeFileAtURLIfExists(url: animatedVideoURL)

        guard let assetExport = AVAssetExportSession(asset: composition, presetName:AVAssetExportPresetHighestQuality) else {return}
        assetExport.videoComposition = layercomposition
        assetExport.outputFileType = AVFileType.mp4
        assetExport.outputURL = animatedVideoURL as URL
        assetExport.exportAsynchronously(completionHandler: {
            switch assetExport.status{
            case  AVAssetExportSessionStatus.failed:
                print("failed \(String(describing: assetExport.error))")
            case AVAssetExportSessionStatus.cancelled:
                print("cancelled \(String(describing: assetExport.error))")
            default:
                print("Exported")
            }
        })
    }


}
