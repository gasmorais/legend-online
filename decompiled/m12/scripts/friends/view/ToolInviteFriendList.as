package friends.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.FriendUpdateEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.friends.ToolInviteInfo;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ToolInviteFriendList extends Sprite implements Disposeable
   {
      
      private var _acceptBtn:TextButton;
      
      private var _rejectBtn:TextButton;
      
      private var _data:Array;
      
      private var _inviteNum:int;
      
      private var _pageTxt:FilterFrameText;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _pageBg:Image;
      
      private var _infosItemList:Vector.<ToolInviteFriendItem>;
      
      private var _pageNum:int;
      
      private var _pageNumMax:int = 8;
      
      private var _recruitCurrentPage:int = 1;
      
      private var _recruitListTotalPage:int;
      
      public function ToolInviteFriendList()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      private function initView() : void
      {
         _data = FriendManager.getInstance().toolInviteFriendList;
         _inviteNum = 0;
         _pageNum = _pageNumMax;
         _acceptBtn = ComponentFactory.Instance.creatComponentByStylename("friends.InvitePlayerAcceptBtn");
         _rejectBtn = ComponentFactory.Instance.creatComponentByStylename("friends.InvitePlayerRejectBtn");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("friends.InvitePlayerPrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("friends.InvitePlayerNextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("friends.InvitePlayerPageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("friends.InvitePageTextStyle");
         _infosItemList = new Vector.<ToolInviteFriendItem>();
         _acceptBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendList.accept");
         _rejectBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendList.reject");
         _acceptBtn.enable = true;
         _rejectBtn.enable = true;
         _pageTxt.text = "1/1";
         addChild(_acceptBtn);
         addChild(_rejectBtn);
         addChild(_prePageBtn);
         addChild(_nextPageBtn);
         addChild(_pageBg);
         addChild(_pageTxt);
      }
      
      private function addEvent() : void
      {
         _prePageBtn.addEventListener("click",__onPageBtnHandler);
         _nextPageBtn.addEventListener("click",__onPageBtnHandler);
         _acceptBtn.addEventListener("click",__onAcceptHandler);
         _rejectBtn.addEventListener("click",__onRejectHandler);
         NotificationManager.instance.addEventListener("INVITE_UPDATE",__updateInvate);
      }
      
      private function removeEvent() : void
      {
         _prePageBtn.removeEventListener("click",__onPageBtnHandler);
         _nextPageBtn.removeEventListener("click",__onPageBtnHandler);
         _acceptBtn.removeEventListener("click",__onAcceptHandler);
         _rejectBtn.removeEventListener("click",__onRejectHandler);
         NotificationManager.instance.removeEventListener("INVITE_UPDATE",__updateInvate);
      }
      
      private function __onPageBtnHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget == _prePageBtn)
         {
            if(_recruitCurrentPage <= 1)
            {
               return;
            }
            _recruitCurrentPage = _recruitCurrentPage - 1;
         }
         else
         {
            if(_recruitCurrentPage >= _recruitListTotalPage)
            {
               return;
            }
            _recruitCurrentPage = _recruitCurrentPage + 1;
         }
         __updateInvate(null);
      }
      
      private function __onAcceptHandler(param1:MouseEvent) : void
      {
         var _loc3_:ToolInviteInfo = null;
         SoundManager.instance.play("022");
         var _loc2_:int = int(FriendManager.getInstance().toolInviteFriendList.length);
         _acceptBtn.enable = _rejectBtn.enable = false;
         while(_loc2_ > 0)
         {
            _loc3_ = FriendManager.getInstance().toolInviteFriendList[0];
            if(_loc3_.serverName != null && _loc3_.serverName != "" && _loc3_.serverName != PlayerManager.instance.currentPlayerModel.playerInfo.serviceName)
            {
               FriendManager.getInstance().sendCrossFriendRequest(0,_loc3_.uuid);
            }
            else
            {
               FriendManager.getInstance().sendAddFriendRequest(_loc3_.nickName,1);
            }
            FriendManager.getInstance().removeToolInviteFriend(_loc3_);
            _loc2_ = int(FriendManager.getInstance().toolInviteFriendList.length);
         }
         _pageTxt.text = "1/1";
      }
      
      private function __onRejectHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:String = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendList.rejectAlert");
         SimpleAlertHelper.instance.data = [rejectCall];
         SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc2_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"));
      }
      
      private function rejectCall(param1:Boolean, param2:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc5_:ToolInviteInfo = null;
         var _loc3_:String = null;
         if(param1)
         {
            _acceptBtn.enable = _rejectBtn.enable = false;
            _loc4_ = int(FriendManager.getInstance().toolInviteFriendList.length);
            while(_loc4_ > 0)
            {
               _loc5_ = FriendManager.getInstance().toolInviteFriendList[0];
               FriendManager.getInstance().removeToolInviteFriend(_loc5_);
               _loc4_ = int(FriendManager.getInstance().toolInviteFriendList.length);
            }
            _loc3_ = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendItem.command01");
            MessageTipManager.instance().show(_loc3_);
            _pageTxt.text = "1/1";
         }
      }
      
      private function initData() : void
      {
         setItemList();
         _recruitCurrentPage = 1;
         refreshList();
         setPageBtnEnable();
      }
      
      private function setItemList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ToolInviteFriendItem = null;
         _loc2_ = 0;
         while(_loc2_ < _pageNumMax)
         {
            _loc1_ = new ToolInviteFriendItem();
            _loc1_.y = _loc2_ * 33;
            _loc1_.colorBg.setFrame(_loc2_ % 2 + 1);
            addChild(_loc1_);
            _infosItemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function __updateInvate(param1:FriendUpdateEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _pageNumMax)
         {
            _infosItemList[_loc2_].data = null;
            _loc2_++;
         }
         if(FriendManager.getInstance().toolInviteFriendList.length > 0)
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
         setPageBtnEnable();
      }
      
      private function refreshList() : void
      {
         var _loc4_:int = 0;
         var _loc1_:int = int(FriendManager.getInstance().toolInviteFriendList.length);
         var _loc3_:int = _loc1_ / 8;
         if(_loc1_ % 8 != 0 || _loc3_ == 0)
         {
            _recruitListTotalPage = _loc3_ + 1;
         }
         else
         {
            _recruitListTotalPage = _loc3_;
         }
         var _loc2_:int = 8;
         if(_recruitCurrentPage < 1)
         {
            _recruitCurrentPage = 1;
         }
         if(_recruitCurrentPage == _recruitListTotalPage)
         {
            _loc2_ = _loc1_ % 8;
         }
         if(_loc1_ > 0 && _loc2_ == 0)
         {
            _loc2_ = 8;
         }
         _pageTxt.text = _recruitCurrentPage + "/" + _recruitListTotalPage;
         _loc4_ = 0;
         while(_loc4_ < _pageNumMax)
         {
            if(_loc2_ > _loc4_)
            {
               _infosItemList[_loc4_].data = FriendManager.getInstance().toolInviteFriendList[_loc4_ + (_recruitCurrentPage - 1) * 8];
            }
            _loc4_++;
         }
      }
      
      private function setPageBtnEnable() : void
      {
         _prePageBtn.enable = _recruitCurrentPage > 1;
         _nextPageBtn.enable = _recruitCurrentPage < _recruitListTotalPage;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _data = null;
         _prePageBtn = null;
         _nextPageBtn = null;
         _acceptBtn = null;
         _rejectBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

