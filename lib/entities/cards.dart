//classe com esse nome para nao confundir com o widget Card

class Cards {
  int id;
  String title;
  String content;

  Cards({this.id, this.title, this.content});

  Cards.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    content = map['content'];
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'content': content};
  }

  @override
  String toString() {
    return ' id: $id, titulo: $title, conteudo: $content';
  }
}
