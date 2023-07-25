class Categorie{
  String thumbnail;
  String name;
  int moofCourses;

  Categorie({
    required this.name,
    required this.moofCourses,
    required this.thumbnail
  });
}

List<Categorie> categoryList = [
  Categorie(
    name: 'cours', 
    moofCourses: 55, 
    thumbnail:'assets/téléchargement.jfif'
  ),
  Categorie(
    name: 'salles', 
    moofCourses: 20, 
    thumbnail:'assets/salles.jfif'
  ),
  Categorie(
    name: 'enseignants', 
    moofCourses: 16, 
    thumbnail:'assets/enseignant.jfif'
  ),
  Categorie(
    name: 'classes', 
    moofCourses: 55, 
    thumbnail:'assets/ecoleElements.jpg'
  )  
];