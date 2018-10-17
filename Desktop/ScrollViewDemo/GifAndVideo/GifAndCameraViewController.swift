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
import Photos
import SwiftMessages
import NVActivityIndicatorView
import MobileCoreServices
import AssetsLibrary

var urlGifString = ""

class GifAndCameraViewController: UIViewController {
     var urlString = ""
    var checkCreateVideoAndGit = 0
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnShareTo: UIButton!
    @IBOutlet weak var btnSaveCameraRoll: UIButton!
    @IBOutlet weak var createGif: UIButton!
    @IBOutlet weak var createVideo: UIButton!
    @IBOutlet weak var videogif: UIImageView!
    @IBOutlet weak var viewShowVideoAndGif: UIView!

    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    @IBOutlet weak var sliderSetValue: UISlider!
    @IBOutlet weak var lblShowValueSlider: UILabel!
    @IBOutlet weak var viewPresent: UIView!
    @IBOutlet weak var lblTut: UILabel!
    @IBOutlet weak var stackViewHidden: UIStackView!
    @IBOutlet weak var constrainViewGifandVideo: NSLayoutConstraint!
    @IBOutlet weak var stackTimeSpeedHidden: UIStackView!
    @IBOutlet weak var constrainSpeed: NSLayoutConstraint!

    @IBOutlet weak var constrainReset: NSLayoutConstraint!
    @IBOutlet weak var constrainTopSpeed: NSLayoutConstraint!
    @IBOutlet weak var constrainBottomSpeed: NSLayoutConstraint!


    let outputSize = CGSize(width: 1920, height: 1280)
    var imagesPerSecond: TimeInterval = 3 //each image will be stay for 3 secs
    var selectedPhotosArray = [UIImage]()
    var timerVideoGif = 3
    var imageArrayToVideoURL = NSURL()
    let audioIsEnabled: Bool = false //if your video has no sound
    var asset: AVAsset!
    var numberValueSlider = 0

    var videoPlayerVc : AVPlayerViewController!


    var arrimageVideo:[UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        btnReset.isHidden = true
        constrainReset.constant = 0
        UserDefaults.standard.removeObject(forKey: "sliderValue")
        lblShowValueSlider.text = "3"
        let imag = UIImage()
        imag.animatedGif(from: arrimageVideo)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                self.title = "Gif & Video"
        btnReset.layer.cornerRadius = btnReset.frame.height / 2
        btnShareTo.layer.cornerRadius = btnShareTo.frame.height / 2
        btnSaveCameraRoll.layer.cornerRadius = btnSaveCameraRoll.frame.height / 2
        createGif.layer.cornerRadius = 7
        createVideo.layer.cornerRadius = 7
        viewPresent.layer.cornerRadius = 30
        viewPresent.clipsToBounds = true
        if let setValueSlider = UserDefaults.standard.object(forKey: "sliderValue") as? Float {
            self.sliderSetValue.value = setValueSlider
            lblShowValueSlider.text = "\(setValueSlider)"
        }
    }
    
    @IBAction func disMiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func slideSpeed(_ sender: UISlider) {
        imagesPerSecond = TimeInterval(sender.value)
        timerVideoGif = Int(sender.value)
        lblShowValueSlider.text = "\(sender.value)"
        let numberUserDerfault = UserDefaults.standard
        numberUserDerfault.set(sender.value, forKey: "sliderValue")
        numberUserDerfault.synchronize()
    }
    
    // MARK: CREATE GIF
    
    @IBAction func audioGif(_ sender: Any) {
        checkCreateVideoAndGit = 1
        // hidden Create Gif and Create Video
        stackViewHidden.isHidden = true
        stackTimeSpeedHidden.isHidden = true
        btnReset.isHidden = false
        constrainViewGifandVideo.constant = 0
        constrainSpeed.constant = 0
        constrainReset.constant = 45
        constrainTopSpeed.constant = 0
        constrainBottomSpeed.constant = 0
         lblTut.isHidden = true

        // Create Gif
        let imageURL = UIImage.gifImageWithURL(urlGifString)
        let imageView3 = UIImageView(image: imageURL)
        imageView3.frame = CGRect(x: 0, y: 0, width: viewPresent.frame.width, height: viewPresent.frame.height)
     //   imageView3.layer.cornerRadius = 17
       // imageView3.clipsToBounds = true
    
        videogif.addSubview(imageView3)
    }

