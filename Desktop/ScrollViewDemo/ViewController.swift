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
    var arrMenuSelect = [UIButton]()
    var arrimageView = [UIImage]()
    var arrListConten = [ItemScrollView]()
    var checkEmoj = 0
    var isDragging: Bool = false
    var oldX: CGFloat = 0
    var oldY: CGFloat = 0
    var lblGuidle :UILabel!
    var viewFontSizeEdit: UIView!
    fileprivate var numberWidthMenuSelect = 0
    fileprivate var numberheighMenuSelect = 52
    var isShowEditedControl: Bool!
    fileprivate var customKeyBoardAccessView: UIView!
    fileprivate var txfInput : UITextField!
    fileprivate var numberFrameXibWidth:CGFloat = 0
    fileprivate var numberFrameXibheigh:CGFloat = 0
    fileprivate let numberWidth = 38
    fileprivate let spaceSwidth = 10
    fileprivate let numberheigh = 38
    fileprivate var isCanUpdateNumberOffset:Bool = false
    fileprivate var currentItemIdx: NSInteger = 0

    @IBOutlet weak var removeAll: UIBarButtonItem!
    @IBOutlet weak var removeIndex: UIBarButtonItem!

    @IBOutlet weak var scrollMenuBot: UIScrollView!
    @IBOutlet weak var txFShowText: UITextField!
    @IBOutlet weak var scrollViewNumber: UIScrollView!
    @IBOutlet weak var scrollViewMain: UIScrollView!

    @IBOutlet weak var viewMenuBottom: UIView!

    @IBOutlet weak var btnMakeNow: UIButton!
    
    @IBOutlet weak var btnAddMore: UIButton!
    
    @IBAction func makeNowAction(_ sender: Any) {
    }
    var arrNumbers = [UIButton]()
    var arrXib = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollMenuBot.delegate = self
        self.navigationController?.navigationBar.isOpaque = true
        self.navigationController?.navigationBar.isTranslucent = false
        btnMakeNow.layer.cornerRadius = 15
        btnMakeNow.layer.borderWidth = 5.0
        btnMakeNow.layer.borderColor = UIColor.white.cgColor
        scrollViewMain.layer.borderWidth = 5.0
        scrollViewMain.layer.borderColor = UIColor.white.cgColor
        btnMakeNow.clipsToBounds = true
        self.layerElement(ele: scrollViewMain.layer, borderColor: UIColor.red, cornerRadius: 15)
