import 'package:contact_app/data/contact_model.dart';
import 'package:faker/faker.dart';
import 'package:get_storage/get_storage.dart';



//for favorite storage
class FavouriteStorage {

  final getStorage = GetStorage('Favorite');
  final storageKey = 'isFavorite'; //has to be String

  var favoriteSelector = Contact(
    name: '${faker.person.firstName()} ${faker.person.lastName()}', 
    email: faker.internet.email(), 
    phoneNumber: faker.phoneNumber.us()
  ).isFavorite;   //favorite();

  ///optional for String/int. just need to pass in "return getStorage.read(storageKey)" in the getter function above and then change it's corresponding type
  ///simultaneously, you can change it to any Data Type you want
  bool isSavedFavorite() {
    return favoriteSelector = true;
  }

  //to let get_storage save whatever you want i.e favourites
  void saveFavorite() {
    getStorage.read(storageKey);
    getStorage.write(storageKey, isSavedFavorite()); //favoriteSelector
  }

}