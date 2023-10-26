//
//  DSAlertEnum.swift
//  MyList
//
//  Created by Gabriel de Castro Chaves on 24/10/23.
//

import Foundation


enum AlertTitleEnum: String {
    case attention = "Atenção"
}

enum AlertMessageEnum: String {
    case deleteItemMessage = "Você realmente deseja deletar este item?"
}

enum AlertLeftButtonTitleEnum: String {
    case ok = "Ok"
    case delete = "Deletar"
    case cancel = "Cancelar"
}

enum AlertRightButtonTitleEnum: String {
    case ok = "Ok"
    case delete = "Deletar"
    case cancel = "Cancelar"
}

enum AlertTextFieldPlaceholder: String {
    case addItem = "Escreva o item que deseja adicionar"
}
