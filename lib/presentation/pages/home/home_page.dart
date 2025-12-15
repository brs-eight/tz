import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text('List Item ${index + 1}'),
            subtitle: Text('Description for item number ${index + 1}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Action on tap
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text('Selected Item ${index + 1}')),
              );
            },
          );
        },
      ),
    );
  }
}
