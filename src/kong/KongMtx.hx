package kong;

typedef PurchaseItem = {
	var identifier:String;
	var data:String;
}

typedef Result = {
	var success:Bool;
}
 
typedef InventoryItem = {
	var id:Int;
	var identifier:String;
	var name:String;
	var data:String;
	var remaining_use:Int;
}

typedef InventoryList = {
	var success:Bool;
	var data:Array<InventoryItem>;
}

typedef UseResult = {
	var success:Bool;
	var id:Int;
}

@:fakeEnum(String) enum PurchaseMethod
{ 
	offers;
	mobile;
} 

@:native("parent.kongregate.mtx")
extern class KongMtx {
	
	static public function purchaseItems(items:Array<Dynamic>, purchaseCallback:Result->Void):Void;
	
	static public function requestUserItemList(username:String, itemListCallback:InventoryList->Void):Void;
	
	static public function showKredPurchaseDialog(purchaseMethod:PurchaseMethod): Void;
	
	static public function useItemInstance(itemInstanceId:Int, callback:UseResult->Void):Void;
	
}