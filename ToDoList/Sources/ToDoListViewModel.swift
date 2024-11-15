import SwiftUI

final class ToDoListViewModel: ObservableObject {
    // MARK: - Private properties

    private let repository: ToDoListRepositoryType
    
    // MARK: - Init

    init(repository: ToDoListRepositoryType) {
        self.repository = repository
        self.toDoItems = repository.loadToDoItems()
        print(self.toDoItems.count)
    }

    // MARK: - Outputs

    @Published var toDoItems: [ToDoItem] = [] {
        didSet {
            repository.saveToDoItems(toDoItems)
        }
    }

    @Published var status: Status = .all
    
    var filteredItems: [ToDoItem] {
        return applyFilter(is: status)
    }

    // MARK: - Inputs

    func add(item: ToDoItem) {
        toDoItems.append(item)
    }

    func toggleTodoItemCompletion(_ item: ToDoItem) {
        if let index = toDoItems.firstIndex(where: { $0.id == item.id }) {
            toDoItems[index].isDone.toggle()
        }
    }

    func removeTodoItem(_ item: ToDoItem) {
        toDoItems.removeAll { $0.id == item.id }
    }

    func applyFilter(is status: Status) -> [ToDoItem] {
        switch status {
        case .all :
            return toDoItems
        case .done :
            return toDoItems.filter{ $0.isDone }
        case .undone :
            return toDoItems.filter{ !$0.isDone }
        }
    }
}
