//
//  ViewController.swift
//  ScrollViewDemo
//
//  Created by NguyenManh on 10/7/18.
//  Copyright © 2018 NguyenManh. All rights reserved.
//

import UIKit
import SwiftMessages

class ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    var views:[UIView]!
    var viewTextFeatureControl :UIView!
    var viewFontSizeEdit: UIView!
    var viewBorderTextControl: UIView!
    var viewFontKeyboard: TextImageViewController! = nil
    var scrollMenuColor :UIScrollView!
    var arrMenuSelect = [UIButton]()
    var arrimageView = [UIImage]()
    var arrListConten = [ItemScrollView]()
    var currentFont: UIFont!
    var arrItemColor = [UIButton]()
    var currentTextLabel : UILabel!
    var currentPoint : CGPoint!
    var isCopying :Bool!
    var currentCopyingLabel: UILabel!
    fileprivate var customKeyBoardAccessView: UIView!

    fileprivate var checkEmoj = 0
    fileprivate var isDragging: Bool = false
    fileprivate var oldX: CGFloat = 0
    fileprivate var oldY: CGFloat = 0
    fileprivate var numberWidthMenuSelect = 0
    fileprivate var numberheighMenuSelect = 52
    fileprivate var isShowEditedControl: Bool!
    fileprivate var txfInput : UITextField!
    fileprivate var numberFrameXibWidth:CGFloat = 0
    fileprivate var numberFrameXibheigh:CGFloat = 0
    fileprivate let numberWidth = 38
    fileprivate let spaceSwidth = 10
    fileprivate let numberheigh = 38
    fileprivate var isCanUpdateNumberOffset:Bool = false
    fileprivate var currentItemIdx: NSInteger = 0

   
    @IBOutlet weak var btnBarAddText: UIBarButtonItem!
    @IBOutlet weak var btnbarReFresh: UIBarButtonItem!
    @IBOutlet weak var btnbarRemove: UIBarButtonItem!

    @IBOutlet weak var scrollMenuBot: UIScrollView!
    @IBOutlet weak var txFShowText: UITextField!
    @IBOutlet weak var scrollViewNumber: UIScrollView!
    @IBOutlet weak var scrollViewMain: UIScrollView!

    @IBOutlet weak var viewMenuBottom: UIView!

    @IBOutlet weak var btnMakeNow: UIButton!
    
    @IBOutlet weak var btnAddMore: UIButton!
    
    @IBOutlet weak var btnForward: UIButton!
    @IBOutlet weak var btnBackward: UIButton!
    
    @IBOutlet weak var viewTopNumberContainer: UIView!
    
    @IBAction func addTextButtonClicked(_ sender: Any) {
        
        
    }
    
    // MARK: ADD NEW TEXT
    
    func addNewText()  {
        //add first Text
        
        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
        let lblMore :UILabel = UILabel(frame: CGRect(x: currentItem.frame.width / 2 - (currentItem.frame.width - 10) / 2, y: currentItem.frame.height / 2 - 50 / 2, width: currentItem.frame.size.width - 10, height: 50))
        lblMore.text = "Tap To Edit Text!"
        lblMore.textAlignment = NSTextAlignment.center
        lblMore.font = UIFont.boldSystemFont(ofSize: 20)
        lblMore.numberOfLines = 0
        lblMore.textColor = UIColor.white
        lblMore.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblMore.backgroundColor = UIColor.clear
        currentItem.addSubview(lblMore)
        let tapGest: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTextToEdit))
        lblMore.addGestureRecognizer(tapGest)
        
        let panGesTxt: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveAround))
        lblMore.addGestureRecognizer(panGesTxt)
        lblMore.isUserInteractionEnabled = true
        
        let rotaGes :UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotationImg))
        lblMore.addGestureRecognizer(rotaGes)
    }
    
   
   
    func expecteSize()  {
//        [currentTextLabel setNumberOfLines:0];
//        [self setLineBreakMode:UILineBreakModeWordWrap];

        let maxSize = CGSize(width: currentTextLabel.frame.size.width, height: 999)
        let size : CGSize = currentTextLabel.intrinsicContentSize
//        CGSize expectedLabelSize = [[self text] sizeWithFont:[self font]
//            constrainedToSize:maximumLabelSize
//            lineBreakMode:[self lineBreakMode]];
       currentTextLabel.frame = CGRect(x: currentTextLabel.frame.origin.x, y: currentTextLabel.frame.origin.y, width: currentTextLabel.frame.width, height: size.height)
    }
    

    
    @IBAction func backWardItemClicked(_ sender: Any) {
        if currentItemIdx > 0 {
            
            currentItemIdx -= 1
            if currentItemIdx == 0{
                btnBackward.isEnabled = false
                btnForward.isEnabled = true
            }else if currentItemIdx < arrXib.count - 1 && currentItemIdx > 0 {
                btnBackward.isEnabled = true
                btnForward.isEnabled = true
            }
            
        }
        else{
            return
        }
        self.updateScrollMainOffset()
        self.updateScrollMenuOffset()
        self.changeUISelected()
    }
    
    func updateDirectionButton() {
        if arrNumbers.count <= 1 {
            btnBackward.isEnabled = false
            btnForward.isEnabled = false
        }else{
            if currentItemIdx == 0{
                btnBackward.isEnabled = false
                btnForward.isEnabled = true
            }else if currentItemIdx < arrNumbers.count - 1 && currentItemIdx > 0 {
                btnBackward.isEnabled = true
                btnForward.isEnabled = true
            }
            if currentItemIdx == arrNumbers.count - 1{
                btnForward.isEnabled = false
                btnBackward.isEnabled = true
            }else if currentItemIdx > 0 &&  currentItemIdx < arrXib.count - 1{
                btnForward.isEnabled = true
                btnBackward.isEnabled = true
            }
        }
    }
    
    @IBAction func forwardItemClicked(_ sender: Any) {
        if currentItemIdx < arrXib.count - 1 {
          
            currentItemIdx += 1
            if currentItemIdx == arrXib.count - 1{
                btnForward.isEnabled = false
                btnBackward.isEnabled = true
            }else if currentItemIdx > 0 &&  currentItemIdx < arrXib.count - 1{
                btnForward.isEnabled = true
                btnBackward.isEnabled = true
            }
        }
        else{
            return
        }
   
        self.updateScrollMainOffset()
        self.updateScrollMenuOffset()
        self.changeUISelected()
      
        
       
    }
    
    func updateScrollMainOffset() {
        let widthScroll:CGFloat =  CGFloat(currentItemIdx)  * numberFrameXibWidth
        let bottomOffset = CGPoint(x: widthScroll , y: 0)
        scrollViewMain.setContentOffset(bottomOffset, animated: true)
    }
    
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
        btnAddMore.layer.cornerRadius = 5
        btnMakeNow.layer.borderWidth = 4.0
        btnMakeNow.layer.borderColor = UIColor.white.cgColor
        scrollViewMain.layer.borderWidth = 4.0
        scrollViewMain.layer.borderColor = UIColor.white.cgColor
        btnMakeNow.clipsToBounds = true
        scrollViewMain.isScrollEnabled = false
        self.layerElement(ele: scrollViewMain.layer, borderColor: UIColor.red, cornerRadius: 15)
//        self.layerElement(ele: btnAddMore.layer, borderColor: UIColor.red, cornerRadius: 15)
//        btnAddMore.layer.borderWidth = 2.0
//        btnAddMore.layer.borderColor = UIColor.white.cgColor
        addButton12()
        addAccessoryView()
        arrMenuSelect[2].sendActions(for: .touchUpInside)
        isShowEditedControl = false
        self.navigationItem.leftItemsSupplementBackButton = true
        let done = UIBarButtonItem(image: #imageLiteral(resourceName: "addText"), style: .plain, target: self, action: #selector(addNewText(sender:)))
        navigationItem.setLeftBarButton(done, animated: false)
        self.navigationController?.navigationBar.barTintColor =  Constant.NAV_COLOR
         self.navigationController?.navigationBar.tintColor =  #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        self.view.backgroundColor = Constant.VIEW_BG_COLOR
    }

    @objc func addNewText(sender :UIBarButtonItem){
        self.addNewText()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrimageView.removeAll()
        navigationController?.isNavigationBarHidden = false
    }
    @objc func addNewItemWithOptionPosition(sender :UIBarButtonItem){
        
    }
    func addButton12() {
          let btn_H = numberheighMenuSelect - 10
        for i in 0...4 {
            numberWidthMenuSelect = Int(scrollMenuBot.frame.size.width / 5)
            let number = arrMenuSelect.count
            let originY = scrollMenuBot.frame.height / 2 - (CGFloat)(btn_H/2)
            var originX = 0

            for _ in 0..<number {
                originX +=  numberWidthMenuSelect
            }
          
            let button:UIButton = UIButton(frame: CGRect(x: originX, y:Int(originY), width: numberWidthMenuSelect, height: btn_H))
            button.backgroundColor = Constant.SELECTED_COLOR
            button.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.8196078431, blue: 0.6823529412, alpha: 1)
            button.setTitleColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), for: .normal)
            scrollMenuBot.addSubview(button)
           
            arrMenuSelect.append(button)
            scrollMenuBot.contentSize.width = CGFloat(originX + numberWidthMenuSelect)
            //scrollView.isPagingEnabled = true

            button.addTarget(self, action: #selector(clickItem12), for: .touchUpInside)
            button.tag = i
        }
