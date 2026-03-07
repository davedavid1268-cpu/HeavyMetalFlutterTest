import 'package:flutter/material.dart';
import '../../../core/app_theme.dart';
import '../../../widgets/responsive_layout.dart';
import '../../../core/mock_data.dart';

class MyListingsScreen extends StatelessWidget {
  const MyListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: const MyListingsMobile(),
      desktop: const MyListingsWeb(),
    );
  }
}

class MyListingsMobile extends StatelessWidget {
  const MyListingsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Listings')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.listings.length,
        itemBuilder: (context, index) {
          final listing = MockData.listings[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                ListTile(
                  leading: Image.network(listing.images.first, width: 60, height: 60, fit: BoxFit.cover),
                  title: Text(listing.title),
                  subtitle: Text('₦${listing.price}'),
                  trailing: _buildStatusChip(listing.status),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(onPressed: () {}, icon: const Icon(Icons.edit, size: 18), label: const Text('Edit')),
                    TextButton.icon(onPressed: () {}, icon: const Icon(Icons.pause, size: 18), label: const Text('Pause')),
                    TextButton.icon(onPressed: () {}, icon: const Icon(Icons.delete, size: 18, color: Colors.red), label: const Text('Delete', style: TextStyle(color: Colors.red))),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Active': color = AppTheme.successGreen; break;
      case 'Paused': color = AppTheme.warningOrange; break;
      default: color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}

class MyListingsWeb extends StatelessWidget {
  const MyListingsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(width: 250, color: AppTheme.primaryBlue),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Manage Listings', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 32),
                  Card(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Photo')),
                        DataColumn(label: Text('Title')),
                        DataColumn(label: Text('Category')),
                        DataColumn(label: Text('Price')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Views')),
                        DataColumn(label: Text('Actions')),
                      ],
                      rows: MockData.listings.map((l) => DataRow(cells: [
                        DataCell(Image.network(l.images.first, width: 40, height: 40, fit: BoxFit.cover)),
                        DataCell(Text(l.title)),
                        DataCell(Text(l.category.name)),
                        DataCell(Text('₦${l.price}')),
                        DataCell(_buildStatusChip(l.status)),
                        DataCell(Text(l.views.toString())),
                        DataCell(Row(
                          children: [
                            IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {}),
                            IconButton(icon: const Icon(Icons.delete, size: 18, color: Colors.red), onPressed: () {}),
                          ],
                        )),
                      ])).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Active': color = AppTheme.successGreen; break;
      case 'Paused': color = AppTheme.warningOrange; break;
      default: color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(status, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}
