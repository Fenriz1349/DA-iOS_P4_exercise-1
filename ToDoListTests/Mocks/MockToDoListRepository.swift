@testable import ToDoList
import Foundation

final class MockToDoListRepository: ToDoListRepositoryType {
    var mockToDoItems: [ToDoItem] = [
        ToDoItem(title: "Faire une todo list", isDone: true, priority: .low),
        ToDoItem(title: "Faire les courses", priority: .medium),
        ToDoItem(title: "Conquerir le monde", priority: .high)
    ]

    init(initialItems: [ToDoItem] = []) {
            if !initialItems.isEmpty {
                self.mockToDoItems = initialItems
            }
        }

    func loadToDoItems() -> [ToDoItem] {
        return mockToDoItems
    }

    func saveToDoItems(_ items: [ToDoItem]) {
        mockToDoItems = items
    }
}
