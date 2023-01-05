//
//  MukChiBaGame.swift
//  RockPaperScissors
//
//  Created by LJ, 준호.
//

import Foundation

struct MukChiBaGame {
    private var turnOwner: Participant?
    
    mutating func startGame() {
        var rockPaperScissorsGame: RockPaperScissorsGame = RockPaperScissorsGame()
        rockPaperScissorsGame.startGame()
        guard let turnOwner: Participant = rockPaperScissorsGame.winner else {
            return
        }
        self.turnOwner = turnOwner
        startMukChiBaGameRoutine()
    }
    
    mutating private func startMukChiBaGameRoutine() {
        var isTurnOwnerWin: Bool
        repeat {
            let selectedUserMenu: Int = getSelectedUserMenu()
            guard let userHand: MukChiBa = MukChiBa.init(rawValue: selectedUserMenu) else {
                return
            }
            guard let gameResult: GameResult = compareComputerHand(with: userHand) else {
                return
            }
            isTurnOwnerWin = isTurnOwnerMukChiBaGameWin(gameResult: gameResult)
            printMukChiBaGameResult(isTurnOwnerWin)
        } while isTurnOwnerWin == false
    }
    
    mutating private func getSelectedUserMenu() -> Int {
        printUserMenu()
        guard let selectedUserMenu: Int = userInput() else {
            printWrongInputMessage()
            turnOwner = .computer
            
            return getSelectedUserMenu()
        }
    
        return getCorrectUserMenu(selectedUserMenu)
    }
        
    private func printUserMenu() {
        guard let nameToPrint = turnOwner?.name else {
            return
        }
        print(String(format: Message.mukChiBaMenu.description, nameToPrint), terminator: "")
    }
    
    private func userInput() -> Int? {
        let userInput: Int? = Int(readLine() ?? "")
        
        return userInput
    }
    
    private func printWrongInputMessage() {
        print(Message.invalidInput)
    }
    
    mutating private func getCorrectUserMenu(_ selectedUserMenu: Int) -> Int {
        guard isCorrectUserMenu(selectedUserMenu) else{
            printWrongInputMessage()
            turnOwner = .computer
            
            return getSelectedUserMenu()
        }
        
        return selectedUserMenu
    }
    
    private func isCorrectUserMenu(_ userMenu: Int) -> Bool {
        switch userMenu {
        case 0...3:
            return true
        default:
            return false
        }
    }
    
    private func compareComputerHand(with userHand: MukChiBa) -> GameResult? {
        guard let computerHand: MukChiBa = getComputerHand() else {
            return nil
        }
        guard userHand != computerHand else {
            return .draw
        }
        switch (userHand, computerHand) {
        case (.muk, .ba):
            return .lose
        case (.muk, .chi):
            return .win
        case (.chi, .muk):
            return .lose
        case (.chi, .ba):
            return .win
        case (.ba, .chi):
            return .lose
        case (.ba, .muk):
            return .win
        default:
            return .draw
        }
    }
    
    private func getComputerHand() -> MukChiBa? {
        return MukChiBa.allCases.randomElement()
    }
    
    mutating private func isTurnOwnerMukChiBaGameWin(gameResult: GameResult) -> Bool {
        switch gameResult {
        case .draw:
            return true
        case .win:
            return false
        case .lose:
            toggleTurnOwner()
            
            return false
        }
    }
    
    mutating private func toggleTurnOwner() {
        if turnOwner == .user {
            turnOwner = .computer
        }
        turnOwner = .user
    }
    
    private func printMukChiBaGameResult(_ isTurnOwnerWin: Bool) {
        guard let turnOwnerName = turnOwner?.name else {
            return
        }
        switch isTurnOwnerWin {
        case true:
            print(String(format: Message.win.description, turnOwnerName))
        case false:
            print(String(format: Message.turn.description, turnOwnerName))
        }
    }
}
