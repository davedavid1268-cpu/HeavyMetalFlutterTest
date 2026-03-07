import 'package:flutter/material.dart';
import '../../../core/app_theme.dart';
import '../../../core/mock_data.dart';

class SupplierManagementScreen extends StatelessWidget {
  const SupplierManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(width: 250, color: Colors.black87),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Supplier Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextField(decoration: InputDecoration(hintText: 'Search suppliers...', prefixIcon: const Icon(Icons.search), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
                      ),
                      const Spacer(),
                      DropdownButton<String>(
                        value: 'All',
                        items: ['All', 'Active', 'Pending', 'Suspended'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (_) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Card(
                    child: SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Business Name')),
                          DataColumn(label: Text('Category')),
                          DataColumn(label: Text('Location')),
                          DataColumn(label: Text('Listings')),
                          DataColumn(label: Text('Joined Date')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: MockData.suppliers.map((s) => DataRow(cells: [
                          DataCell(Row(
                            children: [
                              CircleAvatar(radius: 15, backgroundImage: NetworkImage(s.avatar ?? '')),
                              const SizedBox(width: 12),
                              Text(s.name),
                            ],
                          )),
                          const DataCell(Text('Raw Materials')),
                          DataCell(Text(s.location)),
                          DataCell(Text(s.listingsCount.toString())),
                          DataCell(Text(s.joinedDate)),
                          DataCell(_buildStatusChip(s.status)),
                          DataCell(Row(
                            children: [
                              IconButton(icon: const Icon(Icons.visibility, size: 18), onPressed: () {}),
                              IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {}),
                              IconButton(icon: const Icon(Icons.block, size: 18, color: Colors.red), onPressed: () {}),
                            ],
                          )),
                        ])).toList(),
                      ),
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
    Color color = status == 'Active' ? AppTheme.successGreen : AppTheme.warningOrange;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(status, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}
