package kong;

import flambe.Component;
import kong.KongMtx;
import motogp.G;
import motogp.panels.AutoSaver;
import motogp.screens.GameScreen;

/**
 * ...
 * @author Vladimir
 */


class KongPurchase extends Component {
	private var itemId:Int;
	private var itemIdentifier:String;

	public function new() {
		
	}
	
	override public function onAdded() {
		super.onAdded();
		
		KongMtx.requestUserItemList(null, onUserItemList);
	}
	
	public function openPurchase(itemName:String) {
		KongMtx.purchaseItems([itemName], onPurchaseResult);
	}
	
	function onPurchaseResult(result:Result):Void {
		if (result.success) {
			KongMtx.requestUserItemList(null, onUserItemList);
		}
	}
	
	function onUserItemList(items:InventoryList):Void {
		for (i in items.data) {
			itemId = i.id;
			itemIdentifier = i.identifier;
			KongMtx.useItemInstance(itemId, onUserItem);
		}
	}
	
	function onUserItem(result:UseResult):Void {
		if (result.success) {
			if (itemIdentifier == "x10") {
				G.gameData.mechanics += 10;
				GameScreen.instance.showMechanicBonus(10);
			} else if (itemIdentifier == "x200") {
				G.gameData.mechanics += 200;
				GameScreen.instance.showMechanicBonus(200);
			} else if (itemIdentifier == "x1000") {
				G.gameData.mechanics += 1000;
				GameScreen.instance.showMechanicBonus(1000);
			}
			itemId = 0;
			itemIdentifier = "";
		}
		AutoSaver.instance.save();
		trace("use id: " + result.id + ", use result: " + result.success);
	}
	
	
	
}