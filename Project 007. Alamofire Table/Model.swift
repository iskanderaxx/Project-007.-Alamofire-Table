
// MARK: - Model

struct Cards: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let name: String
    let manaCost: String?
    let cmc: Int
    let rarity: String
    let cardSet, setName: String
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case name, manaCost, cmc, rarity
        case cardSet = "set"
        case setName
        case imageURL = "imageUrl"
    }
}
