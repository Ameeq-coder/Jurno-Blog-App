import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  final String date;
  final VoidCallback onPressed; // Add a callback for when the card is pressed

  const PostCard({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.onPressed, // Include onPressed in constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Set the onTap callback
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Card height adapts to content
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150, // Set a fixed height for the image
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0), // Adjust padding for spacing
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis, // Avoid overflow with ellipsis
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.circle,
                        size: 4,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
