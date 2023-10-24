//
//  DSAlert.swift
//  MyList
//
//  Created by Gabriel de Castro Chaves on 24/10/23.
//

import Foundation
import UIKit

final class DSAlert {
    static func show(alertTitle: AlertTitleEnum, alertMessage: AlertMessageEnum, leftButtonTitle: AlertLeftButtonTitleEnum, rightButtonTitle: AlertRightButtonTitleEnum, rightButtonAction: @escaping() -> Void)  {
        let alert = UIAlertController(
            title: alertTitle.rawValue,
            message: alertMessage.rawValue,
            preferredStyle: .alert)
        
        let leftButtonAction = UIAlertAction(
            title: leftButtonTitle.rawValue,
            style: .cancel
        )
        
        let rightButtonAction = UIAlertAction(
            title: rightButtonTitle.rawValue,
            style: .default
        ) { _ in
            rightButtonAction()
        }
    }
    
    static func showWithTextInput(alertTitle: AlertTitleEnum, alertMessage: AlertMessageEnum, leftButtonTitle: AlertLeftButtonTitleEnum, rightButtonTitle: AlertRightButtonTitleEnum, rightButtonAction: @escaping() -> Void)  {
        let alert = UIAlertController(
            title: alertTitle.rawValue,
            message: alertMessage.rawValue,
            preferredStyle: .alert)
        
        let leftButtonAction = UIAlertAction(
            title: leftButtonTitle.rawValue,
            style: .cancel
        )
        
        let rightButtonAction = UIAlertAction(
            title: rightButtonTitle.rawValue,
            style: .default
        ) { _ in
            rightButtonAction()
        }
    }
}
