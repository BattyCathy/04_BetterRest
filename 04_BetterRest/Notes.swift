//
//  Notes.swift
//  04_BetterRest
//
//  Created by Austin Roach on 1/29/21.
//

import Foundation


//Day 26 Project 4, part 1

//We're starting a new project today, and we're going to add some more SwiftUI skills to your collection while also tackling a fascinating area of programming: machine learning.

//Nick Bostrom, as Swedish professor teaching at Oxford University, once said "machine intelligence is the last invention that humanity will ever need to make." Is that true? Well, it's certainly true that if we can teachc omputers to think competently enough it would remove the need for humans to do that thinking, but on the other hand some might argue most of humanity doesn't do much thinkng in the first place.

//Still, I think you'll be impressed by how easy it is to get started, and how it's a really natural fit inside SwiftUI.

//As a side not, I want to add that by now you're starting to settling into the frequency of this course: some studying, some app building, a technique project, the consolidation - all repeated several times over.

//However I wanted to say that if at any point you're feeling tired, or life just gets in the way, take a break! If you come back to your coe in a day or two, you'll be more relaxed and ready to learn. Like I said at the beginning, this is a marathon, not a sprint, and you won't learn effectively if you're stressed.

//Today you'll have five topics to work through, and you;ll meet Stepper, DatePicker, DateFormatter, and more.

//MARK: 1. BetterRest: Introduction

//This SwiftUI project is another forms-based app that will ask the user to enter information and convert that all into an alert, which might sound dull - you've done this already, right?

//Well, yes, but practice is never a bad thing. However, the reason we have a fairly simple project is because I want to introduce you to one of the true power features of iOS development: machine learning (ML).

//All iPhones come with a technology called Core ML built right in, which allows us to write code that makes predictions about new data based on the previous data it has seen. We'll strt with some raw data, give that to our mac as training data, then use the results to build an app able to make accurate estimates about new data - all on one device, and with complete privacy for users.

//The actual app we're building is called BetterRest, and it's designed to help coffee drinkers get a good night's sleep by asking them three questions:

// 1. When do they want to wake up?

// 2. Roughly how many hours of sleep do they want?

// 3. How many cups of coffee do they drink per day?

//Once we have those three values, we'll feed them into Core ML to get a result telling us when they ought to go to bed. If you think about it there are billions of possible aswers - all the various wakes times multiplied by the number of sleep hours, multiplied again by the full range of coffee amounts.

//That's where machine learning comes in: using a technique called gression analysis we can ask the computer to come up with an algorithm able to represent all our data. This in turn allows it to apply the algorithm to fresh data it hasn't seen before, and get accurate results.

//You're going to need to download some files for this project, which you can do from GitHub: https://github.com/twostraws/HackingWithSwift - make sure you look in the SwiftUI section of the files.

//Once you have those, go ahead and create a new single view app template in Xcode called BetterRest. As before we're going to be starting with an overview of the various technologies required to build the ap, so let's get into it...

//MARK: 2. Entering Numbers with Stepper

//SwiftUI has two ways of letting users enter number, and the one we'll be using here is Stepper: a simple - and + button that can be tapped to select a precise number. The other option is Slider, which we'll be using later on - it also lets us select from a range of values, but less precisely.

//Steppers are smart enough to work with any kind of number type you like - you can bind them to Int, Double, and more, and it will automatically adapt. For example, we might create a property like this:

//@State private var sleepAmount = 8.0

//We could then bind that to a stepper so that it showed the current value, like this:

/*
 Stepper(value: $sleepAmount) {
    Text("\(sleepAmount) hours")
 }
 */

//When that code runs you'll see 8.000000 hours, and you can tap the - and + to step downward to 7, 6, 5, into negative numbers, or step upwards to 9, 10, 11, and so one.

//By default Steppers are limited only by the range of their storage. We're using a Double in this example, which means the maximum value of the slider will be 1.7976931348623157e+308. That's scientific notation, but it means 1.79769 times 10 to the power of 308 - or, im simpler terms, A REally Very Large Number Indeed.

//Now, as a father of two kids, I can't tell you how much I love to sleep, but even I can't sleep that much. Fortunately, Stepper lets us limit the values we want to accept by providing an in range, like this:

/*
 Stepper(value: $sleepAmount, in: 4...12) {
    Text("\(sleepAmount) hours")
 }
 */

//With that change, the stepper will start at 8, then allow the user to move between 4 and 12 inclusive, but not beyond. This allows us to control the sleeps range so that users can't try to sleep for 24 hours, but it also lets us reject impossible values - you can't sleep for -1 hours, for example.

