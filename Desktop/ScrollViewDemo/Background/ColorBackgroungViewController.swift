//
//  ColorBackgroungViewController.swift
//  ScrollViewDemo
//
//  Created by NTQ on 10/8/18.
//  Copyright © 2018 NguyenManh. All rights reserved.
//

import UIKit

protocol ColorBackgroungViewControllerDelegate:class {
    func colorBackgroungView (_ viewcontroller: ColorBackgroungViewController, didselectBackground colorBackground: UIColor)
}

class ColorBackgroungViewController: UIViewController {
    @IBOutlet weak var colorBackgroundCollection: UICollectionView!
    fileprivate var arrColor = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1), #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1), #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6196078431, alpha: 1), #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1), #colorLiteral(red: 0.3803921569, green: 0.3803921569, blue: 0.3803921569, alpha: 1),#colorLiteral(red: 0.2156862745, green: 0.2784313725, blue: 0.3098039216, alpha: 1),#colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1), #colorLiteral(red: 0.8431372549, green: 0.8, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0.737254902, green: 0.6666666667, blue: 0.6431372549, alpha: 1), #colorLiteral(red: 0.631372549, green: 0.5333333333, blue: 0.4980392157, alpha: 1), #colorLiteral(red: 0.4745098039, green: 0.3333333333, blue: 0.2823529412, alpha: 1), #colorLiteral(red: 0.3647058824, green: 0.2509803922, blue: 0.2156862745, alpha: 1),#colorLiteral(red: 0.2431372549, green: 0.1529411765, blue: 0.137254902, alpha: 1), #colorLiteral(red: 0.9843137255, green: 0.9137254902, blue: 0.9058823529, alpha: 1), #colorLiteral(red: 1, green: 0.8, blue: 0.737254902, alpha: 1), #colorLiteral(red: 1, green: 0.6196078431, blue: 0.5019607843, alpha: 1), #colorLiteral(red: 1, green: 0.431372549, blue: 0.2509803922, alpha: 1), #colorLiteral(red: 1, green: 0.2392156863, blue: 0, alpha: 1), #colorLiteral(red: 0.8666666667, green: 0.1725490196, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 0.9921568627, blue: 0.9058823529, alpha: 1), #colorLiteral(red: 1, green: 0.9764705882, blue: 0.768627451, alpha: 1), #colorLiteral(red: 1, green: 0.9450980392, blue: 0.462745098, alpha: 1), #colorLiteral(red: 0.9607843137, green: 0.4980392157, blue: 0.09019607843, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 0.5529411765, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 0.9176470588, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 0.8392156863, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.8784313725, blue: 0.6980392157, alpha: 1), #colorLiteral(red: 1, green: 0.7176470588, blue: 0.3019607843, alpha: 1), #colorLiteral(red: 1, green: 0.568627451, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.4274509804, blue: 0, alpha: 1), #colorLiteral(red: 0.9098039216, green: 0.9607843137, blue: 0.9137254902, alpha: 1), #colorLiteral(red: 0.6470588235, green: 0.8392156863, blue: 0.6549019608, alpha: 1), #colorLiteral(red: 0.4, green: 0.7333333333, blue: 0.4156862745, alpha: 1), #colorLiteral(red: 0.262745098, green: 0.6274509804, blue: 0.2784313725, alpha: 1),#colorLiteral(red: 0.1803921569, green: 0.4901960784, blue: 0.1960784314, alpha: 1), #colorLiteral(red: 0.1058823529, green: 0.368627451, blue: 0.1254901961, alpha: 1), #colorLiteral(red: 0.7254901961, green: 0.9647058824, blue: 0.7921568627, alpha: 1), #colorLiteral(red: 0, green: 0.9019607843, blue: 0.462745098, alpha: 1), #colorLiteral(red: 0, green: 0.7843137255, blue: 0.3254901961, alpha: 1), #colorLiteral(red: 0.9764705882, green: 0.9843137255, blue: 0.9058823529, alpha: 1), #colorLiteral(red: 0.9019607843, green: 0.9333333333, blue: 0.6117647059, alpha: 1), #colorLiteral(red: 0.831372549, green: 0.8823529412, blue: 0.3411764706, alpha: 1),#colorLiteral(red: 0.7529411765, green: 0.7921568627, blue: 0.2, alpha: 1),#colorLiteral(red: 0.6196078431, green: 0.6156862745, blue: 0.1411764706, alpha: 1),#colorLiteral(red: 0.5098039216, green: 0.4666666667, blue: 0.09019607843, alpha: 1), #colorLiteral(red: 0.9568627451, green: 1, blue: 0.5058823529, alpha: 1), #colorLiteral(red: 0.7764705882, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.9176470588, blue: 0, alpha: 1), #colorLiteral(red: 0.9098039216, green: 0.9607843137, blue: 0.9137254902, alpha: 1), #colorLiteral(red: 0.6470588235, green: 0.8392156863, blue: 0.6549019608, alpha: 1), #colorLiteral(red: 0.4, green: 0.7333333333, blue: 0.4156862745, alpha: 1), #colorLiteral(red: 0.1058823529, green: 0.368627451, blue: 0.1254901961, alpha: 1),#colorLiteral(red: 0.7254901961, green: 0.9647058824, blue: 0.7921568627, alpha: 1), #colorLiteral(red: 0.4117647059, green: 0.9411764706, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0, green: 0.9019607843, blue: 0.462745098, alpha: 1), #colorLiteral(red: 0, green: 0.7843137255, blue: 0.3254901961, alpha: 1), #colorLiteral(red: 0.9764705882, green: 0.9843137255, blue: 0.9058823529, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.9568627451, blue: 0.7647058824, alpha: 1),#colorLiteral(red: 0.862745098, green: 0.9058823529, blue: 0.4588235294, alpha: 1), #colorLiteral(red: 0.8039215686, green: 0.862745098, blue: 0.2235294118, alpha: 1), #colorLiteral(red: 0.6862745098, green: 0.7058823529, blue: 0.168627451, alpha: 1), #colorLiteral(red: 0.5098039216, green: 0.4666666667, blue: 0.09019607843, alpha: 1), #colorLiteral(red: 0.9568627451, green: 1, blue: 0.5058823529, alpha: 1), #colorLiteral(red: 0.7764705882, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.9176470588, blue: 0, alpha: 1), #colorLiteral(red: 0.8823529412, green: 0.9607843137, blue: 0.9960784314, alpha: 1), #colorLiteral(red: 0.5058823529, green: 0.831372549, blue: 0.9803921569, alpha: 1),#colorLiteral(red: 0.01176470588, green: 0.6078431373, blue: 0.8980392157, alpha: 1), #colorLiteral(red: 0.003921568627, green: 0.3411764706, blue: 0.6078431373, alpha: 1), #colorLiteral(red: 0.5019607843, green: 0.8470588235, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0.568627451, blue: 0.9176470588, alpha: 1), #colorLiteral(red: 0.8784313725, green: 0.9490196078, blue: 0.9450980392, alpha: 1), #colorLiteral(red: 0.3019607843, green: 0.7137254902, blue: 0.6745098039, alpha: 1), #colorLiteral(red: 0, green: 0.537254902, blue: 0.4823529412, alpha: 1), #colorLiteral(red: 0, green: 0.3019607843, blue: 0.2509803922, alpha: 1), #colorLiteral(red: 0.6549019608, green: 1, blue: 0.9215686275, alpha: 1), #colorLiteral(red: 0.1137254902, green: 0.9137254902, blue: 0.7137254902, alpha: 1), #colorLiteral(red: 0, green: 0.7490196078, blue: 0.6470588235, alpha: 1), #colorLiteral(red: 0.9294117647, green: 0.9058823529, blue: 0.9647058824, alpha: 1), #colorLiteral(red: 0.7019607843, green: 0.6156862745, blue: 0.8588235294, alpha: 1), #colorLiteral(red: 0.1921568627, green: 0.1058823529, blue: 0.5725490196, alpha: 1), #colorLiteral(red: 0.7019607843, green: 0.5333333333, blue: 1, alpha: 1), #colorLiteral(red: 0.4862745098, green: 0.3019607843, blue: 1, alpha: 1), #colorLiteral(red: 0.3843137255, green: 0, blue: 0.9176470588, alpha: 1),#colorLiteral(red: 0.8901960784, green: 0.9490196078, blue: 0.9921568627, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.7921568627, blue: 0.9764705882, alpha: 1), #colorLiteral(red: 0.08235294118, green: 0.3960784314, blue: 0.7529411765, alpha: 1), #colorLiteral(red: 0.2666666667, green: 0.5411764706, blue: 1, alpha: 1), #colorLiteral(red: 0.1607843137, green: 0.3843137255, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.9215686275, blue: 0.9333333333, alpha: 1),#colorLiteral(red: 0.937254902, green: 0.6039215686, blue: 0.6039215686, alpha: 1), #colorLiteral(red: 1, green: 0.5411764706, blue: 0.5019607843, alpha: 1), #colorLiteral(red: 1, green: 0.3215686275, blue: 0.3215686275, alpha: 1),#colorLiteral(red: 1, green: 0.09019607843, blue: 0.2666666667, alpha: 1), #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.9725490196, green: 0.7333333333, blue: 0.8156862745, alpha: 1), #colorLiteral(red: 0.5333333333, green: 0.05490196078, blue: 0.3098039216, alpha: 1), #colorLiteral(red: 0.9529411765, green: 0.8980392157, blue: 0.9607843137, alpha: 1),#colorLiteral(red: 0.2901960784, green: 0.07843137255, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9176470588, green: 0.5019607843, blue: 0.9882352941, alpha: 1), #colorLiteral(red: 0.8784313725, green: 0.2509803922, blue: 0.9843137255, alpha: 1), #colorLiteral(red: 0.6666666667, green: 0, blue: 1, alpha: 1)]


   weak var delegate: ColorBackgroungViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
         let collectionViewLayout = UICollectionViewFlowLayout()
        colorBackgroundCollection.register(UINib(nibName: "CellColorBackgroundCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CellColorBackgroundCollectionViewCell")
        colorBackgroundCollection.delegate = self
        colorBackgroundCollection.dataSource = self
    }

}

extension ColorBackgroungViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return arrColor.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellColorBackgroundCollectionViewCell", for: indexPath) as? CellColorBackgroundCollectionViewCell else { return UICollectionViewCell() }
       cell.viewColorBackground.backgroundColor = arrColor[indexPath.row]
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


}

extension ColorBackgroungViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = arrColor[indexPath.row]
        delegate?.colorBackgroungView(self, didselectBackground: color)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

}

