package bag.view
{
   import bag.datas.GoodsSonType;
   import bag.events.BagEvent;
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
   import yishi.datas.goods.GoodsInfo;
   
   public class SellItem extends Sprite implements Disposeable
   {
      
      private var _line:ScaleLeftRightImage;
      
      private var _countBg:Bitmap;
      
      private var _name:FilterFrameText;
      
      private var _count:FilterFrameText;
      
      private var _closeBtn:BaseButton;
      
      private var _info:GoodsInfo;
      
      public function SellItem()
      {
         super();
         initView();
         initEvent();
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
      
      public function set info(param1:GoodsInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         _info = param1;
         _name.htmlText = "<font color=\'" + GoodsSonType.getColorByProfile(_info.templateInfo.Profile) + "\'>" + _info.templateInfo.TemplateName + "</font>";
         _name.numLines == 2 ? (_name.y = -2) : (_name.y = 8);
         _count.text = _info.count.toString();
      }
      
      public function get info() : GoodsInfo
      {
         return _info;
      }
      
      private function initEvent() : void
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
         var _loc3_:int = _info.count;
         _count.text = _loc2_ + "";
         if(_loc2_ <= 0 || _loc3_ <= 0)
         {
            _count.text = "1";
         }
         else if(_loc2_ >= _loc3_)
         {
            _count.text = _loc3_ + "";
         }
         dispatchEvent(new BagEvent("COUNT_CHANGE",_info,null,true));
      }
      
      private function __closeHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new BagEvent("SELLITEM_DELETE",_info,null,true));
         dispose();
      }
      
      public function get count() : int
      {
         return int(_count.text);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_line);
         ObjectUtils.disposeObject(_countBg);
         ObjectUtils.disposeObject(_name);
         ObjectUtils.disposeObject(_count);
         ObjectUtils.disposeObject(_closeBtn);
         _info = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

