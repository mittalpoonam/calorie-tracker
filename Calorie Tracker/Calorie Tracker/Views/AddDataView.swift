//
//  AddDataView.swift
//  Calorie Tracker
//
//  Created by poonam mittal on 14/02/24.
//

import SwiftUI

struct AddDataView: View {
    
    //MARK: PROPERTIES
    
    @State var selection: String = "Add Food"
    let filterOptions: [String] = ["Add Food", "Add Activity"]
    let filterOptionForMealType: [String] = ["Breakfast", "Lunch", "Dinner"]

    @State var foodGroup: String = ""
    @State var calorieModel = foodCalorieModel()
    @State var metValueMODEL = MetValuesModel(sheet1: [])
    @State var showAlert: Bool = false
    @State var individualUser: User
    @State var metValue: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @State var calorieIn: String = ""
    @State var serving: String = ""
    @State var allStrings:[String] = []
    @State var allStringsForActivity: [String] = []
    
    @State private var searchText = ""
    @State private var searchResults: [String] = []
    @State private var searchTextForActivity = ""
    @State private var searchResultsForActivity: [String] = []
    @State private var showProgressView: Bool = false
    @State private var isListVisible = true
    @State private var isListVisibleForActivity = true
    
    @StateObject var foodDetailVM = FoodDetailViewModel()
    @StateObject var activityDetailVM = ActivityDetailViewModel()
    @StateObject var userDetailVM = UserDetailViewModel()
    @StateObject var jsonVM = JSONViewModel()
    @Environment(\.presentationMode) var presentationMode
   
     
    //MARK: BODY SECTION
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack {
              addSegmentedPicker
                if showProgressView {
                    ProgressView{
                        Text("Loading")
                            .foregroundColor(.blue)
                    }
                       
                }
                if selection == filterOptions[0]{
                    addFoodContent
                }else{
                    addActivityContent
                }
                Spacer()
            }
            .alert(isPresented: $showAlert) {
                showAlert(title: "wrong input")
            }
            .navigationTitle("Add Data")
        }
        .onAppear {
            loadData()

        }
   }
}
    

struct AddDataView_Previews: PreviewProvider {
    static var previews: some View {
        AddDataView(individualUser: User())
    }
}

//MARK: COMPONENETS
extension AddDataView {
    
    private var addSegmentedPicker: some View {
        Picker(selection: $selection) {
            ForEach(filterOptions.indices) { index in
                Text(filterOptions[index]).tag(filterOptions[index])
            }
                
        } label: {
           
            Text("Picker")
        }
        .pickerStyle(SegmentedPickerStyle())
        .background(Color.white)
        .padding()
    }
    
    private var addFoodContent: some View {
        
        VStack {
            HStack {
                Text("Select Date")
                Spacer()
                DatePicker("", selection: $foodDetailVM.date, displayedComponents: .date)
            }

            HStack {
                Text("Select Food Name")
                Spacer()
                searchContentOfFoodName
            }
            
            HStack {
                Text("Select Meal Type")
                Spacer()
                
                Picker(selection: $foodDetailVM.mealType) {
                    ForEach(filterOptionForMealType.indices) { index in
                        Text(filterOptionForMealType[index]).tag(filterOptionForMealType[index])
                    }
                } label: {
                    Text("Picker")
                }
                .frame(width: 150)
                .background()
                
            }
            
            HStack {
                Text("Select Food Group")
                Spacer()
                TextField("Food Group", text: $foodGroup)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .frame(width: 150)
                    .background(Color.white)
          
            }
            
            HStack {
                Text("Serving")
                Spacer()
                TextField("Serving", text: $serving)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .frame(width: 150)
                    .background(Color.white)
            }
          
            
            HStack {
                Button {
                    
                    if let calorie = Float(calorieIn),
                       let serve = Float(serving)
                       
                    {
                        
                        if let id = individualUser.userId {
                            foodDetailVM.userId = id
                        }
                        let totalCalorieInAccToServe = (serve * calorie)
                        foodDetailVM.serving = String(serve)
                        foodDetailVM.calorieIn = String(totalCalorieInAccToServe)
                        
                        foodDetailVM.foodName = searchText
                        foodDetailVM.foodGroup = foodGroup
                        
                        foodDetailVM.save()
                      
                        presentationMode.wrappedValue.dismiss()
                        
                    }else{
                        showAlert = true
                    }

                } label: {
                    Text("Save")
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(20)
                        .padding(.vertical, 50)
                       
                }

            }
        }
    }
    
    private var searchContentOfFoodName: some View {
        VStack {
               TextField("Food Name", text: $searchText)
                   .padding()
                   .onChange(of: searchText, perform: { value in
                       searchResults = allStrings.filter { $0.lowercased().contains(value.lowercased()) }
                       if !value.isEmpty {
                         searchResults.sort { $0.lowercased().hasPrefix(value.lowercased()) && !$1.lowercased().hasPrefix(value.lowercased()) }
                                 }
                       isListVisible = true
                   })
                   .padding(.horizontal, 5)
                   .padding(.vertical, 5)
                   .frame(width: 150)
                   .background(Color.white)

               if isListVisible && !searchResults.isEmpty {
                   List {
                       ForEach(searchResults, id: \.self) { result in
                           Text(result)
                               .onTapGesture {
                                   searchText = result
                                   isListVisible = false
                                   selectingFoodGroup(foodName: searchText)
                               }
                       }
                   }
               }
            
           
            
//            if searchResults.isEmpty && isListVisible {
//               Text("No results found")
//                   .foregroundColor(.black)
//                   .padding()
//                }
           }
    }

