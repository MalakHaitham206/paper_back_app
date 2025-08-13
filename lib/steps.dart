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

//------------------Lecture 7---------------
// what is the http
// the different types of http request:
// 1. PUT --> override in the data
// 2. POST --> add a new data
// 3. GET ---> fetch data
// 4. DELETE ---> Delete the data
// 5. PATCH ---> edit on existing data (in spesific palce)
// difference between the put and patch request
        //UserInfo user = UserInfo(id: 22, userName: "", email: "jjjj@");
        // PUT(id=22,email="jjjj@")
        // Put --> user = UserInfo(id: 22, userName: "",email:"jjjj@");
        // PATCH ---> user=UserInfo(id: 22, userName: "malak",email: "hhhh@");
// http request/response has:
//-------> header: data about data(request/response code , host Name/client id)
// ------> body: send or recieve the data (transfer the data)
//how to use http in flutter:
//---- add http: ^1.5.0 in your pubspec.yaml
// to be more cleaned put your apis files in Services folder
// import 'Package:http/http.dart' as http; in your api class file
// create your api class
// setup your url and use http.get(convert your url to Uri, give it a header to specify the file type for 
// example that will be returned)
// make the response variable to be await
// when your response.statusCode==200
// use the json.decode() to convert your response result to map to make a book object
// map on your items to convert the map to books list (its type is List<Book>) and convert it to list
// filter the result with where to make sure there are a valid books (avoid the null books)
// check the list is empty or not:
//.      if (items.isEmpty) {
          //return ApiResult.success(<Book>[]);
       // }
        //return ApiResult.success(books);
//if you status not equal 200 --> return failure obj from the generic (error message)
//if you don't get the response so catch the error in catch body
// ----> create your provider----
// create fetch books method to fetch all books:
//1. check the empty state of the query param if is empty return and not 
// make any changes
//2. call the search method from your api class
//3. check the success state and return the data list
// -----in your ui -------
// add a consumer on the widget and user your provider
// get the books list and use it to build listView

//using the shared
// install it from the flutter
//import in your file
// create var from the prefrences:
// ---> final prefs = await SharedPreferences.getInstance();
// list myFav= prefs.getStringList("favoriteList")??[];
// check on the id of the book to toggle the state (add/ remove):
//---> bool wasInFavorites = favorites.contains(bookId);
// update your var with the new list (with/without the book after toggle)
// update your shared (don't forget the await)
//--->  await prefs.setStringList('favorite_books', favorites);


// recommend:
//https://medium.com/@codingfriday.dev/generics-is-dart-b91a28a4acf4 ---------> for generics




