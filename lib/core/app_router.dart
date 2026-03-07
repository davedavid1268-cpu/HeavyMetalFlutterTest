import 'package:go_router/go_router.dart';
import '../features/buyer/screens/home_screen.dart';
import '../features/buyer/screens/search_results_screen.dart';
import '../features/buyer/screens/listing_detail_screen.dart';
import '../features/buyer/screens/supplier_profile_screen.dart';
import '../features/auth/screens/auth_screen.dart';
import '../features/supplier/screens/onboarding_screen.dart';
import '../features/supplier/screens/dashboard_screen.dart';
import '../features/supplier/screens/edit_listing_screen.dart';
import '../features/supplier/screens/my_listings_screen.dart';
import '../features/admin/screens/admin_dashboard.dart';
import '../features/admin/screens/supplier_management.dart';
import '../features/admin/screens/verification_queue.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchResultsScreen(),
      ),
      GoRoute(
        path: '/listing/:id',
        builder: (context, state) => ListingDetailScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/supplier/:id',
        builder: (context, state) => SupplierProfileScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/supplier/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/supplier/dashboard',
        builder: (context, state) => const SupplierDashboardScreen(),
      ),
      GoRoute(
        path: '/supplier/my-listings',
        builder: (context, state) => const MyListingsScreen(),
      ),
      GoRoute(
        path: '/supplier/edit-listing',
        builder: (context, state) => const EditListingScreen(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminDashboard(),
      ),
      GoRoute(
        path: '/admin/suppliers',
        builder: (context, state) => const SupplierManagementScreen(),
      ),
      GoRoute(
        path: '/admin/verification',
        builder: (context, state) => const VerificationQueueScreen(),
      ),
    ],
  );
}
