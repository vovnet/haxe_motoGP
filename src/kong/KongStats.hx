package kong;

/**
 * ...
 * @author Vladimir
 */
@:native("parent.kongregate.stats")
extern class KongStats {

	public function new() {
		
	}
	
	public static function submit(name:String, value:Int):Void;
	
}