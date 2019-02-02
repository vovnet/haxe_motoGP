package motogp.shop;

import flambe.Component;
import flambe.Entity;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;
import flambe.script.CallFunction;
import flambe.script.Delay;
import flambe.script.Script;
import flambe.script.Sequence;
import kong.KongUser;
import motogp.screens.GameScreen;
import motogp.tools.Button;

/**
 * ...
 * @author Vladimir
 */
class Shop extends Component {
	private var fade:FillSprite;
	private var background:ImageSprite;
	private var closeBtn:Button;
	private var x10Btn:Button;
	private var x200Btn:Button;
	private var x1000Btn:Button;
	
	private var script:Script;
	private var sequenceShow:Sequence;
	private var sequenceHide:Sequence;

	public function new() {
		fade = new FillSprite(0x000000, G.width, G.height);
		fade.setAlpha(0.6);
		new Entity().add(fade);
		
		background = new ImageSprite(G.pack.getTexture("shop/background"));
		background.centerAnchor();
		background.setXY(G.width / 2, G.height / 2);
		new Entity().add(background);
		
		closeBtn = new Button("shop/close_btn");
		closeBtn.setXY(380, 37);
		closeBtn.eventClick.connect(onClickClose);
		background.owner.addChild(new Entity().add(closeBtn));
		
		x10Btn = new Button("shop/x10_btn");
		x10Btn.setXY(70, 230);
		x10Btn.eventClick.connect(onClickX10);
		background.owner.addChild(new Entity().add(x10Btn));
		
		x200Btn = new Button("shop/x200_btn");
		x200Btn.setXY(200, 190);
		x200Btn.eventClick.connect(onClickX200);
		background.owner.addChild(new Entity().add(x200Btn));
		
		x1000Btn = new Button("shop/x1000_btn");
		x1000Btn.setXY(330, 230);
		x1000Btn.eventClick.connect(onClickX1000);
		background.owner.addChild(new Entity().add(x1000Btn));
		
		script = new Script();
		sequenceShow = new Sequence([
			new CallFunction(startShow)
		]);
		sequenceHide = new Sequence([
			new CallFunction(startHide),
			new Delay(0.3),
			new CallFunction(endHide)
		]);
	}
	
	override public function onAdded() {
		super.onAdded();
		
		owner.add(script);
	}
	
	public function show() {
		script.run(sequenceShow);
	}
	
	public function hide() {
		script.run(sequenceHide);
	}
	
	function onClickClose() {
		hide();
	}
	
	function startShow() {
		owner.addChild(fade.owner);
		owner.addChild(background.owner);
		
		fade.alpha.animate(0, 0.6, 0.2);
		background.alpha.animate(0, 1, 0.2);
		background.y.animate(G.height / 2 - 100, G.height / 2, 0.2);
	}
	
	function startHide() {
		fade.alpha.animateTo(0, 0.2);
		background.alpha.animateTo(0, 0.1);
	}
	
	function endHide() {
		owner.removeChild(fade.owner);
		owner.removeChild(background.owner);
	}
	
	function onClickX10() {
		GameScreen.instance.kongPurchase.openPurchase("x10");
	}
	
	function onClickX200() {
		GameScreen.instance.kongPurchase.openPurchase("x200");
	}
	
	function onClickX1000() {
		GameScreen.instance.kongPurchase.openPurchase("x1000");
	}
	
}