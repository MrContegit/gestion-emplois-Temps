class Utilis{
  double nom;
  String email;
  String password;

  Utilis({
    required this.nom,
    required this.email,
    required this.password
  });

  
  static Utilis fromJson(Map<String,dynamic> json)=>Utilis(
      nom:json['nom'],
      email:json['email'],
      password:json['password'],
  );
}

/*List<Course> courses = [
  Course(
    name: 'azerty', 
    auther: 'auther', 
    completedPercentage: .75, 
    thunbnail: 'assets/enseignant.jfif'
  ),
  Course(
    name: 'azerty', 
    auther: 'auther', 
    completedPercentage: .60, 
    thunbnail: 'assets/salle.jfif'
  ),
  Course(
    name: 'azerty', 
    auther: 'auther', 
    completedPercentage: .75, 
    thunbnail: 'assets/ecoleElements.jpg'
  ),
  Course(
    name: 'azerty', 
    auther: 'auther', 
    completedPercentage: .15, 
    thunbnail: 'assets/ecoleElements.jpg'
  ),
  Course(
    name: 'azerty', 
    auther: 'auther', 
    completedPercentage: .50, 
    thunbnail: 'assets/ecoleElements.jpg'
  ),
  Course(
    name: 'azerty', 
    auther: 'auther', 
    completedPercentage: .30, 
    thunbnail: 'assets/ecoleElements.jpg'
  ),
  Course(
    name: 'azerty', 
    auther: 'auther', 
    completedPercentage: .25, 
    thunbnail: 'assets/ecoleElements.jpg'
  ),
];
*/