//
//  proverkaViewController.swift
//  wordcoin3
//
//  Created by admin on 08.03.2024.
//  Copyright © 2024 admin. All rights reserved.
//

import UIKit

class proverkaViewController: UIViewController {
    
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var letterInput5: UITextField!
    @IBOutlet weak var wordDisplay5: UILabel!
    @IBOutlet weak var infoLabel5: UILabel!
    @IBOutlet weak var coinDisplay5: UILabel!
    @IBOutlet weak var Fon: UIView!
    @IBOutlet weak var Fon2: UIView!
    var words = ["графт","декор","зерно","карат","лидер","магия","плант","связь","уклад","фейер","цифра","часы","щука","ярлык","герой","букет","долги","жизнь","золото","курсы","легко","молод","печка","сумка","фильтр", "эффект", "плант", "связь", "тема", "уклад","веер", "цифра", "часы", "шопинг", "унисон", "ярлык", "герой", "букет", "долги", "жизнь", "золото", "курсы", "легко", "молод", "печка", "сумка"]
    var correctWord: String!
    var guessedWord: [Character] = []
    var attemptsRemaining = 9
    @IBOutlet weak var coinButton: UIButton!
    
    @IBAction func spendCoins(_ sender: UIButton) {
        if coinCount >= 5 {
            coinCount -= 5 // Списываем 5 монеток
            updateCoinDisplay()
            
            let randomIndex = Int.random(in: 0..<correctWord.count)
            let character = correctWord[correctWord.index(correctWord.startIndex, offsetBy: randomIndex)]
            guessedWord[randomIndex] = character
            updateWordDisplay()
        } else {
        }
    }
    var coinCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: "coinCount")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "coinCount")
        }
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        coinButton.addTarget(self, action: #selector(spendCoins), for: .touchUpInside)
        coinButton.backgroundColor = .white
        coinButton.setTitleColor(.black, for: .normal)
        coinButton.layer.cornerRadius = 11
        startNewGame()
        Fon.layer.cornerRadius = Fon.frame.height / 5
        Fon2.layer.cornerRadius = Fon2.frame.height / 5
        let button = UIButton(type: .system)
        button.setTitle("Ввести", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(checkLetter), for: .touchUpInside)
        button.frame = CGRect(x: 147, y: 429, width: 80, height: 54)
        button.backgroundColor = .white
        button.layer.cornerRadius = 13
        self.view.addSubview(button)
        button3.layer.cornerRadius = 13
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(coinCount, forKey: "coinCount")
    }
    func startNewGame() {
        
        correctWord = words.randomElement()!
        guessedWord = Array(repeating: "_", count: correctWord.count)
        updateWordDisplay()
        updateCoinDisplay()
        attemptsRemaining = 9
        infoLabel5.text = "Угадайте слово! Осталось попыток: \(attemptsRemaining)"
    }
    func updateWordDisplay() {
        let wordString = String(guessedWord)
        wordDisplay5.text = wordString
    }
    func updateCoinDisplay() {
        coinDisplay5.text = "\(coinCount)"
    }
    @objc func checkLetter(){
        guard let letter = letterInput5.text?.lowercased().first else { return }
        if correctWord.contains(letter) {
            for (index, char) in correctWord.enumerated() {
                if char == letter {
                    guessedWord[index] = letter
                }
            }
            updateWordDisplay()
            if !guessedWord.contains("_") {

                coinCount += 10
                updateCoinDisplay()
                infoLabel5.text = "Поздравляем! Вы угадали слово: "
                let alert = UIAlertController(title: "Игра окончена", message: "Хотите сыграть еще?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { action in
                    self.startNewGame()
                }))
                alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: { (action) in
                    if let myViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") {
                        self.present(myViewController, animated: true, completion: nil)
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            attemptsRemaining -= 1
            infoLabel5.text = "Буквы \(letter) нет в слове. Осталось попыток: \(attemptsRemaining)"
            
            if attemptsRemaining == 0 {
                coinCount -= 5
                coinCount = max(coinCount, 0)
                updateCoinDisplay()
                let alert = UIAlertController(title: "Игра окончена", message: "Вы проиграли! Хотите сыграть еще?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { action in
                    self.startNewGame()
                }))
                alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: { (action) in
                    if let myViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") {
                        self.present(myViewController, animated: true, completion: nil)
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        letterInput5.text = ""
    }
    var backgroundImage: UIImage? {
        didSet {
            if let backgroundImage = backgroundImage {
                let scaledImage = backgroundImage.resizeImage(targetSize: CGSize(width: 375, height: 667))
                view.backgroundColor = UIColor(patternImage: scaledImage)
            }
        }
    }
}
    

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = CGSize(width: 375, height: 667)
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? UIImage()
    }
}
