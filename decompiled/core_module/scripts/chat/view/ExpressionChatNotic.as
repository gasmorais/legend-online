package chat.view
{
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
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
   
   public class ExpressionChatNotic extends Sprite implements Disposeable, IManualSize
   {
      
      private var _rect:Rectangle;
      
      private var _data:ChatData;
      
      private var _textBlock:TextBlock;
      
      private var _lineWidth:int = 290;
      
      private var _firstLineWidth:int = 290;
      
      private var _needFilters:Boolean = false;
      
      public var totalLine:int = 0;
      
      private var _faceHeigth:Number = 18;
      
      public function ExpressionChatNotic()
      {
         _rect = new Rectangle(0,0,_lineWidth,_faceHeigth);
         super();
         mouseEnabled = false;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _rect;
      }
      
      public function get firstLineWidth() : int
      {
         return _firstLineWidth;
      }
      
      public function set lineWidth(param1:int) : void
      {
         _lineWidth = param1;
      }
      
      public function get lineHeight() : Number
      {
         return _faceHeigth;
      }
      
      public function set needFilters(param1:Boolean) : void
      {
         _needFilters = param1;
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
         if(_loc3_ == null)
         {
            return;
         }
         _firstLineWidth = _loc3_.width;
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
         if(_needFilters)
         {
            filters = [new GlowFilter(0,1,4,4,4)];
         }
         else
         {
            filters = [];
         }
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
         if(_data)
         {
            _data.dispose();
            _data = null;
         }
         ChatFormat.clearTextLine(_textBlock);
         ObjectUtils.disposeAllChildren(this);
         _firstLineWidth = 0;
         _textBlock = null;
      }
   }
}

