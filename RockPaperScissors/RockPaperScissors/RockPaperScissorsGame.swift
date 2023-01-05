//
//  RockPaperScissorsGame.swift
//  RockPaperScissors
//
//  Created by LJ, 준호 on 2022/08/23.
//

struct RockPaperScissorsGame {
    var winner: Participant?
    
    mutating func startGame() {
        let selectedUserMenu: Int = getSelectedUserMenu()
        guard let userHand: RockPaperScissors = RockPaperScissors.init(rawValue: selectedUserMenu),
              let gameResult: GameResult = compareComputerHand(with: userHand) else {
            return
        }
        print(gameResult.result)
        
        switch gameResult {
        case .draw:
            startGame()
        case .win:
            winner = .user
        case .lose:
            winner = .computer
        }
    }
    
    private func getSelectedUserMenu() -> Int {
        printUserMenu()
        guard let selectedUserMenu: Int = userInput() else {
            print(Message.invalidInput)
            
            return getSelectedUserMenu()
        }
        if isCorrectUserMenu(selectedUserMenu) {
            return selectedUserMenu
        } else {
            print(Message.invalidInput)
            
            return getSelectedUserMenu()
        }
    }
    
    private func userInput() -> Int? {
        let userInput: Int? = Int(readLine() ?? "")
        
        return userInput
    }
    
    private func printUserMenu() {
        print(Message.rockPaperScissorsMenu, terminator: "")
    }

    private func isCorrectUserMenu(_ userMenu: Int) -> Bool {
        switch userMenu {
        case 0...3:
            return true
        default:
            return false
        }
    }
    
    private func getComputerHand() -> RockPaperScissors? {
        return RockPaperScissors.allCases.randomElement()
    }
    
    private func compareComputerHand(with userHand: RockPaperScissors) -> GameResult? {
        guard let computerHand: RockPaperScissors = getComputerHand() else {
            return nil
        }
        guard userHand != computerHand else {
            return .draw
        }
        switch (userHand, computerHand) {
        case (.rock, .scissors):
            return .win
        case (.rock, .paper):
            return .lose
        case (.paper, .scissors):
            return .lose
        case (.paper, .rock):
            return .win
        case (.scissors, .paper):
            return .win
        case (.scissors, .rock):
            return .lose
        default:
            return .draw
        }
    }
}
