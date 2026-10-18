package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import mvc.module.stele.StelesysInfo;
   import yishi.manager.FrameControllerManager;
   
   public class StelaStepChooseBoxItem extends StelesysBoxItem
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _switchBtn:BaseButton;
      
      private var _waitFlg:Bitmap;
      
      public function StelaStepChooseBoxItem()
      {
         super();
         initEvent();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _waitFlg = ComponentFactory.Instance.creatBitmap("asset.empty.icon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.stelaNameTxt");
         _switchBtn = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.switchBtn");
         addChild(_waitFlg);
         addChild(_nameTxt);
         addChild(_switchBtn);
      }
      
      override public function set data(param1:StelesysInfo) : void
      {
         super.data = param1;
         if(param1 == null)
         {
            _waitFlg.visible = true;
            tipData = null;
            return;
         }
         _waitFlg.visible = false;
         tipData = param1;
         _nameTxt.htmlText = param1.nameStep;
      }
      
      protected function initEvent() : void
      {
         if(_switchBtn)
         {
            _switchBtn.addEventListener("click",switchHandler);
         }
      }
      
      protected function removeEvent() : void
      {
         if(_switchBtn)
         {
            _switchBtn.removeEventListener("click",switchHandler);
         }
      }
      
      protected function switchHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("stelesys","switch.page",3);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_waitFlg);
         _waitFlg = null;
         ObjectUtils.disposeObject(_switchBtn);
         _switchBtn = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         super.dispose();
      }
   }
}