//        self.layerElement(ele: btnAddMore.layer, borderColor: UIColor.red, cornerRadius: 15)
//        btnAddMore.layer.borderWidth = 2.0
//        btnAddMore.layer.borderColor = UIColor.white.cgColor
        addButton12()
        cusTomView()
        isShowEditedControl = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrimageView.removeAll()
        arrMenuSelect[2].sendActions(for: .touchUpInside)
        navigationController?.isNavigationBarHidden = false
    }

    func addButton12() {
        for i in 0...4 {
            numberWidthMenuSelect = Int(scrollMenuBot.frame.size.width / 5)
            let number = arrMenuSelect.count
            let originY = scrollMenuBot.frame.height / 2 - 52/2
            var originX = 0

            for _ in 0..<number {
                originX +=  numberWidthMenuSelect
            }
            
            let button:UIButton = UIButton(frame: CGRect(x: originX, y:Int(originY), width: numberWidthMenuSelect, height: numberheighMenuSelect))
            button.backgroundColor = Constant.SELECTED_COLOR
            button.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.8196078431, blue: 0.6823529412, alpha: 1)
            button.setTitleColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), for: .normal)
            scrollMenuBot.addSubview(button)
            
            arrMenuSelect.append(button)
            scrollMenuBot.contentSize.width = CGFloat(originX + numberWidthMenuSelect)
            //scrollView.isPagingEnabled = true
            button.setTitle("\(number + 1)", for: .normal)
            button.addTarget(self, action: #selector(clickItem12), for: .touchUpInside)
            button.tag = i
        }
        arrMenuSelect[1].setTitle("hello", for: .normal)
        arrMenuSelect[0].setTitle("hello12", for: .normal)
    }

    @objc func clickItem12(sender:UIButton) {
        for i in 0..<views.count {
            if i == sender.tag {
                views[i].isHidden = false
                sender.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
                sender.setTitleColor(Constant.SELECTED_COLOR, for: .normal)

            } else {
                views[i].isHidden = true
                arrMenuSelect[i].backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.8196078431, blue: 0.6823529412, alpha: 1)
                arrMenuSelect[i].setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)

            }
        }
        self.viewMenuBottom.bringSubview(toFront: views[sender.tag])
     //   self.viewMenuBottom.bringSubview(toFront: views[sender.selectedSegmentIndex])
    }

    
    
    func cusTomView() {

        //Edited By Manh Nguyen
        txFShowText.isHidden = true
        customKeyBoardAccessView = UIView(frame: CGRect(x: 0, y: 0, width: Constant.VIEW_ACCSESS_KEYB_SIZE.width, height: Constant.VIEW_ACCSESS_KEYB_SIZE.height))
        //add clear button
        let btnClear = UIButton(frame: CGRect(x: Constant.VIEW_ACCSESS_KEYB_SIZE.width - 30, y: Constant.VIEW_ACCSESS_KEYB_SIZE.height / 2 - 20, width: 40, height: 40))
        btnClear.addTarget(self, action: #selector(clearTypingText), for: UIControlEvents.touchUpInside)
        customKeyBoardAccessView.addSubview(btnClear)
   
        btnClear.setImage(UIImage.init(named: "clear"), for: UIControlState.normal)
        txfInput = UITextField(frame: CGRect(x: 5, y: Constant.VIEW_ACCSESS_KEYB_SIZE.height / 2 - Constant.TEXTFILED_ACCSESS_KEYB_SIZE.height / 2, width: Constant.TEXTFILED_ACCSESS_KEYB_SIZE.width, height: Constant.TEXTFILED_ACCSESS_KEYB_SIZE.height))
        txfInput.backgroundColor = UIColor.clear
        txfInput.addTarget(self, action: #selector(textInputChanged), for: UIControlEvents.editingChanged)

        txfInput.tag = 10;
        txfInput.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        txfInput.delegate = self
        customKeyBoardAccessView.addSubview(txfInput)
        customKeyBoardAccessView.backgroundColor = Constant.TEXT_EDIT_BG_COLOR
        //        txFShowText.inputAccessoryView = customKeyBoardAccessView

        numberFrameXibWidth = scrollViewMain.frame.size.width
        numberFrameXibheigh = scrollViewMain.frame.size.height
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
        vc1.view.frame = CGRect(x: 0, y: 0, width: viewMenuBottom.frame.width, height: viewMenuBottom.frame.height)
        vc1.delegate = self
        let vc2 = TextImageViewController()
        vc2.view.frame = CGRect(x: 0, y: 0, width: viewMenuBottom.frame.width, height: viewMenuBottom.frame.height)
        vc2.delegate = self
        let vc3 = ColorBackgroungViewController()
        vc3.view.frame = CGRect(x: 0, y: 0, width: viewMenuBottom.frame.width, height: viewMenuBottom.frame.height)
        vc3.delegate = self
        let vc4 = ColorTextViewController()
        vc4.view.frame = CGRect(x: 0, y: 0, width: viewMenuBottom.frame.width, height: viewMenuBottom.frame.height)
        vc4.delegate = self
        let vc5 = ImageCameraViewController()
        vc5.view.frame = CGRect(x: 0, y: 0, width: viewMenuBottom.frame.width, height: viewMenuBottom.frame.height)
        vc5.delegate = self
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
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }

    @objc func clearTypingText(sender:UIButton){
        txfInput.text = ""
        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
        currentItem.lblBackground.text = ""
    }
    
    // MARK: DISSMISS KEYBOARD
    @objc func dismissKeyboard(){
        view.endEditing(true)
        txFShowText.resignFirstResponder()
        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
         currentItem.lblBackground.isUserInteractionEnabled = false
        self.changeTextAtributtedBGColor(lbl: currentItem.lblBackground, color: UIColor.clear)
        if (currentItem.lblBackground.text?.isEmpty)! {
              currentItem.lblTut.isHidden = false
            
        }
        self.guidleText(show: false)
        self.showFontSizeEdit(show: false)
        removeAll.isEnabled = true
        removeIndex.isEnabled = true
    }
    
    @objc func textInputChanged(textView : UITextView) {
          let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
            currentItem.lblBackground.text = textView.text;
          self.changeTextAtributtedBGColor(lbl: currentItem.lblBackground, color: UIColor.red)
        
    }
    
    // MARK: CHANGE TEXT ATTRIBUTED COLOR
    func changeTextAtributtedBGColor(lbl: UILabel, color : UIColor) {
        //creating attributed string
        let atrribString: NSMutableAttributedString = NSMutableAttributedString(attributedString: NSAttributedString(string:lbl.text!))
        //setting background color to attributed text
        atrribString.addAttribute(NSAttributedStringKey.backgroundColor, value: color, range: NSMakeRange(0, atrribString.length))
        //setting attributed text to label
       lbl.attributedText = atrribString
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
    
    // add more number scrollview's item
    
    func addButton() {
        let number = arrNumbers.count
        let originY = scrollViewNumber.frame.height / 2 - 38/2
        var originX = 0
        
        for _ in 0..<number {
            originX +=  numberWidth + spaceSwidth
        }
        
        let button:UIButton = UIButton(frame: CGRect(x: originX, y: Int(originY), width: numberWidth, height: numberheigh))
        button.backgroundColor = Constant.SELECTED_COLOR
        button.layer.cornerRadius = 5
        scrollViewNumber.addSubview(button)
        arrNumbers.append(button)
        scrollViewNumber.contentSize.width = CGFloat(originX + numberWidth)
        scrollViewNumber.isPagingEnabled = true
        let tapGest: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedScrollViewMain))
        scrollViewMain.addGestureRecognizer(tapGest)
        
        button.setTitle("\(number + 1)", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(clickItem), for: .touchUpInside)
        button.tag = arrNumbers.count - 1
    }
    
    // MARK: Tap Scrollview main
    
    @objc func tappedScrollViewMain(_ tap : UITapGestureRecognizer) {
        
        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
        currentItem.lblTut.isHidden = true
        removeIndex.isEnabled = false
        removeAll.isEnabled = false
        
        
        //edited by Manh
        self.guidleText(show: true)
        self.showFontSizeEdit(show: true)
        
        currentItem.lblBackground.isUserInteractionEnabled = true
        self.changeTextAtributtedBGColor(lbl: currentItem.lblBackground, color: UIColor.red)
        
        
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
   
    // MARK: GUIDLE TEXT
    func guidleText(show:Bool) {
        //create guidle view
        if show {
            if lblGuidle != nil{
                return
            }
            
            lblGuidle  = UILabel(frame: CGRect(x: Constant.MAIN_SCREEN_SIZE.width / 2 - Constant.TEXT_GUIDLE_SIZE.width / 2, y: -Constant.TEXT_GUIDLE_SIZE.height, width: Constant.TEXT_GUIDLE_SIZE.width, height: Constant.TEXT_GUIDLE_SIZE.height))
            
            lblGuidle.backgroundColor = Constant.TEXT_EDIT_BG_COLOR
            lblGuidle.textColor = UIColor.white
            lblGuidle.layer.cornerRadius = 10
            lblGuidle.layer.masksToBounds = true
            lblGuidle.textAlignment = NSTextAlignment.center
            lblGuidle.text = "Touch & Drag Text To Move"
            self.view.addSubview(lblGuidle)
           
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollViewNumber.alpha = 0.0
                self.btnAddMore.isEnabled = false
                self.btnAddMore.alpha = 0.0
                self.lblGuidle.frame = CGRect(x: Constant.MAIN_SCREEN_SIZE.width / 2 - Constant.TEXT_GUIDLE_SIZE.width / 2, y: self.scrollViewNumber.frame.origin.y, width: Constant.TEXT_GUIDLE_SIZE.width, height: Constant.TEXT_GUIDLE_SIZE.height)
                
            }) { (true) in
                
            }
        }
        else{
            if lblGuidle == nil{
                return
            }
   
            UIView.animate(withDuration: 0.3, animations: {
                self.lblGuidle.frame =  CGRect(x: Constant.MAIN_SCREEN_SIZE.width / 2 - Constant.TEXT_GUIDLE_SIZE.width / 2, y: -Constant.TEXT_GUIDLE_SIZE.height, width: Constant.TEXT_GUIDLE_SIZE.width, height: Constant.TEXT_GUIDLE_SIZE.height)
                self.scrollViewNumber.alpha = 1
                self.btnAddMore.isEnabled = true
                self.btnAddMore.alpha = 1
                
            }) { (true) in
                   self.lblGuidle?.removeFromSuperview()
                   self.lblGuidle = nil
                
            }
            
        }
       
    }

    func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {

            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }

    @IBAction func createVideoGif(_ sender: Any) {
        let numberCountArrXib = arrXib.count
        for i in 0..<numberCountArrXib {
            guard let imageXib = image(with: arrXib[i]) else { return }
            arrimageView.append(imageXib)
        }
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "GifAndCameraViewController") as? GifAndCameraViewController  else { return }
        let nav:UINavigationController = UINavigationController(rootViewController: vc)

        vc.arrimageVideo = arrimageView
        navigationController?.present(nav, animated: true, completion: nil)
    }

    @IBAction func removeAll(_ sender: Any) {
        for i in 0..<arrNumbers.count {
            arrNumbers[i].removeFromSuperview()
        }
        for i in 0..<arrXib.count {
            arrXib[i].removeFromSuperview()
        }
        arrNumbers.removeAll()
        arrXib.removeAll()
        currentItemIdx = 0
        addButton()
        addImagView()
    }

    @IBAction func removeGifVideo(_ sender: UIButton) {
        arrXib[2].removeFromSuperview()
       arrNumbers[2].removeFromSuperview()
        arrNumbers.remove(at: 2)
        arrXib.remove(at: 2)
        scrollViewNumber.setNeedsDisplay()
        scrollViewMain.setNeedsDisplay()
        self.view.setNeedsDisplay()
    }
    
 // MARK: Click add more button
    @IBAction func clickButton(_ sender: UIButton) {
        checkEmoj = 0
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
                btnButtonNumber.backgroundColor = Constant.SELECTED_COLOR
            }
        }
    }
    
    // MARK: Click scrollview number item
    var numberClickScroll = 0
    @objc func clickItem(sender:UIButton) {
        checkEmoj = 1
        isCanUpdateNumberOffset = false
        print("clicked item number")
        let selectedIdx = sender.tag
        numberClickScroll =  sender.tag
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
                btnButtonNumber.backgroundColor = Constant.SELECTED_COLOR
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
        let originY:CGFloat = 0
        
        for _ in 0..<numberXib {
            originX += numberFrameXibWidth
        }
        
        guard let customView = Bundle.main.loadNibNamed("ItemScrollView", owner: self, options: nil)?.first as? ItemScrollView else { return }
        customView.frame = CGRect(x: originX, y: originY, width: numberFrameXibWidth, height: numberFrameXibheigh)
        customView.lblBackground.text = ""
//        customView.imagBackground.layer.cornerRadius = 20
//        customView.imagBackground.clipsToBounds = true
 
//        customView.backgroundColor = UIColor.white
       
        scrollViewMain.contentSize.width = originX + numberFrameXibWidth
        scrollViewMain.isPagingEnabled = true
        print("X \(originX)")
        customView.imagBackground.backgroundColor = UIColor.random()
        scrollViewMain.addSubview(customView)
        arrListConten.append(customView)
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
    
    
    
    // MARK: FONT SIZE
    func showFontSizeEdit(show: Bool){
        
        if show {
            if isShowEditedControl {
                return
            }
           
            if viewFontSizeEdit == nil{
                let heightOfView = Constant.BUTTON_FONT_SIZE.height * 4 + 5 * Constant.BUTTON_FONT_SIZE_MARGIN
                viewFontSizeEdit = UIView(frame: CGRect(x: Constant.MAIN_SCREEN_SIZE.width, y: (scrollViewMain.frame.origin.y + scrollViewMain.frame.size.height / 2) - heightOfView / 2 , width: Constant.VIEW_FONT_SIZE.width, height:heightOfView))
                viewFontSizeEdit.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                let lblSize : UILabel = UILabel(frame: CGRect(x: Constant.VIEW_FONT_SIZE.width / 2 - Constant.BUTTON_FONT_SIZE.width / 2, y: Constant.BUTTON_FONT_SIZE_MARGIN, width: Constant.BUTTON_FONT_SIZE.width, height: Constant.BUTTON_FONT_SIZE.height))
                lblSize.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                lblSize.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                self.layerElement(ele: lblSize.layer, borderColor: UIColor.red, cornerRadius: 7)
                lblSize.text = "35"
                lblSize.font = UIFont.systemFont(ofSize: 19)
                lblSize.textAlignment = NSTextAlignment.center
                viewFontSizeEdit.addSubview(lblSize)
                let btnPlus: UIButton = UIButton(frame: CGRect(x: Constant.VIEW_FONT_SIZE.width / 2 - Constant.BUTTON_FONT_SIZE.width / 2, y: Constant.BUTTON_FONT_SIZE.width + 2 * Constant.BUTTON_FONT_SIZE_MARGIN, width: Constant.BUTTON_FONT_SIZE.width, height: Constant.BUTTON_FONT_SIZE.height))
                
                btnPlus.backgroundColor =  #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
                self.layerElement(ele: btnPlus.layer, borderColor: UIColor.red, cornerRadius: 7)
                btnPlus.setTitleColor(UIColor.white, for: UIControlState.normal)
                btnPlus.setTitle("+", for: UIControlState.normal)
                btnPlus.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 22)
                btnPlus.addTarget(self, action: #selector(plusFontSizeAction(sender:)), for: UIControlEvents.touchUpInside)
                viewFontSizeEdit.addSubview(btnPlus)
                
                let btnMinus: UIButton = UIButton(frame: CGRect(x: Constant.VIEW_FONT_SIZE.width / 2 - Constant.BUTTON_FONT_SIZE.width / 2, y: 2 * Constant.BUTTON_FONT_SIZE.height + 3 * Constant.BUTTON_FONT_SIZE_MARGIN, width: Constant.BUTTON_FONT_SIZE.width, height: Constant.BUTTON_FONT_SIZE.height))
                btnMinus.backgroundColor =  #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
                btnMinus.setTitleColor(UIColor.white, for: UIControlState.normal)
                btnMinus.setTitle("-", for: UIControlState.normal)
                btnMinus.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
                self.layerElement(ele: btnMinus.layer, borderColor: UIColor.red, cornerRadius: 7)
                btnMinus.addTarget(self, action: #selector(minusFontSizeAction), for: UIControlEvents.touchUpInside)
                 viewFontSizeEdit.addSubview(btnMinus)
                
                //add back to default button
                let btnDefault: UIButton = UIButton(frame: CGRect(x: Constant.VIEW_FONT_SIZE.width / 2 - Constant.BUTTON_FONT_SIZE.width / 2, y: 3 * Constant.BUTTON_FONT_SIZE.height + 4 * Constant.BUTTON_FONT_SIZE_MARGIN, width: Constant.BUTTON_FONT_SIZE.width, height: Constant.BUTTON_FONT_SIZE.height))
                btnDefault.backgroundColor =  #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                btnDefault.setImage(#imageLiteral(resourceName: "return"), for: UIControlState.normal)
                btnDefault.setTitleColor(UIColor.white, for: UIControlState.normal)
               
           
                self.layerElement(ele: btnDefault.layer, borderColor: UIColor.red, cornerRadius: 7)
                btnDefault.addTarget(self, action: #selector(backToDefaultSet), for: UIControlEvents.touchUpInside)
                viewFontSizeEdit.addSubview(btnDefault)
                
               self.layerElement(ele: viewFontSizeEdit.layer, borderColor: UIColor.red, cornerRadius: 10)
                self.view.addSubview(viewFontSizeEdit)
            }
            else{
                //do nothing
            }
            
            UIView.animate(withDuration: 0.3) {
                self.viewFontSizeEdit.frame = CGRect(x: Constant.MAIN_SCREEN_SIZE.width - Constant.VIEW_FONT_SIZE.width - 5, y: self.viewFontSizeEdit.frame.origin.y, width: Constant.VIEW_FONT_SIZE.width, height: self.viewFontSizeEdit.frame.size.height)
                self.btnMakeNow.isEnabled = false
                self.btnMakeNow.alpha = 0.0
                
            }
            isShowEditedControl = true
        }
        else{
            if self.viewFontSizeEdit == nil {
                return
            }
            UIView.animate(withDuration: 0.3) {
                self.viewFontSizeEdit.frame = CGRect(x: Constant.MAIN_SCREEN_SIZE.width, y: self.viewFontSizeEdit.frame.origin.y, width: Constant.VIEW_FONT_SIZE.width, height: self.viewFontSizeEdit.frame.size.height)
                self.btnMakeNow.isEnabled = true
                self.btnMakeNow.alpha = 1.0
            }
            isShowEditedControl = false
        }
       
    }
    
    
    func layerElement(ele: CALayer, borderColor : UIColor, cornerRadius : CGFloat ) {
        ele.cornerRadius = cornerRadius
        ele.masksToBounds = true
    }
    var numberFontSize:CGFloat = 35
    @objc func plusFontSizeAction(sender: UIButton)  {
        numberFontSize += 1
        if checkEmoj == 0 {
            (scrollViewMain.subviews[temp1] as? ItemScrollView)?.lblBackground.font = .systemFont(ofSize: numberFontSize)
        } else {
            (scrollViewMain.subviews[numberClickScroll] as? ItemScrollView)?.lblBackground.font = .systemFont(ofSize: numberFontSize)
        }
    }

    @objc func minusFontSizeAction(sender: UIButton)  {
        numberFontSize -= 1
        if checkEmoj == 0 {
            (scrollViewMain.subviews[temp1] as? ItemScrollView)?.lblBackground.font = .systemFont(ofSize: numberFontSize)
        } else {
            (scrollViewMain.subviews[numberClickScroll] as? ItemScrollView)?.lblBackground.font = .systemFont(ofSize: numberFontSize)
        }
    }
    
    @objc func backToDefaultSet(sender: UIButton)  {
        numberFontSize = 35
        if checkEmoj == 0 {
            (scrollViewMain.subviews[temp1] as? ItemScrollView)?.lblBackground.font = .systemFont(ofSize: numberFontSize)
        } else {
            (scrollViewMain.subviews[numberClickScroll] as? ItemScrollView)?.lblBackground.font = .systemFont(ofSize: numberFontSize)
        }
    }
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
                    btnButtonNumber.backgroundColor = Constant.SELECTED_COLOR
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
        (scrollViewMain.subviews[temp1] as? ItemScrollView)?.lblBackground.text = txFShowText.text
    }
    
    // MARK: TextField Delegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
       let test = 0
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
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let position = touch.location(in: self.view)
//            print(position.x)
//            print(position.y)
//             let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
//            currentItem.lblBackground.frame.origin = CGPoint(x:position.x-60,y:position.y-50)
//        }
//    }
    
    
    // MARK: TOUCH DELEGATE
  
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
        if checkEmoj == 0 {
            arrListConten[temp1].lblBackground.text = arrListConten[temp1].lblBackground.text! + emoji
            arrListConten[temp1].lblTut.isHidden = true
        } else {
            arrListConten[numberClickScroll].lblBackground.text = arrListConten[numberClickScroll].lblBackground.text! + emoji
            arrListConten[numberClickScroll].lblTut.isHidden = true
        }

    }
}

