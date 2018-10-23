//
//  Constant.swift
//  ScrollViewDemo
//
//  Created by NguyenManh on 10/10/18.
//  Copyright © 2018 NguyenManh. All rights reserved.
//

import UIKit

class Constant {
    

  static let VIEW_ACCSESS_KEYB_SIZE =                    CGSize(width: MAIN_SCREEN_SIZE.width - 10, height: 44.0)
  static let TEXTFILED_ACCSESS_KEYB_SIZE =               CGSize(width: VIEW_ACCSESS_KEYB_SIZE.width - 50, height: 30.0)
  static let MAIN_SCREEN_SIZE     =                      UIScreen.main.bounds
  static let SELECTED_COLOR     =                        #colorLiteral(red: 0.3176470588, green: 0.3882352941, blue: 0.3960784314, alpha: 1)
  static let UN_SELECTED_COLOR     =                      #colorLiteral(red: 0.4980392157, green: 0.6156862745, blue: 0.6156862745, alpha: 1)
  static let NAV_COLOR     =                             #colorLiteral(red: 0.9333333333, green: 0.4196078431, blue: 0.3803921569, alpha: 0)
  static let VIEW_BG_COLOR     =                         #colorLiteral(red: 0.937254902, green: 0.9490196078, blue: 0.8666666667, alpha: 1)
  static let TEXT_EDIT_BG_COLOR     =                    #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
  static let TEXT_GUIDLE_SIZE     =                      CGSize(width:250, height: 40.0)
  static let VIEW_FONT_SIZE     =                       CGSize(width:53, height: 180.0)
  static let BUTTON_FONT_SIZE     =                       CGSize(width:45, height: 45.0)
    static let BUTTON_FONT_SIZE_MARGIN: CGFloat =                  4.0
  static let IMG_STICKER_SIZE     =                       CGSize(width:45, height: 45.0)
  static let VIEW_IMG_STICKER_SIZE     =                  CGSize(width:140, height: 140.0)
}
