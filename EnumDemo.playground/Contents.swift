//: Playground - noun: a place where people can play

import UIKit
import Foundation

class EnumTutorial: NSObject {
    
    // Defining Basic Enums
    enum Movement {
        case left
        case right
        case top
        case bottom
    }
    
    // Mapping to Integer or String or Double
    enum Direction: Int {
        case left   = 0
        case right  = 1
        case top    = 2
        case bottom = 3
    }
    
    // Nesting Enums
    enum Character {
        enum Weapon {
            case Bow
            case Sword
            case Lance
            case Dagger
        }
        
        enum Helmet {
            case Wooden
            case Iron
            case Diamond
        }
        
        case Thief
        case Warrior
        case Knight
    }
    
    
    // Associated Values with or without labels
    enum Trade {
        case Buy(stock: String, amount: Int)
        case Sell(stock: String, amount: Int)
        case None(String, Int)
    }
    
    // Cases with different values
    enum UserAction {
        case OpenURL(url: NSURL)
        case SwitchProcess(processId: UInt32)
        case Restart(time: NSDate?, intoCommandLine: Bool)
    }
    //MARK: CHECK 1
    enum Device {
        
        case iPad, iPhone, AppleTV, AppleWatch
        
        // Methods
        func introduced() -> String {
            switch self {
            case AppleTV:       return "\(self) was introduced 2006"
            case iPhone:        return "\(self) was introduced 2007"
            case iPad:          return "\(self) was introduced 2010"
            case AppleWatch:    return "\(self) was introduced 2014"
            }
        }
        
        //Static Methods
        static func fromSlang(term: String) -> Device? {
            if term == "iWatch" { return .AppleWatch }
            return nil
        }
        
        // Properties
        var year: Int {
            switch self {
            case AppleTV:       return 2006
            case iPhone:        return 2007
            case iPad:          return 2010
            case AppleWatch:    return 2014
            }
        }
        
        //Static Properties
        static let allValues = [AppleTV, iPhone, AppleWatch]
    }
    
    
    //MARK: CHECK 2
    // Pattern Matching
    func trade(trade1:Trade) {
        
        if case let Trade.Buy(stock, amount) = trade1 {
            print("buy \(amount) of \(stock)")
        }
        
        // Tuples as Arguments
        let tp = (stock: "TSLA", amount: 100)
        
        let trade = Trade.Sell(tp)
        
        if case let Trade.Sell(stock, amount) = trade {
            print("buy \(amount) of \(stock)")
        }
        
    }
    
    //MARK: CHECK 3
    // Mutating Methods
    enum TriStateSwitch {
        
        case Off, Low, High
        
        mutating func next() {
            switch self {
            case Off: self = Low
            case Low: self = High
            case High: self = Off
            }
        }
    }
}


/* Advanced Enum Usage */
/***********************/

class AdvanceEnum {
    
    enum Trade: CustomStringConvertible {
        
        case Buy, Sell
        
        var description: String {
            switch self {
            case Buy: return "We're buying something"
            case Sell: return "We're selling something"
            }
        }
    }
    
    func  testing(){
        let action = Trade.Buy.description
        print("this action is \(action)")
    }
}


// Generic Enums

// Simplified implementation of Swift's Optional
enum MyOptional<T> {
    case Some(T)
    case None
}

// The well-known either type is, of course, an enum that allows you to return either
// value one (say, a successful value) or value two (say an error) from a function
enum Either<T1, T2> {
    case Left(T1)
    case Right(T2)
}

// Totally nonsensical example. A bag that is either full (has an array with contents)
// or empty.
enum Bag<T: SequenceType where T.Generator.Element==Equatable> {
    case Empty
    case Full(contents: T)
}


//Recursive / Indirect Types
enum FileNode {
    case File(name: String)
    indirect case Folder(name: String, files: [FileNode])
}


indirect enum Tree<Element: Comparable> {
    case Empty
    case Node(Tree<Element>,Element,Tree<Element>)
}

// Using Custom Data Types as Enum Values

enum Devices: CGSize {
    case iPhone3GS = "{320, 480}"
    case iPhone5 = "{320, 568}"
    case iPhone6 = "{375, 667}"
    case iPhone6Plus = "{414, 736}"
}

//MARK: CHECK 4
extension CGSize: StringLiteralConvertible {
    public init(stringLiteral value: String) {
        let size = CGSizeFromString(value)
        self.init(width: size.width, height: size.height)
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        let size = CGSizeFromString(value)
        self.init(width: size.width, height: size.height)
    }
    
    public init(unicodeScalarLiteral value: String) {
        let size = CGSizeFromString(value)
        self.init(width: size.width, height: size.height)
    }
}

// Custom Initializers
enum Device {
    
    case AppleWatch
    
    init?(term: String) {
        if term == "iWatch" {
            self = .AppleWatch
        } else {
            return nil
        }
    }
}

enum NumberCategory {
    
