import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:frontend/shared/config/supabase_config.dart';
import 'package:frontend/features/auth/views/login_page.dart';
import 'package:frontend/features/auth/views/register_page.dart';
import 'package:frontend/features/dashboard/views/dashboard_page.dart';
import 'package:frontend/features/home/views/home_page.dart';
import 'package:frontend/features/home/views/roadmap_page.dart';
import 'package:frontend/features/diagnostic/views/diagnostic_page.dart';
import 'package:frontend/features/market_map/views/market_map_page.dart';
import 'package:frontend/features/profile/views/profile_page.dart';
import 'package:frontend/features/talent_network/views/talent_network_page.dart';
import 'package:frontend/shared/theme/app_theme.dart';
import 'package:frontend/shared/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Growthway Hack',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.register: (context) => const RegisterPage(),
        AppRoutes.dashboard: (context) => const DashboardPage(),
        AppRoutes.roadmap: (context) => const RoadmapPage(),
        AppRoutes.marketMap: (context) => const MarketMapPage(),
        AppRoutes.diagnostic: (context) => const DiagnosticPage(),
        AppRoutes.profile: (context) => const ProfilePage(),
        AppRoutes.talentNetwork: (context) => const TalentNetworkPage(),
        AppRoutes.home: (context) => const HomePage(title: 'Growthway Hack'),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
