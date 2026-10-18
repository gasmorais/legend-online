package tasktracetip.view
{
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import yishi.manager.FrameControllerManager;
   
   public class MountOpenTipView extends PawnCharacteristicsTipView
   {
      
      public function MountOpenTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _contentTxt.htmlText = LanguageMgr.GetTranslation("tasktracetip.view.MountOpenTipView.content");
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         FrameControllerManager.instance.openControllerByInfo("mounts",1);
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         super.dispose();
      }
   }
}

