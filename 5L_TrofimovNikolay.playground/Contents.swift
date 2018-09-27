import Foundation

// Nikolay.Trofimov
// Домашнее задание к уроку №5

//
//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести сами объекты в консоль.
//

//// Мои комментарии по решению.
// Базовый класс Car решил оставить, чтобы в наследованиях TruckCar и SportCar повторно не описывать общие свойства
// Иерархия получилась следующая: protocol -> Car -> TruckCar и SportCar
// В протоколе указано действие без реализации func action(). В классе Car также пустая реализация func action(), но далее доавлено расширение.
// Наследованные классы TruckCar и SportCar дополняются методами с помощью расширений - для каждого класса своё расширение.

//// Что не понял.
// Зачем мне протокол автомобиля, если базовый класс все равно нужен для описание общих свойств?? В данной задаче я вполне могу обойтись без протокола.



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
}

enum ActionListTruck: String {
  case trunkCoolerOff = "Выключить холодильник в прицепе"
  case trunkCoolerOn = "Включить холодильник в прицепе"
}

// Протокол автомобиля
protocol Carable {
  func action()
}

// протокол CustomStringConvertible
protocol ConsolePrintable: CustomStringConvertible {
  func printDescription()
}

// расширение, имплементирующее протокол CustomStringConvertible.
extension ConsolePrintable {
  func printDescription() {
    print(description)
  }
}


// Базовый Класс Car (Автомобиль)
class Car: Carable {
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
 
  func action() {
  }
}


// Добавление метода: возможные действия с траспортным средством
extension Car {
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
    }
  }
}



// Класс Грузовика
class TruckCar: Car, ConsolePrintable {
  let horsePower: Double
  var trunkCooler: TrunkCooler
  init(model: Model, year: UInt16, trunk: Double, engine: EngineState, windowState: WindowState, usedTrunk: Double, horsePower: Double, trunkCooler: TrunkCooler) {
    self.horsePower = horsePower
    self.trunkCooler = trunkCooler
    super.init(model: model, year: year, trunk: trunk, engine: engine, windowState: windowState, usedTrunk: usedTrunk)
  }
  var description: String {
    return String(describing: "Model \(model), year \(year), engine \(engine), window \(windowState), usedTrunk \(usedTrunk), TrunkCooler \(trunkCooler)")
  }
}

// метод включения холодильной установки на TruckCar с помощью перечислений
extension TruckCar {
  func action(mode: ActionListTruck) {
    switch mode {
    case .trunkCoolerOff:
      self.trunkCooler = .off
    case .trunkCoolerOn:
      self.trunkCooler = .on
    }
  }
}



// Класс Гоночной машины
class SportCar: Car, ConsolePrintable {
  let maxSpeed: Double
  var useTurbo: Bool
  init(model: Model, year: UInt16, trunk: Double, engine: EngineState, windowState: WindowState, usedTrunk: Double, maxSpeed: Double, useTurbo: Bool) {
    self.maxSpeed = maxSpeed
    self.useTurbo = useTurbo
    super.init(model: model, year: year, trunk: trunk, engine: engine, windowState: windowState, usedTrunk: usedTrunk)
  }
  var description: String {
    return String(describing: "Model \(model), year \(year), engine \(engine), window \(windowState), usedTrunk \(usedTrunk), Turbo \(useTurbo)")
  }
}

// метод вкл.выкл турбо на SportCar через функцию
extension SportCar {
  func turboOn() {
    self.useTurbo = true
  }
  func turboOff() {
    self.useTurbo = false
  }
  
}




//5. Создать несколько объектов каждого класса. Применить к ним различные действия.

// truck
var truckCar1 = TruckCar(model: .KAMAZ, year: 2016, trunk: 14000, engine: .off, windowState: .close, usedTrunk: 3000, horsePower: 460, trunkCooler: .off)
var truckCar2 = TruckCar(model: .IVECO, year: 2017, trunk: 15000, engine: .on, windowState: .open, usedTrunk: 2000, horsePower: 560, trunkCooler: .on)

// sportCar
var sportCar1 = SportCar(model: .Honda, year: 2016, trunk: 100, engine: .off, windowState: .close, usedTrunk: 50, maxSpeed: 250, useTurbo: true)
var sportCar2 = SportCar(model: .Ford, year: 2017, trunk: 300, engine: .on, windowState: .close, usedTrunk: 100, maxSpeed: 220, useTurbo: false)
var sportCar3: SportCar = SportCar(model: .Honda, year: 2017, trunk: 300, engine: .off, windowState: .close, usedTrunk: 100, maxSpeed: 260, useTurbo: true)


//6. Вывести сами объекты в консоль.


sportCar2.description
sportCar2.turboOn()
sportCar2.description

sportCar2.action(mode: .engineStop)
sportCar2.description


truckCar1.description
truckCar1.action(mode: .trunkCoolerOn)
truckCar1.description

