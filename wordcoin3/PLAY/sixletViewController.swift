import UIKit

class sixletViewController: UIViewController {
    
    @IBOutlet weak var letterInput5: UITextField!
    @IBOutlet weak var wordDisplay5: UILabel!
    @IBOutlet weak var infoLabel5: UILabel!
    @IBOutlet weak var coinDisplay5: UILabel!
    @IBOutlet weak var Fon: UIView!
    @IBOutlet weak var Fon2: UIView!
    var words = ["цунами", "аромат", "внучка", "гипноз", "дикарь", "допрос", "елочка", "жалоба", "железо", "запечь", "кольцо", "курсив", "лесина", "мостик", "огурец", "регион", "резюме", "сейчас", "ураган", "футбол", "худший", "цитата"]
    var correctWord: String!
    var guessedWord: [Character] = []
    var attemptsRemaining = 9
    var coinCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: "coinCount")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "coinCount")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
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
}


