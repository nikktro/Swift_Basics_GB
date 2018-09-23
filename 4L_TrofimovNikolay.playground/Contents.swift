import Foundation

// Lesson 4 Homework
// Nikolay Trofimov
//
// Task
//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.
//


// Описание перечислений

enum Model {
  case Ford, KAMAZ, IVECO, VW, Honda
}

enum WindowState: String {
  case open = "Окна открыты"
  case close = "Окна закрыты"
}

enum EngineState: String {
  case on = "Двигатель запущен"
  case off = "Двигатель остановлен"
}

enum TrunkCooler: String {
    case on = "Охлаждение включено"
    case off = "Охлаждение выключено"
}

enum ActionList: String {
  case engineStop = "Остановить двигатель"
  case engineStart = "Запустить двигатель"
  case windowClose = "Закрыть окна"
  case windowOpen = "Открыть окна"
  case unloadTrunk = "Выгурзить 100кг"
  case loadTrunk = "Погрузить 100кг"
  case turboOff = "Выключить Turbo"
  case turboOn = "Включить Turbo"
  case trunkCoolerOff = "Выключить холодильник в прицепе"
  case trunkCoolerOn = "Включить холодильник в прицепе"
}




// Класс Car

class Car {
  let model: Model                  // модель траспортного средства
  let year: UInt16                 // год выпуска транспортного средства
  let trunk: Double               // допустимый объем багажника
  var engine: EngineState        // состояние работы двигателя
  var windowState: WindowState  // состояние окон
  var usedTrunk: Double        // занятый объем багажника
  
  init(model: Model, year: UInt16, trunk: Double, engine: EngineState, windowState: WindowState, usedTrunk: Double) {
    self.model = model
    self.year = year
    self.trunk = trunk
    self.engine = engine
    self.windowState = windowState
    self.usedTrunk = usedTrunk
  }
  
  // функция погрузки, разгрузки и проверки багажника. Вводные данные - определенный объем
  func changeTrunk(cargo: Double)  {
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
  func action(mode: ActionList) {
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
    default:
      break
    }
  }
}



// Наследник TruckCar
// отличительные свойства: наличие холожильной установки в прицепе и указывается мощность двигателя.
class TruckCar: Car {
  let horsePower: Double
  var trunkCooler: TrunkCooler
  init(model: Model, year: UInt16, trunk: Double, engine: EngineState, windowState: WindowState, usedTrunk: Double, horsePower: Double, trunkCooler: TrunkCooler) {
    self.horsePower = horsePower
    self.trunkCooler = trunkCooler
    super.init(model: model, year: year, trunk: trunk, engine: engine, windowState: windowState, usedTrunk: usedTrunk)
  }
  
  // Не понял как дополнить перечисления от родителя. Пришлось делать copy-paste. Понимаю, что это не хорошо, можно наделать ошибки. Да и код вырос. обращение к родительской функции через super выдает ошибку.
  override func action(mode: ActionList) {
    //super.action(mode: ActionList) // выдает ошибку
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
    case .trunkCoolerOff:
      self.trunkCooler = .off
    case .trunkCoolerOn:
      self.trunkCooler = .on
    default:
      break
    }
  }
  
}


// Наследник SportCar
// отличительные свойства: наличие режима турбо и указывается максимальная скорость автомобиля.
class SportCar: Car {
  let maxSpeed: Double
  var useTurbo: Bool
  init(model: Model, year: UInt16, trunk: Double, engine: EngineState, windowState: WindowState, usedTrunk: Double, maxSpeed: Double, useTurbo: Bool) {
    self.maxSpeed = maxSpeed
    self.useTurbo = useTurbo
    super.init(model: model, year: year, trunk: trunk, engine: engine, windowState: windowState, usedTrunk: usedTrunk)
  }
  
  // Не понял как дополнить перечисления от родителя. Пришлось делать copy-paste. Понимаю, что это не хорошо, можно наделать ошибки. Да и код вырос.
  override func action(mode: ActionList) {
    //super.action(mode: ActionList) // выдает ошибку
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
    case .turboOff:
      self.useTurbo = false
    case .turboOn:
      self.useTurbo = true
    default:
      break
    }
  }
  
}





// любой автомобиль
var car1 = Car(model: .Ford, year: 2000, trunk: 500, engine: .off, windowState: .close, usedTrunk: 100)
var car2 = Car(model: .VW, year: 2014, trunk: 600, engine: .on, windowState: .open, usedTrunk: 200)

// truck
var truckCar1 = TruckCar(model: .KAMAZ, year: 2016, trunk: 14000, engine: .off, windowState: .close, usedTrunk: 3000, horsePower: 460, trunkCooler: .off)
var truckCar2 = TruckCar(model: .IVECO, year: 2017, trunk: 15000, engine: .on, windowState: .open, usedTrunk: 2000, horsePower: 560, trunkCooler: .on)

// sportCar
var sportCar1 = SportCar(model: .Honda, year: 2016, trunk: 100, engine: .off, windowState: .close, usedTrunk: 50, maxSpeed: 250, useTurbo: true)
var sportCar2 = SportCar(model: .Ford, year: 2017, trunk: 300, engine: .on, windowState: .close, usedTrunk: 100, maxSpeed: 220, useTurbo: false)
var sportCar3: SportCar = SportCar(model: .Honda, year: 2017, trunk: 300, engine: .off, windowState: .close, usedTrunk: 100, maxSpeed: 260, useTurbo: true)


car2.usedTrunk
car2.changeTrunk(cargo: 200) // увеличение груза автомобиля на 200
car2.usedTrunk
print("\(car2.model): year \(car2.year), engine \(car2.engine), window \(car2.windowState), usedTrunk \(car2.usedTrunk)")


sportCar2.useTurbo
sportCar2.action(mode: .turboOn) // включение режима турбо для спорткара
sportCar2.useTurbo
print("\(sportCar2.model): year \(sportCar2.year), engine \(sportCar2.engine), window \(sportCar2.windowState), usedTrunk \(sportCar2.usedTrunk), Turbo \(sportCar2.useTurbo)")

truckCar1.trunkCooler
truckCar1.action(mode: .trunkCoolerOn) // включение холодильной установки
truckCar1.trunkCooler
print("\(truckCar1.model): year \(truckCar1.year), engine \(truckCar1.engine), window \(truckCar1.windowState), usedTrunk \(truckCar1.usedTrunk), Trunk Cooler \(truckCar1.trunkCooler)")




