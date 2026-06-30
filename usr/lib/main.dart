import 'package:flutter/material.dart';

void main() {
  runApp(const ImageGridApp());
}

class ImageGridApp extends StatelessWidget {
  const ImageGridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indian Names Image Grid',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ImageGridScreen(),
      },
    );
  }
}

class ImageGridScreen extends StatefulWidget {
  const ImageGridScreen({super.key});

  @override
  State<ImageGridScreen> createState() => _ImageGridScreenState();
}

class _ImageGridScreenState extends State<ImageGridScreen> {
  // 100 distinct Indian names (mixed boys and girls)
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
    // Shuffle the names to mix boys and girls randomly, but they will stay consistent per session.
    names.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('100 Portraits'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Determine number of columns based on screen width
            int crossAxisCount = 2;
            if (constraints.maxWidth > 1200) {
              crossAxisCount = 6;
            } else if (constraints.maxWidth > 900) {
              crossAxisCount = 5;
            } else if (constraints.maxWidth > 600) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth > 400) {
              crossAxisCount = 3;
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: names.length,
              itemBuilder: (context, index) {
                final name = names[index];
                // Using multiavatar API for diverse, unique characters seeded by the name
                final imageUrl = 'https://api.multiavatar.com/${Uri.encodeComponent(name)}.png';

                return ProfileCard(name: name, imageUrl: imageUrl);
              },
            );
          },
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const ProfileCard({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              Theme.of(context).colorScheme.surfaceVariant,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Hero(
                  tag: name,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.person, size: 48, color: Colors.grey);
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              color: Theme.of(context).colorScheme.surface,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
