import Cocoa

enum SquareRootError : Error{
    case outOfBoundary, noRoot
}

func squareRoot (_ number:Int)throws -> Int{
    var x = 0
    switch number {
    case 1:
        return 1
        
    case 2...10_000:
        
        for i in 1...number/2{
            if number%i == 0 {
                x = number/i
                if x == i {
                    return x
                }
            }
        }
        throw SquareRootError.noRoot
    default:
        throw SquareRootError.outOfBoundary
    }
    
}

do {
    let result = try squareRoot(26)
    print(result)
    
}
catch {
    print(error)
}
