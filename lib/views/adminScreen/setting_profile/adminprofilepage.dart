import 'package:flutter/material.dart';
import 'package:sa7a7/models/shared/componantes/companantes.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                     _ProfileInfoRow(),
                    const SizedBox(height: 16),
                    InformationBody(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InformationBody extends StatelessWidget {
  InformationBody({
    super.key,
  });
  final List<String> _listLabels = ['Name', 'Email', "Phone"];
  // final List<String> _listInformation = [
  //   // need to index of current admin
  //   '${adminData[0]['Admin_Name']}',
  //   (emailController.text),
  //   "01123456789"
  // ];
  @override
  Widget build(BuildContext context) {
  final List<String> _listInformation = [
    // need to index of current admin
    'Prof Dr.Essam Halim',
    (emailController.text),
    "01123456789",
  ];
    getAdminData(context: context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _listLabels.length,
      itemBuilder: (context, index) => Card(
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _listLabels[index],
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 11),
                Text(
                  _listInformation[index],
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
   _ProfileInfoRow({Key? key}) : super(key: key);

  final List<ProfileInfoItem> _items =  [
    ProfileInfoItem("Edecatours", edecatourData.length),
    ProfileInfoItem("Students", studentData.length),
    ProfileInfoItem("Courses", dataCourses.length),
  ];
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 80,
        constraints: const BoxConstraints(maxWidth: 400),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _items
              .map((item) => Expanded(
                      child: Row(
                    children: [
                      if (_items.indexOf(item) != 0) const VerticalDivider(),
                      Expanded(child: _singleItem(context, item)),
                    ],
                  )))
              .toList(),
        ),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      );
}

class ProfileInfoItem  {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xffF3E9EF), Color(0xffF3E9EF)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/ProfEssam.jpg')),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}