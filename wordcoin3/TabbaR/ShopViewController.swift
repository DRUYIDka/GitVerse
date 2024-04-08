import UIKit

class ShopViewController: UIViewController {
    
    @IBOutlet var buyButtons: [UIButton]!
    @IBOutlet var imagesAboveButtons: [UIImageView]!
    @IBOutlet weak var coinsLabel: UILabel!
    var coinCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: "coinCount")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "coinCount")
        }
    }
    let imageCosts = [3, 5, 8, 9, 3, 3, 3, 4, 5, 0, 2, 1, 3, 3, 8, 6] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCoinsLabel()
        for imagesAboveButtons in imagesAboveButtons {
            imagesAboveButtons.layer.cornerRadius = 10
            imagesAboveButtons.layer.masksToBounds = true
        }
    }

    
    @IBAction func buyImage(_ sender: UIButton) {
        if let index = buyButtons.firstIndex(of: sender) {
            let cost = imageCosts[index]
            if coinCount >= cost {
                coinCount -= cost
                updateCoinsLabel()

                let imageToBuy = imagesAboveButtons[index].image
                saveImage(image: imageToBuy, imageName: "image\(index + 1).png")
            } else {
                
            }
        }
        
    }
    
    func updateCoinsLabel() {
        coinsLabel.text = "\(coinCount)"
    }
    
    func saveImage(image: UIImage?, imageName: String) {
        guard let image = image, let data = image.pngData() else {
            return
        }
        
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imageName)
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("Ошибка сохранения изображения: \(error)")
        }
    }
}



class SavedImagesViewController: UIViewController {
    
    @IBOutlet var savedImageViews: [UIImageView]!
    @IBOutlet var setBackgroundButton: [UIButton]!
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for imageView in savedImageViews {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGesture)
            
            imageView.layer.cornerRadius = 10
            imageView.layer.masksToBounds = true
        }
        
        for (index, imageView) in savedImageViews.enumerated() {
            if let savedImage = loadImageFromDisk(imageName: "image\(index + 1).png") {
                imageView.image = savedImage
            }
        }
    }
    
    func loadImageFromDisk(imageName: String) -> UIImage? {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imageName)
        
        if let imageData = try? Data(contentsOf: fileURL) {
            return UIImage(data: imageData)
        }
        
        return nil
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView {
            selectedImage = imageView.image
        }
    }
    
    @IBAction func setBackgroundButtonTapped(_ sender: UIButton) {
        guard let selectedImage = selectedImage else {
            return
        }
UserDefaults.standard.set(selectedImage.pngData(), forKey: "SelectedImage\(index)")
        if let otherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "proverkaViewController") as? proverkaViewController {
            otherViewController.backgroundImage = selectedImage
            self.present(otherViewController, animated: true, completion: nil)
        }
    }
}
