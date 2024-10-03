class Item {
  String name;
  double price;
  Item(this.name, this.price);

  String displayItem() {
    return "Item $name , Price of item =${price.toStringAsFixed(2)}";
  }
}

class ItemStock {
  Item item;
  int stock;
  ItemStock(this.item, this.stock);

  bool availableStock() {
    return stock > 0;
  }

  void lessStocks() {
    if (availableStock()) {
      stock - 1;
    }
  }
}

class vendingMachine {
  List<ItemStock> items = [];
  double balance = 0;
  vendingMachine();

  void addItem(Item item, int stock) {
    ItemStock NewStock = ItemStock(item, stock);
    items.add(NewStock);
  }

  ///got this online
  ItemStock selectItem(String itemName) {
    for (int i = 0; i < items.length; i++) {
      ItemStock itemStock = items[i];
      if (itemStock.item.name == itemName) {
        if (itemStock.availableStock()) {
          print(itemStock.item.displayItem());
          return itemStock;
        } else {
          print("${itemName}  is out of stock.");
          return ItemStock(Item("None", 0), 0);
        }
      }
    }
    print("${itemName}   not found.");
    return ItemStock(Item("is not found", 0), 0);
  }

  void insertMoney(double amount) {
    if (amount > 0) {
      balance = amount + balance;
      print(
          "inserted value  ${amount.toStringAsFixed(1)} balance = ${balance.toStringAsFixed(1)} .");
    } else {
      print("a valid amount is needed");
    }
  }

  void dispenseItem(String itemName) {
    ItemStock itemChosen = selectItem(itemName);

    if (itemChosen.stock > 0) {
      if (balance >= itemChosen.item.price) {
        balance = itemChosen.item.price - balance;
        itemChosen.lessStocks();

        print(itemChosen.item.name);
        if (balance > 0) {
          print("cash back ${balance.toStringAsFixed(1)}");
        }
        balance = 0;
      } else {
        print("money is needed");
      }
    } else {
      print("${itemChosen.item.name} out of stock.");
    }
  }

  double getChange() {
    double change = balance;
    balance = 0;
    return change;
  }
}

void main() {
  vendingMachine vending = vendingMachine();

  vending.addItem(Item("kitkat", 0.200), 20);
  vending.insertMoney(1.00);
  vending.dispenseItem("kitkat");
}
