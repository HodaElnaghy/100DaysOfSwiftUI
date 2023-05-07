//
//  ContentView.swift
//  Day17
//
//  Created by Hend on 03/05/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused : Bool
    typealias DodoType = FloatingPointFormatStyle<Double>.Currency
    var currencyFormat : DodoType {
        let formatting = DodoType(code: Locale.current.currency?.identifier ?? "USD")
        return formatting
    }
    

    
    
    var totalPerPerson : Double {
        //calculate the total per person
        let peopleCount = Double (numberOfPeople + 2)
        let tipSelection =  Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var total : Double {
        let peopleCount = Double (numberOfPeople + 2)
        let tipSelection =  Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    
    
    var body: some View {
        NavigationView {
            
            Form {
                Section{
                    TextField("Amount", value: $checkAmount, format: currencyFormat )
                    
                    //code is String
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    Picker("Select a tip percentage", selection: $tipPercentage){
                        ForEach(0..<101, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                
                }
                header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section{
                    Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                header: {
                    Text("Total amount")
                }
                
                
                Section{
                    Text(totalPerPerson , format: currencyFormat)
                }
                header: {
                    Text("Amount Per Person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup (placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        amountIsFocused = false
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
