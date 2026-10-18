package battle.view.buffer
{
   import battle.data.BufferDamageData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class BufferListItem extends Sprite
   {
      
      private var _data:BufferDamageData;
      
      private var _icon:BaseIconView;
      
      private var _turnTxt:FilterFrameText;
      
      private const ITEM_W:int = 30;
      
      public function BufferListItem()
      {
         super();
         _icon = new BaseIconView(loadComplete);
         _icon.tipStyle = "battle.view.buffer.BufferListItemTip";
         addChild(_icon);
         _icon.iconWidth = width;
         _icon.iconHeight = height;
         _turnTxt = ComponentFactory.Instance.creatComponentByStylename("battle.BufferTurnTxt");
         addChild(_turnTxt);
         _turnTxt.y = height - 20;
      }
      
      private function loadComplete(param1:BaseIconView = null) : void
      {
         _icon.content.width = width;
         _icon.content.height = height;
      }
      
      public function set data(param1:BufferDamageData) : void
      {
         _data = param1;
         if(_data)
         {
            _icon.icon = IconFactory.getCommonIconPath(_data.Icon);
            refreshTurn();
         }
      }
      
      public function refreshTurn() : void
      {
         var _loc1_:int = 0;
         if(_data)
         {
            _loc1_ = int(_data.currentTurn);
            _turnTxt.text = String(_loc1_);
            _turnTxt.x = 30 - _turnTxt.width;
            _icon.tipData = _data;
         }
      }
      
      public function get data() : BufferDamageData
      {
         return _data;
      }
      
      override public function get width() : Number
      {
         return 30;
      }
      
      override public function get height() : Number
      {
         return 30;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_turnTxt);
         _turnTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

