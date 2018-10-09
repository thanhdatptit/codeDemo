//
//  ColorTextViewController.swift
//  ScrollViewDemo
//
//  Created by NTQ on 10/8/18.
//  Copyright © 2018 NguyenManh. All rights reserved.
//

import UIKit

class ColorTextViewController: UIViewController {
    @IBOutlet weak var colorTextCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionViewLayout = UICollectionViewFlowLayout()
        colorTextCollection.register(UINib(nibName: "TextColorCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "TextColorCollectionViewCell")
        colorTextCollection.delegate = self
        colorTextCollection.dataSource = self
        collectionViewLayout.minimumLineSpacing = 5
        collectionViewLayout.minimumInteritemSpacing = 5
    }

}

extension ColorTextViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 25
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextColorCollectionViewCell", for: indexPath) as? TextColorCollectionViewCell else { return UICollectionViewCell() }
        cell.viewBackgroundColor.backgroundColor = UIColor.random()
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

}

extension ColorTextViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //  let emoji = emojiList[indexPath.section][indexPath.item]
        //    print(emoji)
        //   delegate?.showViewController(self, didSelect: emoji)
    }

}
