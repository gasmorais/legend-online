package theseusgodhead.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mvc.module.theseus.TheseusGodheadStoneInfo;
   import mvc.module.theseus.TheseusSlateAssetHelper;
   import yishi.manager.NotificationManager;
   
   public class GodheadSellItem extends Sprite implements Disposeable
   {
      
      private var _line:ScaleLeftRightImage;
      
      private var _name:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _closeBtn:BaseButton;
      
      private var _stoneInfo:TheseusGodheadStoneInfo;
      
      private var _stoneIcon:Bitmap;
      
      public function GodheadSellItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _line = ComponentFactory.Instance.creatComponentByStylename("army.SellItem.Line");
         _name = ComponentFactory.Instance.creatComponentByStylename("army.SellItem.name");
         _level = ComponentFactory.Instance.creatComponentByStylename("army.SellItem.count");
         _name.y = 60;
         _line.y = 75;
         _name.x = 17;
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("army.SellItem.closeBtn");
         _level.x = 110;
         _level.y = 23;
         addChild(_line);
         addChild(_name);
         addChild(_level);
         addChild(_closeBtn);
      }
      
      public function set stoneInfo(param1:TheseusGodheadStoneInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         _stoneInfo = param1;
         _name.text = param1.name;
         _level.text = "Lv." + param1.level;
         updateStoneIcon();
      }
      
      private function updateStoneIcon() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         if(_stoneIcon)
         {
            if(_stoneIcon.parent)
            {
               _stoneIcon.parent.removeChild(_stoneIcon);
            }
            _stoneIcon = null;
         }
         if(_stoneInfo && _stoneInfo.shape > 0)
         {
            _stoneIcon = TheseusSlateAssetHelper.getSlateDisplay(_stoneInfo.shape,_stoneInfo.rotate);
            if(_stoneIcon)
            {
               _loc2_ = _stoneIcon.width;
               _loc1_ = _stoneIcon.height;
               _stoneIcon.scaleX = 0.3;
               _stoneIcon.scaleY = 0.3;
               _stoneIcon.x = 50 - _loc2_ * 0.3 / 2;
               _stoneIcon.y = 30 - _loc1_ * 0.3 / 2;
               addChildAt(_stoneIcon,1);
            }
         }
      }
      
      public function get stoneInfo() : TheseusGodheadStoneInfo
      {
         return _stoneInfo;
      }
      
      private function initEvent() : void
      {
         if(_closeBtn)
         {
            _closeBtn.addEventListener("click",__closeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__closeHandler);
         }
      }
      
      private function __closeHandler(param1:MouseEvent) : void
      {
         if(_stoneInfo)
         {
            trace("GodheadSellItem: 删除石板，stoneId=" + _stoneInfo.stoneId);
            NotificationManager.instance.sendNotification("slateRemoveFromDecompose",_stoneInfo.stoneId);
            trace("GodheadSellItem: 已发{invalid_utf8=233}{invalid_utf8=128}? SLATE_REMOVE_FROM_DECOMPOSE 通知");
            dispatchEvent(new Event("decomposeItemDelete",true,true));
         }
         dispose();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_line);
         ObjectUtils.disposeObject(_name);
         ObjectUtils.disposeObject(_level);
         ObjectUtils.disposeObject(_closeBtn);
         if(_stoneIcon)
         {
            if(_stoneIcon.parent)
            {
               _stoneIcon.parent.removeChild(_stoneIcon);
            }
            _stoneIcon = null;
         }
         _stoneInfo = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