//        arrMenuSelect[0].setImage(#imageLiteral(resourceName: "happy"), for: .normal)
//        arrMenuSelect[1].setImage(#imageLiteral(resourceName: "setFront13"), for: .normal)
//        arrMenuSelect[2].setImage(#imageLiteral(resourceName: "colorpalette"), for: .normal)
//        arrMenuSelect[3].setImage(#imageLiteral(resourceName: "tab_sticker"), for: .normal)
//        arrMenuSelect[3].tag = 3
//        arrMenuSelect[4].setImage(#imageLiteral(resourceName: "picture3"), for: .normal)
    }

    @objc func clickItem12(sender:UIButton) {
        for i in 0..<arrMenuSelect.count {
            if i == sender.tag {
                views[i].isHidden = false
                sender.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
                sender.setTitleColor(Constant.SELECTED_COLOR, for: .normal)
                switch i {
                case 0:
                     arrMenuSelect[i].setImage(#imageLiteral(resourceName: "tab_emoji_selected"), for: .normal)
                    break;
                case 1:
                     arrMenuSelect[i].setImage(#imageLiteral(resourceName: "tab_color_selected"), for: .normal)
                    break;
                case 2:
                    arrMenuSelect[i].setImage(#imageLiteral(resourceName: "tab_temp_selected"), for: .normal)
                    break;
                case 3:
                    arrMenuSelect[i].setImage(#imageLiteral(resourceName: "tab_sticker_selected"), for: .normal)
                    break;
                    
                case 4:
                    arrMenuSelect[i].setImage(#imageLiteral(resourceName: "tab_camera_selected"), for: .normal)
                    break;
                    
                default: break
                    
                }

            } else {
                
                views[i].isHidden = true
                arrMenuSelect[i].backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                arrMenuSelect[i].setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                switch i {
                case 0:
                    arrMenuSelect[i].setImage(#imageLiteral(resourceName: "tab_emoji"), for: .normal)
                    break;
                case 1:
                    arrMenuSelect[i].setImage(#imageLiteral(resourceName: "tab_color"), for: .normal)
                    break;
                case 2:
                     arrMenuSelect[i].setImage(#imageLiteral(resourceName: "tab_temp"), for: .normal)
                    break;
                case 3:
                    arrMenuSelect[i].setImage(#imageLiteral(resourceName: "tab_sticker"), for: .normal)
                    break;
                case 4:
                    arrMenuSelect[i].setImage(#imageLiteral(resourceName: "tab_camera"), for: .normal)
                    break;
                default: break
                    
                }
            }
            
        }
       
        self.viewMenuBottom.bringSubview(toFront: views[sender.tag])
     //   self.viewMenuBottom.bringSubview(toFront: views[sender.selectedSegmentIndex])
    }

    @objc func showFontKeyboard(){
        
        txFShowText.resignFirstResponder()
        txFShowText.inputView = nil
        if viewFontKeyboard == nil{
            viewFontKeyboard = TextImageViewController()
            viewFontKeyboard.view.frame = CGRect(x: 0, y: 0, width: viewMenuBottom.frame.width, height: viewMenuBottom.frame.height)
            viewFontKeyboard.delegate = self
        }
      
        txFShowText.inputView = viewFontKeyboard.view
        txFShowText.becomeFirstResponder()
        
    }
    
    // MARK: ADD ACCESSORY VIEW BEGIN
    
    func addAccessoryView() {

      

        numberFrameXibWidth = scrollViewMain.frame.size.width
        numberFrameXibheigh = scrollViewMain.frame.size.height
        scrollViewNumber.showsVerticalScrollIndicator = false
        scrollViewNumber.showsHorizontalScrollIndicator = false
        scrollViewMain.showsVerticalScrollIndicator = false
        scrollViewMain.showsHorizontalScrollIndicator = false
    //    scrollViewNumber.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.3)
      
        self.addNewItem()
         let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
        currentTextLabel = currentItem.lblBackground
        
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
        
        
        
        
        //Edited By Manh Nguyen
        txFShowText.isHidden = true
        customKeyBoardAccessView = UIView(frame: CGRect(x: 0, y: 0, width: Constant.VIEW_ACCSESS_KEYB_SIZE.width, height: Constant.VIEW_ACCSESS_KEYB_SIZE.height))
        
        
        let btnFont = UIButton(frame: CGRect(x: Constant.VIEW_ACCSESS_KEYB_SIZE.width - 140, y: Constant.VIEW_ACCSESS_KEYB_SIZE.height / 2 - 15, width: 140, height: 30))
        btnFont.backgroundColor = UIColor.white
        btnFont.setTitleColor(UIColor.black, for: UIControlState.normal)

        let fontName = currentTextLabel.font.fontName
        btnFont.setTitle(fontName, for: UIControlState.normal)
        btnFont.titleLabel?.font = UIFont(name: fontName, size: 14)
        btnFont.addTarget(self, action: #selector(showFontKeyboard), for: UIControlEvents.touchUpInside)
        btnFont.tag = 1
        self.layerElement(ele: btnFont.layer, borderColor: UIColor.red, cornerRadius: 10)
        
        customKeyBoardAccessView.addSubview(btnFont)
        
        
        txfInput = UITextField(frame: CGRect(x: 5, y: Constant.VIEW_ACCSESS_KEYB_SIZE.height / 2 - Constant.TEXTFILED_ACCSESS_KEYB_SIZE.height / 2, width: Constant.TEXTFILED_ACCSESS_KEYB_SIZE.width / 2, height: Constant.TEXTFILED_ACCSESS_KEYB_SIZE.height))
        txfInput.backgroundColor = UIColor.clear
        txfInput.addTarget(self, action: #selector(textInputChanged), for: UIControlEvents.editingChanged)
        
        txfInput.tag = 10;
        txfInput.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        txfInput.delegate = self
        customKeyBoardAccessView.addSubview(txfInput)
        
        //add clear button
        let btnClear = UIButton(frame: CGRect(x: txfInput.frame.origin.x + txfInput.frame.size.width + 10, y: Constant.VIEW_ACCSESS_KEYB_SIZE.height / 2 - 20, width: 40, height: 40))
        btnClear.addTarget(self, action: #selector(clearTypingText), for: UIControlEvents.touchUpInside)
        btnClear.setImage(UIImage.init(named: "clear"), for: UIControlState.normal)
        
        customKeyBoardAccessView.addSubview(btnClear)
        
        
        customKeyBoardAccessView.backgroundColor = Constant.TEXT_EDIT_BG_COLOR
        //        txFShowText.inputAccessoryView = customKeyBoardAccessView
        
        
         self.changeUISelected()
    }

    // MARK: TEXT EDIT BORDER - CONTROL
    func showTextEditBorderControl(show :Bool) {
        if show{
            //show
            if viewBorderTextControl == nil{
                let view_w = Constant.VIEW_FONT_SIZE.height + 2 * Constant.BUTTON_FONT_SIZE.width + Constant.BUTTON_FONT_SIZE_MARGIN * 4
                
                viewBorderTextControl = UIView(frame: CGRect(x: Constant.MAIN_SCREEN_SIZE.width / 2 - view_w / 2 , y: -Constant.VIEW_FONT_SIZE.width, width: view_w, height: Constant.VIEW_FONT_SIZE.width))
                
                viewBorderTextControl.backgroundColor = UIColor.white
                
               let scrollMenuBorderColor = UIScrollView(frame: CGRect(x: Constant.BUTTON_FONT_SIZE_MARGIN, y: viewBorderTextControl.frame.height / 2 - Constant.BUTTON_FONT_SIZE.height / 2, width: Constant.VIEW_FONT_SIZE.height , height: Constant.BUTTON_FONT_SIZE.width))
                
                scrollMenuBorderColor.showsHorizontalScrollIndicator = false
                scrollMenuBorderColor.showsVerticalScrollIndicator = false
                scrollMenuBorderColor.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                scrollMenuBorderColor.layer.borderColor = UIColor.white.cgColor
                scrollMenuBorderColor.layer.borderWidth = 4
                scrollMenuBorderColor.layer.cornerRadius = 10
                var arrColor = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1), #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1), #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1), #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)]
                var origX :CGFloat = Constant.BUTTON_FONT_SIZE_MARGIN
                for i in 0..<arrColor.count{
                    origX = (CGFloat)(i) * (Constant.BUTTON_FONT_SIZE.width + 0)
                    
                    let btnColor :UIButton = UIButton(frame: CGRect(x: origX, y: scrollMenuBorderColor.frame.height / 2 - Constant.BUTTON_FONT_SIZE.height / 2, width: Constant.BUTTON_FONT_SIZE.width, height: Constant.BUTTON_FONT_SIZE.height))
                    btnColor.backgroundColor = arrColor[i]
                    btnColor.addTarget(self, action: #selector(didSelectedBorderColorPicker), for: UIControlEvents.touchUpInside)
                    
                    scrollMenuBorderColor.addSubview(btnColor)
//                    scrollMenuBorderColor.append(btnColor)
                    
                }
                scrollMenuBorderColor.backgroundColor = UIColor.white
                scrollMenuBorderColor.contentSize.width = Constant.BUTTON_FONT_SIZE.width * (CGFloat)(arrColor.count )
                self.view.addSubview(viewBorderTextControl)
                viewBorderTextControl.addSubview(scrollMenuBorderColor)
                self.layerElement(ele: viewBorderTextControl.layer, borderColor: UIColor.red, cornerRadius: 5)
                
                let btnCorner :UIButton = UIButton(frame: CGRect(x: scrollMenuBorderColor.frame.size.width + Constant.BUTTON_FONT_SIZE_MARGIN * 2, y: viewBorderTextControl.frame.height / 2 - Constant.BUTTON_FONT_SIZE.height / 2, width: Constant.BUTTON_FONT_SIZE.width, height: Constant.BUTTON_FONT_SIZE.height))
                btnCorner.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
                btnCorner.tag = 103
                btnCorner.addTarget(self, action: #selector(cornerTextBorder(sender:)), for: UIControlEvents.touchUpInside)
                btnCorner.setImage(#imageLiteral(resourceName: "corner"), for: UIControlState.normal)
                self.layerElement(ele: btnCorner.layer, borderColor: UIColor.black, cornerRadius: 5)
                viewBorderTextControl.addSubview(btnCorner)
                
                let btnDone :UIButton = UIButton(frame: CGRect(x: scrollMenuBorderColor.frame.size.width + Constant.BUTTON_FONT_SIZE_MARGIN * 3 + Constant.BUTTON_FONT_SIZE.width, y: viewBorderTextControl.frame.height / 2 - Constant.BUTTON_FONT_SIZE.height / 2, width: Constant.BUTTON_FONT_SIZE.width, height: Constant.BUTTON_FONT_SIZE.height))
                
                btnDone.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                btnDone.setImage(#imageLiteral(resourceName: "done"), for: UIControlState.normal)
                btnDone.addTarget(self, action: #selector(doneBorderEditing(sender:)), for: UIControlEvents.touchUpInside)
                
                self.layerElement(ele: btnDone.layer, borderColor: UIColor.black, cornerRadius: 5)
                viewBorderTextControl.addSubview(btnDone)
                
            
                
            }
            
            for ele in viewBorderTextControl.subviews{
                if let sub = ele as? UIButton{
                    if sub.tag == 103{
                        if currentTextLabel.layer.cornerRadius > 0{
                            sub.setImage(#imageLiteral(resourceName: "unCorner"), for: UIControlState.normal)
                        }else{
                            sub.setImage(#imageLiteral(resourceName: "corner"), for: UIControlState.normal)
                        }
                    }
                }
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                  self.viewBorderTextControl.frame =  CGRect(x: Constant.MAIN_SCREEN_SIZE.width / 2 - self.viewBorderTextControl.frame.size.width / 2 , y: 0, width: self.viewBorderTextControl.frame.size.width, height: self.viewBorderTextControl.frame.size.height)
                
            }) { (true) in
                
            }
            
        }
        else{
            if viewBorderTextControl == nil{
                return
            }
            UIView.animate(withDuration: 0.3, animations: {
                self.viewBorderTextControl.frame = CGRect(x: Constant.MAIN_SCREEN_SIZE.width / 2 - self.viewBorderTextControl.frame.width / 2 , y: -Constant.VIEW_FONT_SIZE.width, width: self.viewBorderTextControl.frame.width, height: Constant.VIEW_FONT_SIZE.width)
                
            }) { (true) in
                
            }
        }
    }
    @objc func cornerTextBorder(sender: UIButton){
        if currentTextLabel.layer.cornerRadius > 0 {
           self.layerElement(ele: currentTextLabel.layer, borderColor: UIColor.red, cornerRadius: 0)
             sender.setImage(#imageLiteral(resourceName: "corner"), for: UIControlState.normal)
        }else{
           self.layerElement(ele: currentTextLabel.layer, borderColor: UIColor.red, cornerRadius: 25)
           sender.setImage(#imageLiteral(resourceName: "unCorner"), for: UIControlState.normal)
        }

    }
    @objc func doneBorderEditing(sender: UIButton){
        self.showTextEditBorderControl(show: false)
        self.showEditTextFeatureView(show: true)
    }
    @objc func didSelectedBorderColorPicker(sender: UIButton){
        currentTextLabel.backgroundColor = sender.backgroundColor
    }
    // MARK: TEXT EDIT COLOR - CONTROL
    func showMenuTextColor(show :Bool) {
        if show{
            //show
            if scrollMenuColor == nil{
                scrollMenuColor = UIScrollView(frame: CGRect(x: -viewFontSizeEdit.frame.size.width, y: viewFontSizeEdit.frame.origin.y, width: Constant.VIEW_FONT_SIZE.width, height: viewFontSizeEdit.frame.size.height))
                scrollMenuColor.showsHorizontalScrollIndicator = false
                scrollMenuColor.showsVerticalScrollIndicator = false
                scrollMenuColor.backgroundColor = UIColor.white
                scrollMenuColor.layer.borderColor =  #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
                scrollMenuColor.layer.borderWidth = 4
                scrollMenuColor.layer.cornerRadius = 10
               var arrColor = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1), #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1), #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1), #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)]
                var origY :CGFloat = 0
                for i in 0..<arrColor.count{
                    origY = (CGFloat)(i) * (Constant.BUTTON_FONT_SIZE.height + 0)
                  
                    let btnColor :UIButton = UIButton(frame: CGRect(x: viewFontSizeEdit.frame.size.width / 2 - Constant.VIEW_FONT_SIZE.width / 2, y: origY, width: Constant.VIEW_FONT_SIZE.width, height: Constant.BUTTON_FONT_SIZE.height))
                    btnColor.backgroundColor = arrColor[i]
                    btnColor.addTarget(self, action: #selector(colorSelectedChange), for: UIControlEvents.touchUpInside)
                 
                    scrollMenuColor.addSubview(btnColor)
                    arrItemColor.append(btnColor)
                    
                }
                scrollMenuColor.contentSize.height = Constant.BUTTON_FONT_SIZE.height * (CGFloat)(arrColor.count )
                self.view.addSubview(scrollMenuColor)
                
            }
        
            UIView.animate(withDuration: 0.3, animations: {
                
                self.scrollViewNumber.alpha = 0.0
                self.btnAddMore.isEnabled = false
                self.btnAddMore.alpha = 0.0
                self.scrollMenuColor.frame = CGRect(x: 5, y: self.viewFontSizeEdit.frame.origin.y, width: Constant.VIEW_FONT_SIZE.width, height: self.viewFontSizeEdit.frame.size.height)
                
            }) { (true) in
                self.scrollViewNumber.isUserInteractionEnabled = false
                self.viewTopNumberContainer.isUserInteractionEnabled = false
            }
            
        }
        else{
            if scrollMenuColor == nil{
                return
            }
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollMenuColor.frame = CGRect(x: -self.viewFontSizeEdit.frame.size.width, y: self.viewFontSizeEdit.frame.origin.y, width: Constant.VIEW_FONT_SIZE.width, height: self.viewFontSizeEdit.frame.size.height)
                    self.scrollViewNumber.alpha = 1
                    self.btnAddMore.isEnabled = true
                    self.btnAddMore.alpha = 1
                
            }) { (true) in
                self.scrollViewNumber.isUserInteractionEnabled = true
                self.viewTopNumberContainer.isUserInteractionEnabled = true
            }
        }
    }
    
    
    // MARK: TEXT EDIT COLOR - ACTION
    
    @objc func colorSelectedChange(sender:UIButton){
//        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
       currentTextLabel.textColor = sender.backgroundColor
        self.changeMenuColor(sender: sender)
    }
    
    @objc func clearTypingText(sender:UIButton){
        txfInput.text = ""
//        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
        currentTextLabel.text = ""
        txfInput.attributedPlaceholder = NSAttributedString(string: "Wirte something to add",
                                                            attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
    
    // MARK: DISSMISS KEYBOARD
    @objc func dismissKeyboard(){
//        if txFShowText.canResignFirstResponder{
//                 txFShowText.resignFirstResponder()
//        }else{
//            return
//        }
        
        view.endEditing(true)
         txFShowText.resignFirstResponder()
  
//        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
//         currentItem.lblBackground.isUserInteractionEnabled = true
//        self.changeTextAtributtedBGColor(lbl: currentItem.lblBackground, color: UIColor.clear)
////        if (currentItem.lblBackground.text?.isEmpty)! {
////              currentItem.lblTut.isHidden = false
////            
////        }
       
        self.showEditTextControl(show: false)
//        self.changeTextAtributtedBGColor(lbl: currentTextLabel, color: UIColor.clear)
        self.currentTextLabel.layer.borderWidth = 0
//        self.currentTextLabel.layer.borderColor = UIColor.black.cgColor
        btnbarReFresh.isEnabled = true
        btnbarRemove.isEnabled = true
    }
    
    
    // MARK: TEXT INPUT - ACTION CHANGE
    
    @objc func textInputChanged(textView : UITextView) {
//          let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
           currentTextLabel.text = textView.text;
   
        
        //fit label depending on text lenght
        self.currentTextLabel.layer.borderWidth = 1
        self.currentTextLabel.layer.borderColor = UIColor.black.cgColor
//        self.changeTextAtributtedBGColor(lbl:currentTextLabel, color: UIColor.red)
        let greet4Height = currentTextLabel.optimalHeight
//        let frame = CGRect(x:currentTextLabel.frame.origin.x, y: currentTextLabel.frame.origin.y, width: currentTextLabel.frame.width, height: greet4Height)
//        currentTextLabel.frame = frame
        currentTextLabel.bounds.size.height = greet4Height
            print("POINT AFTER : \(currentTextLabel.frame.origin)")
        
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
    
    // MARK: SCROLLVIEW NUMBER - ADD ITEM

    
    func addNumberItem() {
        let number = arrNumbers.count
        let originY = scrollViewNumber.frame.height / 2 - 38/2
        var originX = 5
        
        for _ in 0..<number {
            originX +=  numberWidth + spaceSwidth
        }
        
        let button:UIButton = UIButton(frame: CGRect(x: originX, y: Int(originY), width: numberWidth, height: numberheigh))
  
        button.layer.cornerRadius = 5
        scrollViewNumber.addSubview(button)
        arrNumbers.append(button)
        scrollViewNumber.contentSize.width = CGFloat(originX + numberWidth) + 5
        scrollViewNumber.isPagingEnabled = true
//        let tapGest: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedScrollViewMain))
//        scrollViewMain.addGestureRecognizer(tapGest)
    
        button.setTitle("\(number + 1)", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(clickItem), for: .touchUpInside)
        button.tag = arrNumbers.count - 1
        currentItemIdx = arrNumbers.count - 1
        self.updateDirectionButton()
    }
    
    // MARK: SCROLLVIEW MAIN - ACTION CLICKED ITEM
    
    @objc func tappedScrollViewMain(_ tap : UITapGestureRecognizer) {
        
        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
      
        btnbarRemove.isEnabled = false
        btnbarReFresh.isEnabled = false
        
        currentTextLabel = currentItem.lblBackground
        //edited by Manh
        self.showEditTextFeatureView(show: true)
        self.showEditTextControl(show: true)
        
        currentItem.lblBackground.isUserInteractionEnabled = true
//        self.changeTextAtributtedBGColor(lbl: currentItem.lblBackground, color: UIColor.red)
        self.currentTextLabel.layer.borderWidth = 1
        self.currentTextLabel.layer.borderColor = UIColor.black.cgColor
        
        if  (currentTextLabel.text?.isEmpty)!{
            txfInput.attributedPlaceholder = NSAttributedString(string: "Wirte something to add",
                                                                attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
            
        }
        else{
            txfInput.text =  currentTextLabel.text
        }
        //        txfInput.text = currentItem.lblBackground.text;
//        print("\(txfInput) as ")
       
       txFShowText.inputAccessoryView = customKeyBoardAccessView
        txFShowText.becomeFirstResponder()
        txfInput.becomeFirstResponder()
    }
   
    // MARK: TEXT EDIT FEATURE - ACTION(copy, paste, border..etc..)
    
    @objc func addMoreText(sender: UIButton){
        
   
        
        
    }
    
    @objc func tapTextToEdit(tapGes: UITapGestureRecognizer){
        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
        currentItem.bringSubview(toFront: tapGes.view!)
//        self.changeTextAtributtedBGColor(lbl: tapGes.view as! UILabel, color: UIColor.red)
        for ele in currentItem.subviews{
            if let sub = ele as? UILabel{
                if sub == tapGes.view{
//                   self.changeTextAtributtedBGColor(lbl: sub , color: UIColor.red)
                    sub.layer.borderWidth = 1
                    sub.layer.borderColor = UIColor.black.cgColor
                    
                }else{
//                    self.changeTextAtributtedBGColor(lbl: sub , color: UIColor.clear)
                      sub.layer.borderWidth = 0
                      sub.layer.borderColor = UIColor.clear.cgColor
                    
                }
              
            }
            else{
             
            }
        }
        
        currentTextLabel = tapGes.view as! UILabel
        currentFont = currentTextLabel.font
        txfInput.text = currentTextLabel.text
      
        self.showEditTextControl(show: true)
        
    }
    
    
    @objc func deleteText(sender: UIButton){
          self.dismissKeyboard()
        currentTextLabel.removeFromSuperview()
        self.showEditTextControl(show: false)
        
        
    }
    
    @objc func copyText(sender: UIButton){
        
        currentCopyingLabel = currentTextLabel
        for ele in viewTextFeatureControl.subviews{
            if let btn = ele as? UIButton{
                if btn.tag == 102{
                    btn.isEnabled = true
                }
            }
        }
     
        
    }
    @objc func pasteText(sender: UIButton){
        //paste
        //        UILabel(f)
        let lblNewText = UILabel(frame: currentCopyingLabel.frame)
        lblNewText.text = currentCopyingLabel.text
        lblNewText.textColor = currentCopyingLabel.textColor
        lblNewText.font = currentCopyingLabel.font
        lblNewText.textAlignment = NSTextAlignment.center
        lblNewText.backgroundColor = UIColor.clear
        lblNewText.bounds = currentCopyingLabel.bounds
        lblNewText.transform = currentCopyingLabel.transform
        lblNewText.numberOfLines = 0
        
        lblNewText.lineBreakMode = NSLineBreakMode.byWordWrapping
        let tapGest: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTextToEdit))
        lblNewText.addGestureRecognizer(tapGest)
        
        let panGesTxt: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveAround))
        lblNewText.addGestureRecognizer(panGesTxt)
        lblNewText.isUserInteractionEnabled = true
        
        let rotaGes :UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotationImg))
        lblNewText.addGestureRecognizer(rotaGes)
       
        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
       currentItem.addSubview(lblNewText)
        
    }
    @objc func borderText(sender: UIButton){
        if  currentTextLabel.backgroundColor == UIColor.clear {
             currentTextLabel.backgroundColor = UIColor.darkGray
             sender.setImage(#imageLiteral(resourceName: "unborder"), for: UIControlState.normal)
            self.showEditTextFeatureView(show: false)
            self.showTextEditBorderControl(show: true)
      
            
        }else{
            currentTextLabel.backgroundColor = UIColor.clear
            sender.setImage(#imageLiteral(resourceName: "border"), for: UIControlState.normal)
          
          
        }
       
    }
    @objc func rotateText(sender: UIButton){
        
        let rotation = (45 * Double.pi) / 180
        
        let previousTransform = currentTextLabel.transform
        currentTextLabel.transform = previousTransform.rotated(by: CGFloat(rotation))
        
    }
    
    
   
     // MARK: TEXT EDIT FEATURE - CONTROL(copy, paste, border..etc..)
    func showEditTextFeatureView(show:Bool) {
        
        //create guidle view
        if show {
        
            if viewTextFeatureControl == nil{
                let view_width = 5 * Constant.BUTTON_FONT_SIZE.width + 6 * Constant.BUTTON_FONT_SIZE_MARGIN
                viewTextFeatureControl  = UILabel(frame: CGRect(x: Constant.MAIN_SCREEN_SIZE.width / 2 - view_width / 2, y: -Constant.TEXT_GUIDLE_SIZE.height, width: view_width, height: Constant.VIEW_FONT_SIZE.width))
                viewTextFeatureControl.isUserInteractionEnabled = true
                viewTextFeatureControl.backgroundColor = UIColor.white
                
                viewTextFeatureControl.layer.cornerRadius = 10
                viewTextFeatureControl.layer.masksToBounds = true
                let btnAddMore :UIButton = UIButton(frame: CGRect(x: Constant.BUTTON_FONT_SIZE_MARGIN, y: viewTextFeatureControl.frame.size.height / 2 - Constant.BUTTON_FONT_SIZE.height / 2, width: Constant.BUTTON_FONT_SIZE.width, height: Constant.BUTTON_FONT_SIZE.height))
                btnAddMore.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
                btnAddMore.addTarget(self, action: #selector(rotateText(sender:)), for: UIControlEvents.touchUpInside)
                
                self.layerElement(ele: btnAddMore.layer, borderColor: UIColor.black, cornerRadius: 5)
                viewTextFeatureControl.addSubview(btnAddMore)
                
                let btnDelete :UIButton = UIButton(frame: CGRect(x: Constant.BUTTON_FONT_SIZE_MARGIN * 2 + Constant.BUTTON_FONT_SIZE.width, y: viewTextFeatureControl.frame.size.height / 2 - Constant.BUTTON_FONT_SIZE.height / 2, width: Constant.BUTTON_FONT_SIZE.width, height: Constant.BUTTON_FONT_SIZE.height))
                btnDelete.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                btnDelete.addTarget(self, action: #selector(deleteText(sender:)), for: UIControlEvents.touchUpInside)
                
                self.layerElement(ele: btnDelete.layer, borderColor: UIColor.black, cornerRadius: 5)
                viewTextFeatureControl.addSubview(btnDelete)
                
                let btnCopy :UIButton = UIButton(frame: CGRect(x: Constant.BUTTON_FONT_SIZE_MARGIN * 3 + Constant.BUTTON_FONT_SIZE.width * 2, y: viewTextFeatureControl.frame.size.height / 2 - Constant.BUTTON_FONT_SIZE.height / 2, width: Constant.BUTTON_FONT_SIZE.width, height: Constant.BUTTON_FONT_SIZE.height))
                btnCopy.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                btnCopy.addTarget(self, action: #selector(copyText(sender:)), for: UIControlEvents.touchUpInside)
                self.layerElement(ele: btnCopy.layer, borderColor: UIColor.black, cornerRadius: 5)
                viewTextFeatureControl.addSubview(btnCopy)
                
                
                let btnPaste :UIButton = UIButton(frame: CGRect(x: Constant.BUTTON_FONT_SIZE_MARGIN * 4 + 3 * Constant.BUTTON_FONT_SIZE.width, y: viewTextFeatureControl.frame.size.height / 2 - Constant.BUTTON_FONT_SIZE.height / 2, width: Constant.BUTTON_FONT_SIZE.width, height: Constant.BUTTON_FONT_SIZE.height))
                btnPaste.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                btnPaste.addTarget(self, action: #selector(pasteText(sender:)), for: UIControlEvents.touchUpInside)
                self.layerElement(ele: btnPaste.layer, borderColor: UIColor.black, cornerRadius: 5)
                viewTextFeatureControl.addSubview(btnPaste)
                btnPaste.isEnabled = false
                btnPaste.tag = 102
                let btnBorder :UIButton = UIButton(frame: CGRect(x: Constant.BUTTON_FONT_SIZE_MARGIN * 5 + 4 * Constant.BUTTON_FONT_SIZE.width, y: viewTextFeatureControl.frame.size.height / 2 - Constant.BUTTON_FONT_SIZE.height / 2, width: Constant.BUTTON_FONT_SIZE.width, height: Constant.BUTTON_FONT_SIZE.height))
                btnBorder.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                btnBorder.tag = 104
                btnBorder.addTarget(self, action: #selector(borderText(sender:)), for: UIControlEvents.touchUpInside)
                self.layerElement(ele: btnBorder.layer, borderColor: UIColor.black, cornerRadius: 5)
                viewTextFeatureControl.addSubview(btnBorder)
                
                btnDelete.setImage(#imageLiteral(resourceName: "del"), for: UIControlState.normal)
                btnCopy.setImage(#imageLiteral(resourceName: "copy"), for: UIControlState.normal)
                btnAddMore.setImage(#imageLiteral(resourceName: "rotate"), for: UIControlState.normal)
                btnPaste.setImage(#imageLiteral(resourceName: "paste"), for: UIControlState.normal)
                btnBorder.setImage(#imageLiteral(resourceName: "border"), for: UIControlState.normal)
                
                self.view.addSubview(viewTextFeatureControl)
            }
            
            for ele in viewTextFeatureControl.subviews{
                if let sub = ele as? UIButton{
                    if sub.tag == 104{
                        if currentTextLabel.backgroundColor == UIColor.clear{
                            sub.setImage(#imageLiteral(resourceName: "border"), for: UIControlState.normal)
                        }else{
                            sub.setImage(#imageLiteral(resourceName: "unborder"), for: UIControlState.normal)
                        }
                    }
                }
            }
            
           
            UIView.animate(withDuration: 0.3, animations: {
             
                self.viewTextFeatureControl.frame = CGRect(x: self.viewTextFeatureControl.frame.origin.x, y:0, width: self.viewTextFeatureControl.frame.width, height: Constant.VIEW_FONT_SIZE.width)
                
            }) { (true) in
                
            }
        }
        else {
            if viewTextFeatureControl == nil{
                return
            }
   
            UIView.animate(withDuration: 0.3, animations: {
                self.viewTextFeatureControl.frame =  CGRect(x: self.viewTextFeatureControl.frame.origin.x, y: -self.viewTextFeatureControl.frame.size.height, width: self.viewTextFeatureControl.frame.size.width, height: Constant.VIEW_FONT_SIZE.width)
                
          
                
            }) { (true) in
//                   self.viewTextFeatureControl?.removeFromSuperview()
//                   self.viewTextFeatureControl = nil
                
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

    // MARK: REFRESH ALL
    @IBAction func refreshToBegin(_ sender: Any) {
        for i in 0..<arrNumbers.count {
            arrNumbers[i].removeFromSuperview()
        }
        for i in 0..<arrXib.count {
            arrXib[i].removeFromSuperview()
        }
        arrNumbers.removeAll()
        arrXib.removeAll()
        arrListConten.removeAll()
        currentItemIdx = 0
        temp1 = 0
        numberClickScroll = 0
        addNumberItem()
        addMainViewItem()
    }

    // MARK: REMOVE ITEM
    
    @IBAction func removeGifVideo(_ sender: UIButton) {
       
        
        btnbarRemove.isEnabled = false
 
        //validate before remove
        
        // remove item on view
        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
        UIView.animate(withDuration: 0.3, animations: {
            currentItem.frame = CGRect(x: currentItem.frame.origin.x, y: currentItem.frame.origin.y, width: 0, height: 0)
        }) { (true) in
            UIView.animate(withDuration: 0.3, animations: {
                currentItem.removeFromSuperview()
                //update scrollview's content size
                self.scrollViewMain.contentSize.width = self.scrollViewMain.contentSize.width - self.numberFrameXibWidth
                var ogriX :CGFloat = 0
                for i in 0..<self.arrXib.count{
                    ogriX = (CGFloat)(i) * (self.numberFrameXibWidth)
                    let itemContent = self.self.arrXib[i]
                    itemContent.frame = CGRect(x: ogriX, y: 0, width: self.numberFrameXibWidth, height: self.numberFrameXibheigh)
                    itemContent.tag = i
                }
            }, completion: { (true) in
                self.numberIndext = Int(self.scrollViewMain.contentOffset.x) / Int(self.numberFrameXibWidth)
                self.currentItemIdx = self.numberIndext
                self.changeUISelected()
            })
            
        }
        
        let currentNumberItem : UIButton = arrNumbers[currentItemIdx]
        //remove item from array that contain items
        arrXib.remove(at: currentItemIdx)
        arrNumbers.remove(at: currentItemIdx)
        UIView.animate(withDuration: 0.3, animations: {
            currentNumberItem.frame = CGRect(x: currentNumberItem.frame.origin.x, y: currentNumberItem.frame.origin.y, width: 0, height: 0)
        }) { (true) in
            UIView.animate(withDuration: 0.3, animations: {
                currentNumberItem.removeFromSuperview()
                self.scrollViewNumber.contentSize.width = self.scrollViewNumber.contentSize.width - (CGFloat)(self.numberWidth)
                var ogriNumberX :Int = 0
                for i in 0..<self.arrNumbers.count{
                    ogriNumberX = i * (self.numberWidth + self.spaceSwidth)
                    let itemContent = self.self.arrNumbers[i]
                    itemContent.frame = CGRect(x: ogriNumberX, y: (Int)(itemContent.frame.origin.y), width: self.numberWidth, height: self.numberheigh)
                    itemContent.setTitle("\(i + 1)", for: UIControlState.normal)
                    itemContent.tag = i
                    
                }
                
            }, completion: { (true) in
                self.btnbarRemove.isEnabled = true
                self.updateDirectionButton()
                if self.arrNumbers.count == 0{
                    self.addNewItem()
                }
            })
            
        }
      
        
    }
    
 // MARK: ADD MORE BUTTON - ACTION CLICKED
    @IBAction func clickButton(_ sender: UIButton) {
        checkEmoj = 0
        self.addNewItem()
        
    }
    
    
    // MARK: ADD NEW ITEMS
    //add new item at last index
    func addNewItem() {
        
        addNumberItem()
        addMainViewItem()
        self.addNewText()
        isCanUpdateNumberOffset = false
        if self.scrollViewNumber.contentSize.width > self.scrollViewNumber.bounds.size.width {
            let bottomOffset = CGPoint(x: scrollViewNumber.contentSize.width - scrollViewNumber.bounds.size.width, y: 0)
            scrollViewNumber.setContentOffset(bottomOffset, animated: true)
        }
        print(scrollViewNumber.contentOffset.x)
        currentItemIdx = arrNumbers.count - 1
        self.changeUISelected()
    }
    
    
    // MARK: SCROLLVIEW NUMBER - ACTION CLICKED ITEM
    var numberClickScroll = 0
    @objc func clickItem(sender:UIButton) {
        checkEmoj = 1
        isCanUpdateNumberOffset = false
        print("clicked item number")
        let selectedIdx = sender.tag
        numberClickScroll =  sender.tag
        currentItemIdx = selectedIdx
      

        //Edited by Manh Nguyen
        //update scrollviewNumber contentoffset
       self.updateScrollMainOffset()
       self.updateScrollMenuOffset()
       self.changeUISelected()
       self.updateDirectionButton()
//            let bottomOffset12 = CGPoint(x: selectedIdx * numberWidth , y: 0)
//            scrollViewNumber.setContentOffset(bottomOffset12, animated: true)
    }
    
     var temp1 = 0
    
     // MARK: SCROLLVIEW MAIN - ADD ITEM
    
    func addMainViewItem() {
        
        let numberXib = arrXib.count
        var originX:CGFloat = 0
        let originY:CGFloat = 0
        
        for _ in 0..<numberXib {
            originX += numberFrameXibWidth
        }
        
        guard let customView = Bundle.main.loadNibNamed("ItemScrollView", owner: self, options: nil)?.first as? ItemScrollView else { return }
        customView.frame = CGRect(x: originX, y: originY, width: numberFrameXibWidth, height: numberFrameXibheigh)
//        let tapGes: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTextToEdit))
//        customView.lblBackground.addGestureRecognizer(tapGes)
        
        
        
        
        
        
//        customView.lblBackground.text = ""
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
    
    
    
    // MARK: TEXT EDIT FONT SIZE - CONTROL
    
    let lblSize : UILabel = UILabel(frame: CGRect(x: Constant.VIEW_FONT_SIZE.width / 2 - Constant.BUTTON_FONT_SIZE.width / 2, y: Constant.BUTTON_FONT_SIZE_MARGIN, width: Constant.BUTTON_FONT_SIZE.width, height: Constant.BUTTON_FONT_SIZE.height))
    
    func showViewFontSizeControl(show: Bool) {
        
        if show {
            if isShowEditedControl {
                let fontSize = (Int)(currentFont.pointSize)
                lblSize.text = "\(fontSize)"
                return
            }
            
            //             let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
            if viewFontSizeEdit == nil{
                
                let heightOfView = Constant.BUTTON_FONT_SIZE.height * 4 + 5 * Constant.BUTTON_FONT_SIZE_MARGIN
                viewFontSizeEdit = UIView(frame: CGRect(x: Constant.MAIN_SCREEN_SIZE.width, y: (scrollViewMain.frame.origin.y + scrollViewMain.frame.size.height / 2) - heightOfView / 2 , width: Constant.VIEW_FONT_SIZE.width, height:heightOfView))
                viewFontSizeEdit.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                lblSize.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                lblSize.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                
                
                self.layerElement(ele: lblSize.layer, borderColor: UIColor.red, cornerRadius: 7)
                
                //                lblSize.text = "\(Int(numberFontSize))"
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
        
            let fontSize = (Int)(currentFont.pointSize)
            lblSize.text = "\(fontSize)"
            UIView.animate(withDuration: 0.3) {
                self.viewFontSizeEdit.frame = CGRect(x: Constant.MAIN_SCREEN_SIZE.width - Constant.VIEW_FONT_SIZE.width - 5, y: self.viewFontSizeEdit.frame.origin.y, width: Constant.VIEW_FONT_SIZE.width, height: self.viewFontSizeEdit.frame.size.height)
                self.btnMakeNow.isEnabled = false
                self.btnMakeNow.alpha = 0.0
                
            }
        }else{
            if self.viewFontSizeEdit == nil {
                return
            }
            UIView.animate(withDuration: 0.3) {
                self.viewFontSizeEdit.frame = CGRect(x: Constant.MAIN_SCREEN_SIZE.width, y: self.viewFontSizeEdit.frame.origin.y, width: Constant.VIEW_FONT_SIZE.width, height: self.viewFontSizeEdit.frame.size.height)
                self.btnMakeNow.isEnabled = true
                self.btnMakeNow.alpha = 1.0
            }
        }
        
    }
    
       // MARK: SHOW TEXT EDIT CONTROL
    func showEditTextControl(show: Bool){
        
        if show {
            if isShowEditedControl {
                let fontSize = (Int)(currentFont.pointSize)
                lblSize.text = "\(fontSize)"
                return
            }
           
//             let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
           
            self.showKeyBoard()
            self.showViewFontSizeControl(show: true)
            self.showMenuTextColor(show: true)
            self.showEditTextFeatureView(show: true)
            
        
//            let fontSize = (Int)(currentFont.pointSize)
//            lblSize.text = "\(fontSize)"
            
//            UIView.animate(withDuration: 0.3) {
//                self.viewFontSizeEdit.frame = CGRect(x: Constant.MAIN_SCREEN_SIZE.width - Constant.VIEW_FONT_SIZE.width - 5, y: self.viewFontSizeEdit.frame.origin.y, width: Constant.VIEW_FONT_SIZE.width, height: self.viewFontSizeEdit.frame.size.height)
//                self.btnMakeNow.isEnabled = false
//                self.btnMakeNow.alpha = 0.0
//
//            }
            isShowEditedControl = true
        }
        else{
//            if self.viewFontSizeEdit == nil {
//                return
//            }
//            UIView.animate(withDuration: 0.3) {
//                self.viewFontSizeEdit.frame = CGRect(x: Constant.MAIN_SCREEN_SIZE.width, y: self.viewFontSizeEdit.frame.origin.y, width: Constant.VIEW_FONT_SIZE.width, height: self.viewFontSizeEdit.frame.size.height)
//                self.btnMakeNow.isEnabled = true
//                self.btnMakeNow.alpha = 1.0
//            }
            isShowEditedControl = false
            self.showViewFontSizeControl(show: false)
            self.showMenuTextColor(show: false)
            self.showEditTextFeatureView(show: false)
            self.showTextEditBorderControl(show: false)
//            self.dismissKeyboard()
            
        }
       
    }
    
    
    func showKeyBoard() {
        
        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
       
        btnbarRemove.isEnabled = false
        btnbarReFresh.isEnabled = false
       // currentItem.lblBackground.isUserInteractionEnabled = true
      //  self.changeTextAtributtedBGColor(lbl: currentItem.lblBackground, color: UIColor.red)
    
        if  (currentTextLabel.text?.isEmpty)!{
            txfInput.attributedPlaceholder = NSAttributedString(string: "Wirte something to add",
                                                                attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
            
        }
        else{
            txfInput.text =  currentTextLabel.text
        }
        //        txfInput.text = currentItem.lblBackground.text;
        //        print("\(txfInput) as ")
        
        txFShowText.inputAccessoryView = customKeyBoardAccessView
//        txFShowText.becomeFirstResponder()
 
//        txt.resignFirstResponder()
//
        txFShowText.inputView = nil
        
       
        
          txFShowText.becomeFirstResponder()
          txfInput.becomeFirstResponder()
    }
    
    
    
    func layerElement(ele: CALayer, borderColor : UIColor, cornerRadius : CGFloat ) {
        ele.cornerRadius = cornerRadius
        ele.masksToBounds = true
    }
    var numberFontSize:CGFloat = 35
    
    // MARK: TEXT EDIT FONT SIZE - ACTION
    
    @objc func plusFontSizeAction(sender: UIButton)  {
         let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
//        if checkEmoj == 0 {
//            numberFontSize += 1
//            let fontText = currentItem.lblBackground.font
//            currentItem.lblBackground.font = UIFont(name: (fontText?.fontName)!, size: numberFontSize)
//
//
//        } else {
//            numberFontSize += 1
////            (scrollViewMain.subviews[numberClickScroll] as? ItemScrollView)?.lblBackground.font = .systemFont(ofSize: numberFontSize)
//
//        }
        let fSize = currentFont.pointSize + 1
        let fontText = currentFont.fontName
        currentFont = UIFont(name: fontText, size: fSize)
        currentTextLabel.font = UIFont(name: fontText, size: fSize)
         lblSize.text = "\(Int(fSize))"
    }

    @objc func minusFontSizeAction(sender: UIButton)  {
//        if checkEmoj == 0 {
//            numberFontSize -=  1
//            (scrollViewMain.subviews[temp1] as? ItemScrollView)?.lblBackground.font = .systemFont(ofSize: numberFontSize)
//            lblSize.text = "\(Int(numberFontSize))"
//        } else {
//            numberFontSize -= 1
//            (scrollViewMain.subviews[numberClickScroll] as? ItemScrollView)?.lblBackground.font = .systemFont(ofSize: numberFontSize)
//            lblSize.text = "\(Int(numberFontSize))"
//        }
         let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
        let fSize = currentFont.pointSize - 1
        let fontText = currentFont.fontName
        currentFont = UIFont(name: fontText, size: fSize)
        currentTextLabel.font = UIFont(name: fontText, size: fSize)
        lblSize.text = "\(Int(fSize))"
    }
    
    @objc func backToDefaultSet(sender: UIButton)  {
        numberFontSize = 35
        lblSize.text = "35"
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
           self.updateOffsetScrollNumberAfterScrolling()
           self.changeUISelected()
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
//            if checkEmoj == 0 {
//                lblSize.text = "\(Int(((scrollViewMain.subviews[temp1] as? ItemScrollView)?.lblBackground.font.pointSize)!))"
//                numberFontSize = ((scrollViewMain.subviews[temp1] as? ItemScrollView)?.lblBackground.font.pointSize)!
//            } else {
//                lblSize.text = "\(Int(((scrollViewMain.subviews[numberClickScroll] as? ItemScrollView)?.lblBackground.font.pointSize)!))"
//                numberFontSize = ((scrollViewMain.subviews[numberClickScroll] as? ItemScrollView)?.lblBackground.font.pointSize)!
//            }

//        if textField.tag == 10{
//            let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
            if  (currentTextLabel.text?.isEmpty)!{
                txfInput.attributedPlaceholder = NSAttributedString(string: "Wirte something to add",
                                                                       attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
                
            }
            else{
                 textField.text =  currentTextLabel.text
            }
          
//            self.view.endEditing(true)
//            textField.becomeFirstResponder()
//            return true
//        }
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
    
    
    // MARK: UPDATE SCROLL NUMBER OFFSET
    func updateScrollMenuOffset() {
        let distanceX = scrollViewNumber.contentSize.width - scrollViewNumber.bounds.size.width
        if distanceX > 0{
            //                var widthScroll:CGFloat =  CGFloat(numberIndext  * numberWidth )
            //                if widthScroll < 0 {
            //                    widthScroll = -4
            //                }else if widthScroll >= distanceX{
            //                    widthScroll = distanceX
            //                }
            //
            //                let bottomOffset = CGPoint(x: widthScroll , y: 0)
            //                scrollViewNumber.setContentOffset(bottomOffset, animated: true)
            //
            //
            
            let selectedItem: UIButton = arrNumbers[currentItemIdx]
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
            
        }else{
            
        }
    }
    
    
    func updateOffsetScrollNumberAfterScrolling() {
        let distanceX = scrollViewNumber.contentSize.width - scrollViewNumber.bounds.size.width
        if distanceX > 0{
            
            var widthScroll:CGFloat =  CGFloat( currentItemIdx  * numberWidth)
            if currentItemIdx < 5 {
                  widthScroll = 0
            }else if currentItemIdx > arrNumbers.count - 5{
                  widthScroll = distanceX
            }
            if widthScroll < 0 {
                widthScroll = 0
            }else if widthScroll >= distanceX{
                widthScroll = distanceX
            }

            let bottomOffset = CGPoint(x: widthScroll , y: 0)
            scrollViewNumber.setContentOffset(bottomOffset, animated: true)

            //
    }
}
    
    // MARK: CHANGE SELECTED COLOR
    func changeMenuColor(sender:UIButton) {
//        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
//        currentFont = currentItem.lblBackground.font
//         let btnButtonNumber:UIButton = arrNumbers[currentItemIdx]
        sender.layer.borderWidth = 3
        sender.layer.borderColor = UIColor.white.cgColor
     
      
       
        for but in arrItemColor {
            if but != sender{
                but.layer.borderWidth = 0
                but.layer.borderColor = UIColor.clear.cgColor
           
            }
        }
    }
    
    // MARK: CHANGE UI WHEN SELECTED
    func changeUISelected() {
        //get current font
        if arrXib.count == 0 {
            return
        }
         let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
         currentFont = currentItem.lblBackground.font
        
        let btnButtonNumber:UIButton = arrNumbers[currentItemIdx]
        for but in arrNumbers {
            if but != btnButtonNumber {
                but.backgroundColor = Constant.UN_SELECTED_COLOR
                but.setTitleColor(UIColor.white, for: UIControlState.normal)
                but.transform = CGAffineTransform(scaleX: 1, y: 1)
                but.layer.borderColor = UIColor.clear.cgColor
                but.layer.borderWidth = 0.0

            } else {
                btnButtonNumber.backgroundColor = Constant.SELECTED_COLOR
                btnButtonNumber.setTitleColor(UIColor.white, for: UIControlState.normal)
                UIView.animate(withDuration: 0.3, animations: {
                   btnButtonNumber.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//                    btnButtonNumber.layer.borderColor = UIColor.white.cgColor
//                    btnButtonNumber.layer.borderWidth = 4

                }) { (true) in
                    
                }
            }
        }
    }
    
    @objc func  rotationImg(rotaGes :UIRotationGestureRecognizer){
        
       
        if let ele = rotaGes.view as? UILabel{
            let rotation = rotaGes.rotation
            
            let previousTransform = ele.transform
            ele.transform = previousTransform.rotated(by: rotation)
            currentPoint = currentTextLabel.frame.origin
            print("POINT : \(currentPoint)")
        }else{
          let imageView = rotaGes.view as! UIView
            let rotation = rotaGes.rotation
            
            let previousTransform = imageView.transform
            imageView.transform = previousTransform.rotated(by: rotation)
           
        }
        rotaGes.rotation = 0
    }
    
    var lastScale :CGFloat = 0
    @objc func zoomImg(pinGes :UIPinchGestureRecognizer){
        
        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
        
//        if pinGes.state == UIGestureRecognizerState.began {
//            lastScale = 1.0;
//            pinGes.location(in: pinGes.view)
//        }
//
//        // Scale
//        let scale :CGFloat = 1.0 - (lastScale - pinGes.scale)
        pinGes.view?.transform = (pinGes.view?.transform)!.scaledBy(x: pinGes.scale, y: pinGes.scale)
        pinGes.scale = 1.0
//        lastScale = pinGes.scale
//        CGFloat scale = 1.0 - (lastScale - sender.scale);
//        [self.layer setAffineTransform:CGAffineTransformScale([self.layer affineTransform],
//scale,
//            scale)];
//        lastScale = sender.scale;
//
//        // Translate
//        CGPoint point = [sender locationInView:self];
//        [self.layer setAffineTransform:
//            CGAffineTransformTranslate([self.layer affineTransform],
//            point.x - lastPoint.x,
//            point.y - lastPoint.y)];
//        lastPoint = [sender locationInView:self];
    
    }
    @objc func  deleteImgSticker(sender: UIButton){
        UIView.animate(withDuration: 0.3, animations: {
            sender.superview?.alpha = 0
        }) { (true) in
               sender.superview?.removeFromSuperview()
        }
     
    }
    @objc func  doneEditImage(sender: UIButton){
      
        
        for ele in (sender.superview?.subviews)!{
            if ele.tag == 100{
                ele.isHidden = false
                ele.layer.borderWidth = 0
               
            }
            else{
                UIView.animate(withDuration: 0.3, animations: {
                  ele.alpha = 0
                }) { (true) in
                  ele.isHidden = true
                }
              
            }
        }
    }
    
    @objc func tapToShowStickerEdit(tapGes: UITapGestureRecognizer){
       
        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
        currentItem.bringSubview(toFront: tapGes.view!)
        for ele in (tapGes.view?.subviews)!{
            ele.alpha = 1
            ele.isHidden = false
        }
    }
    
    @objc func moveAround(panGes : UIPanGestureRecognizer)  {
        
     
          let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
        if panGes.state == UIGestureRecognizerState.changed{
            var centerP = panGes.view?.center
            let trans = panGes.translation(in: currentItem)
            centerP = CGPoint(x: (centerP?.x)! + trans.x  , y: (centerP?.y)! + trans.y )
            let pointExp = CGPoint(x: (centerP?.x)! + currentItem.frame.origin.x, y: (centerP?.y)!)

            if currentItem.frame.contains(pointExp){
                panGes.view?.center = centerP!
                panGes.setTranslation(CGPoint.zero, in: currentItem)
            }
        }
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

extension ViewController:EmojViewControllerDelegate {
    
    func emojView(_ viewcontroller: EmojViewController, didSelect emoji: String) {
        if checkEmoj == 0 {
            arrListConten[temp1].lblBackground.text = arrListConten[temp1].lblBackground.text! + emoji
        
        } else {
            arrListConten[numberClickScroll].lblBackground.text = arrListConten[numberClickScroll].lblBackground.text! + emoji

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

// MARK : ADD STICKER IMAGE

extension ViewController: ColorTextViewControllerDelegate {
    func colorTextView(_ viewcontroller: ColorTextViewController, didSelect textColor: UIColor) {
//        if checkEmoj == 0 {
//            (scrollViewMain.subviews[temp1] as? ItemScrollView)?.lblBackground.textColor = textColor
//        } else {
//            (scrollViewMain.subviews[numberClickScroll] as? ItemScrollView)?.lblBackground.textColor = textColor
//        }
        
        let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
        let viewImgSticker :UIView = UIView(frame: CGRect(x: 0, y: 0, width: Constant.VIEW_IMG_STICKER_SIZE.width, height: Constant.VIEW_IMG_STICKER_SIZE.height))
        viewImgSticker.backgroundColor = UIColor.clear
        
        let imgSticker :UIImageView = UIImageView(frame: CGRect(x:0, y: Constant.BUTTON_FONT_SIZE.height, width: Constant.VIEW_IMG_STICKER_SIZE.width , height: Constant.VIEW_IMG_STICKER_SIZE.height - Constant.BUTTON_FONT_SIZE.height))
        let tapGes :UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToShowStickerEdit))
        viewImgSticker.addGestureRecognizer(tapGes)
        imgSticker.image = UIImage(named: "sticker")
        let rotaGes :UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotationImg))
        viewImgSticker.addGestureRecognizer(rotaGes)
        let pinGes :UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(zoomImg))
//        imgSticker.layer.borderColor = UIColor.black.cgColor
//        imgSticker.layer.borderWidth = 1.0
        let btnDelete :UIButton = UIButton(frame: CGRect(x: 10, y: 0, width: Constant.BUTTON_FONT_SIZE.width, height: Constant.BUTTON_FONT_SIZE.height))
        let btnOk :UIButton = UIButton(frame: CGRect(x: Constant.VIEW_IMG_STICKER_SIZE.width - Constant.BUTTON_FONT_SIZE.width - 10, y: 0, width: Constant.BUTTON_FONT_SIZE.width, height: Constant.BUTTON_FONT_SIZE.height))
        btnDelete.backgroundColor =  #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        btnOk.backgroundColor =  #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        btnOk.setTitle("Ok", for: UIControlState.normal)
        btnOk.addTarget(self, action: #selector(doneEditImage), for: UIControlEvents.touchUpInside)
        viewImgSticker.addSubview(btnOk)
    
         btnDelete.setTitle("X", for: UIControlState.normal)
        btnDelete.layer.cornerRadius = Constant.BUTTON_FONT_SIZE.width / 2
        btnDelete.layer.borderWidth = 2
        btnDelete.layer.borderColor = UIColor.white.cgColor
        btnOk.layer.borderWidth = 2
        btnOk.layer.borderColor = UIColor.white.cgColor
        btnOk.layer.cornerRadius = Constant.BUTTON_FONT_SIZE.width / 2
        
        btnDelete.addTarget(self, action: #selector(deleteImgSticker), for: UIControlEvents.touchUpInside)
        
        viewImgSticker.addSubview(btnDelete)
        viewImgSticker.addSubview(btnOk)
        imgSticker.tag = 100
        viewImgSticker.addGestureRecognizer(pinGes)
        let panGest : UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveAround))
        imgSticker.isUserInteractionEnabled = true
        viewImgSticker.addGestureRecognizer(panGest)
        imgSticker.contentMode = UIViewContentMode.scaleAspectFit
        viewImgSticker.addSubview(imgSticker)
        currentItem.addSubview(viewImgSticker)
        currentItem.bringSubview(toFront: imgSticker)
    }
}

//extension moveAround(panGes : UIPanGestureRecognizer)  {
//
//    //        if panGes.state == UIGestureRecognizerState.changed{
//    //            var centerP = panGes.view?.center
//    //            let trans = panGes.translation(in: self.)
//    //            centerP = CGPoint(x: (centerP?.x)! + trans.x  , y: (centerP?.y)! + trans.y )
//    //            let pointExp = CGPoint(x: (centerP?.x)! + self.frame.origin.x, y: (centerP?.y)!)
//    //
//    //            if self.frame.contains(pointExp){
//    //                panGes.view?.center = centerP!
//    //                panGes.setTranslation(CGPoint.zero, in: self)
//    //            }
//    //        }
//}

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
//        if checkEmoj == 0 {
//            (scrollViewMain.subviews[temp1] as? ItemScrollView)?.lblBackground.font = UIFont(name: fontText, size: 35)
//        } else {
//            (scrollViewMain.subviews[numberClickScroll] as? ItemScrollView)?.lblBackground.font = UIFont(name: fontText, size: 35)
//        }
//       let currentItem: ItemScrollView = arrXib[currentItemIdx] as! ItemScrollView
        let fSize = currentFont.pointSize
//        let fontText = currentFont.fontName
        currentFont = UIFont(name: fontText, size: fSize)
        currentTextLabel.font = UIFont(name: fontText, size: fSize)
        lblSize.text = "\(Int(fSize))"
        //update button font
        for sub in customKeyBoardAccessView.subviews{
            if let btn = sub as? UIButton {
                if btn.tag == 1{
                btn.setTitle(fontText, for: UIControlState.normal)
                btn.titleLabel?.font = UIFont(name: fontText, size: 14)
                }
            }
            else{
                
            }
        }
    }
}

