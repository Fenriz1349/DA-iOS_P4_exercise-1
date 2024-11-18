import SwiftUI

struct ToDoListView: View {
    @ObservedObject var viewModel: ToDoListViewModel
    @State private var newTodoTitle = ""
    @State private var isShowingAlert = false
    @State private var isAddingTodo = false
    @State private var newPriority : Priorities = .low
    
    // New state for filter index
    @State private var filterIndex = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Text("To-Do List")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                // Picker with all the status values to apply filter in the list below
                Picker("", selection: $viewModel.status) {
                    ForEach(Status.allCases, id: \.self) { status in
                        Text(status.rawValue)
                            .tag(status as Status?)
                    }
                }
                .pickerStyle(.segmented)
                .padding(20)
                // Liste des tâches filtrées
                List {
                    ForEach(viewModel.filteredItems) { item in
                        HStack {
                            Button(action: {
                                viewModel.toggleTodoItemCompletion(item)
                            }) {
                                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(item.isDone ? .green : .primary)
                            }
                            Text(item.title)
                                .font(item.isDone ? .subheadline : .body)
                                .strikethrough(item.isDone)
                                .foregroundColor(item.isDone ? .gray : .primary)
                            Text(item.priority.rawValue)
                                .font(item.isDone ? .subheadline : .body)
                                .strikethrough(item.isDone)
                                .foregroundColor(item.priority.color)
                        }
                    }
                    .onDelete { indices in
                        indices.forEach { index in
                            let item = viewModel.toDoItems[index]
                            viewModel.removeTodoItem(item)
                        }
                    }
                }
                
                // Sticky bottom view for adding todos
                if isAddingTodo {
                    HStack {
                        VStack {
                            TextField("Entrer une tâche", text: $newTodoTitle)
                                .padding(.leading)
                            Picker(selection: $newPriority, label: Text("Priorité")) {
                                ForEach(Priorities.allCases, id: \.self) {priority in
                                    Text(priority.rawValue)
                                    .tag(priority as Priorities?)}
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        Spacer()
                        
                        Button(action: {
                            if newTodoTitle.isEmpty {
                                isShowingAlert = true
                            } else {
                                viewModel.add(
                                    item: .init(
                                        title: newTodoTitle,
                                        priority: newPriority
                                    )
                                )
                                newTodoTitle = "" // Reset newTodoTitle to empty.
                                isAddingTodo = false // Close the bottom view after adding
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                }
                
                // Button to toggle the bottom add view
                Button(action: {
                    isAddingTodo.toggle()
                }) {
                    Text(isAddingTodo ? "Fermer" : "Ajouter Tâche")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isAddingTodo ? .red : Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()

            }
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(
            viewModel: ToDoListViewModel(
                repository: ToDoListRepository()
            )
        )
    }
}
