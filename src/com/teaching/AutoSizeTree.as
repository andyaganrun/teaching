package com.teaching
{
	import flash.events.Event;
	
	import mx.controls.Tree;
	import mx.core.ScrollPolicy;
	import mx.core.mx_internal;
	import mx.controls.Alert;
	
	public class AutoSizeTree extends Tree
	{
		public function AutoSizeTree()
		{
			super();
			horizontalScrollPolicy = ScrollPolicy.AUTO;
			verticalScrollPolicy = ScrollPolicy.AUTO;
		}
		
		override public function get maxHorizontalScrollPosition():Number
		{
			if (isNaN(mx_internal::_maxHorizontalScrollPosition))       
				return 0;                        
			return mx_internal::_maxHorizontalScrollPosition;    
		}         
		
		override public function set maxHorizontalScrollPosition(value:Number):void
		{
			mx_internal::_maxHorizontalScrollPosition = value;           
			dispatchEvent(new Event("maxHorizontalScrollPositionChanged"));   
			scrollAreaChanged = true;          
			invalidateDisplayList();     
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{  
			var diffWidth:Number = measureWidthOfItems(0,0) - (unscaledWidth - viewMetrics.left - viewMetrics.right);
			var diffHeigh:Number = measureHeightOfItems(0,0) - (unscaledHeight - viewMetrics.top - viewMetrics.bottom);
			
			var indentation:Number = getStyle("indentation");
			
			if (diffWidth <= 0)                 
				maxHorizontalScrollPosition = NaN;
			else
				maxHorizontalScrollPosition = diffWidth + indentation;   
			
			if (diffHeigh <= 0)                 
				maxVerticalScrollPosition = NaN;
			else
				maxVerticalScrollPosition = diffHeigh + indentation;   
				
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
		
		override public function get maxVerticalScrollPosition():Number
		{
			if (isNaN(mx_internal::_maxVerticalScrollPosition))       
				return 0;                        
			return mx_internal::_maxVerticalScrollPosition;    
		}         
		
		override public function set maxVerticalScrollPosition(value:Number):void
		{
			mx_internal::_maxVerticalScrollPosition = value;           
			dispatchEvent(new Event("maxVerticalScrollPositionChanged"));   
			scrollAreaChanged = true;          
			invalidateDisplayList();     
		}
		
//		public var enentTreeExpand:String = "enentTreeExpand_event";
//		
//		override public function expandChildrenOf(item:Object, open:Boolean):void
//		{
//			super.expandChildrenOf(item, open);
//			var enentTreeExpand_event:Event = new Event(enentTreeExpand);
//			this.dispatchEvent(enentTreeExpand_event);
//		}
	}
}