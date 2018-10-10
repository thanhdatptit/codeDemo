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
        fileprivate var arrColor = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1), #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)]

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

