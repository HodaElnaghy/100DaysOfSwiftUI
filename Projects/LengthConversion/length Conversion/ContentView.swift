//
//  ContentView.swift
//  length Conversion
//
//  Created by Hend on 06/05/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var valueToConvert = 200.0
    private let units = [UnitLength.meters, UnitLength.feet, UnitLength.miles, UnitLength.yards, UnitLength.kilometers]
    @State private var selectedUnit = UnitLength.meters
    
    @State private var outputUnit = UnitLength.meters
    @FocusState private var isFocused : Bool
    
    
    var computedDistance: Double {
        
        let distance = Measurement (value: valueToConvert, unit: selectedUnit)
        let ouput = distance.converted(to: outputUnit)
        return ouput.value
    }
    
    
    var body: some View {
        NavigationView{
            Form{
                
                Section{
                    TextField("Enter value", value: $valueToConvert, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("Select a unit", selection: $selectedUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                    }
                    header :{
                        Text("Enter a value")
                }
                
                
                Section{
                    Picker("Select a unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
             
                    }
                
            header: {
                Text("Convert to:")
            }
                Section{
                    Text("\(computedDistance) \(outputUnit.symbol)" )
                }
                
                
                .navigationTitle("Converter")
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        Button("Done"){
                            isFocused = false
                        }
                    }
                }
            }
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
