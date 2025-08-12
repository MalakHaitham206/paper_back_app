//List view
// --fixed size and not big lists or eny collection
// --generate all items in the list at once 
// you must give it a children

//listview.bulder()
// --large data
// --have a collection(map,list,set)
// --itemCount property: the length of items that will be build by the list
// --itemBuilder: function take the context (BuildContext),index (int)
// -- itemExtent: define the pixels of each item

//drawer 
// --must take a list in the children
// --drawer header (use if condition or make the itemcount:length+1) -> go to my_home_page.dart

//some widgets:
// --SingleChildScrollView -> make the column flixible with scrolling -> go to my_home_page.dart
// --ClipRRect() : add raduis to its child
// --ClipOval() : make your child in circural or ellips shape
// -- Align(): give alignment to the child
// -- how to make the only first is uppercase:
// "${userData.userName[0].toUpperCase()}${userData.userName.substring(1).toLowerCase()}",
// how to get the values of map and use it the list taile -> root_page.dart and read the map items
// Expanded()
// DropdownMenu() --> go to the search_screen.dart

//see more logic
// intial count -> 2 ( int count = 2;)
// intial count in initState -> to be 2 in render the widget 
// check about the length and the current count
// update the count on the function with setState() and use this function
// on see more button

//Card:
// card:A Material Design card: a panel with slightly rounded corners and an elevation shadow.
//A card is a sheet of Material used to represent some related information, for example an album, a geographical location, a meal, contact details, etc.
// Card() -> elevated((with shadow))
// Card.filled() -> fill card without elevation
// Card.outlined() -> card with border only

//error builder in assets
// render some widgets when the asset not found
//errorBuilder: -> property in AssetImage() or Image.asset() widgets
// go to custom_book_item.dart 

//handling data
// remove item from the list
// edit item
// delete item

//ShowDialog() -> Displays a Material dialog above the current contents of the app
// AlertDialog() -> An alert dialog (also known as a basic dialog) informs the user about situations that require acknowledgment. 

//-----------the task---------
// use the bottom navigation bar to navigate between the screens (without navigator)
// go to the search page
// define the list of recent searches
// update this list based on the input of textfield searck 
// navigate to bookPage with pass arguments (book object)
// apply the widgets that we build today 
// apply the alert dialog and the showdialog


//--------Lecture 6------------
// state=data that changes
// state management: manage the widgets debind on my states
//-------create provider-------
// install provider:
//   -$ flutter pub add provider
//   -https://pub.dev/packages/provider
// intialize class provider using ChangeNotifier
// intialize our private variables and access it with getter 
// define the methods
// recomended:---> study the equality
// don't forget to add NotifyListenres() in the end of each method in the provider
// add the provider in the runApp method in the main file
// ChangeNotifierProvider(create: (context) => UserInformationProvider(),),
// to use the provider (to just listen without changes): ----> watch
//   -- context.watch<UserInformationProvider>().user 
// to use the provider (to make changes): ----> read
// put your widget in a consumer if you want it to rebuild automaticly when the data in the provider changed

