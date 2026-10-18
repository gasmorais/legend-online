package consortia.view.club
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.net.ConsortiaSocektSendManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaInviteInfo;
   import yishi.manager.FrameControllerManager;
   
   public class RecordItem extends Sprite implements Disposeable
   {
      
      private var _name:FilterFrameText;
      
      private var _chairmanName:FilterFrameText;
      
      private var _acceptBtn:SelectedCheckButton;
      
      private var _rejectBtn:SelectedCheckButton;
      
      private var _data:ConsortiaInviteInfo;
      
      public function RecordItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _name = ComponentFactory.Instance.creatComponentByStylename("consortia.RecordItemNameTextStyle");
         _chairmanName = ComponentFactory.Instance.creatComponentByStylename("consortia.RecordItemChairmanTextStyle");
         _acceptBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.acceptBtn");
         _rejectBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.rejectBtn");
         _name.text = "";
         _chairmanName.text = "";
         _acceptBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendItem.accept");
         _rejectBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendItem.reject");
         addChild(_name);
         addChild(_chairmanName);
         addChild(_acceptBtn);
         addChild(_rejectBtn);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _acceptBtn = null;
         _rejectBtn = null;
      }
      
      private function addEvent() : void
      {
         _acceptBtn.addEventListener("click",__onAcceptHandler);
         _rejectBtn.addEventListener("click",__onRejectHandler);
      }
      
      private function removeEvent() : void
      {
         _acceptBtn.removeEventListener("click",__onAcceptHandler);
         _rejectBtn.removeEventListener("click",__onRejectHandler);
      }
      
      private function __onAcceptHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.consortiaController.operateConsortiaApply(_data.id,true);
      }
      
      private function __onRejectHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         _rejectBtn.removeEventListener("click",__onRejectHandler);
         if(!_data.fromType)
         {
            ConsortiaSocektSendManager.deleteApplyConsortia(_data.id);
         }
         else
         {
            FrameControllerManager.instance.consortiaController.operateConsortiaApply(_data.id,false);
         }
      }
      
      public function get data() : ConsortiaInviteInfo
      {
         return _data;
      }
      
      public function set data(param1:ConsortiaInviteInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _name.text = _data.consortiaName;
            if(!_data.fromType)
            {
               _acceptBtn.visible = false;
               _rejectBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendItem.reject02");
               _chairmanName.text = _data.chairmanName;
            }
            else
            {
               _chairmanName.text = _data.inviteNickName;
            }
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

