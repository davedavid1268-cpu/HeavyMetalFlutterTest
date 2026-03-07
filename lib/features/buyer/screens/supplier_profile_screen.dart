import 'package:flutter/material.dart';
import '../../../core/app_theme.dart';
import '../../../models/models.dart';
import '../../../widgets/listing_card.dart';
import '../../../widgets/responsive_layout.dart';
import '../../../core/mock_data.dart';
import 'home_screen.dart';

class SupplierProfileScreen extends StatelessWidget {
  final String id;
  const SupplierProfileScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final supplier = MockData.suppliers.firstWhere((s) => s.id == id, orElse: () => MockData.suppliers.first);
    return ResponsiveLayout(
      mobile: SupplierProfileMobile(supplier: supplier),
      desktop: SupplierProfileWeb(supplier: supplier),
    );
  }
}

class SupplierProfileMobile extends StatelessWidget {
  final Supplier supplier;
  const SupplierProfileMobile({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(height: 150, color: AppTheme.secondaryBlue),
                Positioned(
                  bottom: -40,
                  left: 16,
                  child: CircleAvatar(radius: 50, backgroundImage: NetworkImage(supplier.avatar ?? ''), backgroundColor: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(supplier.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      if (supplier.isVerified) const Icon(Icons.verified, color: AppTheme.successGreen, size: 20),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(supplier.location, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatColumn('Listings', supplier.listingsCount.toString()),
                      _buildStatColumn('Views', supplier.viewsCount.toString()),
                      _buildStatColumn('Contacts', supplier.contactsCount.toString()),
                    ],
                  ),
                  const Divider(height: 40),
                  const Text('All Listings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) => ListingCardMobile(listing: MockData.listings[index]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}

class SupplierProfileWeb extends StatelessWidget {
  final Supplier supplier;
  const SupplierProfileWeb({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WebHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              color: AppTheme.secondaryBlue,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 100),
              alignment: Alignment.bottomLeft,
              child: Transform.translate(
                offset: const Offset(0, 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(radius: 60, backgroundImage: NetworkImage(supplier.avatar ?? ''), backgroundColor: Colors.white),
                    const SizedBox(width: 24),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(supplier.name, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                              if (supplier.isVerified) const Icon(Icons.verified, color: Colors.white, size: 24),
                            ],
                          ),
                          Text(supplier.location, style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: ElevatedButton(onPressed: () {}, child: const Text('Contact Supplier')),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('About', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Text('Member since ${supplier.joinedDate}', style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 24),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Rating'), Text('${supplier.rating}/5', style: const TextStyle(fontWeight: FontWeight.bold))]),
                                const Divider(),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Total Views'), Text(supplier.viewsCount.toString(), style: const TextStyle(fontWeight: FontWeight.bold))]),
                                const Divider(),
                                const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Response Time'), Text('< 2hrs', style: TextStyle(fontWeight: FontWeight.bold))]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 60),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Current Listings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
