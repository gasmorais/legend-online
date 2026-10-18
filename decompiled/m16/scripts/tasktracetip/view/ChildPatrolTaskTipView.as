package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.SwitchPageHelp;
   import yishi.manager.FrameControllerManager;
   
   public class ChildPatrolTaskTipView extends TaskTraceTipView
   {
      
      private var _contentTxt:FilterFrameText;
      
      public function ChildPatrolTaskTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         _textBtn.text = LanguageMgr.GetTranslation("appell.AppellFrame.AppellLink.LinkText");
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _contentTxt.htmlText = _data.content;
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         if(!SwitchPageHelp.checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("childpatrol",1);
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
   }
}

