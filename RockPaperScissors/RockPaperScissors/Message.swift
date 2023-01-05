//
//  Message.swift
//  RockPaperScissors
//
//  Created by junho lee on 2023/01/05.
//

enum Message: CustomStringConvertible {
    case invalidInput
    case rockPaperScissorsMenu
    case mukChiBaMenu
    case win
    case turn

    var description: String {
        switch self {
        case .invalidInput:
            return "잘못된 입력입니다. 다시 시도해주세요."
        case .rockPaperScissorsMenu:
            return "가위(1), 바위(2), 보(3)! <종료 : 0> : "
        case .mukChiBaMenu:
            return "[%@ 턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> : "
        case .win:
            return "%@의 승리!"
        case .turn:
            return "%@의 턴입니다."
        }
    }
}
