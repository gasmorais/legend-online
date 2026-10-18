package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketSendManager;
   
   public class KingContractTipView extends TaskTraceTipView
   {
      
      protected var _contentTxt:FilterFrameText;
      
      public function KingContractTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _contentTxt.htmlText = param1.content;
         _textBtn.text = param1.btnTxt;
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         data && data.goods && SocketSendManager.instance.sendUseItem(data.goods.pos);
         NotificationManager.instance.dispatchEvent(new Event("KingBuffItemShine"));
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
      
      override protected function check() : Boolean
      {
         return false;
      }
      
      override public function dispose() : void
      {
         _contentTxt && _contentTxt.dispose();
         _contentTxt = null;
         removeEvent();
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

