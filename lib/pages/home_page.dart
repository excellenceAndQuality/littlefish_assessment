import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:littlefish_assessment/models/character.dart';
import 'package:littlefish_assessment/styles/colors.dart';
import 'package:littlefish_assessment/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../providers/character_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColour,
        elevation: 0,
        title: const Text(
          "Question 3",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
        ),
      ),
      backgroundColor: CustomColors.primaryColour,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, top: 5),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDE0B1C).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Icon(
                    Icons.info_outline_rounded,
                    color: Colors.red,
                    size: 20.0,
                  ),
                ),
                const Text(
                  "Tap character below for more info",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Consumer<CharacterProvider>(
              builder: (context, characterProvider, child) {
                return ListView.builder(
                  itemCount: characterProvider.characters.length + 1,
                  itemBuilder: (context, index) {
                    if (index == characterProvider.characters.length) {
                      if (characterProvider.hasMore) {
                        characterProvider.fetchCharacters();
                        return const Center(child: LoadingWidget());
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                    final character = characterProvider.characters[index];
                    return Container(
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF032333).withOpacity(0.03),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ListTile(
                        leading: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: character.image,
                            width: 50,
                            height: 50,
                            placeholder: (context, url) =>
                                const LoadingWidget(),
                          ),
                        ),
                        title: Text(
                          character.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle:
                            Text('${character.species} (${character.status})'),
                        onTap: () {
                          _showCharacterDetailsModal(context, character);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ))
        ],
      ),
    );
  }

  void _showCharacterDetailsModal(BuildContext context, Character character) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 50.0, left: 15, right: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFDE0B1C).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.red,
                          )),
                    ),
                  ),
                   const SizedBox(
                    height: 20,
                  ),
                  ClipOval(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CachedNetworkImage(
                        imageUrl: character.image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const LoadingWidget(),
                      ),
                    ),
                  ),
                  Text(character.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25
                  ),),
                  Text(character.id.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 20
                    ),),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF032333).withOpacity(0.03),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("Status: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18
                              ),),
                            Text(character.status,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: 18
                              ),),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Species: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18
                              ),),
                            Text(character.species,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: 18
                              ),),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Type: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18
                              ),),
                            Text(character.type,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: 18
                              ),),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Gender: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18
                              ),),
                            Text(character.gender,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: 18
                              ),),
                          ],
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Created at:",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,

                    ),),
                  Text(character.created,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 18
                    ),),


                ],
              ),
            ),
          );
        });
  }
}
