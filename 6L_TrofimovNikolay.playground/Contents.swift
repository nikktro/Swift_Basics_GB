import UIKit

//    Nikolay Trofimov
//    Homework #6
//
//1.  Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//----2.  Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//3.  *Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
//


protocol Id {
  var id: Int {get}
}

class Queue:Id {
  var id: Int
  init(id: Int) {
    self.id = id
  }
}


struct Stack<T:Id> {
  var elements: [T] = []
  
  mutating func push(_ element: T) {
    elements.append(element)
  }
  
  // проверка несуществующего индекса без subscript
  mutating func pop() -> T? {
    guard !elements.isEmpty else { return nil }
    return elements.remove(at: 0)  // первый элемент выходит первым
  }
  
  
  subscript(elements: Int ...) -> Int? {  // доступ к стеку по индексу
    var id = 0
    for index in elements where index < self.elements.count {
      id = self.elements[index].id
    }
    return id

  }
  
}

var stackQueue = Stack<Queue>()

// создаем очередь
stackQueue.push(Queue(id: 1))
stackQueue.push(Queue(id: 3))
stackQueue.push(Queue(id: 5))
stackQueue.push(Queue(id: 4))
stackQueue.push(Queue(id: 7))
stackQueue.push(Queue(id: 9))

stackQueue[3] // достать по индексу значение id 4-го объекта // полученное значение 4
stackQueue[8] // не существует, возвращает 0

// постепенно очищаем очередь
stackQueue.pop() // первый элемент выходит первым
stackQueue.pop()
stackQueue.pop()
stackQueue.pop()
stackQueue.pop()
stackQueue.pop()
stackQueue.pop() // nil, нельзя достать несуществующий объект

// снова заполняем очередь
stackQueue.push(Queue(id: 11))
stackQueue.push(Queue(id: 13))
stackQueue.push(Queue(id: 15))
stackQueue.push(Queue(id: 17))
stackQueue.push(Queue(id: 20))
stackQueue.push(Queue(id: 24))

stackQueue[3] // достать по индексу значение id 4-го объекта // полученное значение 17
stackQueue[8] // не существует, возвращает 0