//There's a third useful parameter for Stepper, which is a step value - how far to move the value each time - or + is tapped. Again, this can be any sort of number, but is does need to math the tupe used fo the binunding. So, if you are binding to an integer you can't then use a Double for the step value.

//In this instance, we might say that users can select any sleep value between 4 and 12, moving in 15 minute incrememtns:

/*
 Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
    Text("\(sleepAmount) hours")
 }
 */

//That's starting to look useful - we have a precise range of reasonable value, a sensible step incrememtn, and users can see exatly what they have chosen each time.

//Before we move on, though, let's fix that text: it says 8.000000 right now, which is accurate, but a little too accurate. Previously we used a string intepolation specifier such as this:

//Text("\(sleepAmount, specifier: "%.2f") hours")

//We could use that here, but it looks odd: "8.00 hours" seems overly clinical. This is a good ecample where the "%g" specifier is useful because it automatically removes insignificant zeroes from the end of the number. So, it will show 8, 8.25, 8.5, 8.75, 9, and so one, which is much more natural for users to read.


//MARK: 3. Selecting Dates and Times with DatePicker

//SwiftUI gives us a dedicated picker type called DatePicker that can be bound to a date property. Yes, Swift has a dedicated type for working with date, and it's called - unsurprisingly - Date.

//So, to use it you'd start with an @State property such as this:

//@State private var wakeUp = Date()

//You could then bind that to a date picker like this:

/*
 var body: some View {
    DatePicker("Please enter a date", selection: $wakeUp)
 }
 */

//Try running in the simulator so you can see how it looks. You should see a spinning wheel with days and times, plus the "Please enter a date" label on the left.

//Now, you might think that label looks ugly, and try replacing it with this:

//DatePicker("", selection: $wakeUp)

//But if you do that you now have two problems: the date picker still makes space for a label even though it's empty, and now users with the screen reader active (more familiar to us as VoiceOver) won't have any idea what the date picker is for.

//There are two alternative, both of which solve the problem.

//First, we can wrap the DatePicker in a Form:

/*
 var body: some View {
    Form {
        DatePicker("Please enter a date", selection: $wakeUp)
    }
 }
 */

//Just like a regular Picker, this changes the way SwiftUI renders the view. We don't get a new view being oushed onto a NavigationView this time, though; instead we get a single list row that folds out into a date picker when tapped.

//This looks really nice, and combines the clean simplicity of forms with the familiar, wheel-based user interface of date pickers. Sadly, right now there are occasionally some glitches with the way these pickers are shown; we'll get onto that later.

//Rather than using forms, an alternative is to use the labelIsHidden() modifier, like this:

/*
 var body: some View {
    DatePicker("Please enter a date", selection: $wakeUp)
        .labelIsHidden
 }
 */

//That still include the original label so screen readers can use it for VoiceOver, but now they aren't visible onscreen any more - the date picmer will take up all horizontal space on the screen.

//Date pickers provide us with a couple of configuration options that control how they work. First, we can use displayedComponents to decide what kind of options users should see.

//--If you don't provide a parameter, users see a day, hour and minute.

//--If you use .date users see month, day, and year.

//--If you use .hourAndMinute users see just the hour and minute compnents.

//So, we can select a precise time like this:

//DatePicker("Please enter a ime", selection: $wakeUp, displayedComponents: .hourAndMinute)

//Finally there's an in parameter that works just the same as with Stepper: we can provide it with a date range, and the date picker will ensure the user cannot select beyond it.

//Now, we've been using ranges for a while now, and you're used to seeing things like 1 ... 5 or 0 ..< 10, but we can also use Swift dates with ranges For example:

/*
 //when you create a new Date instance it will be set to the currant date and time
 let now = Date()
 
 create a second Date instance set to one day in seconds from now
 
 let tomorrow = Date().addingTimeInterval(86400)
 
 // create a range from those two
 
 let range = now ... tomorrow
 */

//That's really useful with DatePicker, but there's something even better: Swift lets us form one-sided ranges - ranges where we specify the start or end but not both, leaving Swift to infer the other side.

//For example, we could create a date picker like this:

//DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)

//That will allow all dates in the future, but none in the past - read it as "from the current date up to anything."

//MARK: 4. Working with Dates

//Having users enter dates is as easy as binding an @State property of type Date to a DatePicker SwiftUI control, but things get a little woolier afterwards.

