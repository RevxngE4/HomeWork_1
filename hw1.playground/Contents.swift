// Задание 1

protocol HomeworkService {
    // Функция деления с остатком, должна вернуть в первой части результат деления, во второй части остаток.
    func divideWithRemainder(_ x: Int, by y: Int) -> (Int, Int)

    // Функция должна вернуть числа фибоначчи.
    func fibonacci(n: Int) -> [Int]

    // Функция должна выполнить сортировку пузырьком.
    func sort(rawArray: [Int]) -> [Int]

    // Функция должна преобразовать массив строк в массив первых символов строки.
    func firstLetter(strings: [String]) -> [Character]

    // Функция должна отфильтровать массив по условию, которое приходит в параметре `condition`. (Нельзя юзать `filter` у `Array`)
    func filter(array: [Int], condition: ((Int) -> Bool)) -> [Int]
}

struct MyHomeworkService: HomeworkService {
    func divideWithRemainder(_ x: Int, by y: Int) -> (Int, Int) {
        let divide = x / y
        let remainder = x % y
        return (divide, remainder)
    }

    func fibonacci(n: Int) -> [Int] {
        var sequence = [0, 1]

        if n <= 0 {
            return []
        }

        if n <= 2 {
            return sequence
        }

        for _ in 3...n {
            let nextNumber = sequence[sequence.count - 1] + sequence[sequence.count - 2]
            sequence.append(nextNumber)
        }
        return sequence
    }

    func sort(rawArray: [Int]) -> [Int] {
        var arr = rawArray
        let n = arr.count
        for i in 0..<n-1 {
            for j in 0..<n-i-1 {
                if arr[j] > arr[j+1] {
                    let temp = arr[j]
                    arr[j] = arr[j+1]
                    arr[j+1] = temp
                }
            }
        }
        return arr
    }

    func firstLetter(strings: [String]) -> [Character] {
        var firstLetters = [Character]()

        for string in strings {
            if let firstLetter = string.first {
                firstLetters.append(firstLetter)
            }
        }
        return firstLetters
    }

    func filter(array: [Int], condition: ((Int) -> Bool)) -> [Int] {
        var filteredArray = [Int]()

        for element in array {
            if condition(element) {
                filteredArray.append(element)
            }
        }

        return filteredArray
    }
}

// Задание 2
internal enum Genres {
    case history
    case science
    case fantasy
    case horror
    case adventure
    case classic
}

internal enum VisitorType {
    case schoolStudent
    case student
    case teacher
    case universal
}

internal enum BookStatus {
    case available
    case borrowed
    case overdue
}

protocol LibraryProtocol {
    var name: String { get }
    var visitorsDataBase: [Visitor] { get }
    var bookStorage: [Printable] { get }
    mutating func addVisitor(visitor: Visitor)
    mutating func addBook(book: Printable)
}

protocol Printable {
    var title: String { get }
    var author: Author { get }
    var year: Int { get }
    var isbn : Int { get }
    var genre: Genres { get }
    func printDetails()
}

private struct Library: LibraryProtocol {
    var name: String
    var visitorsDataBase: [Visitor] = []
    var bookStorage: [Printable] = []

    mutating func addVisitor(visitor: Visitor) {
        visitorsDataBase.append(visitor)
    }

    mutating func addBook(book: Printable) {
        bookStorage.append(book)
    }
}

internal class Publication: Printable {
    var title: String
    var author: Author
    var year: Int
    var isbn: Int
    var genre: Genres
    var status: BookStatus

    init(title: String, author: Author, year: Int, isbn: Int, genre: Genres, status: BookStatus) {
        self.title = title
        self.author = author
        self.year = year
        self.isbn = isbn
        self.genre = genre
        self.status = status
    }

    func printDetails() {
        print("""
Title: \(title)
Author: \(author)
"Year: \(year)
Type: \(genre)
"""
        )
    }
}

internal struct Author {
    let name: String
    let surname: String
}

internal class Book: Publication {
    var pageCount: Int
    var publisher: String

    init(title: String, author: Author, year: Int, isbn: Int, genre: Genres, status: BookStatus, pageCount: Int, publisher: String) {
        self.pageCount = pageCount
        self.publisher = publisher
        super.init(title: title, author: author, year: year, isbn: isbn, genre: genre, status: status)
    }

    override func printDetails() {
        super.printDetails()
        print("Page Count: \(pageCount)")
        print("Publisher: \(publisher)")
    }
}

internal final class BookToSell: Book {
    let price: Double

    init(title: String, author: Author, year: Int, isbn: Int, genre: Genres, status: BookStatus, pageCount: Int, publisher: String, price: Double) {
        self.price = price
        super.init(title: title, author: author, year: year, isbn: isbn, genre: genre, status: status, pageCount: pageCount, publisher: publisher)
    }

    override func printDetails() {
        super.printDetails()
        print("Also you can buy it")
    }
}

internal final class Magazine: Publication {
    var issueNumber: Int

    init(title: String, author: Author, year: Int, isbn: Int, genre: Genres, status: BookStatus, issueNumber: Int) {
        self.issueNumber = issueNumber
        super.init(title: title, author: author, year: year, isbn: isbn, genre: genre, status: status)
    }

    override func printDetails() {
        super.printDetails()
        print("Issue Number: \(issueNumber)")
    }
}

internal final class NewsPapper: Publication {
    var edition: String

    init(title: String, author: Author, year: Int, isbn: Int, genre: Genres, status: BookStatus, edition: String) {
        self.edition = edition
        super.init(title: title, author: author, year: year, isbn: isbn, genre: genre, status: status)
    }

    override func printDetails() {
        super.printDetails()
        print("Edition: \(edition)")
    }
}

internal struct Visitor {
    let name: String
    let status: VisitorType
    var takenBooks: [Publication] = []

    mutating func takeABook(book: Publication) {
        takenBooks.append(book)
    }
}
