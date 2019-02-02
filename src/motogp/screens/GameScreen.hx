package motogp.screens;

import flambe.Component;
import flambe.Entity;
import flambe.display.FillSprite;
import flambe.display.Font;
import flambe.display.ImageSprite;
import flambe.display.TextSprite;
import flambe.math.Point;
import kong.KongMtx;
import kong.KongPurchase;
import motogp.bikes.LockedBike;
import motogp.bikes.UnlockedBike;
import motogp.data.BikeData;
import motogp.effects.Sun;
import motogp.panels.AutoSaver;
import motogp.panels.BikesPanel;
import motogp.panels.Distance;
import motogp.panels.MechanicsPanel;
import motogp.panels.SoundButton;
import motogp.panels.UpPanel;
import motogp.shop.Shop;
import motogp.tools.BigNumber;
import motogp.tutorials.TutorialManager;

/**
 * ...
 * @author Vladimir
 */
class GameScreen extends Component {
	public static var instance:GameScreen;
	
	public var kongPurchase:KongPurchase;
	
	private var background:FillSprite;
	private var upPanel:UpPanel;
	private var mechanicsPanel:MechanicsPanel;
	private var bikesPanel:BikesPanel;
	private var distance:Distance;
	private var shop:Shop;
	
	private var sun:Sun;
	private var icon:ImageSprite;
	
	private var mainLayer:Entity = new Entity();
	private var shopLayer:Entity = new Entity();
	private var bonusLayer:Entity = new Entity();
	private var tutorLayer:Entity = new Entity();
	
	private var goldIcon:ImageSprite;
	private var goldLabel:TextSprite;
	
	private var mechIcon:ImageSprite;
	private var mechLabel:TextSprite;

	public function new() {
		instance = this;
		
		icon = new ImageSprite(G.pack.getTexture("icons/big_flag"));
		icon.disablePointer();
		icon.centerAnchor();
		icon.setXY(G.width / 2, G.height / 2);
		new Entity().add(icon);
		
		goldIcon = new ImageSprite(G.pack.getTexture("icons/gold"));
		goldIcon.disablePointer();
		goldIcon.centerAnchor();
		goldIcon.setXY(G.width / 2, G.height / 2);
		new Entity().add(goldIcon);
		
		goldLabel = new TextSprite(new Font(G.pack, "fonts/white_font_72"));
		goldLabel.setAlign(TextAlign.Center);
		goldLabel.setXY(goldIcon.getNaturalWidth() / 2, 200);
		goldIcon.owner.addChild(new Entity().add(goldLabel));
		
		mechIcon = new ImageSprite(G.pack.getTexture("icons/big_mechanics"));
		mechIcon.disablePointer();
		mechIcon.centerAnchor();
		mechIcon.setXY(G.width / 2, G.height / 2);
		new Entity().add(mechIcon);
		
		mechLabel = new TextSprite(new Font(G.pack, "fonts/white_font_72"));
		mechLabel.setAlign(TextAlign.Center);
		mechLabel.setXY(mechIcon.getNaturalWidth() / 2, 200);
		mechIcon.owner.addChild(new Entity().add(mechLabel));
	}
	
	override public function onAdded() {
		super.onAdded();
		
		owner.addChild(mainLayer);
		owner.addChild(shopLayer);
		owner.addChild(tutorLayer);
		owner.addChild(bonusLayer);
		
		background = new FillSprite(0x472d3d, G.width, G.height);
		mainLayer.addChild(new Entity().add(background));
		
		bikesPanel = new BikesPanel();
		mainLayer.addChild(new Entity().add(bikesPanel));
		
		upPanel = new UpPanel();
		mainLayer.addChild(new Entity().add(upPanel));
		
		mechanicsPanel = new MechanicsPanel(this);
		mainLayer.addChild(new Entity().add(mechanicsPanel));
		
		distance = new Distance(this);
		mainLayer.addChild(new Entity().add(distance));
		
		shop = new Shop();
		shopLayer.addChild(new Entity().add(shop));
		
		sun = new Sun();
		bonusLayer.addChild(new Entity().add(sun));
		
		if (!G.gameData.isTutorComplete) {
			var tutorials:TutorialManager = new TutorialManager();
			tutorLayer.addChild(new Entity().add(tutorials));
		}
		
		var soundBtn:SoundButton = new SoundButton();
		soundBtn.setXY(456, 38);
		mainLayer.addChild(new Entity().add(soundBtn));
		
		var saver:AutoSaver = new AutoSaver();
		mainLayer.addChild(new Entity().add(saver));
		
		G.pack.getSound("sounds/loop").loop().volume.animate(0, 1, 3);
		
		// GOTO: kongregate purchase
		/*
		kongPurchase = new KongPurchase();
		mainLayer.addChild(new Entity().add(kongPurchase));
		*/
	}
	
	public function showShop() {
		shop.show();
	}
	
	public function showNewLevel() {
		G.pack.getSound("sounds/win").play();
		sun.show(icon.owner);
	}
	
	public function showMoneyBonus(money:Float) {
		G.pack.getSound("sounds/win").play();
		goldLabel.text = BigNumber.format(money);
		sun.show(goldIcon.owner);
	}
	
	public function showMechanicBonus(num:Int) {
		G.pack.getSound("sounds/win").play();
		mechLabel.text = Std.string(num);
		sun.show(mechIcon.owner);
	}
}