//You seen, working wit dates is hard. Like, really hard. Way harder than you think. Way harder than I think, and I've been working with dates for years.

//Take a look at this trivial example:
/*
let now = Date()
let tomorrow = Date().addintTimeInterVal(86400)
let range - now ... tomorrow
 */

//That creates a range from now (Date() is the current date) to the dame time tomrrow (86400 is the number of seconds in a day.)

//That might seem easy enough, but do all days have 86400 seconds? If they did, a lot of poeple would be out of jobs! Think about daylight savings time: sometimes clock go forward (losing an hour) and sometimes they go backwards (gaining an hour), meaning that we might have 23 or 25 hours in those days. Then there are leap seconds: times that get added to the clocks in order to adjust for the Earth's slowing rotation.

//If you think that's hard, try running this from your mac's terminal: cal. This prints a simple calendar for the current month, showing you the days of the week. Now try running cal 9 1752, which shows you the calenday for September 1752 - you;ll notice 12 whole days are missing, thanks to the calendar moving from Julian to Gregorian.

//Now, the reason I'm saying all this isn't to scare you off - dates are inevitable in our programs, after all. Instead, I want you to understand that for anything significant - any usage of dates that actually matters in our code - we should rely on Apple's frameworks for calculations and formatting.

//In the project we're making we'll be using dates in three ways:

// 1. Choosing a sensible default "wake up" time.

// 2. Reading the hour and minute they want to wake up.

// 3. Showing their suggested bedtime neatly formatted.

//We could, if we wanted, do all that by hand, but then you're into the realm of daylight savings, leap seconds, and Gregorian calendars.

//Much better is to have iOS do all that hard work for us: it's much less work, and it's guaranteed to be correct regardless of the user's region settings.

//Let's tackle each of those individually, starting with choosing a sensible wake up time.

//As you've seen, Swift gives us Date for working with date, and that encapsulates the year, month, date, hour, minute, second, timezone, and more. However, we don't want to think about most of that - we want to say "give me an 8am wake up time, regardless of what day it is today.

//Swift has a slightly different tupe for that purpose, called DateComponents, which lets us read or write specific parts of a date rather than the whole thing.

//So, if we wanted a date the represented 8am today, we could write code like this:

/*
 var components = DateComponents()
 components.hour = 8
 components.minute = 0
 let date = Calendar.curretn.date(from:components)
 */

//The second challenge is how we could read the hour they want to wake up. Remember, DatePicker is bound to a Date giving su lots of information, so we need to find a way to pill out just the hour and minute components.

//Again, DateComponents comes to the rescue: we can ask iOS to provide specific components from a date, then read those back out. One hiccup is that ther's a disconnect between the values we request and the values we get thanks to the way DateComponents waorks: we can ask for the hour and minute, but we'll be handed back a DateComponents instance with optiona values for all its properties. yes, we know hour and minute will be there because those are the ones we asked for, but we still need to unwrap the optionals or provide default values.

//So, we might write code like this:

/*
 let components = Clendar.current.dateComponents( [.hour, .minute], from: someDate)
 let hour = components.hour ?? 0
 let minute = components.minute ?? 0
 */

//The last challenge is how we can format dates and time, a=and oce again Swift gives us a specific type to do most of the work for us. This time it's called DateFormatter, and it lets us convert a date into a string in a variety of ways.

//For example, if we jsut wanted the time from a date we would write this:

/*
 let formatter = DateFormatter()
 formatter.timeStyle = .short
 let dateString = formatter.string(from: Date)
 */

//We could also set .dateStyle to get date values, and even pass in an entirely custom format using dateFormat, but that's way outside the remit of this project!

//The point is that date are hard, but Apple has provided us with stacks of helpers to make them less hard. If you learn to use them well you'll write less code, and write better code too!

//MARK: 5. Training a Model with Create ML

//On-device machine learining went from "extremely hard to do" to "quite posible and surprising powerful" in iOS 11, all thanks to one Apple framework: Core ML. A year later, Apple introduced a second framework called Create ML app that made the whole proces drag and drop. As a result of all this work, it's now within the reach of anyone to add machine learinig to their app.

//Core ML is capable of handling a variety of training tasks, such as recognizing images, sounds, even motion, but in this instance we're going to look at tabular regression. That's a fancy name, which is common in machine learning, but all it really means is that we can throw a load of speadsheet-like data at Create ML and ask it to figure out the relationship between various values.

