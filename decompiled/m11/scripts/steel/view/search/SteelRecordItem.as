package steel.view.search
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.data.SteelTeamInfo;
   import yishi.manager.FrameControllerManager;
   
   public class SteelRecordItem extends Sprite implements Disposeable
   {
      
      private var _name:FilterFrameText;
      
      private var _rejectBtn:SelectedCheckButton;
      
      private var _data:SteelTeamInfo;
      
      public function SteelRecordItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _name = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRecordItem.TeamNameTxt");
         _rejectBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.rejectBtn");
         _name.text = "";
         _rejectBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendItem.reject02");
         addChild(_name);
         addChild(_rejectBtn);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _rejectBtn = null;
      }
      
      private function addEvent() : void
      {
         _rejectBtn.addEventListener("click",__onRejectHandler);
      }
      
      private function removeEvent() : void
      {
         _rejectBtn.removeEventListener("click",__onRejectHandler);
      }
      
      private function __onRejectHandler(param1:MouseEvent) : void
      {
         _rejectBtn.removeEventListener("click",__onRejectHandler);
         FrameControllerManager.instance.steelController.sendSteelCancelApply(_data.teamUid);
      }
      
      public function get data() : SteelTeamInfo
      {
         return _data;
      }
      
      public function set data(param1:SteelTeamInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _name.text = LanguageMgr.GetTranslation("steel.view.member.SteelMemberFrame.TeamName",_data.teamName);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

