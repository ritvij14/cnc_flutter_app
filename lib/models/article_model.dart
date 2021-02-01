class Article {
  final String author;
  final String title;
  final String body;

  Article({this.author, this.title, this.body});
}

final List<Article> ARTICLES = [
  Article(
      author: 'Dr. Nutrition',
      title: 'How to Eat Right',
      body:
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,but also the leap into electronic typesetting,remaining essentially unchanged. '),
  Article(
      author: 'Dr. Recovery',
      title: 'Tips to Recover',
      body: 'Lorem Ipsum is simply dummy text of the printing orem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,but als'),
  Article(
      author: 'Dr. Diet',
      title: 'What to Eat',
      body: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,but also the leap into electronic typesetting,remaining essentially unchanged. '),
];

