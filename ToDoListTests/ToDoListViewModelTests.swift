import XCTest
import Combine
@testable import ToDoList

final class ToDoListViewModelTests: XCTestCase {
    
    // MARK: - Tests
    func testVariables_initialisationUponCreation_defaultCorrectValues() {
        // Given
        let repository = MockToDoListRepository()
        print("Mock ToDo Items count: \(repository.mockToDoItems.count)")  // Devrait afficher 3
            
            let sut = ToDoListViewModel(repository: repository)
            
            // Vérifie que toDoItems dans le ViewModel est bien initialisé à partir du mock
            print("SUT ToDo Items count: \(sut.toDoItems.count)")
        
        // Then
        XCTAssertEqual(sut.toDoItems.count, 3)
        XCTAssertTrue(sut.toDoItems[0].title == "Faire une todo list")
        XCTAssertTrue(sut.toDoItems[0].priority == .low)
        XCTAssertTrue(sut.toDoItems[0].isDone)
        XCTAssertTrue(sut.toDoItems[1].title == "Faire les courses")
        XCTAssertTrue(sut.toDoItems[1].priority == .medium)
        XCTAssertFalse(sut.toDoItems[1].isDone)
        XCTAssertTrue(sut.toDoItems[2].title == "Conquerir le monde")
        XCTAssertTrue(sut.toDoItems[2].priority == .high)
        XCTAssertFalse(sut.toDoItems[2].isDone)
    }
    
    func testAddTodoItem() {
        // Given
        let repository = MockToDoListRepository()
        let sut = ToDoListViewModel(repository: repository)
        let item = ToDoItem(title: "Test Task", priority: .low)
        
        // When
        sut.add(item: item)
        
        // Then
        XCTAssertEqual(sut.toDoItems.count, 4)
        XCTAssertTrue(sut.toDoItems[3].title == "Test Task")
        XCTAssertTrue(sut.toDoItems[3].priority == .low)
    }
    
    func testToggleTodoItemCompletion() {
        // Given
        let repository = MockToDoListRepository()
        let sut = ToDoListViewModel(repository: repository)
        let item = ToDoItem(title: "Test Task", priority: .low)
        sut.add(item: item)
        
        // When
        sut.toggleTodoItemCompletion(item)
        
        // Then
        XCTAssertTrue(sut.toDoItems[0].isDone)
    }
    
    func testRemoveTodoItem() {
        // Given
        let repository = MockToDoListRepository()
        let sut = ToDoListViewModel(repository: repository)
        let item = ToDoItem(title: "Test Task", priority: .low)
        sut.toDoItems.append(item)
        
        // When
        sut.removeTodoItem(item)
        
        // Then
        XCTAssertEqual(sut.toDoItems.count, 3)
    }
    
    func testFilteredToDoItems_all() {
        // Given
        let repository = MockToDoListRepository()
        let sut = ToDoListViewModel(repository: repository)
        
        // When
        sut.status = .all
        // Then
        XCTAssertEqual(sut.filteredItems.count, 3)
    }
    
    func testFilteredToDoItems_done() {
        // Given
        let repository = MockToDoListRepository()
        let sut = ToDoListViewModel(repository: repository)
        // When
        sut.status = .done
        // Then
        XCTAssertEqual(sut.filteredItems.count, 1)
    }
    
    func testFilteredToDoItems_undone() {
        // Given
        let repository = MockToDoListRepository()
        let sut = ToDoListViewModel(repository: repository)
        // When
        sut.status = .undone
        // Then
        XCTAssertEqual(sut.filteredItems.count, 2)
    }
}
