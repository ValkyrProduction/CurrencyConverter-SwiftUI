import SwiftUI // Importing the SwiftUI framework for building the user interface

// Main view struct for the currency converter
struct ContentView: View {
    // Selected index for the "from" currency
    @State private var itemSelected = 0
    
    // Selected index for the "to" currency
    @State private var itemSelected2 = 1
    
    // User input for the amount to convert (as a string)
    @State private var amount : String = ""
    
    // Array of available currencies
    private let currencies = ["USD", "EUR", "GBP"]
    
    // Function to perform the currency conversion
    func convert(_ convert: String) -> String {
        var conversion: Double = 1.0 // Default value
        
        // Convert input string to Double
        let amount = Double(convert.doubleValue)
        
        // Determine selected currencies
        let selectedCurrency = currencies[itemSelected]
        let to = currencies[itemSelected2]
        
        // Exchange rates with base currency as key
        let eurRates = ["USD": 1.15,"EUR": 1.0, "GBP": 0.84]
        let usdRates = ["USD": 1.0,"EUR": 0.87, "GBP": 0.73]
        let gbpRates = ["USD": 1.37,"EUR": 1.18, "GBP": 1.0]
        
        // Use the appropriate rate depending on selected base currency
        switch (selectedCurrency) {
        case "USD":
            conversion = amount * (usdRates[to] ?? 0.0)
        case "EUR":
            conversion = amount * (eurRates[to] ?? 0.0)
        case "GBP":
            conversion = amount * (gbpRates[to] ?? 0.0)
        default:
            print("Something went wrong!") // fallback error message
        }

        // Format and return the converted amount as a string with 2 decimal places
        return String(format: "%.2f", conversion)
    }
    
    // Main view layout
    var body: some View {
        NavigationView { // Provides navigation bar functionality
            Form { // Displays input fields in a grouped list style
                Section(header: Text("Convert a currency")) {
                    // Input field for the user to enter amount
                    TextField("Enter an amount", text: $amount)
                        .keyboardType(.decimalPad) // Shows decimal pad keyboard
                    
                    // Picker to choose the currency to convert from
                    Picker(selection: $itemSelected, label: Text("From")) {
                        ForEach(0 ..< currencies.count) { index in
                            Text(self.currencies[index]).tag(index) // Assign tag for selection
                        }
                    }
                    
                    // Picker to choose the currency to convert to
                    Picker(selection: $itemSelected2, label: Text("To")) {
                        ForEach(0 ..< currencies.count) { index in
                            Text(self.currencies[index]).tag(index)
                        }
                    }
                }
                
                // Section to display the converted amount
                Section(header: Text("Conversion")) {
                    Text("\(convert(amount)) \(currencies[itemSelected2])")
                }
            }
        }
        
        // Empty VStack (can be removed unless you plan to add something here)
        VStack {
        }
    }
}

// Preview provider to show the layout in Xcode preview
#Preview {
    ContentView()
}
