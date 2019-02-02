package motogp;
import flambe.System;
import flambe.asset.AssetPack;
import flambe.scene.Director;
import motogp.data.GameData;

/**
 * ...
 * @author Vladimir
 */
class G {
	static public var width:Float = 800;
	static public var height:Float = 600;
	static public var gameData:GameData;
	static public var director:Director;
	static public var pack:AssetPack;

	public function new() {
		
	}
	
	static public function init() {
		//System.storage.clear();
		
		gameData = new GameData();
		gameData.load();
	}
	
}