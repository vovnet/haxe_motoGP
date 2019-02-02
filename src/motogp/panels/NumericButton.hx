package motogp.panels;

import flambe.Component;
import flambe.Entity;
import flambe.display.Font;
import flambe.display.ImageSprite;
import flambe.display.TextSprite;
import flambe.util.Signal1;
import motogp.tools.Button;

/**
 * ...
 * @author Vladimir
 */
class NumericButton extends Component {
	public var eventClick:Signal1<NumericButton> = new Signal1<NumericButton>();
	public var id:Int;
	
	private var back:ImageSprite;
	private var btn:Button;
	private var isActive:Bool = false;

	public function new(id:Int) {
		this.id = id;
		
		back = new ImageSprite(G.pack.getTexture("buttons/active_pagination_btn"));
		back.centerAnchor();
		new Entity().add(back);
		
		btn = new Button("buttons/pagination_btn");
		btn.eventClick.connect(onClick);
		new Entity().add(btn);
		
		var grayLabel:TextSprite = new TextSprite(new Font(G.pack, "fonts/white_font_18"), Std.string(id + 1));
		grayLabel.setAlign(TextAlign.Center);
		grayLabel.setXY(back.getNaturalWidth() / 2, -50);
		grayLabel.setAlpha(0.5);
		back.owner.addChild(new Entity().add(grayLabel));
		
		var btnLabel:TextSprite = new TextSprite(new Font(G.pack, "fonts/white_font_18"), Std.string(id + 1));
		btnLabel.setAlign(TextAlign.Center);
		btnLabel.setXY(btn.getWidth() / 2, -50);
		btn.owner.addChild(new Entity().add(btnLabel));
	}
	
	override public function onUpdate(dt:Float) {
		super.onUpdate(dt);
		
		if (isActive) {
			owner.removeChild(btn.owner);
			owner.addChild(back.owner);
		} else {
			owner.addChild(btn.owner);
			owner.removeChild(back.owner);
		}
	}
	
	public function setXY(x:Float, y:Float) {
		back.setXY(x, y);
		btn.setXY(x, y);
	}
	
	public function setActive(isActive:Bool) {
		this.isActive = isActive;
	}
	
	function onClick() {
		eventClick.emit(this);
	}
	
	
	
}