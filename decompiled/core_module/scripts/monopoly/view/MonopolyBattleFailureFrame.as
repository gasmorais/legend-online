package monopoly.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.campaign.CampaignNodeInfoMsg;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MonopolySocketOutManager;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   
   public class MonopolyBattleFailureFrame extends Frame
   {
      
      private var _contentTxt:FilterFrameText;
      
      private var _selfFightBtn:IconButton;
      
      private var _friendFightBtn:IconButton;
      
      private var _data:CampaignNodeInfoMsg;
      
      public function MonopolyBattleFailureFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MONOPOLY_ALERT"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("monopoly.view.MonopolyBattleFailureFrame.TitleTxt");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyBattleFailureFrame.ContentTxt");
         _selfFightBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyBattleFailureFrame.SelfFightBtn");
         _friendFightBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyBattleFailureFrame.FriendFightBtn");
         addToContent(_contentTxt);
         addToContent(_selfFightBtn);
         addToContent(_friendFightBtn);
         _contentTxt.htmlText = LanguageMgr.GetTranslation("monopoly.view.MonopolyBattleFailureFrame.ContentTxt");
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_contentTxt);
         _contentTxt = null;
         ObjectUtils.disposeObject(_selfFightBtn);
         _selfFightBtn = null;
         ObjectUtils.disposeObject(_friendFightBtn);
         _friendFightBtn = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         _selfFightBtn.addEventListener("click",__selfFightBtnClickHandler);
         _friendFightBtn.addEventListener("click",__friendFightBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _selfFightBtn.removeEventListener("click",__selfFightBtnClickHandler);
         _friendFightBtn.removeEventListener("click",__friendFightBtnClickHandler);
      }
      
      private function __selfFightBtnClickHandler(param1:MouseEvent) : void
      {
         MonopolySocketOutManager.sendTriggerConfirm();
         dispose();
      }
      
      private function __friendFightBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("monopoly",3);
      }
      
      private function __confirmBtnClickHandler(param1:MouseEvent) : void
      {
         MonopolySocketOutManager.sendTriggerConfirm();
         dispose();
      }
      
      private function refresh() : void
      {
      }
      
      public function set data(param1:CampaignNodeInfoMsg) : void
      {
         _data = param1;
         refresh();
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,0);
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

