package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.manager.FrameControllerManager;
   
   public class MountTipView extends TaskTraceTipView
   {
      
      private var _contentTxt:FilterFrameText;
      
      public function MountTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.MountTipView.text");
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         if(param1.data == 2)
         {
            _contentTxt.htmlText = LanguageMgr.GetTranslation("tasktracetip.view.MountTipView.content2");
            _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.MountTipView.text2");
         }
         else
         {
            _contentTxt.htmlText = LanguageMgr.GetTranslation("tasktracetip.view.MountTipView.content");
         }
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         FrameControllerManager.instance.storeController.startFrameByType("STORE_PANEL_MOUNT");
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
   }
}

