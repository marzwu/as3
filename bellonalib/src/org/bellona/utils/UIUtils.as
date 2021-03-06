package org.bellona.utils {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * UI的一些方便的方法
	 * @author marz
	 */
	public class UIUtils {
		public static const RIGHT:String = 'right';
		public static const TOP:String = 'top';
		public static const LEFT:String = 'left';
		public static const BOTTOM:String = 'bottom';
		
		/**
		 * 定位到父容器的中间
		 * @param src
		 * @param des 父容器
		 *
		 */
		public static function centerToParent(self:DisplayObject):void {
			self.x = (self.parent.width - self.width) >> 1;
			self.y = (self.parent.height - self.height) >> 1;
		}
		
		/**
		 * 定位到坐标系内的某矩形的中间
		 * @param src
		 * @param rect 与src坐标系相同
		 *
		 */
		public static function centerToRect(self:DisplayObject, rect:Rectangle):void {
			self.x = rect.x + ((rect.width - self.width) >> 1);
			self.y = rect.y + ((rect.height - self.height) >> 1);
		}
		
		public static function centerToStage(self:DisplayObject, stage:Stage):void {
			var point:Point = new Point();
			point.x = ((stage.stageWidth - self.width) >> 1);
			point.y = ((stage.stageHeight - self.height) >> 1);
			
			point = self.parent.globalToLocal(point);
			self.x = point.x;
			self.y = point.y;
		}
		
		public static function getStagePos(dis:DisplayObject, offset:Point):Point {
			var global:Point = dis.localToGlobal(offset);
			return global;
		}
		
		public static function setToStagePos(dis:DisplayObject, des:Point):void {
			var pos:Point = dis.parent.globalToLocal(des);
			dis.x = pos.x;
			dis.y = pos.y;
		}
		
		/**
		 * 定位到des的右侧
		 * @param src
		 * @param des 与src坐标系相同
		 *
		 */
		public static function rightTo(self:DisplayObject, des:DisplayObject, gap:int = 8):void {
			self.x = des.x + des.width + gap;
		}
		
		/**
		 * 定位到des的下面
		 * @param src
		 * @param des 与src坐标系相同
		 *
		 */
		public static function bottomTo(self:DisplayObject, des:DisplayObject, gap:int = 8):void {
			self.y = des.y + des.height + gap;
		}
		
		/**
		 * 与des纵向居中对齐
		 * @param src
		 * @param des 与src坐标系相同
		 *
		 */
		public static function verticalMiddleTo(self:DisplayObject, des:*):void {
			self.y = des.y + ((des.height - self.height) >> 1);
		}
		
		/**
		 * 与des横向居中对齐
		 * @param self
		 * @param des
		 *
		 */
		public static function horizontalCenterTo(self:DisplayObject, des:*):void {
			if (des is Stage) {
				self.x = ((des as Stage).stageWidth - self.width) >> 1;
			} else {
				self.x = des.x + ((des.width - self.width) >> 1);
			}
		}
		
		/**
		 * 纵向将对象居中
		 * @param self
		 *
		 */
		public static function verticalMiddleToParent(self:DisplayObject):void {
			self.y = ((self.parent.height - self.height) >> 1);
		}
		
		/**
		 * 横向将对象居中
		 * @param self
		 *
		 */
		public static function horizontalCenterToParent(self:DisplayObject):void {
			self.x = ((self.parent.width - self.width) >> 1);
		}
		
		/**
		 * 文本组横向居中
		 * @param texts
		 * @param refer
		 *
		 */
		public static function horizontalCenterTextsTo(texts:Vector.<TextField>, refer:*):void {
			var box:Rectangle = null;
			var text:TextField = null;
			
			for each (text in texts) {
				var bounds:Rectangle = text.getBounds(text.parent);
				if (box == null) {
					box = bounds;
				} else {
					box = bounds.union(box);
				}
			}
			
			var marginLeft:int = int.MAX_VALUE;
			var marginRight:int = int.MAX_VALUE;
			for each (text in texts) {
				var leftToBox:Number = text.x - box.x;
				var rightToBox:Number = (box.x + box.width) - (text.x + text.width);
				switch (text.autoSize) {
					case TextFieldAutoSize.LEFT:
					case TextFieldAutoSize.NONE:
						marginLeft = Math.min(marginLeft, leftToBox);
						marginRight = Math.min(marginRight, text.width - text.textWidth + rightToBox);
						break;
					case TextFieldAutoSize.CENTER:
						marginLeft = Math.min(marginLeft, leftToBox + ((text.width - text.textWidth) >> 1));
						marginRight = Math.min(marginRight, ((text.width - text.textWidth) >> 1) + rightToBox);
						break;
					case TextFieldAutoSize.RIGHT:
						marginLeft = Math.min(marginLeft, leftToBox + text.width - text.textWidth);
						marginRight = Math.min(marginRight, rightToBox);
					default:
						break;
				}
			}
			
			var offset:Number = refer.x + ((refer.width - (box.width - marginLeft - marginRight)) >> 1);
			offset -= box.x + marginLeft;
			
			for each (text in texts) {
				text.x += offset;
			}
		}
		
		/**
		 * 将文本纵向与目标居中对齐
		 * @param tf
		 * @param refer
		 *
		 */
		public function verticalCentralText(tf:TextField, refer:DisplayObject):void {
			tf.y = refer.y + ((refer.height - (tf.textHeight + 4)) >> 1);
		}
		
		public static function removeFromParent(self:DisplayObject):void {
			if (self && self.parent) {
				self.parent.removeChild(self);
			}
		}
		
		public static function setPivotX(self:DisplayObject, pivotX:int):void {
			self.x = -pivotX;
		}
		
		public static function setPivotY(self:DisplayObject, pivotY:int):void {
			self.y = -pivotY;
		}
		
		public static function setPivot(self:DisplayObject, pivotX:int, pivotY:int):void {
			setPivotX(self, pivotX);
			setPivotY(self, pivotY);
		}
		
		public static function setPivotDefault(self:DisplayObject):void {
			setPivotX(self, self.width >> 1);
			setPivotY(self, self.height >> 1);
		}
		
		public static function swapPos(dis1:DisplayObject, dis2:DisplayObject):void {
			var x:Number = dis1.x;
			var y:Number = dis1.y;
			dis1.x = dis2.x;
			dis1.y = dis2.y;
			dis2.x = x;
			dis2.y = y;
		}
		
		public static function align(src:DisplayObject, refer:DisplayObject, pos:String):void {
			switch (pos) {
				case LEFT:
					src.x = refer.x;
					break;
				case TOP:
					src.y = refer.y;
					break;
				case RIGHT:
					src.x = refer.x + refer.width - src.width;
					break;
				case BOTTOM:
					src.y = refer.y + refer.height - src.height;
					break;
				default:
					break;
			}
		}
		
		/**判断是否是显示对象，或者父对象是比较的显示对象*/
		public static function isOrParentIs(dis:DisplayObject, target:DisplayObject):Boolean {
			while (dis) {
				if (dis == target) {
					return true;
				}
				dis = dis.parent;
			}
			
			return false;
		}
		
		public static function makeGapEqual(disArr:Array, refer:DisplayObject):void {
			var sum:int = 0;
			for each (var dis:DisplayObject in disArr) {
				sum += dis.width;
			}
			
			var gap:Number = (refer.width - sum) / (disArr.length + 1);
			
			var start:Number = refer.x + gap;
			for (var i:int = 0; i < disArr.length; i++) {
				dis = disArr[i];
				dis.x = start;
				start += dis.width + gap;
			}
		}
		
		public static function setVisible(disArr:Array, visible:Boolean):void {
			for each (var i:DisplayObject in disArr) {
				i.visible = visible;
			}
		}
	}
}
