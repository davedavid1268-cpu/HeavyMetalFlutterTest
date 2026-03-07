import 'package:flutter/material.dart';
import '../../../core/app_theme.dart';
import '../../../widgets/responsive_layout.dart';
import '../../../core/mock_data.dart';

class SupplierDashboardScreen extends StatelessWidget {
  const SupplierDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: const SupplierDashboardMobile(),
      desktop: const SupplierDashboardWeb(),
    );
  }
}

class SupplierDashboardMobile extends StatelessWidget {
  const SupplierDashboardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(child: StatCard(title: 'Listings', value: '12', color: AppTheme.primaryBlue)),
                SizedBox(width: 16),
                Expanded(child: StatCard(title: 'Views', value: '1.2k', color: AppTheme.secondaryBlue)),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(child: StatCard(title: 'Contacts', value: '450', color: AppTheme.successGreen)),
                SizedBox(width: 16),
                Expanded(child: StatCard(title: 'Rating', value: '4.8', color: AppTheme.warningOrange)),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Recent Listings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text('Manage All')),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) => ListTile(
                leading: Image.network(MockData.listings[index].images.first, width: 50, height: 50, fit: BoxFit.cover),
                title: Text(MockData.listings[index].title),
                subtitle: Text('₦${MockData.listings[index].price}'),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.primaryBlue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SupplierDashboardWeb extends StatelessWidget {
  const SupplierDashboardWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 250,
            color: AppTheme.primaryBlue,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text('HEAVYMETAL', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                _buildNavItem(Icons.dashboard, 'Dashboard', true),
                _buildNavItem(Icons.list, 'My Listings', false),
                _buildNavItem(Icons.analytics, 'Analytics', false),
                _buildNavItem(Icons.verified_user, 'Verification', false),
                const Spacer(),
                _buildNavItem(Icons.settings, 'Settings', false),
                _buildNavItem(Icons.logout, 'Logout', false),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Welcome, Lekki Sand & Gravel Ltd', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('Create New Listing')),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Row(
                    children: [
                      Expanded(child: StatCard(title: 'Active Listings', value: '12', color: AppTheme.primaryBlue)),
                      SizedBox(width: 24),
                      Expanded(child: StatCard(title: 'Total Views', value: '1,245', color: AppTheme.secondaryBlue)),
                      SizedBox(width: 24),
                      Expanded(child: StatCard(title: 'Contact Requests', value: '450', color: AppTheme.successGreen)),
                      SizedBox(width: 24),
                      Expanded(child: StatCard(title: 'Trust Score', value: '98%', color: AppTheme.warningOrange)),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Recent Performance', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 200, child: Center(child: Text('Chart Placeholder'))),
                        ],
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

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return ListTile(
      leading: Icon(icon, color: isActive ? Colors.white : Colors.white60),
      title: Text(label, style: TextStyle(color: isActive ? Colors.white : Colors.white60)),
      tileColor: isActive ? Colors.white.withValues(alpha: 0.1) : null,
      onTap: () {},
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  const StatCard({super.key, required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}
