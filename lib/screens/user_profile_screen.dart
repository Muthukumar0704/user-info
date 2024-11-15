import 'package:flutter/material.dart';
import 'package:userdata/model/user.dart';

class UserProfile extends StatelessWidget {
  final User user;
  const UserProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          child: Text(
                            user.name!.characters.first,
                            style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          user.name!,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          user.username!,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 230, 229, 229),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _userCard('Contact Info', [
                  _userCardInformation('Email:', user.email),
                  _userCardInformation('Phone:', user.phone),
                ]),
                const SizedBox(height: 20),
                _userCard('Address', [
                  _userCardInformation('Street:', user.address!.street),
                  _userCardInformation('City:', user.address!.city),
                  _userCardInformation('Zip:', user.address!.zipcode),
                ]),
                const SizedBox(height: 20),
                _userCard('Company', [
                  _userCardInformation('Company Name:', user.company!.name),
                  _userCardInformation(
                      'Catchphrase:', user.company!.catchPhrase),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userCard(String title, List<Widget> rows) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 228, 226, 226)),
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 203, 199, 199),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...rows,
        ],
      ),
    );
  }

  Widget _userCardInformation(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value ?? 'Not Available'),
        ],
      ),
    );
  }
}
