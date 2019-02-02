package motogp.panels;

import flambe.Component;
import flambe.Entity;

/**
 * ...
 * @author Vladimir
 */
class Pagination extends Component {
	private var buttons:Array<NumericButton> = new Array<NumericButton>();
	private var bikesPanel:BikesPanel;

	public function new(bikesPanel:BikesPanel) {
		this.bikesPanel = bikesPanel;
	}
	
	override public function onAdded() {
		super.onAdded();
		
		for (i in 0...7) {
			var btn:NumericButton = new NumericButton(i);
			btn.setXY(i * 46 + 130, 36);
			btn.eventClick.connect(onClick);
			owner.addChild(new Entity().add(btn));
			buttons.push(btn);
		}
		buttons[0].setActive(true);
	}
	
	function onClick(btn:NumericButton) {
		for (i in buttons) {
			i.setActive(false);
		}
		btn.setActive(true);
		bikesPanel.setPage(btn.id);
	}
	
}