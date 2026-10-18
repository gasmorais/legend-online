package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SteleSysManager;
   import mvc.module.stele.StelesysInfo;
   
   public class StelesysSwitchBox extends StelesysBoxItem
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _equipDesTxt:GradientText;
      
      private var _isEvent:Boolean;
      
      private var _chooseFlg:Bitmap;
      
      public function StelesysSwitchBox()
      {
         super();
      }
      
      override public function set data(param1:StelesysInfo) : void
      {
         super.data = param1;
         if(param1 == null)
         {
            tipData = null;
            removeEvent();
            return;
         }
         tipData = param1;
         if(!_isEvent)
         {
            initEvent();
         }
         _nameTxt.htmlText = param1.nameStep;
         if(param1.isOnEquip)
         {
            _equipDesTxt.text = LanguageMgr.GetTranslation("stela.equip");
         }
         else
         {
            _equipDesTxt.text = "";
         }
      }
      
      override protected function initView() : void
      {
         super.initView();
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("stelesys.switchNickTxt");
         _equipDesTxt = ComponentFactory.Instance.creatComponentByStylename("stele.equip.stateTxt");
         _chooseFlg = ComponentFactory.Instance.creatBitmap("asset.stelesys.yellowChoose");
         addChild(_nameTxt);
         addChild(_equipDesTxt);
         addChild(_chooseFlg);
         _chooseFlg.visible = false;
      }
      
      private function initEvent() : void
      {
         _isEvent = true;
         addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _isEvent = false;
         removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         SteleSysManager.Ins.model.currChoose = _data;
         dispose();
      }
      
      override protected function _outHander(param1:MouseEvent) : void
      {
         super._outHander(param1);
         _chooseFlg.visible = false;
      }
      
      override protected function _overHandler(param1:MouseEvent) : void
      {
         super._overHandler(param1);
         _chooseFlg.visible = true;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_equipDesTxt);
         _equipDesTxt = null;
         ObjectUtils.disposeObject(_chooseFlg);
         _chooseFlg = null;
         super.dispose();
      }
   }
}

