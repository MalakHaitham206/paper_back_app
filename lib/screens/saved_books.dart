// Fixed SavedItemsPage - resolves the initState issue
import 'package:day2_course/core/helper.dart';
import 'package:day2_course/core/theme.dart';
import 'package:day2_course/core/widgets/custom_book_item.dart';
import 'package:day2_course/model/book_model.dart';
import 'package:day2_course/providers/books_provider.dart';
import 'package:day2_course/screens/book_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedItemsPage extends StatefulWidget {
  const SavedItemsPage({super.key});

  @override
  State<SavedItemsPage> createState() => _SavedItemsPageState();
}

class _SavedItemsPageState extends State<SavedItemsPage> {
  List<String?> categories = ["All items"];
  String selectedCategory = "All items";

  List<String?> getCategories(List<Book> books) {
    Set<String?> list = {"All items"};
    for (Book book in books) {
      if (book.category.isNotEmpty) {
        list.add(book.category);
      }
    }
    return list.toList();
  }

  @override
  void initState() {
    super.initState();
    // Load favorite books when the page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BooksProvider>().loadFavoriteBooks();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update categories based on current favorite books
    final provider = context.watch<BooksProvider>();
    categories = getCategories(provider.favoriteBooks);
  }

  List<Book> getFilteredBooks(List<Book> books) {
    if (selectedCategory == "All items") {
      return books;
    }
    return books.where((book) => book.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.all(Helper.getResponsiveWidth(context, width: 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Filter
          DropdownMenuTheme(
            data: DropdownMenuThemeData(
              textStyle: theme.textTheme.displayMedium,
              inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Helper.getResponsiveWidth(context, width: 8),
                ),
                suffixIconColor: theme.colorScheme.primary,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              menuStyle: MenuStyle(
                side: const WidgetStatePropertyAll(BorderSide.none),
                shape: const WidgetStatePropertyAll(
                  RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                padding: const WidgetStatePropertyAll(EdgeInsets.zero),
              ),
            ),
            child: DropdownMenu<String>(
              initialSelection: selectedCategory,
              onSelected: (String? value) {
                if (value != null) {
                  setState(() {
                    selectedCategory = value;
                  });
                }
              },
              dropdownMenuEntries: [
                ...categories.map((category) {
                  return DropdownMenuEntry(
                    value: category ?? "Unknown",
                    label: category ?? "Unknown",
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 8),
                      ),
                      side: WidgetStatePropertyAll(BorderSide.none),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: Helper.getResponsiveHeight(context, height: 32)),

          // Favorite Books List
          Expanded(
            child: Consumer<BooksProvider>(
              builder: (context, provider, child) {
                final filteredBooks = getFilteredBooks(provider.favoriteBooks);
                return _buildFavoritesList(provider, filteredBooks, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(
    BooksProvider provider,
    List<Book> filteredBooks,
    BuildContext context,
  ) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (filteredBooks.isEmpty) {
      return Container(
        height: Helper.getResponsiveHeight(context, height: 200),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                selectedCategory == "All items"
                    ? 'No favorite books yet'
                    : 'No favorites in $selectedCategory',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Tap on any book to add it to your favorites!',
                style: TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      itemExtent: Helper.getResponsiveHeight(context, height: 120),
      itemCount: filteredBooks.length,
      itemBuilder: (context, index) {
        final book = filteredBooks[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailsPage(book: book),
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(
              bottom: Helper.getResponsiveHeight(context, height: 8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomBookCard(
                bookInfo: book,
                onFavoriteToggle: () async => provider.toggleFavorite(book.id),
              ),
            ),
          ),
        );
      },
    );
  }
}
