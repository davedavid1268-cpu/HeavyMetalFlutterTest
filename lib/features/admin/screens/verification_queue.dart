import 'package:flutter/material.dart';
import '../../../core/app_theme.dart';

class VerificationQueueScreen extends StatelessWidget {
  const VerificationQueueScreen({super.key});

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
                  const Text('Verification Queue', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 32),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) => _buildVerificationCard(context),
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

  Widget _buildVerificationCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 25),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Ojo Heavy Equipment', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Equipment Rental', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Phone:'), Text('08012345678', style: TextStyle(fontWeight: FontWeight.bold))]),
            const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Applied:'), Text('2 hours ago', style: TextStyle(fontWeight: FontWeight.bold))]),
            const Spacer(),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.successGreen), child: const Text('Approve'))),
                const SizedBox(width: 12),
                Expanded(child: OutlinedButton(onPressed: () => _showRejectModal(context), style: OutlinedButton.styleFrom(foregroundColor: Colors.red), child: const Text('Reject'))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showRejectModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Verification'),
        content: const TextField(
          maxLines: 3,
          decoration: InputDecoration(hintText: 'Reason for rejection...', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text('Confirm Reject')),
        ],
      ),
    );
  }
}
