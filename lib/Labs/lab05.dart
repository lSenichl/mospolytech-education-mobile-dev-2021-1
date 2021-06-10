import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class Lab05 extends StatefulWidget {
  @override
  Lab05State createState() => Lab05State();
}

class Lab05State extends State<Lab05> {
  GoogleSignInAccount _currentUser;
  GoogleContacts contacts;
  bool isLoading = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future getUserContacts() async {
    final host = "https://people.googleapis.com";
    final endPoint =
        "/v1/people/me/connections?personFields=names,phoneNumbers";
    final header = await _currentUser.authHeaders;

    setState(() {
      isLoading = true;
    });

    print("loading contact");
    final request = await http.get("$host$endPoint", headers: header);
    print("Loading completed");
    setState(() {
      isLoading = false;
    });

    if (request.statusCode == 200) {
      print("Api working perfect");
      setState(() {
        contacts = googleContactsFromJson(request.body);
      });
    } else {
      print("Api got error");
      print(request.body);
    }
  }

  @override
  initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        getUserContacts();
      }
    });
    _googleSignIn.signInSilently();
  }

  Widget getLoginWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Вы не вошли в аккаунт!",
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }

  Widget getContactListWidget(context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final currentContact = contacts.connections[index];
        return ListTile(
          title: Text("${currentContact.names.first.displayName}"),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Номер телефона: ${currentContact.phoneNumbers.first.value}")));
          },
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: contacts.connections.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    MyApp.analytics
        .logEvent(name: 'lab09_lab05_tab_was_opened', parameters: null);
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : contacts != null && _currentUser != null
                ? getContactListWidget(context)
                : getLoginWidget(),
      ),
    );
  }
}

GoogleContacts googleContactsFromJson(String str) =>
    GoogleContacts.fromJson(json.decode(str));

String googleContactsToJson(GoogleContacts data) => json.encode(data.toJson());

class GoogleContacts {
  GoogleContacts({
    this.connections,
    this.nextPageToken,
    this.totalPeople,
    this.totalItems,
  });

  List<Connection> connections;
  String nextPageToken;
  int totalPeople;
  int totalItems;

  factory GoogleContacts.fromJson(Map<String, dynamic> json) => GoogleContacts(
        connections: List<Connection>.from(
            json["connections"].map((x) => Connection.fromJson(x))),
        nextPageToken: json["nextPageToken"],
        totalPeople: json["totalPeople"],
        totalItems: json["totalItems"],
      );

  Map<String, dynamic> toJson() => {
        "connections": List<dynamic>.from(connections.map((x) => x.toJson())),
        "nextPageToken": nextPageToken,
        "totalPeople": totalPeople,
        "totalItems": totalItems,
      };
}

class Connection {
  Connection({
    this.resourceName,
    this.etag,
    this.names,
    this.phoneNumbers,
  });

  String resourceName;
  String etag;
  List<Name> names;
  List<PhoneNumber> phoneNumbers;

  factory Connection.fromJson(Map<String, dynamic> json) => Connection(
        resourceName: json["resourceName"],
        etag: json["etag"],
        names: json["names"] == null
            ? null
            : List<Name>.from(json["names"].map((x) => Name.fromJson(x))),
        phoneNumbers: json["phoneNumbers"] == null
            ? null
            : List<PhoneNumber>.from(
                json["phoneNumbers"].map((x) => PhoneNumber.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resourceName": resourceName,
        "etag": etag,
        "names": names == null
            ? null
            : List<dynamic>.from(names.map((x) => x.toJson())),
        "phoneNumbers": phoneNumbers == null
            ? null
            : List<dynamic>.from(phoneNumbers.map((x) => x.toJson())),
      };
}

class Name {
  Name({
    this.metadata,
    this.displayName,
    this.familyName,
    this.givenName,
    this.displayNameLastFirst,
    this.unstructuredName,
    this.middleName,
  });

  Metadata metadata;
  String displayName;
  String familyName;
  String givenName;
  String displayNameLastFirst;
  String unstructuredName;
  String middleName;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        metadata: Metadata.fromJson(json["metadata"]),
        displayName: json["displayName"],
        familyName: json["familyName"] == null ? null : json["familyName"],
        givenName: json["givenName"],
        displayNameLastFirst: json["displayNameLastFirst"],
        unstructuredName: json["unstructuredName"],
        middleName: json["middleName"] == null ? null : json["middleName"],
      );

  Map<String, dynamic> toJson() => {
        "metadata": metadata.toJson(),
        "displayName": displayName,
        "familyName": familyName == null ? null : familyName,
        "givenName": givenName,
        "displayNameLastFirst": displayNameLastFirst,
        "unstructuredName": unstructuredName,
        "middleName": middleName == null ? null : middleName,
      };
}

class Metadata {
  Metadata({
    this.primary,
    this.source,
  });

  bool primary;
  Source source;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        primary: json["primary"] == null ? null : json["primary"],
        source: Source.fromJson(json["source"]),
      );

  Map<String, dynamic> toJson() => {
        "primary": primary == null ? null : primary,
        "source": source.toJson(),
      };
}

class Source {
  Source({
    this.type,
    this.id,
  });

  SourceType type;
  String id;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        type: sourceTypeValues.map[json["type"]],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": sourceTypeValues.reverse[type],
        "id": id,
      };
}

enum SourceType { CONTACT }

final sourceTypeValues = EnumValues({"CONTACT": SourceType.CONTACT});

class PhoneNumber {
  PhoneNumber({
    this.metadata,
    this.value,
    this.canonicalForm,
    this.type,
    this.formattedType,
  });

  Metadata metadata;
  String value;
  String canonicalForm;
  PhoneNumberType type;
  FormattedType formattedType;

  factory PhoneNumber.fromJson(Map<String, dynamic> json) => PhoneNumber(
        metadata: Metadata.fromJson(json["metadata"]),
        value: json["value"],
        canonicalForm:
            json["canonicalForm"] == null ? null : json["canonicalForm"],
        type: phoneNumberTypeValues.map[json["type"]],
        formattedType: formattedTypeValues.map[json["formattedType"]],
      );

  Map<String, dynamic> toJson() => {
        "metadata": metadata.toJson(),
        "value": value,
        "canonicalForm": canonicalForm == null ? null : canonicalForm,
        "type": phoneNumberTypeValues.reverse[type],
        "formattedType": formattedTypeValues.reverse[formattedType],
      };
}

enum FormattedType { MOBILE }

final formattedTypeValues = EnumValues({"Mobile": FormattedType.MOBILE});

enum PhoneNumberType { MOBILE }

final phoneNumberTypeValues = EnumValues({"mobile": PhoneNumberType.MOBILE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
