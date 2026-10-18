package armyII.viewII.stone.view
{
   import armyII.viewII.stone.item.StoneGroupItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.armyII.RuneInfo;
   
   public class StoneDkTipView extends Sprite
   {
      
      private var _bg1:ScaleBitmapImage;
      
      private var _cancelBtn:IconButton;
      
      private var _confrimBtn:IconButton;
      
      private var _desTxt:FilterFrameText;
      
      private var _gItem:StoneGroupItem;
      
      private var _data:RuneInfo;
      
      public function StoneDkTipView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("ui.army.tipCancelBtn");
         _confrimBtn = ComponentFactory.Instance.creatComponentByStylename("ui.army.tipConfrimBtn");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("ui.army.tipggbg");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.army.sTipTxt");
         _desTxt.text = LanguageMgr.GetTranslation("army.stone.tipRelcae");
         _gItem = new StoneGroupItem(3);
         addChild(_bg1);
         addChild(_cancelBtn);
         addChild(_confrimBtn);
         addChild(_desTxt);
         addChild(_gItem);
         _gItem.x = 38;
         _gItem.y = 14;
      }
      
      public function set data(param1:RuneInfo) : void
      {
         _data = param1;
         _gItem.updateView(_data.runeHole,_data.templateInfo.RuneType);
      }
      
      private function initEvent() : void
      {
         _confrimBtn.addEventListener("click",cancelHandler);
         _cancelBtn.addEventListener("click",confrimHandler);
      }
      
      private function removeEvent() : void
      {
         _confrimBtn.removeEventListener("click",cancelHandler);
         _cancelBtn.removeEventListener("click",confrimHandler);
      }
      
      private function cancelHandler(param1:MouseEvent) : void
      {
      }
      
      private function confrimHandler(param1:MouseEvent) : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_confrimBtn);
         _confrimBtn = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeObject(_gItem);
         _gItem = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

