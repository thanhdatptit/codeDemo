//
//  HomeViewController.swift
//  ScrollViewDemo
//
//  Created by NTQ on 10/12/18.
//  Copyright © 2018 NguyenManh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var constrainLeft: NSLayoutConstraint!
    @IBOutlet weak var btnSquare: UIButton!
    @IBOutlet weak var btnPortrait: UIButton!
    @IBOutlet weak var constrainSquare: NSLayoutConstraint!
    @IBOutlet weak var constrainPortrait: NSLayoutConstraint!
    @IBOutlet weak var btnLandScape: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        animationHome()
        cusTomView()
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.constrainLeft.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.constrainSquare.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.constrainPortrait.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    @IBAction func naviSquare(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }


}
// MARK: - CustomView
extension HomeViewController {
    func cusTomView(){
        btnSquare.layer.cornerRadius = 5
        btnPortrait.layer.cornerRadius = 5
        btnLandScape.layer.cornerRadius = 5
    }
    func animationHome() {
        constrainLeft.constant -= view.bounds.width
        constrainSquare.constant -= view.bounds.width
        constrainPortrait.constant -= view.bounds.width
    }
}

