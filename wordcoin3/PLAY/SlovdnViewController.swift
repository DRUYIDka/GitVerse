import UIKit

class SlovdnViewController: UIViewController {
    
    @IBOutlet weak var letterInput: UITextField!
    @IBOutlet weak var displayWord: UILabel!
    @IBOutlet weak var coinDisplay: UILabel!
    @IBOutlet weak var attemptsDisplay: UILabel!
    @IBOutlet weak var Fon: UIView!
    @IBOutlet weak var Fon2: UIView!
    var words = ["автомобиль", "космос", "библиотека", "магнит", "пальма", "компьютер", "оранжерея", "слон", "журналист", "октябрь", "философия", "шоколад", "реакция", "энциклопедия", "кинотеатр", "революция", "лазер", "карандаш", "парус", "метрополитен"]
    var correctWord: String!
    var guessedWord: [Character] = []
    var guessedPositions: [Int] = []
    var coinCount = UserDefaults.standard.integer(forKey: "coinCount")
    var attempts = 33
    var lastGuessedDate: Date?
    var guessedToday = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLastGuessedDate()
        startNewGame()
        Fon.layer.cornerRadius = Fon.frame.height / 5
        Fon2.layer.cornerRadius = Fon2.frame.height / 5
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    func checkLastGuessedDate() {
        let currentDate = Date()
        
        if let lastGuessedDate = UserDefaults.standard.object(forKey: "lastGuessedDate") as? Date {
            if Calendar.current.isDateInToday(lastGuessedDate) {
                guessedToday = true
            } else {
                guessedToday = false
            }
        } else {
            guessedToday = false
        }
    }
    
    func startNewGame() {
        if guessedToday {
            let alert = UIAlertController(title: "Сегодня уже угадывали слово", message: "Приходите завтра!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        attempts = 9
        correctWord = words.randomElement()!
        guessedWord = Array(repeating: "_", count: correctWord.count)
        guessedPositions.removeAll()
        displayWord.text = String(guessedWord)
        coinDisplay.text = " \(coinCount)"
        attemptsDisplay.text = "Попыток осталось: \(attempts)"
    }
    func highlightGuessedLetters() {
        let attributedString = NSMutableAttributedString(string: "")
        
        for (index, char) in correctWord.enumerated() {
            if guessedPositions.contains(index) {
                let range = NSRange(location: index, length: 1)
                attributedString.append(NSAttributedString(string: String(char), attributes: [NSAttributedString.Key.foregroundColor: UIColor.green]))
            } else {
                attributedString.append(NSAttributedString(string: "_", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]))
            }
        }
        
        displayWord.attributedText = attributedString
    }

    @IBAction func checkLetter(_ sender: Any) {
        if guessedToday {
            let alert = UIAlertController(title: "Вы уже угадали слово сегодня", message: "Попробуйте завтра!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        if attempts > 0 {
            guard let letter = letterInput.text?.lowercased().first else { return }
            
            var letterGuessed = false
            
            var correctlyGuessed = false
            
            for (index, char) in correctWord.enumerated() {
                if char == letter {
                    guessedWord[index] = letter
                    guessedPositions.append(index)
                    letterGuessed = true
                    correctlyGuessed = true
                }
            }
            
            if correctlyGuessed {
                let displayString = guessedWord.map { String($0) }.joined(separator: " ")
                displayWord.text = displayString
                highlightGuessedLetters()
            } else {
                attempts -= 1
                attemptsDisplay.text = "Попыток осталось: \(attempts)"
            }
            
            if guessedWord == Array(correctWord) {
                coinCount += 20
                coinDisplay.text = " \(coinCount)"
                guessedToday = true
                lastGuessedDate = Date()
                UserDefaults.standard.set(coinCount, forKey: "coinCount")
                UserDefaults.standard.set(lastGuessedDate, forKey: "lastGuessedDate")
                let alert = UIAlertController(title: "Вы угадали слово", message: "Загаданное слово: \(correctWord). Получено 20 монет. Попробуйте завтра!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } else if attempts == 0 {
                let alert = UIAlertController(title: "Исчерпан лимит попыток", message: "Попробуйте завтра!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                guessedToday = true
                lastGuessedDate = Date()
                UserDefaults.standard.set(lastGuessedDate, forKey: "lastGuessedDate")
            }
        }
}
}