//Machine learining is done in two steps: we train the model, then we ask the model to make predictions. Training is the process of the computer looking at all our data to figure out the relationship between all the values we ahve, and in large data sets it can take a long time - easily hors, potentially much longer. Prediction is done on device: we feed it the trained model, and it will use previous results to make estimates about new data.

//Let's start the training process now: please open the Create ML app on your Mac. If you don't know where this si, you can launch it fom Xcode by going to the Xcode menu and choosing the Open Developer Tool > Create ML.

//The first thing the Create Ml aoo wil do is ask you to create a project or open a previous one - please click New Document to get started. You'll see Tabular Regressor; please choose that and press Next, select your desktop, the press Create.

//This is where Create ML can seem a little tricky at first, becayse you'll see a screen with quite a few options. Don't worry, though - once I walk you through it isn't so ahrd.

//the first step is to provide Create ML with some training data. This is the raw statistics for it to look at, which in our case consists of four values: when someone wanted to wake up, how muh sleep they though they liked to hace, how much coffe they drink per day, and how much sleep they actually need.

//I've provided this data for you in BetterRest.csv, which is in the project files for this project. This is a comma-separated values data set that Create ML can work with, and our first job is to import that.

//So, in Creat ML look under Data inputs and select Choose under the Training Data title. When you press Select File it will open a file selection window, and you should choose BetterRest.csv.

//Important: This CSV file contains sample data for the purpose of this project, and should not be used for actual health-related work.

//The next job is to decide the target, which is the value we want the computer to learn to predict, and the features, which are the values we want the computer to inspect in order to predict the target. For example, if we chose how much sleep someone thought they needed and how much sleep they actually needed as feature, we could train the computer to predict how much coffee they drink.

//In this instace, I'd like you to choose "actualSleep" for the target, which means we want the computer to learn how to predict how much sleep they acutally need. now [press Select Features, and select all three options: wake, estimatedSleep, and coffee  we want the computer to take all three of those into account when producing its predictions.

//Below the Select Feature button is a dropdown for the algorith, and there are five options:Automatic, Random Forest, Boosted Tree, Decision Tree, and Linear Regression. Each takes a different approach to analyzing data, and although this isn't a book about machine learining I want to explain what they do briefly.

//Linear Regressors are the easiest to understant because it's pretty much exactly how our brain works. They attempt to estimate the relationships between yor variable by considering them as part of a linear funtion such as applyAlgorithm(var1, var2, var3). The goal of a linear regression is to be able to fraw one straight line through all your data points, where the average distance between the line and each data point is as small as possible.

//Decision tree regressors form a natural tree structure letting us organize as a series of choices. Try to enxision this almost like a game of 20 questions: "are you a person or an animal? If you're a person, are you alive or dead? If you're alive, are you young or old?" And do one - each time the tree can branch off depending on the answer to each question until eventually there's a definitive answer.

//Boosted tree regressors work using a series of decision trees, where each tree is designed to correct any errors in the previous tree. For example, the first decision tree takes its best guess at finding a good prediction, but it's off by 20%. This then gets passed down to a second decision tree for further refinement, and the process repeats - this time, though, the error is down to 10%. That goes into a third tree where the error comes down to 8%, and a fourth tree where the error comes down to 7%.

//The random forest model is similar to boosted trees, but with a slight difference: with boosted trees every decision in the tree is made witha ccess to all available data, whereas with random trees each tree has access to only a subset of data.

//This might sound bizarre: why would you want to withold data? Well, image you were facing a coding problem and tring to come up with a solution. If you ask a colleague for ideas, they will give you some based on what they know. If you ask a different colleague for ideas, they are likely to gicve you different ideas based on what they know. And if you asked hundreds of colleagues for ideas, you'll get a range of solutions.

//Each of your colleagues will have a different bckground, different education, and a different job history that the other, which is why you ge a range of suggestions. But if you average out the suggestions across everyone - go with whatever most people say, regardless of what led them to that decision - you might have the best chance of getting the right solution.

//This is exactly how random forest regressors work: each decision tree has its own view of your data that's different to other trees, and by combining all their predictions together to make an average you  stand a great chance of getting a strong result.

//Helfully, there is an Automatic option that attempts to choose the best algorithm automatically. It's not always correct, and in fact it does limit the options we have quite dramatically, but for this project it's more than good enough.

//When you're ready, click the Train button in the window title bar. After a couple of seconds - our data is pretty small! - you'll see some result metric appear. The value we care about is called the root mean squared error, and you should get a value around 180. This means that on average the model was able to predict suggested accurate sleep time with an error of only 180 seconds, or 3 minute.

