import 'package:flutter/material.dart';
import '../../../widgets/listing_card.dart';
import '../../../widgets/responsive_layout.dart';
import '../../../core/mock_data.dart';
import '../../../models/models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: const HomeMobile(),
      desktop: const HomeWeb(),
    );
  }
}

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HeavyMetal', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for sand, trucks, etc...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                scrollDirection: Axis.horizontal,
                itemCount: MockData.categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return FilterChip(
                    label: Text(MockData.categories[index].name),
                    onSelected: (val) {},
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Near You', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text('See All')),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) => ListingCardMobile(listing: MockData.listings[index]),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Recently Added', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: MockData.listings.length,
              itemBuilder: (context, index) => ListingCardMobile(listing: MockData.listings[index]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1F4E79),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Color(0xFF1F4E79),
              child: Icon(Icons.add, color: Colors.white),
            ),
            label: 'Post',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeWeb extends StatelessWidget {
  const HomeWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WebHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1F4E79),
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1541888946425-d81bb19480c5?w=1200'),
                  fit: BoxFit.cover,
                  opacity: 0.3,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Find Heavy Goods & Services in Nigeria',
                    style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  Container(
                    width: 600,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'What are you looking for?',
                        icon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 40),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.5,
                ),
                itemCount: MockData.categories.length,
                itemBuilder: (context, index) => CategoryCardWeb(category: MockData.categories[index]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Popular Categories', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 16),
                        ...MockData.categories.map((c) => ListTile(
                          title: Text(c.name),
                          onTap: () {},
                          contentPadding: EdgeInsets.zero,
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Near You', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: MockData.listings.length,
                          itemBuilder: (context, index) => ListingCardWeb(listing: MockData.listings[index]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class CategoryCardWeb extends StatelessWidget {
  final Category category;
  const CategoryCardWeb({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.category, color: Color(0xFF1F4E79), size: 32),
          const SizedBox(height: 8),
          Text(category.name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class WebHeader extends StatelessWidget implements PreferredSizeWidget {
  const WebHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('HEAVYMETAL', style: TextStyle(color: Color(0xFF1F4E79), fontSize: 24, fontWeight: FontWeight.bold)),
              const Spacer(),
              TextButton(onPressed: () {}, child: const Text('Login')),
              const SizedBox(width: 16),
              ElevatedButton(onPressed: () {}, child: const Text('Post a Listing')),
            ],
          ),
          const Divider(height: 1),
          Row(
            children: MockData.categories.map((c) => Padding(
              padding: const EdgeInsets.only(right: 24, top: 12, bottom: 12),
              child: Text(c.name, style: const TextStyle(fontSize: 14)),
            )).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