    private var searchContentForActivity: some View {
        VStack {
               TextField("Activity Name", text: $searchTextForActivity)
                   .padding()
                   .onChange(of: searchTextForActivity, perform: { value in
                       searchResultsForActivity = allStringsForActivity.filter { $0.lowercased().contains(value.lowercased()) }
                       if !value.isEmpty {
                         searchResultsForActivity.sort { $0.lowercased().hasPrefix(value.lowercased()) && !$1.lowercased().hasPrefix(value.lowercased()) }
                                 }
                       isListVisibleForActivity = true
                   })
                   .padding(.horizontal, 5)
                   .padding(.vertical, 5)
                   .frame(width: 150)
                   .background(Color.white)

               if isListVisibleForActivity && !searchResultsForActivity.isEmpty {
                   List {
                   ForEach(searchResultsForActivity, id: \.self) { result in
                       Text(result)
                           .onTapGesture {
                               searchTextForActivity = result
                               isListVisibleForActivity = false
                               selectingActivityDescription(activityName: searchTextForActivity)
                           }
                   }
                   }
               }
           }
    }

    
    private var addActivityContent: some View {
        VStack {
            HStack {
                Text("Select Date")
                Spacer()
                DatePicker("", selection: $activityDetailVM.date, displayedComponents: .date)
            }
            HStack {
                Text("Activity Name")
                Spacer()
                searchContentForActivity
                
            }
            
            HStack {
                Text("Activity Description")
                Spacer()
                TextField("Description", text: $activityDetailVM.activityDesc)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .frame(width: 150)
                    .background(Color.white)
            }
            
      
            HStack {
                Text("MET Value")
                Spacer()
                TextField("value", text: $metValue)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .frame(width: 150)
                    .background(Color.white)
            }
            HStack {
                Text("Start Time")
                Spacer()
                DatePicker("", selection: $startDate, displayedComponents: [.hourAndMinute])
            }
            
            HStack {
                Text("End Time")
                Spacer()
                DatePicker("", selection: $endDate, displayedComponents: [.hourAndMinute])
            }
            
            
            HStack {
                Button {
                    
                    if let met = Float(metValue)
                    {
                        
                        if let id = individualUser.userId {
                            activityDetailVM.userId = id
                        }
                       
                        activityDetailVM.metValue = String(met)
                        activityDetailVM.startTime = startDate
                        activityDetailVM.endTime = endDate
                        
                       
                        if let unwrapMetValue = Float(metValue),
                           let unwrapWeight1 = individualUser.weight
                        {
                            if let unwrapWeight2 = Float(unwrapWeight1) {
                                let calorieOut = CommonFuncs.calculateCaloriesOutDuringActivities(metValue: unwrapMetValue, weight: unwrapWeight2 , startDate: startDate, endDate: endDate)
                                
                                activityDetailVM.calorieOut = String(format: "%.2f" , calorieOut)
                            }
                        }
                        activityDetailVM.save()
                       
                        presentationMode.wrappedValue.dismiss()
                        print(URL.documentsDirectory)
                       
                    }else{
                       
                        showAlert = true
                    }

                } label: {
                    Text("Save")
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(20)
                        .padding(.vertical, 50)
                       
                }

            }
        }
    }
}


extension AddDataView {
    func showAlert(title: String) -> Alert {
        return Alert(title: Text(title))
    }
}

//MARK: FUNCTIONS
extension AddDataView {
    
    func loadData() {
        showProgressView = true
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        jsonVM.fetchDataFromFoodJSON { foodCalorieModel in
            defer {
                dispatchGroup.leave()
            }
            
            if let foodCalorieModel = foodCalorieModel {
                calorieModel = foodCalorieModel
                allStrings = foodCalorieModel.map { $0.name }
            } else {
                print("Failed to fetch food calorie data.")
            }
        }
        
        dispatchGroup.enter()
        jsonVM.fetchDataFromActivityJSON { metValues in
            defer {
                dispatchGroup.leave()
            }
            
            if let metValues = metValues {
                metValueMODEL = metValues
                allStringsForActivity = (metValues.sheet1).map { $0.specificMotion }
            } else {
                print("Failed to fetch met value data.")
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            // This closure will be called when both fetch operations are completed
            showProgressView = false
        }
    }
    
    func selectingFoodGroup(foodName: String){
        let filteredModel = calorieModel.filter{ $0.name == foodName}
        for model in filteredModel {
            foodGroup = (model.foodGroup).rawValue
            calorieIn = String(model.calories)
        }
    }
    
    func selectingActivityDescription(activityName: String) {
        let filterModel = (metValueMODEL.sheet1).filter{ $0.specificMotion == activityName}
        
        for model in filterModel {
            activityDetailVM.activityDesc = (model.activity).rawValue
            metValue = String(model.meTs)
            
        }
        
    }
}

