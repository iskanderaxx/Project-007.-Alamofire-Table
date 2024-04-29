
import Foundation
import Alamofire

// MARK: - Protocols

protocol CardsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfRows() -> Int
    func configure(cell: TableViewCell, forRow row: Int)
    func didSelectRow(at indexPath: IndexPath)
}

// MARK: - Presenter

class CardsPresenter: CardsPresenterProtocol {
    
    weak var view: (CardsViewProtocol)?
    private var cards: [Card] = []
    
    init(view: CardsViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        fetchCards()
    }
    
    private func fetchCards() {
        let request = AF.request("https://api.magicthegathering.io/v1/cards")
        request.responseDecodable(of: Cards.self) { (data) in
            guard let versionOne = data.value else { return }
            let cards = versionOne.cards
            self.cards = cards
            
            self.view?.reloadData()
        }
    }
    
    func numberOfRows() -> Int {
        return cards.count
    }
    
    func configure(cell: TableViewCell, forRow row: Int) {
        let card = cards[row]
        cell.card = card
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let card = cards[indexPath.row]
        view?.showCardDetail(card)
    }
}
