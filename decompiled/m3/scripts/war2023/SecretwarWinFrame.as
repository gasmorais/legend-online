package war2023
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.war2023.info.SecretwarResultInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.SecretWarManager;
   
   public class SecretwarWinFrame extends Frame
   {
      
      private var _bit:Bitmap;
      
      private var _tipTxt:FilterFrameText;
      
      public function SecretwarWinFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:SecretwarResultInfo = SecretWarManager.Instance.model.resultInfo;
         if(_loc1_)
         {
            if(_loc1_.winCamp == 1)
            {
               _bit = ComponentFactory.Instance.creatBitmap("asset.secretwar.blueWin");
            }
            else
            {
               _bit = ComponentFactory.Instance.creatBitmap("asset.secretwar.redWin");
            }
            addChild(_bit);
         }
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.resultTipTxt");
         addChild(_tipTxt);
         _tipTxt.text = LanguageMgr.GetTranslation("secretwar.resultTip");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         StageReferance.stage.addEventListener("click",sClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         StageReferance.stage.removeEventListener("click",sClickHandler);
      }
      
      private function sClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("secretwar",4);
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bit);
         _bit = null;
         ObjectUtils.disposeObject(_tipTxt);
         _tipTxt = null;
         super.dispose();
      }
      
      public function show() : void
      {
         _closeButton.visible = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

