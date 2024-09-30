const baseUrl =
    'max-shoppinglist-default-rtdb.europe-west1.firebasedatabase.app';
const shoppingListPath = 'shopping-list.json';

String deleteItem(String id) => 'shopping-list/$id.json';
