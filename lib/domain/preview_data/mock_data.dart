import 'package:twitter_cosmos_db/config/constants/app_constants.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';

List<User> users = [
  User(
    username: 'MatBuompy',
    nome: "Matteo",
    cognome: "Buompastore",
    dateCreated: DateTime.now(),
    phoneNumber: '3334445555',
    posted: ['0'],
    profileImageUrl: profilePic,
  ),
  User(
    username: 'TrumpOfficial✔️',
    nome: "Donald",
    cognome: "Trump",
    dateCreated: DateTime.now(),
    phoneNumber: '1112223333',
    posted: ['1', '2', '3'],
    profileImageUrl: 'https://i.abcnewsfe.com/a/404d254e-7d93-406b-addb-af88686e8e64/trump-france-macron-ap-lv-250214_1740446568606_hpMain.jpg',
  ),
  User(
    username: 'FrancisPope',
    nome: "Papa",
    cognome: "Francesco",
    dateCreated: DateTime.now(),
    phoneNumber: '34343412',
    posted: ['4', '5'],
    profileImageUrl: 'https://s.france24.com/media/display/bd303ccc-f536-11ef-8502-005056bfb2b6/w:1280/p:16x9/000_36YN9RM.jpg',
  ),
  User(
    username: 'MarioBros',
    nome: "Mario",
    cognome: "Rossi",
    dateCreated: DateTime.now(),
    phoneNumber: '3479342080',
    posted: ['6', '7'],
    profileImageUrl: 'https://game-experience.it/wp-content/uploads/2023/05/super-mario-1024x576.jpeg',
  ),
  User(
    username: 'FernandoH',
    nome: "Fernando",
    cognome: "Herrera",
    dateCreated: DateTime.now(),
    phoneNumber: '3490293029330',
    posted: ['8', '9'],
    profileImageUrl: 'https://yt3.googleusercontent.com/ytc/AIdro_kFMlV5pd9yp52QPeW3OpNkNjZJ2n_hJxjKlBSOkKZtOLk=s900-c-k-c0x00ffffff-no-rj',
  ),
];

List<Post> tweets = [
  Post(
    id: '0',
    userId: 'MatBuompy', 
    body: "Hi, I'm new around here! Show me around!"),
  Post(
    id: '1',
    userId: 'TrumpOfficial✔️', 
    body: "Looking forward to see Mr. Putin in the oval office soon."),
  Post(
    id: '2',
    userId: 'TrumpOfficial✔️', 
    body: "Gonna impose a 50% tarrifs on every inch of fat in your bodies."),
  Post(
    id: '3',
    userId: 'TrumpOfficial✔️', 
    body: "The DOGE has done a pretty goodjob so far. Thank you Elon, you are a great guy!"),
  Post(
    id: '4',
    userId: 'FrancisPope', 
    body: "I'm still breathing, I had  a fine night."),
  Post(
    id: '5',
    userId: 'FrancisPope', 
    body: "Fermate la guerra"),
  Post(
    id: '6',
    userId: 'MarioBros', 
    body: "Wonder where peach's gone 🤔"),
  Post(
    id: '7',
    userId: 'MarioBros', 
    body: "Here with Luigi smashing the hell out of Bower! 👊"),
  Post(
    id: '8',
    userId: 'FernandoH', 
    body: "Hola que tal? Les recuerda suscribiros al canal Discord DevTalles!"),
  Post(
    id: '9',
    userId: 'FernandoH', 
    body: "Acaba de salir el nuevo curso de Flutter Intermedio! Echale un 👀!"),
];