//Even better, if you look in the top right corner you'll see an MLModel icon saying "Output" and it has a file size of 438 bytes or so. Create ML has taked 180KB of data, and condensed it don to just 438 bytes - almost nothing.

//Now 438 bytes sound tiny, I know, but it's worth adding that almost all of those bytes are metadata: the author name is in there, as is the default description of "A machine learning model that has been trained for regression." It even encodes the names of all the fields: wake, estimateSleep, coffee, and actualSleep.

//The Actual amount of space taken up by the hard data - how to predict the mount of required sleep based on threee variables - is well under 100 bytes. This is possible beacuse Create ML doesn't actually care what the values are, it onoly cares what the relationships are. So, it spends a couple of billion cpu cycles trying out various combinations of weight for each of the features to see which ones produce the closest value to the actual target, and once it knows the best algorith it simply store that.

//Now that our model is trained, I'd like you to drag that icon from Create ML to your desktop, so we canuse it in code.

//Tip: if you want to try training again - perhaps to experiment with the various algorithms available to us - click Make A Copy in the bottom-right corner of the Create ML window.


//MARK : Day 27 project 4, part 2

//Today we're going to build our project, combining both SwiftUI and Core ML in remarkeably few lines of code - I think you'll be impressed.

//What I hope you'll get from this project - apart from all the SwiftUI goodies, of course - is just a little glimpse into the wider world of app development. Core ML is just one of Apple's powerhouse frameworks, and there are over a dozen more: ARKit, Core Graphics, Core Image, MapKit, WebKit, and more, are all witing o be discovered whe you're ready.

//I realize thaat you might have thought "wow, we're loking at machine learinng already?" After all, this is only day 27 of a 100-day course. But, as Andre Gide said, "you cannot discover new oceans unles you're willing to lose sight of the shore."


//Today you have three topics to work through, and you'll get busy implementing Stepper, DatePicker, DateFormatter, and more in a real app.

//MARK: 1. Building a Basic Layout

//This app is going to allow user input with a date picker an two steppers, which combined will tell us when they want to wake up, how much sleep they usually like, and how much coffee they drink.

//So, please start by adding three properties that let us store the information for those controls:

/*
 @State private var wakeUp = Date()
 @State private var sleepAmount = 8.0
 @State private var coffeeAmount = 1
 */

//Inside our body we're going to place three sets of components wrapped in a VStack and a NavigationView, so let's start with the wake up time. Replce the default "Hello World" Text view with this:

/*
 NavigationView {
    VStack {
        Text("When do you want to wake up?)
            .font(.headline)
 
        DatePicker("Please enter a time", selection: $wakeup, displayedComponenets: .hourAndMinute)
            .labelIsHidden()
 
        // more to come
    }
 }
 */

//Because we're in a VStack, that will render the date picker as a spinning wheel on iOS, which is fine here. We've asked for .hourAndMinute configuration because we care about the time someone wants to wake up and not the day, and with the labelsHidden() modifier we don't get a second label for the picker - the one above is more than enough.

//Next we're going to add a stepper to let users choose roughly how much sleep they want. By giving this thing an in range of 4 ... 12 and a step of 0.25 we can be sure thay'll enter sensible values, but we can combine that with the %g string interpolation sppecifier so we see numbers like "8" not 8.000000

//Add this code in place of the // more to come comment:

/*
 Text("Desired amount of sleep")
    .font(.headline)
 
 Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
    Text("\(sleepAmount, specifier: "%g") hours")
 }
 */

//Finally we'll add one last stepper and label to handle how much coffee they drink. This time we'll use the range of 1 through 20 (becuse surely 20 coffees a day is enough for anyone?), but we'll also display one of two lavels inside the stepper to handle pluralization better. If the user has set a coffeeAmount of exatly 1 we'll show "1 cup", otherwise we'll use that amount plus "cups"

//Add these inside the VStack, below the previous views:

/*
 Text("Daily coffee intake")
    .font(.headline)
 Stepper(value: $coffeeAmount, in 1...20) {
    if coffeeAmount == 1 {
        Text("1 cup")
    } else {
        Text("\(coffeeAmount) cups")
    }
 }
 */

//The final thing we need is a button to let users calculate the best time they should go to sleep. We could do that with a simple button at the end of the VStack, but to spice up this project a little I want to try something new: we're going to add a button directly to the navigation bar.

//First we need a method for the button to calle, so add an empy calculateBedtime() methos like this:

/*
 func calculateBedtime() {
 }
 */

