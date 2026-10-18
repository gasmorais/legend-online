package chargelottery
{
   import chat.datas.ChatData;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.engine.ContentElement;
   import flash.text.engine.GroupElement;
   import flash.text.engine.TextBlock;
   import flash.text.engine.TextLine;
   
   public class ChargelotteryShopEventItem extends Sprite implements Disposeable, IManualSize
   {
      
      private var _rect:Rectangle;
      
      private var _data:ChatData;
      
      private var _textBlock:TextBlock;
      
      private var _lineWidth:int = 205;
      
      private var _faceHeigth:Number = 18;
      
      public var totalLine:int = 0;
      
      public function ChargelotteryShopEventItem()
      {
         _rect = new Rectangle(0,0,_lineWidth,_faceHeigth);
         super();
         mouseEnabled = false;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _rect;
      }
      
      public function set lineWidth(param1:int) : void
      {
         _lineWidth = param1;
      }
      
      public function set data(param1:ChatData) : void
      {
         _data = param1 as ChatData;
         ObjectUtils.disposeAllChildren(this);
         var _loc3_:Vector.<ContentElement> = _data.chatItemData.getAllElements();
         if(!_loc3_ || _loc3_.length == 0)
         {
            return;
         }
         var _loc2_:GroupElement = new GroupElement(_loc3_);
         _loc3_ = null;
         _textBlock = new TextBlock();
         _textBlock.baselineZero = "ideographicCenter";
         _textBlock.content = _loc2_;
         createTextLines();
         drawBack();
      }
      
      private function createTextLines() : void
      {
         var _loc1_:int = 0;
         totalLine = 0;
         var _loc2_:Boolean = true;
         var _loc3_:TextLine = _textBlock.createTextLine(null,_lineWidth);
         _loc3_.mouseEnabled = false;
         _loc3_.doubleClickEnabled = false;
         while(_loc3_)
         {
            totalLine = totalLine + 1;
            addChild(_loc3_);
            _loc3_.x = 0;
            if(_loc2_)
            {
               _loc2_ = false;
               _loc1_ = _loc3_.y = _loc3_.height / 2;
            }
            else
            {
               _loc1_ = _loc3_.y = _loc1_ + _faceHeigth;
               _loc3_.x = 2;
            }
            _loc3_ = _textBlock.createTextLine(_loc3_,_lineWidth);
         }
         filters = [new GlowFilter(0,1,4,4,4)];
      }
      
      private function drawBack() : void
      {
         graphics.beginFill(16777215,0);
         graphics.drawRect(0,0,_lineWidth,totalLine * _faceHeigth);
         graphics.endFill();
         _rect.height = totalLine * _faceHeigth;
      }
      
      public function dispose() : void
      {
         graphics.clear();
         _data.dispose();
         _data = null;
         _textBlock = null;
      }
   }
}

