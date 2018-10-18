//
//  TextImageViewController.swift
//  ScrollViewDemo
//
//  Created by NTQ on 10/8/18.
//  Copyright © 2018 NguyenManh. All rights reserved.
//

import UIKit

protocol TextImageViewControllerDelegate:class {
    func textImageView (_ viewcontroller:TextImageViewController, didSelectfont fontText: String)
}

class TextImageViewController: UIViewController {

    @IBOutlet weak var tbVTextItem: UITableView!

    let gradePickerValues = ["Arial","AvenirNextCondensed-Italic","Arial Rounded","Avenir-Black","Avenir-Roman","Avenir-Light", "AcademyEngravedLetPlain","Baskerville-SemiBoldItalic","BodoniOrnamentsITCTT" ,"BodoniSvtyTwoOSITCTT-Bold","Baskerville-Bold","Baskerville","Copperplate-Light","Copperplate","Copperplate-Bold","Damascus", "Didot-Italic" ,"Didot-Bold","Didot", "EuphemiaUCAS-Italic", "EuphemiaUCAS","Futura-Medium", "Futura-MediumItalic","Futura-Bold", "Farah", "GurmukhiMN-Bold","GurmukhiMN","Helvetica Neue", "HelveticaNeue-Light", "HelveticaNeue-Italic","Kailasa-Bold","Kailasa","Noteworthy-Light","Noteworthy-Bold","Farah","Papyrus","Papyrus-Condensed","PartyLetPlain","Palatino-Italic","LaoSangamMN","SnellRoundhand-Bold", "SnellRoundhand","SnellRoundhand-Black","ZapfDingbatsITC","SavoyeLetPlain","Zapfino"]
    weak var delegate:TextImageViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tbVTextItem.delegate = self
        tbVTextItem.dataSource = self
    }
}

extension TextImageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gradePickerValues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = Bundle.main.loadNibNamed("CellTextItemTableViewCell", owner: self, options: nil)?.first as? CellTextItemTableViewCell else { return UITableViewCell() }
        cell.lblShowNameText.font = UIFont(name: gradePickerValues[indexPath.row], size: 25)
        cell.lblShowNameText.text = gradePickerValues[indexPath.row]
        return cell
    }
}
extension TextImageViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let frontText = gradePickerValues[indexPath.row]
        print(frontText)
        delegate?.textImageView(self, didSelectfont: frontText)
    }
}




