package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   
   public class ConsortiaSkillTip extends BaseTip
   {
      
      private var _titleTxtStyle:String;
      
      private var _itemTxtStyle:String;
      
      private var _explainTxtStyle:String;
      
      protected var _maxWidth:Number = 0;
      
      private var _titleTxt:FilterFrameText;
      
      private var _itemArr:Array = [];
      
      private var _explainArr:Array = [];
      
      private var _container:VBox;
      
      public function ConsortiaSkillTip()
      {
         super();
         isFollowMouse = false;
         _container = new VBox();
         _container.spacing = 3;
      }
      
      override protected function updateTransform() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:Dictionary = null;
         var _loc7_:Array = null;
         var _loc5_:int = 0;
         var _loc4_:FilterFrameText = null;
         var _loc6_:Array = null;
         var _loc2_:FilterFrameText = null;
         if(_data is ConsortiaSkillTipInfo)
         {
            removeAllItem();
            _loc3_ = 0;
            _loc1_ = (_data as ConsortiaSkillTipInfo).data;
            if(_loc1_["title"])
            {
               _titleTxt = getTextItem(_loc1_["title"],_titleTxtStyle);
               _maxWidth = _titleTxt.textWidth > _maxWidth ? _titleTxt.textWidth : _maxWidth;
               _container.x = _titleTxt.x;
               _container.y = _titleTxt.y + _titleTxt.height + 5;
            }
            _loc7_ = _loc1_["itemArr"];
            _loc5_ = 0;
            while(_loc5_ < _loc7_.length)
            {
               _loc4_ = getTextItem(_loc7_[_loc5_],_itemTxtStyle);
               _maxWidth = _loc4_.textWidth > _maxWidth ? _loc4_.textWidth : _maxWidth;
               _itemArr.push(_loc4_);
               _container.addChild(_loc4_);
               _loc5_++;
            }
            _loc6_ = _loc1_["explainArr"];
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length)
            {
               _loc2_ = getTextItem(_loc6_[_loc5_],_explainTxtStyle);
               _maxWidth = _loc2_.textWidth > _maxWidth ? _loc2_.textWidth : _maxWidth;
               _explainArr.push(_loc2_);
               _container.addChild(_loc2_);
               _loc5_++;
            }
            addChild(_container);
            _bg.width = _maxWidth + 26;
            _bg.height = _container.y + _container.height + 10;
         }
      }
      
      private function removeAllItem() : void
      {
         if(_titleTxt)
         {
            _titleTxt.parent.removeChild(_titleTxt);
            _titleTxt = null;
         }
         for each(var _loc2_:FilterFrameText in _itemArr)
         {
            _container.removeChild(_loc2_);
            ObjectUtils.disposeObject(_loc2_);
         }
         _itemArr.length = 0;
         for each(var _loc1_:FilterFrameText in _explainArr)
         {
            _container.removeChild(_loc1_);
            ObjectUtils.disposeObject(_loc1_);
         }
         _explainArr.length = 0;
      }
      
      protected function getTextItem(param1:String, param2:String) : FilterFrameText
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:FilterFrameText = createTxt(param2);
         _loc3_.text = param1;
         addChild(_loc3_);
         return _loc3_;
      }
      
      protected function createTxt(param1:String) : FilterFrameText
      {
         return ComponentFactory.Instance.creatComponentByStylename(param1);
      }
      
      public function get titleTxtStyle() : String
      {
         return _titleTxtStyle;
      }
      
      public function set titleTxtStyle(param1:String) : void
      {
         _titleTxtStyle = param1;
      }
      
      public function get itemTxtStyle() : String
      {
         return _itemTxtStyle;
      }
      
      public function set itemTxtStyle(param1:String) : void
      {
         _itemTxtStyle = param1;
      }
      
      public function get explainTxtStyle() : String
      {
         return _explainTxtStyle;
      }
      
      public function set explainTxtStyle(param1:String) : void
      {
         _explainTxtStyle = param1;
      }
      
      override public function dispose() : void
      {
         if(_titleTxt)
         {
            ObjectUtils.disposeObject(_titleTxt);
         }
         _titleTxt = null;
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
         }
         _container = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

