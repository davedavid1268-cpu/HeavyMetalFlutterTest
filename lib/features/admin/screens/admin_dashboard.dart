import 'package:flutter/material.dart';
import '../../../core/mock_data.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 250,
            color: Colors.black87,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text('ADMIN PANEL', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                _buildAdminNavItem(Icons.dashboard, 'Overview', true),
                _buildAdminNavItem(Icons.people, 'Suppliers', false),
                _buildAdminNavItem(Icons.verified, 'Verification Queue', false),
                _buildAdminNavItem(Icons.report, 'Flagged Items', false),
                const Spacer(),
                _buildAdminNavItem(Icons.logout, 'Logout', false),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Dashboard Overview', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      _buildAdminStatCard('Active Listings', '1,420', Icons.list, Colors.blue),
                      const SizedBox(width: 24),
                      _buildAdminStatCard('New Suppliers', '24', Icons.person_add, Colors.green),
                      const SizedBox(width: 24),
                      _buildAdminStatCard('Contact Actions', '3,890', Icons.touch_app, Colors.orange),
                      const SizedBox(width: 24),
                      _buildAdminStatCard('Flagged Items', '5', Icons.flag, Colors.red),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Contact Actions (Last 30 Days)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                SizedBox(height: 300, child: Center(child: Text('Performance Line Chart Placeholder'))),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Recent Registrations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 16),
                                ...MockData.suppliers.map((s) => ListTile(
                                  leading: const CircleAvatar(radius: 15),
                                  title: Text(s.name, style: const TextStyle(fontSize: 12)),
                                  subtitle: Text(s.joinedDate, style: const TextStyle(fontSize: 10)),
                                  trailing: const Icon(Icons.chevron_right, size: 16),
                                  contentPadding: EdgeInsets.zero,
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminNavItem(IconData icon, String label, bool isActive) {
    return ListTile(
      leading: Icon(icon, color: isActive ? Colors.white : Colors.white54),
      title: Text(label, style: TextStyle(color: isActive ? Colors.white : Colors.white54, fontSize: 14)),
      tileColor: isActive ? Colors.white.withValues(alpha: 0.1) : null,
      onTap: () {},
    );
  }

  Widget _buildAdminStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
