import 'package:flutter/material.dart';
import '../../../core/app_theme.dart';
import '../../../models/models.dart';
import '../../../widgets/listing_card.dart';
import '../../../widgets/responsive_layout.dart';
import '../../../core/mock_data.dart';
import 'home_screen.dart';

class ListingDetailScreen extends StatelessWidget {
  final String id;
  const ListingDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final listing = MockData.listings.firstWhere((l) => l.id == id, orElse: () => MockData.listings.first);
    return ResponsiveLayout(
      mobile: ListingDetailMobile(listing: listing),
      desktop: ListingDetailWeb(listing: listing),
    );
  }
}

class ListingDetailMobile extends StatelessWidget {
  final Listing listing;
  const ListingDetailMobile({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              child: PageView.builder(
                itemCount: listing.images.length,
                itemBuilder: (context, index) => Image.network(listing.images[index], fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('₦${listing.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(4)),
                        child: Text(listing.unit, style: const TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(listing.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.grey, size: 20),
                      const SizedBox(width: 4),
                      Text(listing.location, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const Divider(height: 32),
                  const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(listing.description, style: const TextStyle(color: Colors.black87, height: 1.5)),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        const CircleAvatar(radius: 25, backgroundColor: Colors.grey),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(listing.supplierName, style: const TextStyle(fontWeight: FontWeight.bold)),
                              if (listing.isSupplierVerified) const Text('Verified Supplier', style: TextStyle(color: AppTheme.successGreen, fontSize: 12)),
                            ],
                          ),
                        ),
                        TextButton(onPressed: () {}, child: const Text('View Profile')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text('You may also need', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      separatorBuilder: (context, index) => const SizedBox(width: 16),
                      itemBuilder: (context, index) => SizedBox(
                        width: 160,
                        child: ListingCardWeb(listing: MockData.listings[(index + 1) % MockData.listings.length]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)]),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.call),
                label: const Text('Call'),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryBlue),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chat),
                label: const Text('WhatsApp'),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.successGreen),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListingDetailWeb extends StatelessWidget {
  final Listing listing;
  const ListingDetailWeb({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WebHeader(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(listing.images.first, height: 500, width: double.infinity, fit: BoxFit.cover),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: listing.images.map((img) => Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(img, width: 100, height: 80, fit: BoxFit.cover),
                            ),
                          )).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(listing.title, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Text('₦${listing.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                        Text('per ${listing.unit}', style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 24),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                const CircleAvatar(radius: 40, backgroundColor: Colors.grey),
                                const SizedBox(height: 16),
                                Text(listing.supplierName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                if (listing.isSupplierVerified)
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.verified, color: AppTheme.successGreen, size: 16),
                                      SizedBox(width: 4),
                                      Text('Verified Seller', style: TextStyle(color: AppTheme.successGreen)),
                                    ],
                                  ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(onPressed: () {}, child: const Text('Show Contact Number')),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(onPressed: () {}, child: const Text('Message on WhatsApp')),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              const Text('Description', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text(listing.description, style: const TextStyle(fontSize: 16, height: 1.6)),
              const SizedBox(height: 80),
              const Text('Related Products', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: 4,
                itemBuilder: (context, index) => ListingCardWeb(listing: MockData.listings[index % MockData.listings.length]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
