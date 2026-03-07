import 'package:flutter/material.dart';
import '../../../core/app_theme.dart';
import '../../../widgets/responsive_layout.dart';

class EditListingScreen extends StatelessWidget {
  const EditListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: const EditListingMobile(),
      desktop: const EditListingWeb(),
    );
  }
}

class EditListingMobile extends StatelessWidget {
  const EditListingMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Listing')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 200, width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const TextField(decoration: InputDecoration(labelText: 'Listing Title', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            const TextField(maxLines: 5, decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Price', prefixText: '₦', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Unit (e.g. Trip, Day, Ton)', border: OutlineInputBorder())),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: const Text('Save Changes')),
            ),
          ],
        ),
      ),
    );
  }
}

class EditListingWeb extends StatelessWidget {
  const EditListingWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(width: 250, color: AppTheme.primaryBlue),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Edit Listing', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 32),
                        const Card(
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              children: [
                                TextField(decoration: InputDecoration(labelText: 'Title', border: OutlineInputBorder())),
                                SizedBox(height: 20),
                                TextField(maxLines: 6, decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder())),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(child: TextField(decoration: InputDecoration(labelText: 'Price', prefixText: '₦', border: OutlineInputBorder()))),
                                    SizedBox(width: 20),
                                    Expanded(child: TextField(decoration: InputDecoration(labelText: 'Unit', border: OutlineInputBorder()))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(onPressed: () {}, child: const Text('Save Changes')),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
