//
//  EmojViewController.swift
//  ScrollViewDemo
//
//  Created by NTQ on 10/8/18.
//  Copyright © 2018 NguyenManh. All rights reserved.
//

import UIKit

protocol EmojViewControllerDelegate: class {
    
    func emojViewController(_ viewcontroller: EmojViewController, didSelect emoji: String)
}

class EmojViewController: UIViewController {
    @IBOutlet weak var eMojCollection: UICollectionView!
    
    weak var delegate: EmojViewControllerDelegate? = nil

    var emojiList: [[String]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        eMojCollection.allowsMultipleSelection = true
         let collectionViewLayout = UICollectionViewFlowLayout()
        fetchEmojis()
        eMojCollection.register(UINib(nibName: "CellEmojCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CellEmojCollectionViewCell")
        eMojCollection.delegate = self
        eMojCollection.dataSource = self
        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.minimumInteritemSpacing = 10
    }

    func fetchEmojis(){
        let emojiRanges = [
            0x1F601...0x1F635
            //                        0x2702...0x27B0,
            //                        0x1F680...0x1F6C0,
            //                        0x1F170...0x1F251
        ]

        for range in emojiRanges {
            var array: [String] = []
            for i in range {
                if let unicodeScalar = UnicodeScalar(i){
                    array.append(String(describing: unicodeScalar))
                }
            }
            emojiList.append(array)
        }
    }

}

extension EmojViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

         return emojiList[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellEmojCollectionViewCell", for: indexPath) as? CellEmojCollectionViewCell else { return UICollectionViewCell() }
        cell.imagEmoj.image = emojiList[indexPath.section][indexPath.item].image()

        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return emojiList.count
    }

}

extension EmojViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let emoji = emojiList[indexPath.section][indexPath.item]
        print(emoji)
        delegate?.emojViewController(self, didSelect: emoji)
    }
}

extension String {
    func image() -> UIImage? {
        let size = CGSize(width: 80, height: 80)
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        UIColor.clear.set()

        let stringBounds = (self as NSString).size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 75)])
        let originX = (size.width - stringBounds.width)/2
        let originY = (size.height - stringBounds.height)/2
        //  print(stringBounds)
        let rect = CGRect(origin: CGPoint(x: originX, y: originY), size: size)
        UIRectFill(rect)

        (self as NSString).draw(in: rect, withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 75)])

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
