import Cocoa

var valueToConvert = 200.0
let units = [UnitLength.meters]
var selectedUnit = UnitLength.feet

var outputUnit = UnitLength.meters
var inputUnitLength = ""

var convertedValue = 20.0

var computedDistance: Measurement<UnitLength> {

    print(inputUnitLength)
    let distance = Measurement(value: valueToConvert, unit:selectedUnit)

    return distance.converted(to: outputUnit)
}

print(computedDistance) // Call computedDistance with
