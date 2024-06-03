import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/profile'),
              child: const Text('Go to Profile Screen'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/cart'),
              child: const Text('Go to Cart Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final bool isAuthenticated;

  const ProfileScreen({super.key, required this.isAuthenticated});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Screen')),
      body: Center(
        child: isAuthenticated //условный параметр авторизации дляя примера с keeper
            ? ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Back to Home'),
        )
            : const Text('You are not authorized to view this page.'),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Back to Home'),
        ),
      ),
    );
  }
}

