import 'package:flutter/material.dart';
import '../../../widgets/listing_card.dart';
import '../../../widgets/responsive_layout.dart';
import '../../../core/mock_data.dart';
import 'home_screen.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: const SearchResultsMobile(),
      desktop: const SearchResultsWeb(),
    );
  }
}

class SearchResultsMobile extends StatelessWidget {
  const SearchResultsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration(
            hintText: 'Search sand, trucks...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.tune), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ActionChip(label: const Text('Sort: Best Match'), onPressed: () {}),
                const SizedBox(width: 8),
                ActionChip(label: const Text('Distance: < 10km'), onPressed: () {}),
                const SizedBox(width: 8),
                ActionChip(label: const Text('Price: All'), onPressed: () {}),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: MockData.listings.length,
              itemBuilder: (context, index) => ListingCardMobile(listing: MockData.listings[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchResultsWeb extends StatelessWidget {
  const SearchResultsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WebHeader(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Filters', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 24),
                      const Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      ...MockData.categories.map((c) => CheckboxListTile(
                        title: Text(c.name, style: const TextStyle(fontSize: 14)),
                        value: false,
                        onChanged: (_) {},
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        controlAffinity: ListTileControlAffinity.leading,
                      )),
                      const SizedBox(height: 24),
                      const Text('Distance (km)', style: TextStyle(fontWeight: FontWeight.bold)),
                      Slider(value: 20, max: 100, onChanged: (_) {}),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('0km'), Text('100km')],
                      ),
                      const SizedBox(height: 24),
                      const Text('Verification', style: TextStyle(fontWeight: FontWeight.bold)),
                      SwitchListTile(
                        title: const Text('Verified Suppliers only', style: TextStyle(fontSize: 14)),
                        value: true,
                        onChanged: (_) {},
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${MockData.listings.length} results found', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      DropdownButton<String>(
                        value: 'Best Match',
                        items: ['Best Match', 'Price: Low to High', 'Newest First']
                            .map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (_) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
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
    );
  }
}
