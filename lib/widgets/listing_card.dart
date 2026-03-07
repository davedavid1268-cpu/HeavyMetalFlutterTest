import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../models/models.dart';

class ListingCardMobile extends StatelessWidget {
  final Listing listing;
  final VoidCallback? onTap;

  const ListingCardMobile({super.key, required this.listing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(listing.images.first, height: 200, width: double.infinity, fit: BoxFit.cover),
                if (listing.isSupplierVerified)
                  Positioned(
                    top: 10, right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: AppTheme.successGreen, borderRadius: BorderRadius.circular(4)),
                      child: const Row(
                        children: [
                          Icon(Icons.verified, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text('VERIFIED', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(listing.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('₦${listing.price.toStringAsFixed(0)} / ${listing.unit}',
                    style: const TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                      Text('${listing.location} (${listing.distance}km)', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      const Spacer(),
                      Text(listing.supplierName, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListingCardWeb extends StatelessWidget {
  final Listing listing;
  final VoidCallback? onTap;

  const ListingCardWeb({super.key, required this.listing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(listing.images.first, height: 180, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(listing.title, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis)),
                      if (listing.isSupplierVerified) const Icon(Icons.verified, color: AppTheme.successGreen, size: 16),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('₦${listing.price.toStringAsFixed(0)}', style: const TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(listing.location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const Divider(),
                  Row(
                    children: [
                      const CircleAvatar(radius: 10, backgroundColor: Colors.grey),
                      const SizedBox(width: 8),
                      Text(listing.supplierName, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
