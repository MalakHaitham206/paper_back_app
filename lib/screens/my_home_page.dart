// Example of how to integrate the updated flow in your existing home page

// In your existing MyHomePage.dart, update the navigation:

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/helper.dart';
import '../core/widgets/custom_book_item.dart';
import '../model/book_model.dart';
import '../providers/books_provider.dart';
import 'book_details_page.dart'; // Import the updated book details page

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  int count = 2;

  @override
  void initState() {
    super.initState();
    count = 2;
    // Load trending books when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BooksProvider>().loadTrendingBooks();
      context.read<BooksProvider>().loadFavoriteBooks();
    });
  }

  void seeMoreFunc(int length) {
    setState(() {
      if (count >= length) {
        count = length;
      } else {
        count = (count + 2 > length) ? length : count + 2;
      }
    });
  }

  void _navigateToBookDetails(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookDetailsPage(book: book)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.all(Helper.getResponsiveWidth(context, width: 16)),
      child: Consumer<BooksProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Helper.getResponsiveHeight(context, height: 24),
                ),

                Text(
                  "Discover your next favorite\nbook",
                  textAlign: TextAlign.left,
                  style: theme.textTheme.displayMedium,
                ),

                SizedBox(
                  height: Helper.getResponsiveHeight(context, height: 32),
                ),

                // Trending Books Section
                _buildTrendingSection(provider, context),

                SizedBox(
                  height: Helper.getResponsiveHeight(context, height: 32),
                ),

                // Favorites Section Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Your favorites",
                          textAlign: TextAlign.left,
                          style: theme.textTheme.displayMedium,
                        ),
                        Text(
                          provider.favoriteBooks.isNotEmpty
                              ? "Your saved list of favorites"
                              : "No favorites yet - start exploring!",
                          textAlign: TextAlign.left,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    if (provider.favoriteBooks.isNotEmpty)
                      TextButton(
                        onPressed: () {
                          seeMoreFunc(provider.favoriteBooks.length);
                        },
                        child: Text("See more", textAlign: TextAlign.start),
                      ),
                  ],
                ),

                SizedBox(
                  height: Helper.getResponsiveHeight(context, height: 16),
                ),

                // Favorites List
                _buildFavoritesList(provider, context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingSection(BooksProvider provider, BuildContext context) {
    if (provider.isLoading) {
      return Container(
        height: Helper.getResponsiveHeight(context, height: 264),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.errorMessage != null) {
      return Container(
        height: Helper.getResponsiveHeight(context, height: 264),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 48, color: Colors.red),
              Text('Error loading books', style: TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: () => provider.loadTrendingBooks(),
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: Helper.getResponsiveHeight(context, height: 264),
      child: ListView.builder(
        itemExtent: Helper.getResponsiveWidth(context, width: 200),
        scrollDirection: Axis.horizontal,
        itemCount: provider.books.length,
        itemBuilder: (context, index) {
          final book = provider.books[index];
          return GestureDetector(
            onTap: () => _navigateToBookDetails(book), // Updated navigation
            child: Container(
              width: Helper.getResponsiveWidth(context, width: 181),
              height: Helper.getResponsiveHeight(context, height: 240),
              margin: EdgeInsets.only(
                right: Helper.getResponsiveWidth(context, width: 16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: book.imageUrl.isNotEmpty
                    ? Image.network(
                        book.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey.shade300,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.book,
                                  size: 48,
                                  color: Colors.grey.shade600,
                                ),
                                SizedBox(height: 8),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    book.title,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey.shade300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.book,
                              size: 48,
                              color: Colors.grey.shade600,
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                book.title,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFavoritesList(BooksProvider provider, BuildContext context) {
    if (provider.favoriteBooks.isEmpty) {
      return Container(
        height: Helper.getResponsiveHeight(context, height: 200),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No favorite books yet',
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

    final displayCount = count.clamp(0, provider.favoriteBooks.length);

    return ListView.builder(
      itemExtent: Helper.getResponsiveHeight(context, height: 120),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: displayCount,
      itemBuilder: (context, index) {
        final book = provider.favoriteBooks[index];
        return GestureDetector(
          onTap: () => _navigateToBookDetails(book), // Updated navigation
          child: Container(
            margin: EdgeInsets.only(
              bottom: Helper.getResponsiveHeight(context, height: 8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomBookCard(
                bookInfo: book,
                onFavoriteToggle: () => provider.toggleFavorite(book.id),
              ),
            ),
          ),
        );
      },
    );
  }
}
