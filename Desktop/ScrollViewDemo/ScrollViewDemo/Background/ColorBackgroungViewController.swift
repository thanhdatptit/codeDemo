//
//  ColorBackgroungViewController.swift
//  ScrollViewDemo
//
//  Created by NTQ on 10/8/18.
//  Copyright © 2018 NguyenManh. All rights reserved.
//

import UIKit

class ColorBackgroungViewController: UIViewController {
    @IBOutlet weak var colorBackgroundCollection: UICollectionView!

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

        return 25
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellColorBackgroundCollectionViewCell", for: indexPath) as? CellColorBackgroundCollectionViewCell else { return UICollectionViewCell() }
       cell.viewColorBackground.backgroundColor = UIColor.random()
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

}

extension ColorBackgroungViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      //  let emoji = emojiList[indexPath.section][indexPath.item]
    //    print(emoji)
        //   delegate?.showViewController(self, didSelect: emoji)
    }

}

