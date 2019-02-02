package motogp.data;

/**
 * ...
 * @author Vladimir
 */
class BikeData {
	public var name:String;
	public var image:String;
	public var isOpen:Bool;
	public var openPrice:Float;
	public var upgradePrice:Float;
	public var speed:Float;
	public var gears:Float;
	public var award:Float;
	public var awardRait:Float;
	
	public var timeToFihish:Float;
	public var currentAward:Float;

	public function new() {
		
	}
	
	public function init(name:String, image:String, isOpen:Bool, openPrice:Float, upgradePrice:Float, speed:Float, gears:Float, award:Float, awardRait:Float):BikeData {
		this.name = name;
		this.image = image;
		this.isOpen = isOpen;
		this.openPrice = openPrice;
		this.upgradePrice = upgradePrice;
		this.speed = speed;
		this.gears = gears;
		this.award = award;
		this.awardRait = awardRait;
		
		timeToFihish = 0;
		currentAward = 0;
		
		return this;
	}
	
	public function toObject():Dynamic {
		return {
			"name":name,
			"image":image,
			"isOpen":isOpen,
			"openPrice":openPrice,
			"upgradePrice":upgradePrice,
			"speed":speed,
			"gears":gears,
			"award":award,
			"awardRait":awardRait,
			"timeToFihish":timeToFihish,
			"currentAward":currentAward
		};
	}
	
	static public function fromObject(obj:Dynamic):BikeData {
		var data:BikeData = new BikeData();
		data.name = obj.name;
		data.image = obj.image;
		data.isOpen = obj.isOpen;
		data.openPrice = obj.openPrice;
		data.upgradePrice = obj.upgradePrice;
		data.speed = obj.speed;
		data.gears = obj.gears;
		data.award = obj.award;
		data.awardRait = obj.awardRait;
		data.timeToFihish = obj.timeToFihish;
		data.currentAward = obj.currentAward;
		return data;
	}
	
}