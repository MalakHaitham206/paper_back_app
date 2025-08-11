class Book {
  String title;
  String id;
  String? description;
  double rate;
  String author;
  String? category;
  String coverImage;
  Book({
    required this.title,
    required this.id,
    this.description,
    required this.author,
    this.category,
    required this.coverImage,
    required this.rate,
  });
}

List<Book> books = [
  Book(
    title: "The Silent Patient",
    id: "1",
    description: "A psychological thriller about a woman who stops speaking.",
    author: "Alex Michaelides",
    category: "Thriller",
    coverImage: "assets/image/home_images/book1.jpg",
    rate: 5.0,
  ),
  Book(
    title: "Atomic Habits",
    id: "2",
    description: "A guide to building good habits and breaking bad ones.",
    author: "James Clear",
    category: "Self-Help",
    coverImage: "assets/image/home_images/book2.jpeg",
    rate: 5.0,
  ),
  Book(
    title: "The Midnight Library",
    id: "3",
    description: "A woman explores alternate lives through a magical library.",
    author: "Matt Haig",
    category: "Fiction",
    coverImage: "assets/image/home_images/book3.jpeg",
    rate: 4.0,
  ),
  Book(
    title: "Educated",
    id: "4",
    description: "A memoir of a woman’s quest for education.",
    author: "Tara Westover",
    category: "Memoir",
    coverImage: "assets/image/home_images/book4.jpeg",
    rate: 5.0,
  ),
  Book(
    title: "The Subtle Art of Not Giving a F*ck",
    id: "5",
    description: "A counterintuitive approach to living a good life.",
    author: "Mark Manson",
    category: "Self-Help",
    coverImage: "assets/image/home_images/book5.jpeg",
    rate: 4.0,
  ),
  Book(
    title: "Project Hail Mary",
    id: "6",
    description: "A sci-fi adventure of a lone astronaut on a mission.",
    author: "Andy Weir",
    category: "Science Fiction",
    coverImage: "assets/image/home_images/book6.png",
    rate: 5.0,
  ),
  Book(
    title: "Becoming",
    id: "7",
    description: "The memoir of former First Lady Michelle Obama.",
    author: "Michelle Obama",
    category: "Memoir",
    coverImage: "assets/image/home_images/book7.png",
    rate: 5.0,
  ),
  Book(
    title: "Where the Crawdads Sing",
    id: "8",
    description: "A coming-of-age mystery set in the marshlands.",
    author: "Delia Owens",
    category: "Fiction",
    coverImage: "assets/image/home_images/book8.jpeg",
    rate: 4.5,
  ),
  Book(
    title: "Deep Work",
    id: "9",
    description: "Rules for focused success in a distracted world.",
    author: "Cal Newport",
    category: "Productivity",
    coverImage: "assetdfs/image/home_images/book9.jpeg",
    rate: 5.0,
  ),
];
