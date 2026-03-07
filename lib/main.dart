import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/app_theme.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/buyer/bloc/buyer_bloc.dart';
import 'features/supplier/bloc/supplier_bloc.dart';
import 'widgets/screen_showcase.dart';
import 'core/mock_data.dart';

// Import all screens for the showcase
import 'features/buyer/screens/home_screen.dart';
import 'features/buyer/screens/search_results_screen.dart';
import 'features/buyer/screens/listing_detail_screen.dart';
import 'features/buyer/screens/supplier_profile_screen.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/supplier/screens/onboarding_screen.dart';
import 'features/supplier/screens/dashboard_screen.dart';
import 'features/supplier/screens/edit_listing_screen.dart';
import 'features/supplier/screens/my_listings_screen.dart';
import 'features/admin/screens/admin_dashboard.dart';
import 'features/admin/screens/supplier_management.dart';
import 'features/admin/screens/verification_queue.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => BuyerBloc()),
        BlocProvider(create: (context) => SupplierBloc()),
      ],
      child: MaterialApp(
        title: 'HeavyMetal Nigeria',
        theme: AppTheme.lightTheme,
        home: const ShowcaseSelectionScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class ShowcaseSelectionScreen extends StatelessWidget {
  const ShowcaseSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HeavyMetal Screen Showcase')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('BUYER SCREENS', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const Divider(),
          _buildItem(context, '1. Home / Discovery', const HomeMobile(), const HomeWeb()),
          _buildItem(context, '2. Search Results + Filter', const SearchResultsMobile(), const SearchResultsWeb()),
          _buildItem(context, '3. Listing Detail Page', ListingDetailMobile(listing: MockData.listings.first), ListingDetailWeb(listing: MockData.listings.first)),
          _buildItem(context, '4. Supplier Public Profile', SupplierProfileMobile(supplier: MockData.suppliers.first), SupplierProfileWeb(supplier: MockData.suppliers.first)),
          _buildItem(context, '5. Login / Register / OTP', const AuthScreen(), const AuthScreen()),

          const SizedBox(height: 32),
          const Text('SUPPLIER SCREENS', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const Divider(),
          _buildItem(context, '6-10. Onboarding Flow (Step 1-5)', const OnboardingScreen(), const OnboardingScreen()),
          _buildItem(context, '11. Supplier Dashboard', const SupplierDashboardMobile(), const SupplierDashboardWeb()),
          _buildItem(context, '12. Create / Edit Listing', const EditListingMobile(), const EditListingWeb()),
          _buildItem(context, '13. My Listings Screen', const MyListingsMobile(), const MyListingsWeb()),

          const SizedBox(height: 32),
          const Text('ADMIN SCREENS (Web Only)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const Divider(),
          _buildItem(context, '14. Admin Overview Dashboard', const Center(child: Text('Web Only')), const AdminDashboard()),
          _buildItem(context, '15. Admin Supplier Management', const Center(child: Text('Web Only')), const SupplierManagementScreen()),
          _buildItem(context, '16. Admin Verification Queue', const Center(child: Text('Web Only')), const VerificationQueueScreen()),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String title, Widget mobile, Widget web) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenShowcase(
          title: title,
          mobileView: mobile,
          webView: web,
        )));
      },
    );
  }
}
