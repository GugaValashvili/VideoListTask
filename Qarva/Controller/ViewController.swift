import UIKit

class Section {
    let title: String
    let options: [String]
    var isOpened = false

    init(title: String, options: [String], isOpend: Bool = false) {
        self.title = title
        self.options = options
        self.isOpened = isOpend
    }
}

class ViewController: UITableViewController  {
   
    
    
    // MARK: - Properties
    
    let reuseIdentifier = "VideoCell"
//    let nestedCellIdentifier = "NestedCell"
//    let collectionViewNib = MyCollectionViewCell.nib()
    let nestedCellIdentifier = "NestedTableViewCellWithCollection"
    
    @IBOutlet var collectionView: UICollectionView!
    var models = [Model]()
    
    var root: [Root]? {
        didSet {
            DispatchQueue.main.async {
                self.sections = self.root?.map { root in
                    Section(title: root.name, options: root.videos.map { $0.title }, isOpend: false)
                } ?? []
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Lifecycle
    
    private var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        let videoManager = VideoManager()
        videoManager.fetchVideos { videos in
            self.root = videos.root
        }
    }
    
    // MARK: - Helpers
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.register(NestedTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
//        tableView.register(NestedTableViewCell.self, forCellReuseIdentifier: nestedCellIdentifier)
        tableView.register(MyCollectionViewCell.nib(), forCellReuseIdentifier: MyCollectionViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.dataSource = self
    }
    // MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier , for: indexPath) as! MyCollectionViewCell
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].isOpened ? 2 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NestedTableViewCell
            cell?.configure(with: sections[indexPath.section].title)
            return cell ?? .init()
        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: nestedCellIdentifier, for: indexPath) as! NestedTableViewCell
//            let option = sections[indexPath.section].options[indexPath.row - 1]
//            cell.configure(with: option, imageName: "") // Adjust as needed
//            cell.contentView.backgroundColor = .lightGray
//            cell.indentationLevel = 1
//            
//            return cell
            
            let cell = tableView.dequeueReusableCell(withIdentifier: NestedTableViewCellWithCollection.identifier, for: indexPath) as! NestedTableViewCellWithCollection
                        let options = sections[indexPath.section].options.map { Model(text: $0, imageName: "") }
            
                        cell.configure(with: options)
//                        cell.contentView.backgroundColor = .lightGray
                        return cell
        }
    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        
//        if indexPath.row == 0 {
//            sections[indexPath.section].isOpened.toggle()
//            
//            var indexPaths = [IndexPath]()
//            for row in 1...sections[indexPath.section].options.count {
//                indexPaths.append(IndexPath(row: row, section: indexPath.section))
//            }
//            
//            if sections[indexPath.section].isOpened {
//                tableView.insertRows(at: indexPaths, with: .fade)
//            } else {
//                tableView.deleteRows(at: indexPaths, with: .fade)
//            }
//        } else {
//            print("Tapped sub cell")
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            sections[indexPath.section].isOpened.toggle()
            let indexPaths = [IndexPath(row: 1, section: indexPath.section)]
//            for row in 1...sections[indexPath.section].options.count {
//                indexPaths.append(IndexPath(row: row, section: indexPath.section))
//            }
            if sections[indexPath.section].isOpened {
                tableView.insertRows(at: indexPaths, with: .fade)
            } else {
                tableView.deleteRows(at: indexPaths, with: .fade)
            }
        } else {
            print("Tapped sub cell")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 220.0
        }
        return 44.0
    }
}

struct Model {
    let text: String
    let imageName: String
    
    init(text: String, imageName: String) {
        self.text = text
        self.imageName = imageName
    }
}
