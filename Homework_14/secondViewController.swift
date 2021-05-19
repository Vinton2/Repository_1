import UIKit
import RealmSwift

class ToDo: Object{
    @objc dynamic var toDoList = ""
}

class secondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let list = ToDo()
    static let secondShared = secondViewController()
    private let realm = try! Realm()

    func firstTest(){
        let alertController = UIAlertController(title: "Введите задачу", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Добавить", style: .default) {(action) in
            let text = alertController.textFields?.first?.text
                try! self.realm.write {
                        let task = ToDo()
                        task.toDoList = text ?? ""
                        self.realm.add(task)
                }
                self.tableView.reloadData()
        }
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func secondTest(){
        let alertController = UIAlertController(title: "Введите номер ячейки которую вы собираетесь удалить", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Удалить", style: .default) {(action) in
            let text = alertController.textFields?.first?.text
            var b = Int(text ?? "1") ?? 1
            let i = Int(b) - 1
            let a = self.realm.objects(ToDo.self)
            let edit = a[i]
            try! self.realm.write {
                self.realm.delete(edit)
            }
            self.tableView.reloadData()
        }
        alertController.addTextField { (textField) in
            textField.keyboardType = .numberPad
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
// Добавляем задачу
    @IBAction func addToDoWork(_ sender: Any) {
        firstTest()
    }
    
    // Удаляем задачу
    @IBAction func removeToDoWork(_ sender: Any) {
        secondTest()
    }
}

extension secondViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = self.realm.objects(ToDo.self)
            return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = self.realm.objects(ToDo.self)
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! firstToDoTableViewCell
        cell.firstToDo.text = item.toDoList
        return cell
    }
}
