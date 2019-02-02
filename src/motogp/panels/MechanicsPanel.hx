package motogp.panels;

import flambe.Component;
import flambe.Entity;
import flambe.System;
import flambe.display.Font;
import flambe.display.ImageSprite;
import flambe.display.TextSprite;
import flambe.input.PointerEvent;
import motogp.gift.Gift;
import motogp.screens.GameScreen;
import motogp.tools.BigNumber;
import motogp.tools.Button;

/**
 * ...
 * @author Vladimir
 */
class MechanicsPanel extends Component {
	private var game:GameScreen;
	private var background:ImageSprite;
	private var photo:ImageSprite;
	private var mechIcon:ImageSprite;
	private var mechLabel:TextSprite;
	private var addBtn:Button;
	private var grayMechBtn:ImageSprite;
	private var grayMechLabel:TextSprite;
	private var buyMechBtn:Button;
	private var priceMechLable:TextSprite;
	private var servicePanel:Service;
	var gift:Gift;
	

	public function new(game:GameScreen) {
		this.game = game;
		
		background = new ImageSprite(G.pack.getTexture("mechanic_back"));
		background.setXY(510, 70);
		new Entity().add(background);
		
		photo = new ImageSprite(G.pack.getTexture("mechanics_photo"));
		photo.centerAnchor();
		photo.setXY(background.getNaturalWidth() / 2, 98);
		new Entity().add(photo);
		
		addBtn = new Button("shop/shop_btn");
		addBtn.setXY(80, 330);
		addBtn.eventClick.connect(onClickShop);
		new Entity().add(addBtn);
		
		mechIcon = new ImageSprite(G.pack.getTexture("mech_field"));
		mechIcon.centerAnchor();
		mechIcon.setXY(120, 200);
		new Entity().add(mechIcon);
		
		mechLabel = new TextSprite(new Font(G.pack, "fonts/blue_font_30"), Std.string(G.gameData.mechanics));
		mechLabel.setAlign(TextAlign.Center);
		mechLabel.setXY(104, 0);
		mechIcon.owner.addChild(new Entity().add(mechLabel));
		
		grayMechBtn = new ImageSprite(G.pack.getTexture("buttons/add_btn"));
		grayMechBtn.centerAnchor();
		grayMechBtn.setAlpha(0.7);
		grayMechBtn.pointerDown.connect(onClickGrayMech);
		grayMechBtn.setXY(background.getNaturalWidth() / 2, 250);
		new Entity().add(grayMechBtn);
		
		grayMechLabel = new TextSprite(new Font(G.pack, "fonts/white_font_18"), BigNumber.format(G.gameData.mechanicPrice));
		grayMechLabel.setAlign(TextAlign.Center);
		//grayMechLabel.setAlpha(0.5);
		grayMechLabel.setXY(60, -54);
		grayMechBtn.owner.addChild(new Entity().add(grayMechLabel));
		
		buyMechBtn = new Button("buttons/add_btn");
		buyMechBtn.setXY(background.getNaturalWidth() / 2, 250);
		buyMechBtn.eventClick.connect(onClickBuyMechBtn);
		new Entity().add(buyMechBtn);
		
		priceMechLable = new TextSprite(new Font(G.pack, "fonts/white_font_18"), BigNumber.format(G.gameData.mechanicPrice));
		priceMechLable.setAlign(TextAlign.Center);
		priceMechLable.setXY(60, -54);
		buyMechBtn.owner.addChild(new Entity().add(priceMechLable));
		
		gift = new Gift();
		new Entity().add(gift);
		
		servicePanel = new Service();
		new Entity().add(servicePanel);
		
	}
	
	function onClickGrayMech(e:PointerEvent) {
		//game.showShop();
	}
	
	function onClickShop() {
		game.showShop();
	}
	
	override public function onAdded() {
		super.onAdded();
		
		owner.addChild(background.owner);
		
		background.owner.addChild(photo.owner);
		background.owner.addChild(mechIcon.owner);
		//background.owner.addChild(addBtn.owner);
		background.owner.addChild(grayMechBtn.owner);
		background.owner.addChild(buyMechBtn.owner);
		background.owner.addChild(gift.owner);
		background.owner.addChild(servicePanel.owner);
	}
	
	override public function onUpdate(dt:Float) {
		super.onUpdate(dt);
		
		if (G.gameData.money >= G.gameData.mechanicPrice) {
			background.owner.removeChild(grayMechBtn.owner);
			background.owner.addChild(buyMechBtn.owner);
		} else {
			background.owner.addChild(grayMechBtn.owner);
			background.owner.removeChild(buyMechBtn.owner);
		}
		var price = BigNumber.format(G.gameData.mechanicPrice);
		grayMechLabel.text = price;
		priceMechLable.text = price;
		
		mechLabel.text = Std.string(G.gameData.mechanics);
	}
	
	function onClickBuyMechBtn() {
		if (G.gameData.money >= G.gameData.mechanicPrice) {
			G.pack.getSound("sounds/buy").play();
			G.gameData.money -= G.gameData.mechanicPrice;
			G.gameData.mechanicPrice *= 1.3;
			G.gameData.mechanics++;
		}
	}
	
	
	
}