//Now we need to use the navigationBarItems() modifier to add a trailing button to the navigation view. "Trailing" in left-to-right languages like English means "on the right", and you can provide any view here - if you want several buttons, you could use a HStack, for example. While we're here, we might as well also use navigationBaTitle(0 to put some text at the top.

//So, add these modifiers to the VStack:

/*
 .navigationBarTitle("BetterRest")
 .navigationBarItems(trailing:
    // our button here
 }
 */

//In our case we want to replace that commment with a "Calculate" button. Previously I exmplained that buttons come in two forms:

/*
 Button("Hello") {
    print("Button was tapped")
 }
 
 Button(action: {
    print("Button was tapped")
 }) {
    Text("Hello")
 }
 
 */

//We could use the first option here if we wanted:

/*
 Button("Calculate") {
    self.calculateBedtime()
 }
 */

//That would work fine, but I'd like you to reconsider. That code creates a new closure, and the closure's sole job is to call a method. Closures are, for the most part, just functions without a name - we assign them directly to something, rather than having them as a seperate entity.

//So, we're creating a function that just cals another function. Wouldn't it be better for everyone if we could skip to that middle layer entirely?

//Well, we can. What the button cares about is that its action is some sort of function that accepts no paramertetrs and sens nothing back - it doesn't care whether that's a method or a closure, as long as they both follow those rules.

//As a resule, we can actually sen calculateBedtime directly to the button's action, like this:

/*
 Button(action: calculateBedtime) {
    Text("Calculate")
 }
 
 */

//Now, when people see that they often think I've made a mistake. They want to write this instead:

/*
 Button(action: calculateBedtime()) {
    Text("Calculate")
 }
 */

//However, that code won't work and in fact means something quite different. If we add the parentheses after calculateBedtime it means "call calculateBedtime() and it wil send back to the correct function to use when the button is tapped." So, Swift would require that calculateBedtime() returns a closure to run.

//By writing calculateBedtime instead of calculateBedtime() we're telling Swift to run that method when the button is tapped, and nothing more; it won't return anything that should then be run.

//Swift really blurs the lines between functions, methods, closure, and even operators (+, _, and so on), which is what allows us to use them so interchangeably.

//So, the whole modifier should look like this:

/*
 navigationBarItems(trailing:
    Button(action: calculateBedtime) {
        Text("Calculate")
    }
 )
 */

//That won't do anything yet because calculateBedtime() is empty, but at least our UI is good enough for the time being.

//MARK: 2. Connect SwiftUI to Core ML

//In the same way that SwiftUI makes user interface development easy, Core ML makes machine learning easy. How easy? Well, once you have a trained model you can get predictions in just two lines of code- you just need to send in the values that should be used as input, then read what comes back.

//In our case, we already made a Core ML model using Xcode's Create ML app, so we''re going to use that. You should have saved it on your desktop, so please now drag it into the project navigator in Xcode - just below Info.plist should do the trick.

//When you add an .mlmodel file to Xcode, it will automatically create a Swift class of the same name. You can't see the class, and don't need to - it's generated automatically as part of the build process. However, it does mean that if your model file is named oddly then the auto-generated class name will also be named oddly.

//In my case, I had a file called "BetterRest1.mlmodel", which meant Xcode would generate a Swift class called BetterRest_1. No matter what name your model file has, please rename it to be "SleepCalculator.mlmodel", thus making the class be called SleepCalculator.

//How can we be sure? Well, just select the model file itself and Xcode will show you more information. You'll see inputs and their types, and an output plus type too - these were encoded in the model file, which is why it was (comparatively!) so big.

//Let's start filling in calculateBedtime(). First, we need to create an instance of the SleepCalculator class, like this:

//let model = SleepCalculator()

//That's the thing that reads in all our data, and will output a prediction. We trained our model with a CSV ile containing the following fields:

//--"wake": when the user wants to wake up. This is expressed as the number of seconds from midnight, so 8am would be 8 hours multiplied by 60 multiplied by 60, giving 28880.

//--"estimatedSleep": roughly how much sleep the user wants to have, stored as values from 4 thorugh 12 in quarter increments.

//--"coffee": roughly how many cups of coffee the user drinks per day.

//So, in order to get a prediction out of our model, we need to fill in those values.

//We already have two of them, because our sleepAmount and coffeeAmount properties are mostly good enough - we just need to convert coffeeAmount from an integer to a Double so that Swift is happy.

