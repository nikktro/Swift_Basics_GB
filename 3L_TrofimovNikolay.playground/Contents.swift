import Foundation

// Lesson 3 Homework
// Nikolay Trofimov
//
// Task
//  1. Описать несколько структур – любой легковой автомобиль и любой грузовик.
//  2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова,
//      запущен ли двигатель, открыты ли окна, заполненный объем багажника.
//  3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из
//      кузова/багажника груз определенного объема.
//  4. Добавить в ваши структуры метод с одним аргументом типа вашего перечисления,
//      который будет менять свойства структуры в зависимости от действия.
//  5. Инициализировать несколько экземпляров ваших структур. Применить к ним
//      различные действия.
//  6. Вывести значения свойств экземпляров в консоль.
//



// Task 1-4.

// Описание перечислений

enum Model {
  case Ford, KAMAZ, IVECO, VW
}

enum WindowState: String {
  case open = "Окна открыты"
  case close = "Окна закрыты"
}

enum EngineState: String {
  case on = "Двигатель запущен"
  case off = "Двигатель остановлен"
}

enum ActionList: String {
  case engineStop = "Остановить двигатель"
  case engineStart = "Запустить двигатель"
  case windowClose = "Закрыть окна"
  case windowOpen = "Открыть окна"
  case unloadTrunk = "Выгурзить 100кг"
  case loadTrunk = "Погрузить 100кг"

}

// Описание структуры Vehicle

struct Vehicle {

  let model: Model                  // модель траспортного средства
  let year: UInt16                 // год выпуска транспортного средства
  let trunk: Double               // допустимый объем багажника
  
  // проверка работы двигателя
  var engine: EngineState {
    willSet { // блок будет вызван ДО того как значение изменится
      if newValue == .on {
        print("\(self.model): \(EngineState.on.rawValue)")
      }
      else {
        print("\(self.model): \(EngineState.off.rawValue)")
      }
    }
  }
  
  // проверка состояния окон
  var windowState: WindowState {
    willSet {
      if newValue == .open {
        print("\(self.model): \(WindowState.open.rawValue)")
      }
      else {
        print("\(self.model): \(WindowState.close.rawValue)")
      }
    }
  }
  
  // информация о загрузке багажника
  var usedTrunk: Double

  
  // функция погрузки, разгрузки и проверки багажника. Вводные данные - определенный объем
  mutating func changeTrunk(cargo: Double)  {
    if (self.usedTrunk + cargo) > self.trunk {
      print("\(self.model): Перегруз") // если пытаемся погрузить больше допустимого
    }
    else if self.usedTrunk + cargo >= 0 {
      cargo > 0 ? print("\(self.model): Груз увеличен на \(cargo)") : print("\(self.model): Груз уменьшен на \(abs(cargo))")
      self.usedTrunk += cargo
    }
    else {
      print("\(self.model): В багажнике нет такого груза") // если объем груза становится отрицательным
    }
  }
  
  
  // Добавление метода: возможные действия с траспортным средством
  mutating func action(mode: ActionList) {
    switch mode {
      case .engineStop:
        self.engine = .off
      case .engineStart:
        self.engine = .on
      case .windowClose:
        self.windowState = .close
      case .windowOpen:
        self.windowState = .open
      case .unloadTrunk:
        changeTrunk(cargo: -100) // действие будет выгружать 100кг через функцию changeTrunk
      case .loadTrunk:
        changeTrunk(cargo: 100) // действие будет погружать 100кг через функцию changeTrunk
    }
  }
  
}


// Task 5. Инициализация нескольких экземплятов

// легковые авто
var car1 = Vehicle(model: .Ford, year: 2010, trunk: 230.4, engine: .off, windowState: .open, usedTrunk: 140.0)
var car2 = Vehicle(model: .VW, year: 2016, trunk: 400, engine: .off, windowState: .close, usedTrunk: 50.5)

// грузовые авто
var truck1 = Vehicle(model: .KAMAZ, year: 2012, trunk: 14351.8, engine: .off, windowState: .close, usedTrunk: 2000.0)
var truck2 = Vehicle(model: .IVECO, year: 2014, trunk: 15000, engine: .on, windowState: .close, usedTrunk: 5000.0)




// Применение к объектам различных действий

// Запустить двигатель
truck1.engine.rawValue
truck1.action(mode: .engineStart)
truck1.engine.rawValue

// Остановить двигатель
truck2.engine.rawValue
truck2.action(mode: .engineStop)
truck2.engine.rawValue


// Закрыть окна
car1.windowState.rawValue
car1.action(mode: .windowClose)
car1.windowState.rawValue


// Открыть окна
car2.windowState.rawValue
car2.action(mode: .windowOpen)
car2.windowState.rawValue


// Выгурзить 100кг
car1.usedTrunk
car1.action(mode: .unloadTrunk)
car1.usedTrunk


// Погрузить 100кг
car2.usedTrunk
car2.action(mode: .loadTrunk)
car2.usedTrunk



// Добавление груза определенного объема (+400 кг)
truck1.usedTrunk
truck1.changeTrunk(cargo: 400)
truck1.usedTrunk

// Уменьшение грузка определенного объема (-1000 кг)
truck1.usedTrunk
truck1.changeTrunk(cargo: -1000)
truck1.usedTrunk


// Добавление груза 14000 кг
truck2.usedTrunk
truck2.changeTrunk(cargo: 14000) // ПЕРЕГРУЗ! Новый груз не добавлен
truck2.usedTrunk

// Уменьшение грузка -1000 кг
car1.usedTrunk
car1.changeTrunk(cargo: -100) // ОШИБКА! Нельзя убрать из багажника больше, чем там находится
car1.usedTrunk



// Task 6. Вывод свойств экземплятов в консоль

print("\n")
var carPark: [Vehicle] = [car1, car2, truck1, truck2]

func printVehicle() {
  for i in 0..<carPark.count {
    print("\(carPark[i].model): year \(carPark[i].year), engine \(carPark[i].engine), window \(carPark[i].windowState), usedTrunk \(carPark[i].usedTrunk)")
  }
}

printVehicle()
