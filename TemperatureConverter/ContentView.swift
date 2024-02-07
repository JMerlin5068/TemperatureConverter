//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Student on 2/6/24.
//

import SwiftUI

struct ContentView: View {

    // Declare State variables for input and establish a default value for each.
    @State private var inputTemperature = 0.0
    @State private var inputUnits = "C"
    @State private var outputUnits = "C"

    // Array with the initial of the type of units we can convert to and from.
    let unitsTemperature = ["C","F","K"]

    // Declare Focus State variable to dismiss numeric keyboard
    @FocusState private var inputTemperatureFocused: Bool

    // Calculated Property with the temperature converted to the unit selected.
    var outputTemperature: Double {
        // Variable to hold the temperature in our intermediate unit Cº
        var temperatureInCelsius = 0.0

        // Converting from any unit to celsius
        if inputUnits == "F" { // from Fahrenheit
            temperatureInCelsius = (inputTemperature - 32) * 5/9
        } else if inputUnits == "K" { // from Kelvin
            temperatureInCelsius = inputTemperature - 273.15
        } else { // from Celsius
            temperatureInCelsius = inputTemperature
        }

        // Converting from celsius to the desired unit and returning the value.
        if outputUnits == "F" { // to Fahrenheit
            return temperatureInCelsius * 9/5 + 32
        } else if outputUnits == "K" { // to Kelvin
            return temperatureInCelsius + 273.15
        } else { // to Celsius
            return temperatureInCelsius
        }

    }

    var body: some View {
        NavigationView { // Container to prevent scroll over the unsafe area
            Form { // Simple form to hold the view divided in four sections
                Section { // Picker to choose the input units
                    Picker("Units", selection: $inputUnits){
                        ForEach(unitsTemperature,id:\.self){
                            Text("º\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("units")
                }
                Section { // Field to recieve the temperature written by user
                    TextField("Temperature in \(inputUnits)º", value: $inputTemperature, format: .number)
                        .keyboardType(.decimalPad) // Since numeric field, show decimal pad
                        .focused($inputTemperatureFocused) //Beats me???
                }
                Section { // Picker to choose the output units
                    Picker("Units", selection: $outputUnits){
                        ForEach(unitsTemperature,id:\.self){
                            Text("º\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert to")
                }
                Section { // Place to show the numeric output of the conversion.
                    Text(outputTemperature, format: .number)
                }
            }
            .toolbar { // Enable toolbar and button to dismiss popup keyboard.
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        inputTemperatureFocused = false
                    }
                }
            }
            .navigationTitle("TempConvert") // Title to our form.
        }
    }

}
