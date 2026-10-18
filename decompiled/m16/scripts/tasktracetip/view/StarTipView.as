package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import yishi.manager.FrameControllerManager;
   
   public class StarTipView extends TaskTraceTipView
   {
      
      private var _contentTxt:FilterFrameText;
      
      public function StarTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         _contentTxt.text = LanguageMgr.GetTranslation("tasktracetip.view.StarTipView.content");
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.StarTipView.text");
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         FrameControllerManager.instance.openControllerByInfo("star");
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
   }
}

