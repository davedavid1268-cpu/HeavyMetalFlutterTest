import 'package:flutter/material.dart';
import '../../../core/app_theme.dart';
import '../../../widgets/listing_card.dart';
import '../../../widgets/responsive_layout.dart';
import '../../../core/mock_data.dart';
import '../../../models/models.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentStep = 0;

  void next() => setState(() => currentStep++);
  void back() => setState(() => currentStep--);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: OnboardingMobile(step: currentStep, onNext: next, onBack: back),
      desktop: OnboardingWeb(step: currentStep, onNext: next, onBack: back),
    );
  }
}

class OnboardingMobile extends StatelessWidget {
  final int step;
  final VoidCallback onNext;
  final VoidCallback onBack;
  const OnboardingMobile({super.key, required this.step, required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Step ${step + 1} of 5'),
        leading: step > 0 ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: onBack) : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _buildStepContent(context),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: onNext,
          child: Text(step == 4 ? 'Finish' : 'Next'),
        ),
      ),
    );
  }

  Widget _buildStepContent(BuildContext context) {
    switch (step) {
      case 0:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.phone_android, size: 80, color: AppTheme.primaryBlue),
            const SizedBox(height: 32),
            const Text('Verify Phone', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('We will send a 6-digit code to verify your business phone.', textAlign: TextAlign.center),
            const SizedBox(height: 32),
            const TextField(decoration: InputDecoration(labelText: 'Phone Number', prefixText: '+234 ', border: OutlineInputBorder())),
          ],
        );
      case 1:
        return Column(
          children: [
            const Text('Select Category', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: MockData.categories.length,
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.category, color: AppTheme.primaryBlue),
                    title: Text(MockData.categories[index].name),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: onNext,
                  ),
                ),
              ),
            ),
          ],
        );
      case 2:
        return const SingleChildScrollView(
          child: Column(
            children: [
              Text('Business Details', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 24),
              TextField(decoration: InputDecoration(labelText: 'Business Name', border: OutlineInputBorder())),
              SizedBox(height: 16),
              TextField(decoration: InputDecoration(labelText: 'Business Email', border: OutlineInputBorder())),
              SizedBox(height: 16),
              TextField(decoration: InputDecoration(labelText: 'CAC Registration Number (Optional)', border: OutlineInputBorder())),
            ],
          ),
        );
      case 3:
        return Column(
          children: [
            const Text('Set Location', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Expanded(child: Container(color: Colors.grey[300], child: const Center(child: Icon(Icons.map, size: 100, color: Colors.white)))),
            const SizedBox(height: 24),
            const TextField(decoration: InputDecoration(labelText: 'Address', border: OutlineInputBorder())),
          ],
        );
      case 4:
        return SingleChildScrollView(
          child: Column(
            children: [
              const Text('Create First Listing', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Container(
                height: 150, width: double.infinity,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const TextField(decoration: InputDecoration(labelText: 'Listing Title', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              const TextField(decoration: InputDecoration(labelText: 'Price', prefixText: '₦', border: OutlineInputBorder())),
            ],
          ),
        );
      default: return Container();
    }
  }
}

class OnboardingWeb extends StatelessWidget {
  final int step;
  final VoidCallback onNext;
  final VoidCallback onBack;
  const OnboardingWeb({super.key, required this.step, required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 800,
          child: Column(
            children: [
              const SizedBox(height: 60),
              Row(
                children: List.generate(5, (index) => Expanded(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: step >= index ? AppTheme.primaryBlue : Colors.grey[300],
                        radius: 15,
                        child: Text('${index + 1}', style: TextStyle(color: step >= index ? Colors.white : Colors.black)),
                      ),
                      const SizedBox(height: 8),
                      Text(['Phone', 'Category', 'Business', 'Location', 'Listing'][index], style: TextStyle(fontSize: 12, fontWeight: step == index ? FontWeight.bold : FontWeight.normal)),
                    ],
                  ),
                )),
              ),
              const SizedBox(height: 60),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: _buildStepContent(context),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(BuildContext context) {
    switch (step) {
      case 0:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Business Phone Verification', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            const SizedBox(width: 400, child: TextField(decoration: InputDecoration(labelText: 'Phone Number', prefixText: '+234 ', border: OutlineInputBorder()))),
            const SizedBox(height: 40),
            ElevatedButton(onPressed: onNext, child: const Text('Send Verification Code')),
          ],
        );
      case 1:
        return Column(
          children: [
            const Text('Select Your Primary Category', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20, childAspectRatio: 3),
                itemCount: MockData.categories.length,
                itemBuilder: (context, index) => Card(
                  child: InkWell(
                    onTap: onNext,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.category, color: AppTheme.primaryBlue),
                          const SizedBox(width: 16),
                          Text(MockData.categories[index].name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      case 4:
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Listing Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  const TextField(decoration: InputDecoration(labelText: 'Title', border: OutlineInputBorder())),
                  const SizedBox(height: 16),
                  const TextField(maxLines: 4, decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder())),
                  const SizedBox(height: 16),
                  const TextField(decoration: InputDecoration(labelText: 'Price', prefixText: '₦', border: OutlineInputBorder())),
                  const Spacer(),
                  Row(
                    children: [
                      TextButton(onPressed: onBack, child: const Text('Back')),
                      const Spacer(),
                      ElevatedButton(onPressed: onNext, child: const Text('Publish Listing')),
                    ],
                  ),
                ],
              ),
            ),
            const VerticalDivider(width: 60),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Live Preview', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  ListingCardWeb(listing: Listing(
                    id: 'preview', title: 'Your Listing Title', description: '', price: 0, unit: 'trip',
                    category: ListingCategory.rawMaterials, supplierId: '', supplierName: 'Your Business', images: const ['https://images.unsplash.com/photo-1533044309907-0fa3413da946?w=500'],
                    location: 'Lagos', distance: 0, createdAt: DateTime.now(),
                  )),
                ],
              ),
            ),
          ],
        );
      default:
        return Column(
          children: [
            Text('Step ${step + 1} Content', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: onBack, child: const Text('Back')),
                ElevatedButton(onPressed: onNext, child: const Text('Continue')),
              ],
            ),
          ],
        );
    }
  }
}
