import UIKit

class StatisticsViewController: UIViewController {
    let items: [ListItem]

    init(items: [ListItem]) {
        self.items = items
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        displayStatistics()
    }

    func displayStatistics() {
        let itemCount = UILabel()
        itemCount.textColor = .black
        itemCount.text = "Number of Items: \(items.count)"
        itemCount.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 20)
        view.addSubview(itemCount)

        let characterCounts = items
            .flatMap { $0.title + $0.subtitle }
            .reduce(into: [:]) { counts, character in
                counts[character, default: 0] += 1
            }

        let topCharacters = characterCounts.filter { $0.key != " " }.sorted { $0.value > $1.value }.prefix(3)

        var yOffset = 140
        for (character, count) in topCharacters {
            let label = UILabel()
            label.text = "\(character) = \(count)"
            label.frame = CGRect(x: 20, y: yOffset, width: Int(view.frame.width) - 40, height: 20)
            label.textColor = .black
            view.addSubview(label)
            yOffset += 30
        }
    }
}
