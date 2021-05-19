import UIKit
import CoreData

class thirdViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items:[ToDoList]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTask()
    }
    
    // Добавляем задачу
    @IBAction func addToDoWork(_ sender: Any) {
        firstTest()
    }

    // Удаляем задачу
    @IBAction func removeToDoWork(_ sender: Any) {
        secondTest()
    }
    
    
    func fetchTask(){
        do{
            self.items = try context.fetch(ToDoList.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch{
            
        }
    }
    
    func firstTest(){
        let alertController = UIAlertController(title: "Введите задачу", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Добавить", style: .default) {(action) in
            let text = alertController.textFields?.first?.text
            let newTask = ToDoList(context: self.context)
            newTask.toDoTask = text
            do{
                try self.context.save()
            }catch{
                
            }
            self.fetchTask()
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
            let taskToRemove = self.items![i]
            self.context.delete(taskToRemove)
            do{
                try self.context.save()
            }catch{
                
            }
            self.fetchTask()
        }
        alertController.addTextField { (textField) in
            textField.keyboardType = .numberPad
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }

}


extension thirdViewController: UITableViewDataSource{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items?.count ?? 0
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! firstToDoTableViewCell
    let task = self.items![indexPath.row]
    
    cell.firstToDo.text = task.toDoTask
    
    return cell
}
}
