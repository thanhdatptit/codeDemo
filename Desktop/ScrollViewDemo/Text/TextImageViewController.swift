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

    let gradePickerValues = ["Arial","Academy Engraved LET","American Typewriter","AppleColorEmoji","Arial Rounded MT Bold","AvenirNextCondensed-Italic","Arial Rounded","Avenir-Black","Avenir-Roman","Avenir-Light","Baskerville-SemiBoldItalic","BodoniOrnamentsITCTT" ,"BodoniSvtyTwoOSITCTT-Bold","Baskerville-Bold","Baskerville","Bodoni 72 Smallcaps","Bradley Hand","Chalkduster","Copperplate-Light","Cochin-Italic","Cochin-BoldItalic","Copperplate","Copperplate-Bold","Damascus", "Didot-Italic" ,"Didot-Bold","Didot", "EuphemiaUCAS-Italic", "EuphemiaUCAS","Futura-Medium", "Futura-MediumItalic","Futura-Bold", "Farah", "GurmukhiMN-Bold","GurmukhiMN","Helvetica Neue", "HelveticaNeue-Light", "HelveticaNeue-Italic","HelveticaNeue-UltraLightItalic","Kailasa-Bold","Kailasa","Noteworthy-Light","Noteworthy-Bold","MarkerFelt-Wide","Menlo-Bold","Farah","Papyrus","Papyrus-Condensed","PartyLetPlain","Palatino-Italic","LaoSangamMN","SnellRoundhand-Bold", "SnellRoundhand","SnellRoundhand-Black","ZapfDingbatsITC","SavoyeLetPlain","Zapfino","Thonburi","TimesNewRomanPSMT","GeezaPro"]

    weak var delegate:TextImageViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tbVTextItem.delegate = self
        tbVTextItem.dataSource = self
        tbVTextItem.reloadData()
    }
}

extension TextImageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gradePickerValues.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
     return 1
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
        let cell :UITableViewCell = tableView.cellForRow(at: indexPath)!
//        cell.accessoryType = UITableViewCellAccessoryType.checkmark
        let frontText = gradePickerValues[indexPath.row]
        print(frontText)
        delegate?.textImageView(self, didSelectfont: frontText)
    }
}