//But figuring out the wake time requires more thinking, because our wakeUp property is a Date not a Double representing the number of seconds. Helpfully, this is where Swift's DateComponents type comes in: it stores all the parts required to represent a date as individual values, meaning that we can read the hour and minute components and ignore the rest. All we then need to do is multiply the minute by 60 (toget seconds rather than minutes), and the hour by 60 and 60 (to get seconds rather than hours).

//We can get a DateComponents instance from a Date with a very specific method call: Calendar.current.dateComponents(). We can then request the hour and minute components, and pass in our wake up date. The DateComponents instance that comes back has properties for all its components - year, month, day, timezone, etc - but most of them won't be set. The ones we asked for - hour and minute - will be set, but will be optional, so we need to unwrap them carefully.

//So, put this directly below the previous line in calculateBedtime():

/*
 let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
 let hour = (components.hour ?? 0) * 60 * 60
 let minute = (components.minute ?? 0) * 60
 */

//That code uses 0 if either hour or minute can't be read, but realistically that's never going to happen so it will result in hour and minute being set to those values in seconds.

//The next step is to feed our values into Core ML and see what comes out. This might fail if Core ML hits some srot of problem, so wee need to use do and catch. Honestly, I can't think I've ever had a prediction fail in my life, but there's no harm in being safe!

//So, we're going to create a do/catch block, and iside there use the prediction() method of our model. This wants the wake time, estimates sleep, and coffee amount values required to make a prediction, all provided as Double values. We just calculated our hour and minute as seconds, so we'll add those together before sending them in.

//Please add this code to calculateBedtime() now:

/*
 do {
    let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
 
    // more code here
 
 } catch {
    ///something went wrong!
 }
 */

//With that in place, prediction now contains how much sleep they actually need. This almost ceratinly wasn't part of the training data our model saw, but was instead computed dynamically by the Core ML algorithm.

//However, it's not a helpful value for users - it will be some number in seconds. What we want is to convert that into the time they shoud go to bed, which means we need to subtract that value in seconds from the time they need to wake up.

//Thanks to Apple's powerful APIs, that's just one line of code - you can subtract a value in seconds directly from a Date, and you'll get back a new Date! So, add this line of code after the prediction:

//let sleepTime = wakeUp - prediction.actualSleep

//And now we know exactly when they should go to sleep. Our final challend, for now at least, is to show that to the user. We'll be doing this with an aler, because you've already learned how to do that and could use the practice.

//So, start by adding three properties that determine the title and message of the alert, and whether or not it's showing:

/*
 @State private var alertTitle = ""
 @State private var alertMessage = ""
 @State private var showingAlert = false
 */

//We can immediately use those values in calculateBedtime(). IF our calculation goes wrong - if reading a prediction throws an error - we can replace the // something went wrang comment with some code that sets up a useful error message:

/*
 alertTitle = "Error"
 alertMessage = "Sorry, there was a problem calculating your bedtime."
 */

//And regardless of whether or not the prediction worker, we should show the aler. It might contain the results of their prediction or might contain the error messafe, but it's srill useful. So, put this at the end of calculateBedtime(), after the catch block:
//showingAlert = true

//Now for the more challenging part: if the prediction worked we create a constant called sleepTime that contains the time they need to go to bed. But this is a Date rather than a neatly formatted string, so we need to use Swift's DateFormatter to make that look better.

//DateFormatter can format dates and times in all sorts of ways using its datStyle and timeStyle properties. In this instance, though, we just want a time string so we can put that into alertMessage.

//So, put these final lines of code into calculateBedtime(), irectly after where we set the sleepTime constant:
/*
let formatter = DateFormatter()
 formatter.timeStyle = .short
 
 alertMessage = formatter.string(from: sleepTime)
 alertTitle = "Your ideal bedtime is..."
*/

//To wrap up this stage of the app, we just need to add an alert() modifier that shows alertTitle and alertMessage when showingAlert becomes true.

//Please add this modifier to our VStack:

/*
 .alert(isPresented: $showingAlert) {
    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
 }
 */

//Now go ahead an run the app - it works! It doesn't look great, but it works.

//MARK: 3. Cleaning Up the User Interface

//Although our app works right now, it's not something you;d want to ship on the App Store - it has at least one major useability problem, and the design is... well... let's say "substandard"

//Let's look at the usability problem first, because it's possible it hasn't occurred to you. When you create a new instance of Date it is automatically set to the current date and time. So, when you create a new instance of Date it is automatically set to the current date and time. So, wehn we create our wakeUp property with a new date, the default wake up time will be whatever time it is right now.

