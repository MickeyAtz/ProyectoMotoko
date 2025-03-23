import Array "mo:base/Array";


actor ToDoList {

  //Estructura de la tarea
  type Task = {
    id : Nat;
    description : Text;
    completed : Bool;
  };

  //lista de tareas y ultimo id
  stable var tasks : [Task] = [];
  stable var nextId : Nat = 0;

  // nueva tarea
  public func addTask(desc: Text) : async Int {
    if(desc == ""){
      return -1;
    };
    let newTask = { id = nextId; description = desc; completed = false };
    tasks := Array.append(tasks, [newTask]);
    nextId += 1;
    return newTask.id;
  };

  //Obtener otdas las tareas
  public query func getTasks() : async [Task] {
    return tasks;
  };

  //Tareas completadas
  public query func getCompletedTasks() : async [Task] {
    return Array.filter<Task>(tasks, func (task) { task.completed });
  };

  //Tareas pendientes
  public query func getPendingTasks() : async [Task] {
    return Array.filter<Task>(tasks, func (task) { not task.completed });
  };

  //Completar tarea
  public func completeTask(taskId: Nat) : async Bool {
    tasks := Array.map<Task, Task>(
      tasks, 
      func (task) { 
        if (task.id == taskId) { { task with completed = true } } else { task } 
      }
    );
    return true;
  };

  // Eliminar tarea
  public func deleteTask(taskId: Nat) : async Bool {
    tasks := Array.filter<Task>(tasks, func (task) { task.id != taskId });
    return true;
  };



}
