import 'package:flutter/material.dart';
import '../../../core/app_theme.dart';
import '../../../widgets/responsive_layout.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isOTPStage = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: AuthMobile(
        isOTPStage: isOTPStage,
        onNext: () => setState(() => isOTPStage = true),
      ),
      desktop: AuthWeb(
        isOTPStage: isOTPStage,
        onNext: () => setState(() => isOTPStage = true),
      ),
    );
  }
}

class AuthMobile extends StatelessWidget {
  final bool isOTPStage;
  final VoidCallback onNext;
  const AuthMobile({super.key, required this.isOTPStage, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('HEAVYMETAL', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
            const SizedBox(height: 48),
            if (!isOTPStage) ...[
              const Text('Welcome back', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Enter your phone number to continue', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 32),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixText: '+234 ',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: onNext, child: const Text('Continue')),
              ),
            ] else ...[
              const Text('Verify OTP', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Enter the 6-digit code sent to you', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) => SizedBox(
                  width: 45,
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(counterText: '', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                  ),
                )),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () {}, child: const Text('Verify & Login')),
              ),
              TextButton(onPressed: () {}, child: const Text('Resend Code')),
            ],
          ],
        ),
      ),
    );
  }
}

class AuthWeb extends StatelessWidget {
  final bool isOTPStage;
  final VoidCallback onNext;
  const AuthWeb({super.key, required this.isOTPStage, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: AppTheme.primaryBlue,
              padding: const EdgeInsets.all(60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('HEAVYMETAL', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 40),
                  _buildPropItem(Icons.verified, 'Verified Suppliers', 'Connect with trusted providers of heavy goods across Nigeria.'),
                  _buildPropItem(Icons.local_shipping, 'Haulage Simplified', 'Find the right truck for your needs in minutes.'),
                  _buildPropItem(Icons.security, 'Safe & Secure', 'Direct contact with suppliers without hidden fees.'),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: 400,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!isOTPStage) ...[
                          const Text('Login / Register', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 32),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              prefixText: '+234 ',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(onPressed: onNext, child: const Text('Get OTP')),
                          ),
                        ] else ...[
                          const Text('Enter OTP', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 32),
                          TextField(
                            decoration: InputDecoration(
                              labelText: '6-Digit Code',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(onPressed: () {}, child: const Text('Verify & Continue')),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
