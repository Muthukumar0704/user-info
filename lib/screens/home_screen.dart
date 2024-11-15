import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userdata/model/user.dart';
import 'package:userdata/screens/user_profile_screen.dart';
import 'package:userdata/provider/user_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController usernameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().fetchUsers(null);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 10),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.person, color: Colors.white),
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          backgroundColor: Colors.black,
          title: _searchBar(),
        ),
        body: Consumer<UserProvider>(builder: (context, userProvider, child) {
          List<User> userList = userProvider.users;
          return RefreshIndicator(
            onRefresh: () async {
              context.read<UserProvider>().fetchUsers(null);
            },
            child: userProvider.isloading
                ? const Center(child: CircularProgressIndicator())
                : (userProvider.errorMessage.isNotEmpty)
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userProvider.errorMessage,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                context.read<UserProvider>().fetchUsers(null);
                              },
                              child: const Text("Retry"),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserProfile(user: userList[index])));
                            },
                            child: ListTile(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              tileColor: Colors.grey,
                              leading: CircleAvatar(
                                child: Text(userList[index]
                                    .name
                                    .toString()
                                    .characters
                                    .first),
                              ),
                              title: Text(userList[index].name!),
                              subtitle: Text(userList[index].email!),
                            ),
                          );
                        },
                        separatorBuilder: (context, _) {
                          return const SizedBox(height: 10);
                        },
                        itemCount: userList.length),
          );
        }),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 136, 135, 135),
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: TextField(
          controller: usernameController,
          cursorColor: Colors.black,
          decoration: InputDecoration(
              hintStyle: const TextStyle(fontSize: 20),
              hintText: "   Search user by name...",
              suffix: IconButton(
                  onPressed: () {
                    context
                        .read<UserProvider>()
                        .fetchUsers(usernameController.text);
                    usernameController.clear();
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 20,
                  )),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