    @IBAction func ShareAudioGifandVideo(_ sender: Any) {
        if checkCreateVideoAndGit == 0 {
            let title = "Error"
            let message = "Not File"
            let view = MessageView.viewFromNib(layout: .cardView)
            view.configureTheme(.error)
            view.configureContent(title: title, body: message)
            view.button?.isHidden = true
            //Config
            var config = SwiftMessages.Config()
            config.duration = .automatic
            SwiftMessages.show(config: config, view: view)
        } else if checkCreateVideoAndGit == 1  {
            btnReset.isHidden = false
            // Share Gif
            let shareURL: URL = URL(string: urlGifString)!
            do {
                let  shareData: NSData = try NSData(contentsOf: shareURL)
                let firstActivityItem: Array = [shareData]
                let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: firstActivityItem, applicationActivities: nil)
                self.present(activityViewController, animated: true, completion: nil)
            } catch {
                print("error")
            }
        } else {
            print("ajskljas")
            btnReset.isHidden = false
            // Share Video
            let videoURL = URL(fileURLWithPath: urlString)
            let activityItems: [Any] = [videoURL]
            let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            activityController.popoverPresentationController?.sourceView = view
            activityController.popoverPresentationController?.sourceRect = view.frame

            self.present(activityController, animated: true, completion: nil)
        }
    }

    @IBAction func saveCameraRoll(_ sender: Any) {
        if checkCreateVideoAndGit == 0 {
            let title = "Error"
            let message = "Not File"
            let view = MessageView.viewFromNib(layout: .cardView)
            view.configureTheme(.error)
            view.configureContent(title: title, body: message)
            view.button?.isHidden = true
            //Config
            var config = SwiftMessages.Config()
            config.duration = .automatic
            SwiftMessages.show(config: config, view: view)
        } else if checkCreateVideoAndGit == 1 {
            var placeHolder : PHObjectPlaceholder?
            PHPhotoLibrary.shared().performChanges({
                let creationRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(string: urlGifString)! )
                placeHolder = creationRequest?.placeholderForCreatedAsset

            }, completionHandler: { (success, error) in 
                if success {
                    let title = "Notification"
                    let message = "Your video was successfully saved"
                    let view = MessageView.viewFromNib(layout: .cardView)
                    view.configureTheme(.success)
                    view.configureContent(title: title, body: message)
                    view.button?.isHidden = true
                    //Config
                    var config = SwiftMessages.Config()
                    config.duration = .automatic
                    SwiftMessages.show(config: config, view: view)
                }
            })

        } else {
            var placeHolder : PHObjectPlaceholder?
            PHPhotoLibrary.shared().performChanges({
                let creationRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(string: self.urlString)! )
                placeHolder = creationRequest?.placeholderForCreatedAsset

            }, completionHandler: { (success, error) in
                if success {
                    let title = "Notification"
                    let message = "Your video was successfully saved"
                    let view = MessageView.viewFromNib(layout: .cardView)
                    view.configureTheme(.success)
                    view.configureContent(title: title, body: message)
                    view.button?.isHidden = true
                    //Config
                    var config = SwiftMessages.Config()
                    config.duration = .automatic
                    SwiftMessages.show(config: config, view: view)

                    //               let result = PHAsset.fetchAssets(withLocalIdentifiers: [placeHolder!.localIdentifier], options: nil)
                    //                result.firstObject?.PHAsset(
                    //
                    //                    // this is the url to the saved asset
                    //
                    //                })
                }
            })
        }
    }

