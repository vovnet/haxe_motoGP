package motogp.bikes;

import flambe.Component;
import flambe.Entity;
import flambe.System;
import flambe.display.Font;
import flambe.display.ImageSprite;
import flambe.display.TextSprite;
import flambe.math.Point;
import flambe.util.Signal1;
import flambe.util.Signal2;
import motogp.data.BikeData;
import motogp.tools.BigNumber;
import motogp.tools.Button;
import motogp.tutorials.TutorialManager;

/**
 * ...
 * @author Vladimir
 */
class LockedBike extends Component {
	public var eventBuy:Signal1<LockedBike> = new Signal1<LockedBike>();
	public var data:BikeData;
	public var position:Point;
	
	private var background:ImageSprite;
	private var nameLabel:TextSprite;
	private var image:ImageSprite;
	private var buyBtn:Button;
	private var buyLabel:TextSprite;
	private var gearIcon:ImageSprite;
	private var coinIcon:ImageSprite;
	private var gearLabel:TextSprite;
	private var coinLabel:TextSprite;
	private var grayBtn:ImageSprite;
	private var grayBtnLabel:TextSprite;

	public function new(data:BikeData, position:Point) {
		this.data = data;
		this.position = position;
		
		background = new ImageSprite(G.pack.getTexture("locked_back"));
		background.setXY(position.x, position.y);
		new Entity().add(background);
		
		image = new ImageSprite(G.pack.getTexture("bikes/" + data.image));
		image.setXY(4, 4);
		new Entity().add(image);
		
		nameLabel = new TextSprite(new Font(G.pack, "fonts/white_font_18"), data.name);
		nameLabel.align = TextAlign.Center;
		nameLabel.setXY(158, -45);
		new Entity().add(nameLabel);
		
		grayBtn = new ImageSprite(G.pack.getTexture("buttons/small_gray_btn"));
		grayBtn.centerAnchor();
		grayBtn.setXY(47, 75);
		new Entity().add(grayBtn);
		
		grayBtnLabel = new TextSprite(new Font(G.pack, "fonts/white_font_18"), BigNumber.format(data.openPrice));
		grayBtnLabel.align = TextAlign.Center;
		grayBtnLabel.setXY(grayBtn.getNaturalWidth() / 2, -55);
		grayBtnLabel.setAlpha(0.5);
		new Entity().add(grayBtnLabel);
		grayBtn.owner.addChild(grayBtnLabel.owner);
		
		buyBtn = new Button("buttons/small_blue_btn");
		buyBtn.setXY(47, 75);
		buyBtn.eventClick.connect(onClickBuyBtn);
		new Entity().add(buyBtn);
		
		buyLabel = new TextSprite(new Font(G.pack, "fonts/white_font_18"), BigNumber.format(data.openPrice));
		buyLabel.align = TextAlign.Center;
		buyLabel.setXY(buyBtn.getWidth() / 2, -55);
		new Entity().add(buyLabel);
		buyBtn.owner.addChild(buyLabel.owner);
		
		gearIcon = new ImageSprite(G.pack.getTexture("icons/small_gear"));
		gearIcon.setXY(96, 56);
		new Entity().add(gearIcon);
		
		coinIcon = new ImageSprite(G.pack.getTexture("icons/small_coin"));
		coinIcon.setXY(160, 58);
		new Entity().add(coinIcon);
		
		gearLabel = new TextSprite(new Font(G.pack, "fonts/white_font_14"), Std.string(data.gears));
		gearLabel.align = TextAlign.Center;
		gearLabel.setXY(140, -4);
		new Entity().add(gearLabel);
		
		coinLabel = new TextSprite(new Font(G.pack, "fonts/white_font_14"), BigNumber.format(data.award));
		coinLabel.align = TextAlign.Center;
		coinLabel.setXY(206, -4);
		new Entity().add(coinLabel);
	}
	
	function onClickBuyBtn() {
		if (G.gameData.money >= data.openPrice) {
			G.pack.getSound("sounds/engine3").play();
			G.gameData.money -= data.openPrice;
			data.isOpen = true;
			eventBuy.emit(this);
			TutorialManager.eventBuyBike.emit();
		}
	}
	
	override public function onAdded() {
		super.onAdded();
		
		owner.addChild(background.owner);
		
		background.owner.addChild(image.owner);
		background.owner.addChild(nameLabel.owner);
		background.owner.addChild(grayBtn.owner);		
		background.owner.addChild(buyBtn.owner);
		background.owner.addChild(gearIcon.owner);
		background.owner.addChild(coinIcon.owner);
		background.owner.addChild(gearLabel.owner);
		background.owner.addChild(coinLabel.owner);
	}
	
	override public function onUpdate(dt:Float) {
		super.onUpdate(dt);
		
		if (G.gameData.money >= data.openPrice) {
			background.owner.removeChild(grayBtn.owner);
			background.owner.addChild(buyBtn.owner);
		} else {
			background.owner.addChild(grayBtn.owner);
			background.owner.removeChild(buyBtn.owner);
		}
	}
	
	public function setXY(x:Float, y:Float) {
		background.setXY(x, y);
	}
	
}