package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import manager.ExternalInterfaceManager;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.service.managers.SocketSendManager;
   
   public class VIPCustomTipView extends TaskTraceTipView
   {
      
      private var _vcTitleImg:Bitmap;
      
      private var _contentImg:Bitmap;
      
      private var _contentTxt:FilterFrameText;
      
      private var _vcBtn:IconButton;
      
      public function VIPCustomTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(4);
         _panel.visible = false;
         _titleImg.visible = false;
         _clostBtn.x = 196;
         _clostBtn.y = 41;
         _vcTitleImg = ComponentFactory.Instance.creatBitmap("asset.taskTrace.VIPCustom.TitleAsset");
         _contentImg = ComponentFactory.Instance.creatBitmap("asset.taskTrace.VIPCustom.ContentAsset");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.VIPCustomTipView.ContentTxt");
         _vcBtn = ComponentFactory.Instance.creatComponentByStylename("tasktracebar.VIPCustomTipView.VCBtn");
         addChild(_vcTitleImg);
         addChild(_contentImg);
         addChild(_contentTxt);
         addChild(_vcBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _contentTxt.htmlText = data.content;
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _vcBtn.addEventListener("click",__btnHandler);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         if(_vcBtn)
         {
            _vcBtn.removeEventListener("click",__btnHandler);
         }
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         var _loc2_:String = "http://wpa.qq.com/msgrd?V=1&Uin=" + data.title + "&Site=sq.7road.com&Menu=yes";
         ExternalInterfaceManager.instance.AASRegisterPath(_loc2_);
         SocketSendManager.instance.vipCustomAdd();
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
      
      override protected function get hei() : int
      {
         return 195;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_vcTitleImg);
         _vcTitleImg = null;
         ObjectUtils.disposeObject(_contentImg);
         _contentImg = null;
         ObjectUtils.disposeObject(_contentTxt);
         _contentTxt = null;
         ObjectUtils.disposeObject(_vcBtn);
         _vcBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

