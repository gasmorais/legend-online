package friends.view
{
   import chat.datas.ChatCellData;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.FriendControler;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.IMEManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.StringHelper;
   import yishi.view.base.BaseInputFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class AddOrDeleteFriendFrame extends BaseInputFrame
   {
      
      private var _relation:int;
      
      public function AddOrDeleteFriendFrame()
      {
         super();
      }
      
      override protected function initText() : void
      {
         _inputTxt.maxChars = 14;
         _alertTxt.text = LanguageMgr.GetTranslation("friends.view.AddOrDeleteFriendFrame.alert");
         _describtTxt.text = LanguageMgr.GetTranslation("friends.view.AddOrDeleteFriendFrame.describt");
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm");
         inputFocuseText = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaTransferFrame.command03");
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         NotificationManager.instance.addEventListener("PLAYER_NAME_CLICK",__getNameFromChat);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         NotificationManager.instance.removeEventListener("PLAYER_NAME_CLICK",__getNameFromChat);
      }
      
      override protected function __focuseOutHandler(param1:FocusEvent) : void
      {
         IMEManager.disable();
         param1.stopPropagation();
      }
      
      private function __getNameFromChat(param1:NotificationEvent) : void
      {
         var _loc2_:ChatCellData = param1.data as ChatCellData;
         _inputTxt.text = String(_loc2_.data);
      }
      
      override protected function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         var _loc3_:String = _inputTxt.text;
         if(StringHelper.isNullOrEmpty(_loc3_))
         {
            _loc2_ = LanguageMgr.GetTranslation("friends.view.AddOrDeleteFriendFrame.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_relation == 1)
         {
            control.sendAddFriendRequest(_loc3_,1);
         }
         else if(_relation == 2)
         {
            control.sendAddFriendRequest(_loc3_,2);
         }
         dispose();
      }
      
      private function get control() : FriendControler
      {
         return FrameControllerManager.instance.friendControler;
      }
      
      public function set relation(param1:int) : void
      {
         _relation = param1;
         if(_relation == 1)
         {
            titleText = LanguageMgr.GetTranslation("friends.im.IMFrame.addFriend");
         }
         else
         {
            titleText = LanguageMgr.GetTranslation("friends.view.AddOrDeleteFriendFrame.title");
         }
         initEvent();
      }
      
      override public function show() : void
      {
         StageReferance.stage.focus = _inputTxt;
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

