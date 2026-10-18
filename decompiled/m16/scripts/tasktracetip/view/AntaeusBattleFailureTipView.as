package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.manager.FrameControllerManager;
   
   public class AntaeusBattleFailureTipView extends TaskTraceTipView
   {
      
      private var _contentTxt:FilterFrameText;
      
      public function AntaeusBattleFailureTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.GetGiftBtn");
         _contentTxt.htmlText = LanguageMgr.GetTranslation("tasktracetip.view.AntaeusBattleFailureTipView.ContentTxt");
         _textBtn.text = LanguageMgr.GetTranslation("gameguide.GameGuideFrame.skipNow");
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         FrameControllerManager.instance.openControllerByInfo("antaeus");
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
      
      override protected function check() : Boolean
      {
         return false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

