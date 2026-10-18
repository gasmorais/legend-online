package friends.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ToolJoinTeamList extends Sprite implements Disposeable
   {
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _acceptBtn:TextButton;
      
      private var _rejectBtn:TextButton;
      
      private var _data:Array;
      
      private var _pageNumMax:int = 10;
      
      private var _itemList:Array;
      
      public function ToolJoinTeamList()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      private function initView() : void
      {
         _data = FriendManager.getInstance().applyJoinList;
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("friend.applyJoinScrollPanel");
         _vbox = new VBox();
         _vbox.spacing = 1;
         _itemList = [];
         _acceptBtn = ComponentFactory.Instance.creatComponentByStylename("friends.InvitePlayerAcceptBtn");
         _rejectBtn = ComponentFactory.Instance.creatComponentByStylename("friends.InvitePlayerRejectBtn");
         _acceptBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendList.accept");
         _rejectBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendList.reject");
         _acceptBtn.enable = true;
         _rejectBtn.enable = true;
         _scrollPanel.setView(_vbox);
         addChild(_scrollPanel);
         addChild(_acceptBtn);
         addChild(_rejectBtn);
         _acceptBtn.x = 65;
         _acceptBtn.y = 169;
         _rejectBtn.x = 210;
         _rejectBtn.y = 169;
      }
      
      private function addEvent() : void
      {
         _acceptBtn.addEventListener("click",__onAcceptHandler);
         _rejectBtn.addEventListener("click",__onRejectHandler);
         NotificationManager.instance.addEventListener("REFRESH_JOINTEAMLIST",__updateJoinTeamList);
      }
      
      private function removeEvent() : void
      {
         _acceptBtn.removeEventListener("click",__onAcceptHandler);
         _rejectBtn.removeEventListener("click",__onRejectHandler);
         NotificationManager.instance.removeEventListener("REFRESH_JOINTEAMLIST",__updateJoinTeamList);
      }
      
      private function __onAcceptHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:int = int(FriendManager.getInstance().toolInviteFriendList.length);
         FreedomTeamManager.instance.joinTeamOp(3);
      }
      
      private function __onRejectHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:String = LanguageMgr.GetTranslation("friends.view.ToolJoinTeamList.rejectAlert");
         SimpleAlertHelper.instance.data = [rejectCall];
         SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc2_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"));
      }
      
      private function rejectCall(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         if(param1)
         {
            FreedomTeamManager.instance.joinTeamOp(2);
            _rejectBtn.enable = false;
            _loc3_ = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendItem.command01");
            MessageTipManager.instance().show(_loc3_);
         }
      }
      
      private function initData() : void
      {
         refreshList();
      }
      
      private function __updateJoinTeamList(param1:Event) : void
      {
         if(FriendManager.getInstance().applyJoinList.length > 0)
         {
            _acceptBtn.enable = true;
            _rejectBtn.enable = true;
         }
         else
         {
            _acceptBtn.enable = false;
            _rejectBtn.enable = false;
         }
         refreshList();
      }
      
      private function refreshList() : void
      {
         var _loc3_:int = 0;
         var _loc2_:ToolJoinTeamItem = null;
         var _loc4_:Array = FriendManager.getInstance().applyJoinList;
         if(!_itemList)
         {
            _itemList = [];
         }
         else
         {
            clearArr(_itemList);
         }
         _vbox.removeAllChild();
         var _loc1_:int = int(_loc4_.length > 5 ? _loc4_.length : 5);
         if(_loc1_ > 5)
         {
            _scrollPanel.vScrollbar.visible = true;
         }
         else
         {
            _scrollPanel.vScrollbar.visible = false;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = new ToolJoinTeamItem();
            if(_loc4_.length > _loc3_)
            {
               _loc2_.data = _loc4_[_loc3_];
            }
            else
            {
               _loc2_.data = null;
            }
            _vbox.addChild(_loc2_);
            _loc3_++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function clearArr(param1:Array) : void
      {
         while(param1 && param1.length > 0)
         {
            ObjectUtils.disposeObject(param1.shift());
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _data = null;
         _acceptBtn = null;
         _rejectBtn = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