//Although the app needs to be able to handle any sort of times - we don't wnat to exclude folks on night shift, for example, I think it's safe to say that a default wake up time somewhere between 6am and 8am is going to be more useful to the vast majority of users.

//To fix this, we're going to add a computed property to our ContentView struct that contains a Date value referencing 7am orf the current day. This is surprisingly easy: we can just create a new DateComponenets of our own, and use Calendar.current.date(from:) to convert those components into a full date.

//So, add this propert ro ContentView now:

/*
 var defaultWakeTime: Date {
    var componenets = DateComponents()
    components.hour = 7
    components.minute = 0
    return Calenday.current.date(from: components) ?? Date()
 }
 */

//And now we can use that for the default value of wakeUp in place of Date():

//@State private var wakeUp = defaultWakeUpTime

//If you try compiling that code you'll see it fails, and the reason is that we're accessing one property from inside another - Swift doesn't know which order the properties will be created in, so this isn't allowed.

//The fix here is simple: we can make defaultWakeTime a static variable, which menas it belongs to the ContentView struct itself rather than a single instance of that struct. This in turn means defaultWakeTime can be read whenever we want, because it doesn't rely on the existence of other properties.

//So, change the property definition to this:

//static var defaultWakeTime: Date {

//That fixes our usability problem, ecause the majority of users will find the default wake up time is close to what they want to choose.

//As for our styling, this requires more effort. A simple change to make is to switch to a Form rather than a VStack. So, find this:

/*
 NavigationView {
    VStack {
 */

//And replace with this:

/*
 NavigationView {
    Form {
 
 */

//that immediately makes the UI look better - we get a clearly segmented table of inputs, rather than some controls ventered in a white space.

//If you prefer, you can get the old style back by specifically asking for the wheel picker to be used. We lost it when we moved to a Form, because DatePicker has a different style when used in forms, but we can get it back by using the modifier .datePickerStyle(WheelDatePickerStyle()).

//So, modify your date picker code to this:

/*
 DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
    .labelsHidden()
    .datePickerStyle(WheelDatePickerStyle())
 
 //Tip: Wheel pickers are available only to iOS and watcOS, so if you plan to write SwiftUI code for macOS or tvOS you should avoid them.
 
 //There's still an annoyance in our form: every view inside the form is treated as a row in the list, when really all the text views form part of the same logical form section.
 
 //We could use Section views here, with our text views as title - you'll get to experiment with that in the challenges. Insted,w we're going to wrap each pair of text view and control with a VStack so they are seen as a single row.
 
 //Go ahead and wrap each of the pairs in a VStack now, using .leading for the alignment and 0 for spacing. For example, you'd take these two views:
 
 Text("Desired amount of sleep")
    .font(.headline)
 
 Stepper(value: $sleepAmount, in 4...12, step: 0.25) {
    Text("\(sleepAmount, specifier: "%g") hours")
 }
 */

//And wrap them in a VStack like this:

/*
 VStack(alignment: .leading, spacing: 0) {
    Text("Desired amount of sleep")
        .font(.headline)
 
    Stepper(value: $sleepAmount, in 4...12, step: 0.25) {
        Text("\(sleepAmount, specifier: "%g") hours")
    }
 }
 */

//And now run the app one last time - good job!


//MARK: BetterRest: Wrap Up

//This project gave you the chance to get some practice with forms and indings, while also introducing you to DatePicker, Stepper, navigationBarItems(), Date, DateComponents, and DateFormatter - thesd are things you'll be using time and time again, si I wanted to get them in nice and early.

//Of course, I also ttok the chance to give you a glimpse of some of the incredible things we can build using Appl'e frameworks, all thanks to Create ML and Core ML. As you saw, these frameworks allow us to take advantaage of decades of research and development in machine learning, all sing a drag and drop user interface and a couple lines of code - it really couldn't be easier.

//The truly fascinating thing about machine learning is that it doesn't need big or clever scenarios to be used. You could use machine learning to predict car prices, to figure our user handwriting, or even detect faces in images. And most importantly of all, the entire process happens of the user's device, in complete privacy.

//MARK: Review what you learned

//Anyone can sit through a tutlrial, but it take actaul work to remember what was taught. It's my job to make sure you take as much from these tutorials as possible, so I've prepared a short review to help you check your learining.


//Note: If you're keen to learn more about Core ML, I have a video you might enjoy - click here to check it out

//Once you've made it throught these topics, make sure and post your progress somewhere online - you've taken the first steps towards understanding machine learining!
