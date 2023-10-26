//
//  DSAlert.swift
//  MyList
//
//  Created by Gabriel de Castro Chaves on 24/10/23.
//

import Foundation
import UIKit

final class DSAlert {
    static func show(controller: UIViewController,
                     alertTitle: AlertTitleEnum,
                     alertMessage: AlertMessageEnum,
                     leftButtonTitle: AlertLeftButtonTitleEnum,
                     rightButtonTitle: AlertRightButtonTitleEnum,
                     rightButtonAction: @escaping() -> Void) {
        let alert = UIAlertController(
            title: alertTitle.rawValue,
            message: alertMessage.rawValue,
            preferredStyle: .alert
        )
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
        alert.addAction(leftButtonAction)
        alert.addAction(rightButtonAction)
        controller.present(alert, animated: true)
    }
    
    static func showWithTextField(controller: UIViewController ,
                                  textFieldPlaceholder: AlertTextFieldPlaceholder,
                                  alertTitle: AlertTitleEnum,
                                  alertMessage: AlertMessageEnum,
                                  leftButtonTitle: AlertLeftButtonTitleEnum,
                                  rightButtonTitle: AlertRightButtonTitleEnum,
                                  rightButtonAction: @escaping(String) -> Void) {
        let alert = UIAlertController(
            title: alertTitle.rawValue,
            message: alertMessage.rawValue,
            preferredStyle: .alert
        )
        alert.addTextField { textField in
            textField.placeholder = textFieldPlaceholder.rawValue
        }
        let leftButtonAction = UIAlertAction(
            title: leftButtonTitle.rawValue,
            style: .cancel
        )
        let rightButtonAction = UIAlertAction(
            title: rightButtonTitle.rawValue,
            style: .default
        ) { _ in
            let inputedText = alert.textFields![0] as UITextField
            rightButtonAction(inputedText.text ?? "")
        }
        alert.addAction(leftButtonAction)
        alert.addAction(rightButtonAction)
        controller.present(alert, animated: true)
    }
}
