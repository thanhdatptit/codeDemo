//
//  ViewController.swift
//  ScrollViewDemo
//
//  Created by NguyenManh on 10/7/18.
//  Copyright © 2018 NguyenManh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    var views:[UIView]!
   
    var numberFrameXibWidth:CGFloat = 0
    var numberFrameXibheigh:CGFloat = 0
    let numberWidth = 52
    let spaceSwidth = 10
    let numberheigh = 52

    @IBOutlet weak var lblTest: UILabel!
    @IBOutlet weak var txFShowText: UITextField!
    @IBOutlet weak var scrollViewNumber: UIScrollView!
    @IBOutlet weak var scrollViewMain: UIScrollView!

    @IBOutlet weak var viewMenuBottom: UIView!
    @IBOutlet weak var segmentedClickMenu: UISegmentedControl!

    var arrNumbers = [UIButton]()
    var arrXib = [UIView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        numberFrameXibWidth = scrollViewMain.frame.size.width
        numberFrameXibheigh = scrollViewMain.frame.size.width
        scrollViewNumber.showsVerticalScrollIndicator = false
        scrollViewNumber.showsHorizontalScrollIndicator = false
        scrollViewNumber.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.3)
        addButton()
        addImagView()
        scrollViewMain.delegate = self
        // SegMented
        views = [UIView]()
        let vc1 = EmojViewController()
        vc1.delegate = self
        let vc2 = TextImageViewController()
     //   vc2.delete = self
        let vc3 = ColorBackgroungViewController()
     //  vc3.delegate = self
        let vc4 = ColorTextViewController()
     // vc4.delegate = self
        let vc5 = ImageCameraViewController()
    //  vc5.delegate = self
        views.append(vc1.view)
        views.append(vc2.view)
        views.append(vc3.view)
        views.append(vc4.view)
        views.append(vc5.view)
        for v in views {
            viewMenuBottom.addSubview(v)
        }
        viewMenuBottom.addSubview(vc1.view)
        viewMenuBottom.addSubview(vc2.view)
        viewMenuBottom.addSubview(vc3.view)
        viewMenuBottom.addSubview(vc4.view)
        viewMenuBottom.addSubview(vc5.view)
        self.addChildViewController(vc1)
        self.addChildViewController(vc2)
        self.addChildViewController(vc3)
        self.addChildViewController(vc4)
        self.addChildViewController(vc5)
        viewMenuBottom.bringSubview(toFront: views[0])
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard(){
        view.endEditing(true)
        txFShowText.resignFirstResponder()
    }
    
    // add more number scrollview's item
    
    func addButton() {
        let number = arrNumbers.count
        let originY = 0
        var originX = 0
        
        for _ in 0..<number {
            originX +=  numberWidth + spaceSwidth
        }
        
        let button:UIButton = UIButton(frame: CGRect(x: originX, y: originY, width: numberWidth, height: numberheigh))
        button.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        scrollViewNumber.addSubview(button)
        arrNumbers.append(button)
        scrollViewNumber.contentSize.width = CGFloat(originX + numberWidth)
        scrollViewNumber.isPagingEnabled = true
        button.setTitle("\(number + 1)", for: .normal)
        button.addTarget(self, action: #selector(clickItem), for: .touchUpInside)
        button.tag = arrNumbers.count - 1
    }
    
    
    // Click add more button
    
    @IBAction func clickButton(_ sender: UIButton) {
        addButton()
        addImagView()
        if self.scrollViewNumber.contentSize.width > self.scrollViewNumber.bounds.size.width {
            let bottomOffset = CGPoint(x: scrollViewNumber.contentSize.width - scrollViewNumber.bounds.size.width, y: 0)
            scrollViewNumber.setContentOffset(bottomOffset, animated: true)
            
        }
        
        print(scrollViewNumber.contentOffset.x)
        let btnButtonNumber:UIButton = arrNumbers[arrNumbers.count - 1]
        for but in arrNumbers {
            if but != btnButtonNumber {
                but.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            } else {
                btnButtonNumber.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            }
        }
        
        
    }
    
    // Click scrollview number item
    @objc func clickItem(sender:UIButton) {
        
        print("clicked item number")
        let selectedIdx = sender.tag
        let widthScroll:CGFloat =  CGFloat(selectedIdx)  * numberFrameXibWidth

        let bottomOffset = CGPoint(x: widthScroll , y: 0)
        scrollViewMain.setContentOffset(bottomOffset, animated: true)
        
        
        
        //Edited by Manh Nguyen
        //update scrollviewNumber contentoffset
        
       if self.scrollViewNumber.contentSize.width > self.scrollViewNumber.bounds.size.width{
  
            let selectedItem: UIButton = arrNumbers[selectedIdx]
       
            let middleX =  scrollViewNumber.bounds.size.width / 2.0
            let currentX = selectedItem.frame.origin.x - scrollViewNumber.contentOffset.x;
        
            var offsetX : CGFloat = 0
            var scrollMenuOffset : CGPoint = CGPoint(x: 0, y: 0)
            if  currentX > middleX {
                
                print("bigger Than : ")
                //check if selected index is bigger than middle index, will plus contenoffset's width with a item's width
                offsetX = (CGFloat) (scrollViewNumber.contentOffset.x) + 2.0 * (CGFloat)(numberWidth) + (CGFloat)(spaceSwidth);
                
                let rangeDis = scrollViewNumber.contentSize.width - scrollViewNumber.bounds.size.width
                if offsetX >= rangeDis{
                    offsetX = rangeDis
                }else{
                    // do nothing
                }
                scrollMenuOffset = CGPoint(x: offsetX , y: 0)
                
            }
            else{
                
                print("small Than : ")
                offsetX = (CGFloat) (scrollViewNumber.contentOffset.x) - 2.0 * (CGFloat)(numberWidth) - (CGFloat)(spaceSwidth);
                if offsetX <= 0 {
                    offsetX = 0
                }else{
                    //do nothing
                }
                scrollMenuOffset = CGPoint(x: offsetX , y: 0)
                
            }
        
            //** excute update offset
            scrollViewNumber.setContentOffset(scrollMenuOffset, animated: true)
        
        }
    
        
        let btnButtonNumber:UIButton = arrNumbers[selectedIdx]
        for but in arrNumbers {
            if but != btnButtonNumber {
                but.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            } else {
                btnButtonNumber.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            }
        }
//            let bottomOffset12 = CGPoint(x: selectedIdx * numberWidth , y: 0)
//            scrollViewNumber.setContentOffset(bottomOffset12, animated: true)
    }
    
     var temp1 = 0
    func addImagView() {
        let numberXib = arrXib.count
        var originX:CGFloat = 0
        let originY = 0
        
        for _ in 0..<numberXib {
            originX += numberFrameXibWidth
        }
        
        guard let customView = Bundle.main.loadNibNamed("IemScrollView", owner: self, options: nil)?.first as? ItemScrollView else { return }
        customView.frame = CGRect(x: originX, y: CGFloat(originY), width: numberFrameXibWidth, height: numberFrameXibheigh)
        
        scrollViewMain.contentSize.width = originX + numberFrameXibWidth
        scrollViewMain.isPagingEnabled = true
        print("X \(originX)")
            customView.backgroundColor = UIColor.random()
        scrollViewMain.addSubview(customView)
        print("abc \(arrXib.count)")
        arrXib.append(customView)
        if self.scrollViewMain.contentSize.width > self.scrollViewMain.bounds.size.width {
            let bottomOffset = CGPoint(x: scrollViewMain.contentSize.width - scrollViewMain.bounds.size.width, y: 0)
            scrollViewMain.setContentOffset(bottomOffset, animated: true)
            customView.tag = arrXib.count - 1
         //   customView.indext.text = "\(customView.tag + 1)"
            temp1 = customView.tag
        }
    }

    var numberIndext = 0
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        numberIndext = Int(scrollViewMain.contentOffset.x) / Int(numberFrameXibWidth)
       // print("indext:  \(numberIndext)")

    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("kasjdjkasd\(numberIndext)")
        let widthScroll:CGFloat =  CGFloat(numberIndext  * numberWidth)
        let bottomOffset = CGPoint(x: widthScroll , y: 0)
        scrollViewNumber.setContentOffset(bottomOffset, animated: true)
        let btnButtonNumber:UIButton = arrNumbers[numberIndext]
        for but in arrNumbers {
            if but != btnButtonNumber {
                but.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            } else {
                btnButtonNumber.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            }
        }
        
    }
    //Show Text Main

    @IBAction func showTextMainBackground(_ sender: UITextField) {
//        guard let customView = Bundle.main.loadNibNamed("IemScrollView", owner: self, options: nil)?.first as? ItemScrollView else { return }
       // customView.frame = CGRect(x: originX, y: CGFloat(originY), width: numberFrameXibWidth, height: numberFrameXibheigh)
     //   customView.indext.text = txFShowText.text
    //    lblTextViewMain.text = txFShowText.text

    }

    //SegMented
    @IBAction func segMentedMenu(_ sender: UISegmentedControl) {
          self.viewMenuBottom.bringSubview(toFront: views[sender.selectedSegmentIndex])
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

extension ViewController: EmojViewControllerDelegate {
    func emojViewController(_ viewcontroller: EmojViewController, didSelect emoji: String) {
        lblTest.text = emoji
    }
}

