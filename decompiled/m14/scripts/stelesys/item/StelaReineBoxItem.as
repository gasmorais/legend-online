package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import mvc.module.stele.StelesysInfo;
   import yishi.manager.FrameControllerManager;
   
   public class StelaReineBoxItem extends StelesysBoxItem
   {
      
      private var _switchBtn:BaseButton;
      
      private var _waitFlg:Bitmap;
      
      public function StelaReineBoxItem()
      {
         super();
         initEvent();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _waitFlg = ComponentFactory.Instance.creatBitmap("asset.empty.icon");
         _switchBtn = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.switchBtn");
         addChild(_waitFlg);
         addChild(_switchBtn);
      }
      
      override public function set data(param1:StelesysInfo) : void
      {
         super.data = param1;
         _waitFlg.visible = param1 ? false : true;
         tipData = param1;
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
         FrameControllerManager.instance.openControllerByInfo("stelesys","switch.page",4);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_waitFlg);
         _waitFlg = null;
         ObjectUtils.disposeObject(_switchBtn);
         _switchBtn = null;
         super.dispose();
      }
   }
}

