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
        fileprivate var arrColor = [#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1),#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),#colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1), #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]

   weak var delegate: ColorBackgroungViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
         let collectionViewLayout = UICollectionViewFlowLayout()
        colorBackgroundCollection.register(UINib(nibName: "CellColorBackgroundCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CellColorBackgroundCollectionViewCell")
        colorBackgroundCollection.delegate = self
        colorBackgroundCollection.dataSource = self
        collectionViewLayout.minimumLineSpacing = 5
        collectionViewLayout.minimumInteritemSpacing = 5
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

extension ColorBackgroungViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = arrColor[indexPath.row]
        delegate?.colorBackgroungView(self, didselectBackground: color)
    }
}

