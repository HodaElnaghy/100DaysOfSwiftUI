import Cocoa

let thre = "fizz"
let fi = "buzz"
let thfi = "\(thre)\(fi)"
for i in 1...100{
    if (i%3 == 0 && i%5 == 0){
        print(thfi)
    }
    else if (i%3 == 0){
        print(thre)
    }
    else if (i%5 == 0){
        print(fi)
    }
    else{
        print (i)
    }
}

func buyCar(price: Int) {
    switch price {
    case 0...20_000:
        print("This seems cheap.")
    case 20_001...50_000:
        print("This seems like a reasonable car.")
    case 50_001...100_000:
        print("This had better be a good car.")
    default:
        print("HI")
    }
}
