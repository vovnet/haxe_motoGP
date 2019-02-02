package motogp.data;
import flambe.System;
import flambe.math.Point;
import motogp.bikes.BikesFactory;
import motogp.data.BikeData;

/**
 * ...
 * @author Vladimir
 */
class GameData {
	public var bikesData:Array<BikeData> = new Array<BikeData>();
	public var money:Float;
	public var gears:Float;
	public var distance:Float;
	public var flags:Float;
	public var mechanics:Float;
	public var mechanicPrice:Float;
	public var isTutorComplete:Bool;
	public var isOnSound:Bool;
	public var giftTimer:Float;
	
	private var isExistSaves:Bool;

	public function new() {
		
	}
	
	public function load() {
		isExistSaves = System.storage.get("isExistSaves", false);
		
		if (isExistSaves) {
			bikesData = System.storage.get("bikes");
			money = System.storage.get("money");
			gears = System.storage.get("gears");
			distance = System.storage.get("distance");
			flags = System.storage.get("flags");
			mechanics = System.storage.get("mechanics");
			mechanicPrice = System.storage.get("mechanicPrice");
			isTutorComplete = System.storage.get("isTutorComplete");
			isOnSound = System.storage.get("isOnSound");
			giftTimer = System.storage.get("giftTimer");
		} else {
			init();
		}
	}
	
	public function save() {
		isExistSaves = true;
		
		System.storage.set("isExistSaves", isExistSaves);
		System.storage.set("bikes", bikesData);
		System.storage.set("money", money);
		System.storage.set("gears", gears);
		System.storage.set("distance", distance);
		System.storage.set("flags", flags);
		System.storage.set("mechanics", mechanics);
		System.storage.set("mechanicPrice", mechanicPrice);
		System.storage.set("isTutorComplete", isTutorComplete);
		System.storage.set("isOnSound", isOnSound);
		System.storage.set("giftTimer", giftTimer);
	}
	
	private function init() {
		money = 500;
		gears = 3;
		distance = 0;
		flags = 0;
		mechanics = 3;
		mechanicPrice = 550;
		isTutorComplete = false;
		isOnSound = true;
		giftTimer = 181;
		
		var factory:BikesFactory = new BikesFactory();
		bikesData = factory.getBikes();
	}
	
}