extension ViewController:ImageCameraViewControllerDelegate {
    func imageCameraView(_ viewcontroller: ImageCameraViewController, selectImage image: UIImage) {
        if checkEmoj == 0 {
            (scrollViewMain.subviews[temp1] as? ItemScrollView)?.imagBackground.image = image
            (scrollViewMain.subviews[temp1] as? ItemScrollView)?.lblBackground.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        } else {
            (scrollViewMain.subviews[numberClickScroll] as? ItemScrollView)?.imagBackground.image = image
            (scrollViewMain.subviews[numberClickScroll] as? ItemScrollView)?.lblBackground.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        }
    }
}

extension ViewController: ColorTextViewControllerDelegate {
    func colorTextView(_ viewcontroller: ColorTextViewController, didSelect textColor: UIColor) {
        if checkEmoj == 0 {
            (scrollViewMain.subviews[temp1] as? ItemScrollView)?.lblBackground.textColor = textColor
        } else {
            (scrollViewMain.subviews[numberClickScroll] as? ItemScrollView)?.lblBackground.textColor = textColor
        }
    }
}

extension ViewController: ColorBackgroungViewControllerDelegate {
    func colorBackgroungView(_ viewcontroller: ColorBackgroungViewController, didselectBackground colorBackground: UIColor) {
        if checkEmoj == 0 {
            (scrollViewMain.subviews[temp1] as? ItemScrollView)?.imagBackground.backgroundColor = colorBackground
        } else {
            (scrollViewMain.subviews[numberClickScroll] as? ItemScrollView)?.imagBackground.backgroundColor = colorBackground
        }
    }
}

extension ViewController: TextImageViewControllerDelegate {
    func textImageView(_ viewcontroller: TextImageViewController, didSelectfont fontText: String) {
        if checkEmoj == 0 {
            (scrollViewMain.subviews[temp1] as? ItemScrollView)?.lblBackground.font = UIFont(name: fontText, size: 35)
        } else {
            (scrollViewMain.subviews[numberClickScroll] as? ItemScrollView)?.lblBackground.font = UIFont(name: fontText, size: 35)
        }
    }
}

