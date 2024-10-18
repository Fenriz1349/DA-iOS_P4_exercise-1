import SwiftUI

final class ToDoListViewModel: ObservableObject {
    // MARK: - Private properties

    private let repository: ToDoListRepositoryType

    // MARK: - Init

    init(repository: ToDoListRepositoryType) {
        self.repository = repository
        self.toDoItems = repository.loadToDoItems()
    }

    // MARK: - Outputs

    /// Publisher for the list of to-do items.
    @Published var toDoItems: [ToDoItem] = [] {
        didSet {
            repository.saveToDoItems(toDoItems)
        }
    }
    // Published var to select the status of completion, natively return all
    @Published var status: Status = .all
    
    // Computed Propriety to filter toDoItems without removing anything
      var filteredItems: [ToDoItem] {
        return applyFilter(is: status)
      }
    
    // MARK: - Inputs

    // Add a new to-do item with priority and category
    func add(item: ToDoItem) {
        toDoItems.append(item)
    }

    /// Toggles the completion status of a to-do item.
    func toggleTodoItemCompletion(_ item: ToDoItem) {
        if let index = toDoItems.firstIndex(where: { $0.id == item.id }) {
            toDoItems[index].isDone.toggle()
        }
    }

    /// Removes a to-do item from the list.
    func removeTodoItem(_ item: ToDoItem) {
        toDoItems.removeAll { $0.id == item.id }
    }

    /// Apply the filter to update the list.
    ///
    /// Index 1 to filter isDone true
    /// index 2 to filter isDone false
    func applyFilter(is status: Status) -> [ToDoItem] {
        // TODO: - Implement the logic for filtering
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
