//
//  ViewController.swift
//  ScrollViewDemo
//
//  Created by NguyenManh on 10/7/18.
//  Copyright © 2018 NguyenManh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    var views:[UIView]!
  

    var customKeyBoardAccessView: UIView!
    var txfInput : UITextField!
    var numberFrameXibWidth:CGFloat = 0
    var numberFrameXibheigh:CGFloat = 0
    let numberWidth = 52
    let spaceSwidth = 10
    let numberheigh = 52
    var isCanUpdateNumberOffset:Bool = false
    var currentItemIdx: NSInteger = 0
    

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
        
        //Edited By Manh Nguyen
        txFShowText.isHidden = true
        customKeyBoardAccessView = UIView(frame: CGRect(x: 0, y: 0, width: Constant.VIEW_ACCSESS_KEYB_SIZE.width, height: Constant.VIEW_ACCSESS_KEYB_SIZE.height))
        
        txfInput = UITextField(frame: CGRect(x: 5, y: Constant.VIEW_ACCSESS_KEYB_SIZE.height / 2 - Constant.TEXTFILED_ACCSESS_KEYB_SIZE.height / 2, width: Constant.TEXTFILED_ACCSESS_KEYB_SIZE.width, height: Constant.TEXTFILED_ACCSESS_KEYB_SIZE.height))
        txfInput.backgroundColor = UIColor.clear
        txfInput.addTarget(self, action: #selector(textInputChanged), for: UIControlEvents.editingChanged)
        
        txfInput.tag = 10;
        txfInput.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        txfInput.delegate = self
        customKeyBoardAccessView.addSubview(txfInput)
        customKeyBoardAccessView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
//        txFShowText.inputAccessoryView = customKeyBoardAccessView
        
        
        
        numberFrameXibWidth = scrollViewMain.frame.size.width
        numberFrameXibheigh = scrollViewMain.frame.size.width
        scrollViewNumber.showsVerticalScrollIndicator = false
        scrollViewNumber.showsHorizontalScrollIndicator = false
        scrollViewMain.showsVerticalScrollIndicator = false
        scrollViewMain.showsHorizontalScrollIndicator = false
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
        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
        if (currentItem.lblBackground.text?.isEmpty)! {
                currentItem.lblTut.isHidden = false
        }
    
    }
    
    @objc func textInputChanged(textView : UITextView) {
          let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
            currentItem.lblBackground.text = textView.text;
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
        let tapGest: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedScrollViewMain))
        scrollViewMain.addGestureRecognizer(tapGest)
        button.setTitle("\(number + 1)", for: .normal)
        button.addTarget(self, action: #selector(clickItem), for: .touchUpInside)
        button.tag = arrNumbers.count - 1
    }
    
    // MARK: Tap Scrollview main
    
    @objc func tappedScrollViewMain(_ tap : UITapGestureRecognizer) {
        
        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
        currentItem.lblTut.isHidden = true
        if  (currentItem.lblBackground.text?.isEmpty)!{
            txfInput.text = ""
            txfInput.placeholder = "dfd"
        }
        //        txfInput.text = currentItem.lblBackground.text;
//        print("\(txfInput) as ")
       
       txFShowText.inputAccessoryView = customKeyBoardAccessView
        txFShowText.becomeFirstResponder()
        txfInput.becomeFirstResponder()
     
        
    }
    
    // MARK: Click add more button
    
    @IBAction func clickButton(_ sender: UIButton) {
        addButton()
        addImagView()
        isCanUpdateNumberOffset = false
        if self.scrollViewNumber.contentSize.width > self.scrollViewNumber.bounds.size.width {
            let bottomOffset = CGPoint(x: scrollViewNumber.contentSize.width - scrollViewNumber.bounds.size.width, y: 0)
            scrollViewNumber.setContentOffset(bottomOffset, animated: true)
            
        }
        
        print(scrollViewNumber.contentOffset.x)
        currentItemIdx = arrNumbers.count - 1
        let btnButtonNumber:UIButton = arrNumbers[arrNumbers.count - 1]
        for but in arrNumbers {
            if but != btnButtonNumber {
                but.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            } else {
                btnButtonNumber.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            }
        }
        
        
    }
    
    // MARK: Click scrollview number item
    @objc func clickItem(sender:UIButton) {
        
        print("clicked item number")
        let selectedIdx = sender.tag
        currentItemIdx = selectedIdx
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
    
     // MARK: Main Scroll ITEM
    func addImagView() {
        
        let numberXib = arrXib.count
        var originX:CGFloat = 0
        let originY = 0
        
        for _ in 0..<numberXib {
            originX += numberFrameXibWidth
        }
        
        guard let customView = Bundle.main.loadNibNamed("IemScrollView", owner: self, options: nil)?.first as? ItemScrollView else { return }
        customView.frame = CGRect(x: originX, y: CGFloat(originY), width: numberFrameXibWidth, height: numberFrameXibheigh)
        customView.lblBackground.text = ""
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
    
    
    
    // MARK:  SCROLLVIEW DELEGATE
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scrollViewMain && isCanUpdateNumberOffset == true{
            if self.scrollViewNumber.contentSize.width > self.scrollViewNumber.bounds.size.width{
                
            }
            numberIndext = Int(scrollViewMain.contentOffset.x) / Int(numberFrameXibWidth)
            currentItemIdx = numberIndext
            //Edited by Manh Nguyen
            //update srollviewNumber
            let distanceX = scrollViewNumber.contentSize.width - scrollViewNumber.bounds.size.width
            if distanceX > 0{
                var widthScroll:CGFloat =  CGFloat(numberIndext  * numberWidth)
                if widthScroll < 0 {
                    widthScroll = 0
                }else if widthScroll >= distanceX{
                    widthScroll = distanceX
                }
                
                let bottomOffset = CGPoint(x: widthScroll , y: 0)
                scrollViewNumber.setContentOffset(bottomOffset, animated: true)
                
            }else{
                
            }
           
            let btnButtonNumber:UIButton = arrNumbers[numberIndext]
            
            for but in arrNumbers {
                if but != btnButtonNumber {
                    but.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                } else {
                    btnButtonNumber.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
                }
            }
        }
      
       // print("indext:  \(numberIndext)")

    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == scrollViewMain {
            //set can update
            isCanUpdateNumberOffset = true
            
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("kasjdjkasd\(numberIndext)")
        
      
        
    }
    //Show Text Main

    @IBAction func showTextMainBackground(_ sender: UITextField) {
        //        for element in scrollViewMain.subviews {
        //            if element is ItemScrollView  {
        (scrollViewMain.subviews[temp1] as? ItemScrollView)?.lblBackground.text = txFShowText.text
        //            }
        //        }
    }

    //SegMented
    @IBAction func segMentedMenu(_ sender: UISegmentedControl) {
          self.viewMenuBottom.bringSubview(toFront: views[sender.selectedSegmentIndex])
    }
    
    
    // MARK: TextField Delegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

        if textField.tag == 10{
            let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
            if  (currentItem.lblBackground.text?.isEmpty)!{
                txfInput.attributedPlaceholder = NSAttributedString(string: "Wirte something to add",
                                                                       attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
                
            }
            else{
                 textField.text =  currentItem.lblBackground.text
            }
          
//            self.view.endEditing(true)
//            textField.becomeFirstResponder()
//            return true
        }
       return true
    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
//        currentItem.lblBackground.text = textField.text! + string;
//        return true
//    }
   
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



extension ViewController:EmojViewControllerDelegate {
    
    func emojView(_ viewcontroller: EmojViewController, didSelect emoji: String) {
        for element in scrollViewMain.subviews {
            if element is ItemScrollView  {
                txFShowText.text = txFShowText.text! + emoji
                (element as! ItemScrollView).lblBackground.text = (element as! ItemScrollView).lblBackground.text! + emoji
            }
        }
    }
}





