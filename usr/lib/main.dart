import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const GoogleReviewApp());
}

class GoogleReviewApp extends StatelessWidget {
  const GoogleReviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Review Screens',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ReviewPagerScreen(),
      },
    );
  }
}

class ReviewPagerScreen extends StatefulWidget {
  const ReviewPagerScreen({super.key});

  @override
  State<ReviewPagerScreen> createState() => _ReviewPagerScreenState();
}

class _ReviewPagerScreenState extends State<ReviewPagerScreen> {
  final List<String> names = [
    // 50 Boy Names
    'Aarav', 'Vihaan', 'Vivaan', 'Advik', 'Kabir',
    'Ansh', 'Ishaan', 'Shaurya', 'Siddharth', 'Aryan',
    'Dhruv', 'Reyansh', 'Ayaan', 'Atharva', 'Daksh',
    'Yuvraj', 'Ojas', 'Pratyush', 'Rohan', 'Rahul',
    'Amit', 'Sumit', 'Manish', 'Vikram', 'Surya',
    'Akash', 'Karan', 'Tarun', 'Raj', 'Dev',
    'Yash', 'Jai', 'Sameer', 'Naveen', 'Rohit',
    'Sanjay', 'Vijay', 'Ajay', 'Kartik', 'Kunal',
    'Neeraj', 'Ravi', 'Rakesh', 'Suresh', 'Ramesh',
    'Sunil', 'Anil', 'Pramod', 'Gautam', 'Kiran',
    // 50 Girl Names
    'Aadya', 'Ananya', 'Diya', 'Isha', 'Kavya',
    'Navya', 'Oviya', 'Pari', 'Riya', 'Sana',
    'Tara', 'Zara', 'Myra', 'Nyra', 'Kiara',
    'Aisha', 'Amara', 'Avni', 'Gauri', 'Ishita',
    'Jia', 'Meera', 'Neha', 'Pooja', 'Priya',
    'Rhea', 'Risha', 'Ruchi', 'Sakshi', 'Shreya',
    'Sneha', 'Swati', 'Tanvi', 'Trisha', 'Urvashi',
    'Vidya', 'Yashvi', 'Aahana', 'Aditi', 'Anika',
    'Charu', 'Disha', 'Ekta', 'Fatima', 'Gayatri',
    'Heena', 'Jhanvi', 'Kirti', 'Leela', 'Maya'
  ];

  @override
  void initState() {
    super.initState();
    // Maintain same order or shuffle, keeping them consistent for testing.
    names.shuffle(Random(42));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return ReviewScreenItem(name: names[index]);
        },
      ),
    );
  }
}

class ReviewScreenItem extends StatelessWidget {
  final String name;

  const ReviewScreenItem({super.key, required this.name});

  Color _getAvatarColor(String name) {
    final colors = [
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.teal,
      Colors.green,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
    ];
    final hash = name.hashCode;
    return colors[hash % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final avatarColor = _getAvatarColor(name);
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AppBar Area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Decathlon Sports - Pacific Mall, New Delhi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // User Info Area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: avatarColor,
                  child: Text(
                    initial,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            'Posting publicly across Google',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.info_outline,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Stars
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: List.generate(5, (index) {
                return const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 40,
                  ),
                );
              }),
            ),
          ),
          
          const SizedBox(height: 24),
          const Divider(height: 1, thickness: 1),
          const SizedBox(height: 16),
          
          // Text Input Placeholder
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Share details of your own experience at this place',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          
          const Spacer(),
          
          // Bottom Actions
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade100,
                    foregroundColor: Colors.blue.shade900,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  icon: const Icon(Icons.auto_awesome, size: 18),
                  label: const Text(
                    'Post',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
