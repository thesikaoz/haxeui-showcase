package haxe.ui.showcase.views;

import haxe.ui.toolkit.core.Component;
import haxe.ui.toolkit.core.XMLController;

@:build(haxe.ui.toolkit.core.Macros.buildController("assets/resources/VerticalLayout/VerticalLayout.xml"))
class VerticalLayout extends XMLController {
	private static var HALIGNS:Array<String> = ["left", "center", "right"];
	
	public function new() {
		theBox.onReady = function(e) {
			width.pos = theBox.width;
			height.pos = theBox.height;
			width.disabled = autoSize.selected;
			height.disabled = autoSize.selected;
			
			widthLabel.text = "" + width.pos;
			heightLabel.text = "" + height.pos;
		};
		
		getComponent(child.text).onReady = function(e) {
			updateChildValues();
		};
		
		width.onChange = function(e) {
			theBox.width = width.pos;
			widthLabel.text = "" + width.pos;
		}
		
		height.onChange = function(e) {
			theBox.height = height.pos;
			heightLabel.text = "" + height.pos;
		}

		autoSize.onChange = function(e) {
			theBox.autoSize = autoSize.selected;
			width.disabled = autoSize.selected;
			height.disabled = autoSize.selected;
			width.pos = theBox.width;
			height.pos = theBox.height;
		};

		clipContent.onChange = function(e) {
			theBox.clipContent = clipContent.selected;
		};
		
		disabled.onChange = function(e) {
			theBox.disabled = disabled.selected;
		};
		
		child.onChange = function(e) {
			updateChildValues();
		}
		
		childWidth.onChange = function(e) {
			updateChildWidth();
		}

		childHeight.onChange = function(e) {
			updateChildHeight();
		}
		
		childWidthAsPercent.onClick = function(e) {
			updateChildWidth();
		}
		
		childHeightAsPercent.onClick = function(e) {
			updateChildHeight();
		}
		
		halign.onChange = function(e) {
			var c:Component = getComponent(child.text);
			c.horizontalAlign = halign.text;
		}
	}
	
	private function updateChildValues():Void {
		var c:Component = getComponent(child.text);
		if (c.percentWidth == -1) {
			childWidthAsPercent.selected = false;
			childWidth.pos = c.width;
			childWidthLabel.text = "" + c.width;
		} else {
			childWidthAsPercent.selected = true;
			childWidth.pos = c.percentWidth;
			childWidthLabel.text = "" + c.percentWidth;
		}
		
		if (c.percentHeight == -1) {
			childHeightAsPercent.selected = false;
			childHeight.pos = c.height;
			childHeightLabel.text = "" + c.height;
		} else {
			childHeightAsPercent.selected = true;
			childHeight.pos = c.percentHeight;
			childHeightLabel.text = "" + c.percentHeight;
		}
		
		halign.selectedIndex = Lambda.indexOf(HALIGNS, c.horizontalAlign);
	}
	
	private function updateChildWidth():Void {
		var c:Component = getComponent(child.text);
		if (childWidthAsPercent.selected == false) {
			c.percentWidth = -1;
			c.width = childWidth.pos;
			childWidthLabel.text = "" + c.width;
		} else {
			c.percentWidth = childWidth.pos;
			childWidthLabel.text = "" + c.percentWidth;
		}
		width.pos = theBox.width;
	}
	
	private function updateChildHeight():Void {
		var c:Component = getComponent(child.text);
		if (childHeightAsPercent.selected == false) {
			c.percentHeight = -1;
			c.height = childHeight.pos;
			childHeightLabel.text = "" + c.height;
		} else {
			c.percentHeight = childHeight.pos;
			childHeightLabel.text = "" + c.percentHeight;
		}
		height.pos = theBox.height;
	}
}