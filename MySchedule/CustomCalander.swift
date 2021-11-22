//
//  CustomCalander.swift
//  MySchedule
//
//  Created by Jackson on 17/11/2021.
//

import SwiftUI

struct CustomCalender: View {
    private let gridItems = Array(repeating: GridItem(.flexible()), count: 7)
    private let weekdayts = ["Sun","Mon","Tue","Wed","Thu","Fir","Sat"]
    
    @EnvironmentObject var vm : ScheduleVM
    @State private var monthIndex = 0
    @State private var currentDate : Date = Date()
    @State private var addTask : Bool = false
    @Binding var showNav : Bool
    @Binding var animateBackground : Bool
    @Binding var animatePath : Bool
    var body: some View {
        
        ZStack(alignment:.bottomTrailing){
            VStack(alignment:.leading){
                HStack(){
                    Button(action:{
                        withAnimation{
                            self.animateBackground.toggle()
                        }
                        
                        withAnimation(.spring()){
                            self.showNav.toggle()
                        }
                        
                        withAnimation(Animation.interactiveSpring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3).delay(0.2)){
                            self.animatePath.toggle()
                        }
                    }){
                        ZStack{
                            Circle()
                                .fill(Color("MenuButton"))
                                .frame(width: 100, height: 100)
                                
                         
                            Image(systemName: "list.bullet.indent")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .font(.title2)
                                .offset(x:5,y:15)

                        }
                        .padding(.bottom,-50)
                        .offset(x: -20, y: -40)
                    }

                    Spacer()
                    
                    Button(action:{
                        withAnimation{
                            self.addTask.toggle()
                        }
                    }){
                        ZStack{
                            Circle()
                                .fill(Color("AddButton"))
                                .frame(width: 100, height: 100)
                                
                         
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .font(.title2)
                                .offset(x:-5,y:15)
                        }
                        .padding(.bottom,-50)
                        .offset(x: 20, y: -40)
                    }
                }
                
                HStack{
                    Button(action:{
                        withAnimation{
                            self.monthIndex  = self.monthIndex-1
                        }
                    }){
                        Image(systemName: "arrowtriangle.left.fill")
                            .foregroundColor(Color("ThemeColor"))
                            .font(.title)
                    }
                    .padding(.leading,5)
                    Spacer()
                    VStack(alignment:.center){
                        Group{
                            Text(extraDateFormat()[0])
                                .font(.footnote)
                                .foregroundColor(.white)
                            
                            Text(extraDateFormat()[1])
                                .bold()
                                .foregroundColor(.white)
                                .font(.title)
                            
                        }
                        .padding(.leading,5)
                    }
              
                    Spacer()
                    Button(action:{
                        withAnimation{
                            self.monthIndex  = self.monthIndex + 1
                        }
                    }){
                        Image(systemName: "arrowtriangle.right.fill")
                            .foregroundColor(Color("ThemeColor"))
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.trailing,5)
                }

                Divider()
                    .background(Color("ThemeColor"))
                    .padding(.horizontal)
                
                HStack{
                    ForEach(weekdayts,id:\.self){ day in
                        Text(day)
                            .bold()
                            .font(.callout)
                            .frame(maxWidth:.infinity)
                            .foregroundColor(.white)
                    }
                }
                
                
                LazyVGrid(columns: gridItems,spacing:15){
                    ForEach(self.extraDate()){ value in
                        
                        CardView(value:value)
                            .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.blue) .opacity(isSameDay(day1: self.currentDate, day2: value.date) ? 1 : 0))
                            .onTapGesture {
                                self.currentDate = value.date
                            }
    //
                            
                    }
                }
                Spacer()

            }
            .edgesIgnoringSafeArea(.top)
            .onChange(of: self.monthIndex){newvalue in
                currentDate = getCurrentMonth()
            }

            TaskView(addTask: self.$addTask, currentDate: $currentDate)
          

        }
        .background(Color("Background").edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $addTask, content: {
            AddTaskView(dismiss: self.$addTask)
        })
        .edgesIgnoringSafeArea(.all)


    }
    
    
    @ViewBuilder
    func CardView(value : DateModel) -> some View{
        VStack{
            if value.day != -1 {
                
                if let _ = self.vm.allSchedule.first(where:{task in
                    return isSameDay(day1: value.date, day2: task.date)
                }){
                    //is same date
                    Text(value.day.description)
                        .foregroundColor(isSameDay(day1: self.currentDate, day2: value.date) ? Color.orange : isSameDay(day1: Date(), day2: value.date) ? Color.red : Color.white)
                        .font(.footnote)
                        .bold()
                        .frame(maxWidth:.infinity)
                    
                    Spacer()
                        
                    Circle()
                        .fill(isSameDay(day1: Date(), day2: value.date) ? Color.red : Color.blue)
                        .frame(width: 8, height: 8)
                    
                }else{
                    //Not the same day
                    //no task is set
                    
                    Text(value.day.description)
                        .foregroundColor(isSameDay(day1: self.currentDate, day2: value.date) ? Color.orange : isSameDay(day1: Date(), day2: value.date) ? Color.red : Color.white)
                        .font(.footnote)
                        .font(.body)
                        .bold()
                        .frame(maxWidth:.infinity)
                }
            }
        }
        .padding(.vertical,4)
        .frame(height:40,alignment: .top)

    }
    
    func isSameDay(day1 : Date, day2 : Date) -> Bool {
        let calender = Calendar.current
        return calender.isDate(day1, inSameDayAs: day2)
    }
    
    func extraDate() -> [DateModel]{
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDate().compactMap{date -> DateModel in
            let day = calendar.component(.day, from: date)
            return DateModel(day: day, date: date)
        }
        
        let firstWeek = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeek-1{
            days.insert(DateModel(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let month = calendar.date(byAdding: .month, value: self.monthIndex, to: Date()) else {
            return Date()
        }
        
        return month
    }
    
    func extraDateFormat() -> [String] {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY MMMM EEEE"
        
        let dateString = dateFormatter.string(from: self.currentDate)
        
        return dateString.components(separatedBy: " ")
    }
    
}

//struct CustomCalander_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        CustomCalender()
//            .environmentObject(ScheduleVM())
//    }
//}

struct TaskView : View{
    @EnvironmentObject var vm : ScheduleVM
    @Binding var addTask : Bool
    @State private var offset : CGFloat = 0.0
    @State private var tempOffset : CGFloat = 0.0
    @GestureState private var gestureOffset : CGFloat = 0.0
    @Binding var currentDate : Date
    var body: some View{
        return AnyView(
            GeometryReader{proxy in
                let height = proxy.frame(in:.global).height
                let maxHeight = (height / 1.75) - 120
                VStack(){
    //                Spacer()
                    Capsule()
                        .fill(Color.white.opacity(0.65))
                        .frame(width:50,height:5)


                    HStack{
                        Text("Tasks(\(extraDateFormate()[2]))")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.white)
                        Spacer()
                        
                        //Add to current Date
                        Button(action:{
                            withAnimation(){
                                self.addTask.toggle()
                            }
                        }){
                            
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .font(.title2)
                            
                        }
                    }
                    .padding(.horizontal)
                    Divider()
                        .background(Color("ThemeColor"))
                        .padding(.horizontal)

                    if let tasks = self.vm.allSchedule.first(where: {task in
                        return isSameDay(day1: self.currentDate, day2: task.date)
                    }){
                        GeometryReader{geo in
                            ScrollView(.vertical, showsIndicators: false){
                                ForEach(tasks.todoData,id:\.id){info  in

                                    HStack(alignment:.center){
                                        Circle()
                                            .fill(info.color)
                                            .frame(width: 8, height: 8)
                                            .padding(.horizontal,5)
                                            .padding(.leading,3)
                                        VStack(alignment:.leading,spacing:10){
                                            Text(info.title)
                                                .strikethrough(info.isDone, color: .red)
                                                .font(.body)
                                                .bold()
                                                .foregroundColor(Color.white.opacity(0.75))
                                                .lineLimit(1)
                                            
                                            
                                            //
                                            Text(info.note)
                                                .foregroundColor(.secondary)
                                                .font(.footnote)
                                                .lineLimit(1)
                                        }
                                        .padding(.vertical,8)
//
//
                                        Spacer()
//
                                        Text(self.vm.getDateFormat(date: info.time)[4])
                                            .padding(5)
                                            .background(info.color.cornerRadius(15))

                                        Image(systemName:info.isDone ? "checkmark.circle.fill":"chevron.right")
                                            .foregroundColor(info.isDone ? Color.green : Color.white)
                                            .padding(.trailing)
                                    }
                                    .frame(maxWidth:.infinity)
                                    .background(info.isDone ? Color("Done").cornerRadius(10) : Color("ThemeColor").cornerRadius(10))
                                    .padding(.horizontal)
                                    .padding(.vertical,5)
                                    .onTapGesture(count: 2){
                                        
                                        let listIndex = self.vm.findDate(date: self.currentDate)
                                        if listIndex != -1{
                                            let index = self.vm.allSchedule[listIndex].todoData.firstIndex(where: {$0.id == info.id})
                                            self.vm.allSchedule[listIndex].todoData[index!].isDone.toggle()
                                        }
                                    }
                   

                                }
                            }
                            .frame(height:geo.frame(in: .global).height - 65)
                          
                        }

                        
                    }else{
                        Text("No Daliy Tasks")
                            .foregroundColor(Color.gray.opacity(0.65))
                            .font(.title2)
                            .bold()

                    }
                    Spacer()

                }
                .padding(.top)
                .background(Color("CardColor").clipShape(CustomConer(coners: [.topLeft,.topRight])).edgesIgnoringSafeArea(.bottom))
                .offset(y:height / 1.75)
                .offset(y:-offset > 0 ? -offset <= maxHeight ? offset : -maxHeight : 0 )
                .gesture(DragGesture().updating($gestureOffset, body: { value,out,_ in
                    out = value.translation.height
                    onChange()
                }).onEnded({value in
                    //Condition
                    print(offset)
                    let maxHeight = (height / 1.75) - 120
                    withAnimation{
                        if -offset > maxHeight / 2{
                            offset = -maxHeight
                        }else{
                            offset = 0
                        }

                        self.tempOffset = offset

                    }
//                    self.offset = 0
                }))
               
                
            }
        )

    }
    
    func onChange(){
        DispatchQueue.main.async {
            self.offset = self.gestureOffset + self.tempOffset
        }
    }
    
    func isSameDay(day1 : Date, day2 : Date) -> Bool {
        let calender = Calendar.current
        return calender.isDate(day1, inSameDayAs: day2)
    }

    func extraDateFormate() -> [String] {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "YYYY MMMM EEEE"

        let dateString = dateFormatter.string(from: self.currentDate)

        return dateString.components(separatedBy: " ")
    }
}

struct AddTaskView : View{
    
    @Binding var dismiss : Bool
    @EnvironmentObject var vm : ScheduleVM
    @State private var title : String = ""
    @State private var note : String = "Note Here..."
    @State private var taskDate = Date()
    @State private var taskTime = Date()
    @State private var color = Color.blue
    var body: some View {
        VStack{
            HStack{
                Text("Add Task")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.vertical,8)
                
                ColorPicker("Select a color", selection: $color)
                    .labelsHidden()
                Spacer()
                
                Button(action: {
                    withAnimation{
                        //dissmiss the view
                        self.dismiss.toggle()
                        
                    }
                }){
                    Image(systemName: "xmark")
                       
                        .foregroundColor(.white)
                        .font(.title2)
                }
            }
            .padding(.horizontal)
        
            VStack(spacing:0){
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        Group{
                            DatePicker("Date", selection: $taskDate, in :Date()...)
                                .datePickerStyle(GraphicalDatePickerStyle())
//                                .labelsHidden()
                            
                            VStack{
                                HStack{
                                    Text("Title")
                                        .font(.headline)
                                        .bold()
                                    Spacer()
                                }
                                VStack{
                                    TextField("Task Title", text: $title)
                                        .background(Color(UIColor.systemGray4))
                                    
                                }.padding()
                                .background(Color(UIColor.systemGray4))
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(Color(UIColor.systemGray4)))
                            }
                            .padding(.bottom)
                            
                            HStack{
                                Text("Note")
                                    .font(.headline)
                                    .bold()
                                Spacer()
                            }
                            VStack{
                                TextEditor(text: $note)
                                    .foregroundColor(.secondary)
                                    .colorMultiply(Color(UIColor.systemGray4))
                                    .frame(height:200)
                            }.padding()
                            .background(Color(UIColor.systemGray4))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(Color(UIColor.systemGray4)))
                            
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        Spacer()
                        
                    }
                    .padding(.vertical)
                }

                Button(action:{
                    //Find the date
                    //append the struct to the list
                    var task : TaskInfo
                    let taskInfo = TaskInfoDate(title: title, note: note, time: taskDate, color: color, isDone: false)
                    let index = vm.findDate(date: self.taskDate)
                    if index == -1{
                        //No exist any task in that day
                        //Create an info
                        task = TaskInfo(date: self.taskDate, todoData: [
                            taskInfo
                        ])
                        self.vm.allSchedule.append(task)

                    }else{
                        self.vm.allSchedule[index].todoData.append(taskInfo)
                    }

                    withAnimation{
                        //dissmiss the view
                        self.dismiss.toggle()
                        
                    }
                }){
                    VStack{
                        Text("Add")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(width:UIScreen.main.bounds.width / 2,height:50)
                    .background(Color.blue)
                    .cornerRadius(15)
                    
                }
                .padding(.vertical)
            }
            .padding(.top,15)
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(Color.white.clipShape(CustomConer(coners: [.topLeft,.topRight])).edgesIgnoringSafeArea(.bottom))
            


        }
        .padding(.top,20)
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(Color("Background").edgesIgnoringSafeArea(.all))
        .onAppear(){
            UITableView.appearance().backgroundColor = .clear
        }
    }
    
}

struct TaskField : View{
    var header : String
    var plachHolder : String
    @Binding var text : String
    var body: some View {
        VStack{
            HStack{
                Text(header)
                    .font(.title3)
                    .bold()
                Spacer()
            }
            VStack{
                TextField(plachHolder, text: $text)
                    .background(Color(UIColor.systemGray4))
            }.padding()
            .background(Color(UIColor.systemGray4))
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(Color(UIColor.systemGray4)))
        }
        .padding(.bottom)

    }
    
}


extension Date{
    func getAllDate() -> [Date] {
        let current = Calendar.current
        
        let startDate = current.date(from: Calendar.current.dateComponents([.year,.month],from: self))!
        print(startDate)
        
        let range = current.range(of: .day, in: .month, for: startDate)!
        
//        range.removeLast()
        
        return range.compactMap{ day -> Date in
            print(day)
            return current.date(byAdding: .day, value: day-1, to: startDate)!
            
        }
    }
}
