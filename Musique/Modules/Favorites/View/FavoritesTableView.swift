import UIKit

import UIKit

class FavoritesTableView: UITableView {
    
    var cellsTableView = [FavoriteSong]()
    var selectedIndexPath: IndexPath?
    weak var dbDelegate: FavoriteDeleteFromDB?
    
    init() {
        super.init(frame: .zero, style: .plain)
        backgroundColor = .mDarkBlue
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        super.register(SearchCategoryTableViewCell.self, forCellReuseIdentifier: SearchCategoryTableViewCell.reuseID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTableView(cells: [FavoriteSong]) {
        self.cellsTableView = cells
        reloadData()
    }
}

extension FavoritesTableView: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCategoryTableViewCell.reuseID, for: indexPath) as! SearchCategoryTableViewCell
        
        let track = cellsTableView[indexPath.row]
        guard let trackName = track.trackName, let artistName = track.artistName else {
            return cell
        }
        cell.configureCell(title: trackName,
                           subtitle: artistName,
                           imageUrlString: track.artworkUrl100)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    //MARK: - Header
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
//        headerView.backgroundColor = .mBlack
//        
//        let headerLabel = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.width - 20, height: headerView.frame.height))
//        headerLabel.text = "Header Title"
//        headerLabel.font = UIFont.systemFont(ofSize: 18)
//        headerView.addSubview(headerLabel)
//        
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

extension FavoritesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedIndexPath = selectedIndexPath, selectedIndexPath == indexPath {
            // Ячейка уже выбрана, нет необходимости повторно выделять её
            return
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? SearchCategoryTableViewCell {
            cell.cellView.backgroundColor = UIColor.systemGray6// Выбранный цвет фона ячейки
        }
        if let selectedIndexPath = selectedIndexPath, let selectedCell = tableView.cellForRow(at: selectedIndexPath) as? SearchCategoryTableViewCell {
            selectedCell.cellView.backgroundColor = .mDarkBlue // Сброс цвета предыдущей выбранной ячейки
        }
        selectedIndexPath = indexPath
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           print("Deleted")
           cellsTableView.remove(at: indexPath.row)
            dbDelegate?.getIndexPathToDelete(indexPath: indexPath)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
