import Array "mo:base/Array";


actor ToDoList{
  //Estructura de Tarea
  type Task = {
    id: Nat;
    description: Text;
    completed: Bool;
  };

  //Listado de tareas persistente y proximo ID 
  stable var tasks : [Task] = [];
  stable var nextId : Nat = 0;

  //Nueva Tarea
  public func addTask(desc: Text) : async Nat {
    let newTask  = {
      id = nextId; 
      description = desc; 
      completed = false
    };
    tasks := Array.append(tasks, [newTask]);
    nextId += 1;

    return newTask.id;
  };

  public query func getTasks(): async [Task]{
    return tasks;
  };

  public func completeTask(id:Nat): async Bool {
    tasks := Array.map<Task, Task>(
      tasks,
      func (task){
        if(task.id == id){
          {task with completed = true}
        } else {
          task
        }
      }
    );
    return true;
  }







}