    case Small
    case Medium
    case Big
    case Huge
    
    init(number n: Int) {
        if n < 10000 { self = .Small }
        else if n < 1000000 { self = .Medium }
        else if n < 100000000 { self = .Big }
        else { self = .Huge }
    }
    
    //let aNumber = NumberCategory(number: 100)
    // print(aNumber)
}

/* Advanced & Practical Enum usage in Swift Error Handling */
/**********************************************************/

/*
 Swift enumerations are particularly well suited to modeling a group of related error conditions, with associated values allowing for additional information about the nature of an error to be communicated.
 
 */


enum DecodeError: ErrorType {
    case TypeMismatch(expected: String, actual: String)
    case MissingKey(String)
    case Custom(String)
}

// Observer Pattern
enum Change<Item> {
    case Insertion(items: [Item])
    case Deletion(items: [Item])
    case Update(items: [Item])
}

// Map Result Types
enum JSON <JSONValue> {
    case JSONString(Swift.String)
    case JSONNumber(Double)
    case JSONObject([String : JSONValue])
    case JSONArray([JSONValue])
    case JSONBool(Bool)
    case JSONNull
}

// UIKit Identifiers
enum CellType: String {
    case ButtonValueCell    = "ButtonValueCell"
    case UnitEditCell       = "UnitEditCell"
    case LabelCell          = "LabelCell"
    case ResultLabelCell    = "ResultLabelCell"
}

// Units
enum Liquid: Float {
    case ml = 1.0
    case l = 1000.0
    func convert(amount amount: Float, to: Liquid) -> Float {
        if self.rawValue < to.rawValue {
            return (self.rawValue / to.rawValue) * amount
        } else {
            return (self.rawValue * to.rawValue) * amount
        }
    }
}

// Battling stringly typed code
enum DetailViewImages: String {
    case Background = "bg1.png"
    case Sidebar = "sbg.png"
    case ActionButton1 = "btn1_1.png"
    case ActionButton2 = "btn2_1.png"
}


// API Endpoints
enum Instagram {
    enum Media {
        case Popular
        case Shortcode(id: String)
        case Search(lat: Float, min_timestamp: Int, lng: Float, max_timestamp: Int, distance: Int)
    }
    
    enum Users {
        case User(id: String)
        case Feed
        case Recent(id: String)
    }
}

// Status Codes
enum HttpError: String {
    case Code400 = "Bad Request"
    case Code401 = "Unauthorized"
    case Code402 = "Payment Required"
    case Code403 = "Forbidden"
    case Code404 = "Not Found"
}

enum APIError : ErrorType {
    // Can't connect to the server (maybe offline?)
    case ConnectionError(error: NSError)
    // The server responded with a non 200 status code
    case ServerError(statusCode: Int, error: NSError)
    // We got no data (0 bytes) back from the server
    case NoDataError
    // The server response can't be converted from JSON to a Dictionary
    case JSONSerializationError(error: ErrorType)
    // The Argo decoding Failed
    case JSONMappingError(converstionError: DecodeError)
}



// GAME EXAMPLE 2
enum FlyingBeast { case Dragon, Hippogriff, Gargoyle }
enum Horde { case Ork, Troll }
enum Player { case Mage, Warrior, Barbarian }
enum NPC { case Vendor, Blacksmith }
enum Element { case Tree, Fence, Stone }

protocol Hurtable {}
protocol Killable {}
protocol Flying {}
protocol Attacking {}
protocol Obstacle {}

extension FlyingBeast: Hurtable, Killable, Flying, Attacking {}
extension Horde: Hurtable, Killable, Attacking {}
extension Player: Hurtable, Obstacle {}
extension NPC: Hurtable {}
extension Element: Obstacle {}


// EXAMPLE 1
protocol AccountCompatible {
    var remainingFunds: Int { get }
    mutating func addFunds(amount: Int) throws
    mutating func removeFunds(amount: Int) throws
}


enum Account {
    case Empty
    case Funds(remaining: Int)
    
    enum Error: ErrorType {
        case Overdraft(amount: Int)
    }
    
    var remainingFunds: Int {
        switch self {
        case Empty: return 0
        case Funds(let remaining): return remaining
        }
    }
}


extension Account: AccountCompatible {
    
    mutating func addFunds(amount: Int) throws {
        var newAmount = amount
        if case let .Funds(remaining) = self {
            newAmount += remaining
        }
        if newAmount < 0 {
            throw Error.Overdraft(amount: -newAmount)
        } else if newAmount == 0 {
            self = .Empty
        } else {
            self = .Funds(remaining: newAmount)
        }
    }
    
    mutating func removeFunds(amount: Int) throws {
        try self.addFunds(amount * -1)
    }
    
}


/*
 Enums are typically one byte long. […] If you want to get very very silly, you can build an enumeration with hundreds of cases, in which case the enum takes up 2 or more bytes depending on the minimum bit count needed.
 */



