class ReviewModel {
  ReviewModel({
    required this.Pic_link,
    required this.Name,
    required this.Bio,
    required this.Location,
    required this.rating,
    required this.Time,
    required this.Title,
    required this.TimeN,
  });

  late final String Pic_link;
  late final String Name;
  late final String Location;
  late final String Time;
  late final String Bio;
  late final int rating;
  late final int TimeN;
  late final String Title;

  ReviewModel.fromJson(Map<String, dynamic> json) {
    Pic_link = json['Pic_link'] ?? ' ';
    Name = json['Name'] ?? ' ';
    Location = json['Pic_link'] ?? ' ';
    Time = json['Time'] ?? ' ';
    Bio = json['Bio'] ?? ' ';
    TimeN = json['TimeN'] ?? 567 ;
    rating = json['rating'] ?? 3;
    Title = json['Title'] ?? ' ';
  }
}
