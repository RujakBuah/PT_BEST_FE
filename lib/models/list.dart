class ListModel {
  String jobGiver;
  String posted; 
  String address; 
  String dropAt; 
  String deadline; 
  String priceOffer; 

  ListModel({
    required this.jobGiver,
    required this.posted,
    required this.address,
    required this.dropAt,
    required this.deadline,
    required this.priceOffer,
  });

  static List < ListModel > getList() {
    List < ListModel > jblists = [];

    jblists.add(
      ListModel(jobGiver: 'Asep Dimanasye', posted: '2 hours ago', address: 'Jl. Land of dawn, Mid lane, nomer 6, Turtle', dropAt: 'Jl. Land of dawn, Jungle, nomer 9, Lord', deadline: '15/09/2025', priceOffer: 'Rp 20,000')
    );

    jblists.add(
      ListModel(jobGiver: 'Hidayat Arba Putra', posted: '6 hours ago', address: 'Jl. Land of dawn, Mid lane, nomer 6, Turtle', dropAt: 'Jl. Land of dawn, Jungle, nomer 9, Lord', deadline: '15/09/2025', priceOffer: 'Rp 29,000')
    );

    return jblists;
  }
}