package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.manager.FrameControllerManager;
   
   public class FashionIdentityBufferTipView extends TaskTraceTipView
   {
      
      private var _contentTxt:FilterFrameText;
      
      public function FashionIdentityBufferTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("fashionIdentityBufferTipView.ContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         _textBtn.text = LanguageMgr.GetTranslation("fashionIdentityBufferTipView.btnText");
         _textBtn.width = 195;
         _textBtn.x = 10;
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _contentTxt.htmlText = _data.content;
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.x = (188 - _contentTxt.textWidth) * 0.5 + 12;
         _contentTxt.y = (89 - _contentTxt.textHeight) * 0.5 + 18;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         FrameControllerManager.instance.openControllerByInfo("fashion",1);
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
      
      override protected function check() : Boolean
      {
         return false;
      }
   }
}

