package motogp.panels;

import flambe.Component;
import flambe.Entity;
import flambe.System;
import flambe.display.FillSprite;
import flambe.input.MouseButton;
import flambe.math.Point;
import flambe.math.Rectangle;
import motogp.bikes.LockedBike;
import motogp.bikes.UnlockedBike;
import motogp.data.BikeData;

/**
 * ...
 * @author Vladimir
 */
class BikesPanel extends Component {
	private var background:FillSprite;
	private var container:Entity = new Entity();
	
	private var bikesBack:FillSprite;
	private var pagin:Pagination;

	public function new() {
		background = new FillSprite(0x472D3D, 480, 512);
		background.setXY(30, 70);
		background.scissor = new Rectangle(0, 0, 480, 512);
		container.add(background);
		
		bikesBack = new FillSprite(0x472D3D, 4000, 512);
		container.addChild(new Entity().add(bikesBack));
		
		pagin = new Pagination(this);
		new Entity().add(pagin);
	}
	
	override public function onAdded() {
		super.onAdded();
		
		owner.addChild(pagin.owner);
		
		owner.addChild(container);
		
		var index:Int = 0;
		for (i in 0...14) {
			for (j in 0...5) {
				if (G.gameData.bikesData[index].isOpen) {
					makeUnlockedBike(G.gameData.bikesData[index], 244 * i, 104 * j);
				} else {
					makeLockedBike(G.gameData.bikesData[index], 244 * i, 104 * j);
				}
				index++;
			}
		}
	}
	
	private function makeLockedBike(data:BikeData, x:Float, y:Float) {
		var loc:LockedBike = new LockedBike(data, new Point(x, y));
		loc.eventBuy.connect(onBuy);
		bikesBack.owner.addChild(new Entity().add(loc));
	}
	
	private function makeUnlockedBike(data:BikeData, x:Float, y:Float) {
		var unlock:UnlockedBike = new UnlockedBike(data, new Point(x, y));
		bikesBack.owner.addChild(new Entity().add(unlock));
	}
	
	public function setPage(page:Int) {
		bikesBack.x._ = -(page * 488);
	}
	
	function onBuy(lockBike:LockedBike) {
		bikesBack.owner.removeChild(lockBike.owner);
		
		var unl:UnlockedBike = new UnlockedBike(lockBike.data, lockBike.position);
		bikesBack.owner.addChild(new Entity().add(unl));
	}
	
	override public function onUpdate(dt:Float) {
		super.onUpdate(dt);
		
	}
	
}