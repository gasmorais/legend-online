package steel.view.member
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.campaign.data.SteelModel;
   import map.campaign.event.SteelEvent;
   import mvc.controler.SteelController;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class SteelMemberFrame extends Frame implements IManualSize
   {
      
      private var _listView:SteelMemberView;
      
      private var _inviteBtn:IconButton;
      
      private var _auditBtn:IconButton;
      
      private var _quitBtn:IconButton;
      
      private var _memberQuitBtn:BaseButton;
      
      private var _controller:SteelController;
      
      private var _model:SteelModel;
      
      public function SteelMemberFrame()
      {
         super();
         _controller = FrameControllerManager.instance.steelController;
         _model = _controller.model;
         initView();
         addEvent();
         _controller.sendSteelListUsers();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,this.width,this.height);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _listView = ComponentFactory.Instance.creatCustomObject("steel.SteelMemberView");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("steel.SteelMemberFrame.InviteBtn");
         _auditBtn = ComponentFactory.Instance.creatComponentByStylename("steel.SteelMemberFrame.AuditBtn");
         _quitBtn = ComponentFactory.Instance.creatComponentByStylename("steel.SteelMemberFrame.QuitBtn");
         _memberQuitBtn = ComponentFactory.Instance.creatComponentByStylename("steel.SteelMemberFrame.MemberQuitBtn");
         _inviteBtn.visible = false;
         _auditBtn.visible = false;
         _quitBtn.visible = false;
         _memberQuitBtn.visible = false;
         addToContent(_listView);
         addToContent(_inviteBtn);
         addToContent(_auditBtn);
         addToContent(_quitBtn);
         addToContent(_memberQuitBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _inviteBtn.addEventListener("click",__inviteBtnClickHandler);
         _auditBtn.addEventListener("click",__auditBtnClickHandler);
         _quitBtn.addEventListener("click",__quitBtnClickHandler);
         _memberQuitBtn.addEventListener("click",__quitBtnClickHandler);
         _model.addEventListener("STEEL_USER_LIST_CHANGE",__userListChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _inviteBtn.removeEventListener("click",__inviteBtnClickHandler);
         _auditBtn.removeEventListener("click",__auditBtnClickHandler);
         _quitBtn.removeEventListener("click",__quitBtnClickHandler);
         _memberQuitBtn.removeEventListener("click",__quitBtnClickHandler);
         _model.removeEventListener("STEEL_USER_LIST_CHANGE",__userListChangeHandler);
      }
      
      private function __userListChangeHandler(param1:SteelEvent) : void
      {
         if(_listView)
         {
            _listView.setListView();
         }
         refreshView();
      }
      
      private function __quitBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         quitTeam();
      }
      
      private function quitTeam() : void
      {
         SimpleAlertHelper.instance.data = [quitTeamCallBack];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("steel.view.search.SteelSearchFrame.TipsTxt03");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,false,true);
      }
      
      private function quitTeamCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.steelController.sendSteelQuit();
            dispose();
         }
      }
      
      private function __auditBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("steelmap",3);
      }
      
      private function __inviteBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("steelmap",4);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function refreshView() : void
      {
         if(_model.isHostPlayer)
         {
            _inviteBtn.visible = true;
            _auditBtn.visible = true;
            _quitBtn.visible = true;
            _memberQuitBtn.visible = false;
         }
         else
         {
            _inviteBtn.visible = false;
            _auditBtn.visible = false;
            _quitBtn.visible = false;
            _memberQuitBtn.visible = true;
         }
         titleText = LanguageMgr.GetTranslation("steel.view.member.SteelMemberFrame.TeamName",_model.selfTeamName);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
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

