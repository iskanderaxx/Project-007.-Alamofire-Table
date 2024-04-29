
import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: - UI Elements & Oulets
    
    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var role: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 25)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()

    
    var character: Character? {
        didSet {
            role.text = character?.role
            name.text = character?.name
            
            guard let imagePath = character?.imageURL,
                  let imageURL = URL(string: imagePath),
                  let imageData = try? Data(contentsOf: imageURL)
            else {
                characterImage.image = UIImage(named: "square-image")
                return
            }
            characterImage.image = UIImage(data: imageData)
        }
    }
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(characterImage)
        addSubview(name)
        addSubview(role)
    }
    
    private func setupLayout() {
        characterImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        name.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        role.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(name).offset(30)
        }
    }
    
    func configure(with character: Character) {
            name.text = character.name
            role.text = character.role
            
            guard let imageURL = URL(string: character.imageURL) else {
                characterImage.image = UIImage(named: "square-image")
                return
            }
            
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        self.characterImage.image = UIImage(data: imageData)
                    }
                }
            }
        }
}