//    class func saveToCameraRoll(imageUrl: String) {
//        ImageService.GetImageData(url: imageUrl) { data in // This helper function just fetches Data from the url using Alamofire
//            guard let data = data else { return }
//            PHPhotoLibrary.shared().performChanges({ _ in
//                PHAssetCreationRequest.forAsset().addResource(with: .photo, data: data, options: nil)
//            }) { success, error in
//                guard success else {
//                    log.debug("failed to save gif \(error)")
//                    return
//                }
//                log.debug("successfully saved gif")
//            }
//        }
//    }

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
    //    videogif.isHidden = true
        videoPlayerVc.view.isHidden = false
        videoPlayerVc.player?.play()
        self.loadingView.stopAnimating()
    }

    @IBAction func audioVideo(_ sender: Any) {
        self.loadingView.type = .ballSpinFadeLoader
        self.loadingView.color = #colorLiteral(red: 0.2588235294, green: 0.07843137255, blue: 0.9411764706, alpha: 1)
        self.loadingView.startAnimating()
        checkCreateVideoAndGit = 2
        // hidden Create Gif and Create Video
        stackViewHidden.isHidden = true
        stackTimeSpeedHidden.isHidden = true
        btnReset.isHidden = false
        constrainViewGifandVideo.constant = 0
        constrainSpeed.constant = 0
        constrainReset.constant = 45
        constrainTopSpeed.constant = 0
        constrainBottomSpeed.constant = 0

        //Play Video
        buildVideoFromImageArray()
    }

    @IBAction func resetGifAndVideo(_ sender: UIButton) {
        checkCreateVideoAndGit = 0
        // Show Create Gif and Create Video
        stackViewHidden.isHidden = false
        stackTimeSpeedHidden.isHidden = false
        btnReset.isHidden = true
        constrainViewGifandVideo.constant = 45
        constrainSpeed.constant = 30
        constrainReset.constant = 0
        constrainTopSpeed.constant = 15
        constrainBottomSpeed.constant = 15
        lblTut.isHidden = false

        //Remove Video and Gif
        removeFileAtURLIfExists(url: NSURL(fileURLWithPath: urlString))
        videoPlayerVc?.player?.pause()
        videoPlayerVc?.view.removeFromSuperview()
        videoPlayerVc = nil
    //    videogif.removeFromSuperview()
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

extension UIImage {
    func animatedGif(from images: [UIImage]) {
        let fileProperties: CFDictionary = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: 0]]  as CFDictionary
        let frameProperties: CFDictionary = [kCGImagePropertyGIFDictionary as String: [(kCGImagePropertyGIFDelayTime as String): 1.0]] as CFDictionary

        let documentsDirectoryURL: URL? = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL: URL? = documentsDirectoryURL?.appendingPathComponent("animated.gif")

        if let url = fileURL as CFURL? {
            if let destination = CGImageDestinationCreateWithURL(url, kUTTypeGIF, images.count, nil) {
                CGImageDestinationSetProperties(destination, fileProperties)
                for image in images {
                    if let cgImage = image.cgImage {
                        CGImageDestinationAddImage(destination, cgImage, frameProperties)
                    }
                }
                if !CGImageDestinationFinalize(destination) {
                    print("Failed to finalize the image destination")
                }
                print("Url = \(fileURL)")
                urlGifString = "\(fileURL!)"
            }
        }
    }

    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }

        return UIImage.animatedImageWithSource(source)
    }

    public class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
        guard let bundleURL:URL? = URL(string: gifUrl)
            else {
                print("image named \"\(gifUrl)\" doesn't exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL!) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }

        return gifImageWithData(imageData)
    }

    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }

        return gifImageWithData(imageData)
    }

    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1

        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)

        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }

        delay = delayObject as! Double

        if delay < 0.1 {
            delay = 0.1
        }

        return delay
    }

    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }

        if a! < b! {
            let c = a
            a = b
            b = c
        }

        var rest: Int
        while true {
            rest = a! % b!

            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }

    class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }

        var gcd = array[0]

        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }

        return gcd
    }

    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()

        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }

            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }

        let duration: Int = {
            var sum = 0

            for val: Int in delays {
                sum += val
            }

            return sum
        }()

        let gcd = gcdForArray(delays)
        var frames = [UIImage]()

        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)

            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }

        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 1000.0)

        return animation
    }
}


