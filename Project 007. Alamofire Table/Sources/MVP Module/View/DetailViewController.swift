
import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
    var card: Card?
    
    // MARK: - UI Elements & Oulets
    
    public var chosenCardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var chosenCardName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var chosenCardRarity: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewsHierarchy()
        setupLayout()
        useModelData()
    }
    
    // MARK: - Setup & Layout
    
    private func setupViewsHierarchy() {
        [chosenCardImage, chosenCardName, chosenCardRarity].forEach { view.addSubview($0) }
    }
   
    private func setupLayout() {
        chosenCardImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(450)
            make.width.equalTo(320)
        }
        chosenCardName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(chosenCardImage.snp.top).offset(-30)
        }
        
        chosenCardRarity.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(chosenCardImage.snp.bottom).offset(30)
        }
    }
    
    private func useModelData() {
        guard let card = card,
              let image = card.imageURL,
              let imageURL = URL(string: image) else {
            chosenCardImage.image = UIImage(named: "placeholder")
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.chosenCardImage.image = UIImage(named: "placeholder")
                    self.chosenCardName.text = card.name
                    self.chosenCardRarity.text = card.rarity
                }
                return
            }
            DispatchQueue.main.async {
                self.chosenCardImage.image = UIImage(data: data)
                self.chosenCardName.text = card.name
                self.chosenCardRarity.text = card.rarity
            }
        }.resume()
    }
}
