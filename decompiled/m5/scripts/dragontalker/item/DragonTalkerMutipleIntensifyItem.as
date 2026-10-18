package dragontalker.item
{
   import bag.datas.GoodsSonType;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.utils.MsgMan;
   
   public class DragonTalkerMutipleIntensifyItem extends Component
   {
      
      private var _line:ScaleLeftRightImage;
      
      private var _countBg:Bitmap;
      
      private var _name:FilterFrameText;
      
      private var _count:FilterFrameText;
      
      private var _closeBtn:BaseButton;
      
      private var _info:DragonTalkerTalismanInfo;
      
      public function DragonTalkerMutipleIntensifyItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _line = ComponentFactory.Instance.creatComponentByStylename("army.SellItem.Line");
         _countBg = ComponentFactory.Instance.creatBitmap("asset.core.SellItemCountBg");
         _name = ComponentFactory.Instance.creatComponentByStylename("army.SellItem.name");
         _count = ComponentFactory.Instance.creatComponentByStylename("army.SellItem.count");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("army.SellItem.closeBtn");
         addChild(_line);
         addChild(_countBg);
         addChild(_name);
         addChild(_count);
         addChild(_closeBtn);
         _count.restrict = "0-9";
      }
      
      private function addEvent() : void
      {
         if(_closeBtn)
         {
            _closeBtn.addEventListener("click",__closeHandler);
         }
         if(_count)
         {
            _count.addEventListener("change",__countChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__closeHandler);
         }
         if(_count)
         {
            _count.removeEventListener("change",__countChangeHandler);
         }
      }
      
      private function __countChangeHandler(param1:Event) : void
      {
         var _loc2_:int = int(_count.text);
         var _loc3_:int = int(_info.count);
         _count.text = _loc2_ + "";
         if(_loc2_ <= 0 || _loc3_ <= 0)
         {
            _count.text = "1";
         }
         else if(_loc2_ >= _loc3_)
         {
            _count.text = _loc3_ + "";
         }
         MsgMan.notifyObserver("MUTI_INTENSIFY_COUNT_CHANGE",info);
      }
      
      private function __closeHandler(param1:MouseEvent) : void
      {
         MsgMan.notifyObserver("MUTI_INTENSIFY_TALISMAN_DELETE",info);
         dispose();
      }
      
      public function set info(param1:DragonTalkerTalismanInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         _info = param1;
         _name.htmlText = "<font color=\'" + GoodsSonType.getColorByProfile(_info.goodsTempInfo.Profile) + "\'>" + _info.goodsTempInfo.TemplateName + "</font>";
         _count.text = _info.count.toString();
      }
      
      public function get info() : DragonTalkerTalismanInfo
      {
         return _info;
      }
      
      public function get count() : int
      {
         return int(_count.text);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_countBg);
         _countBg = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_count);
         _count = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         super.dispose();
      }
   }
}

