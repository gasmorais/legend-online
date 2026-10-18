package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.manager.FrameControllerManager;
   import yishi.view.community.BaseIconView;
   
   public class ApexStartTipView extends TaskTraceTipView
   {
      
      private var _icon:BaseIconView;
      
      private var _contentTxt:FilterFrameText;
      
      public function ApexStartTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         _icon = ComponentFactory.Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         _icon.icon = ComponentFactory.Instance.creatBitmap("asset.taskTraceTips.ConsortiaIcon");
         _textBtn.text = LanguageMgr.GetTranslation("gameguide.GameGuideFrame.skipNow");
         addChild(_contentTxt);
         addChild(_textBtn);
         addChild(_icon);
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
         FrameControllerManager.instance.openControllerByInfo("apex",1);
         TaskTraceTipManager.instance.cleanByType(51);
      }
      
      override protected function check() : Boolean
      {
         return false;
      }
   }
}

