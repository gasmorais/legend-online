package friends.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.ConsortiaEvent;
   import events.ConsortiaMenuEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class ConsortiaMenuView extends Sprite implements Disposeable
   {
      
      private var _consortiaBtn:FriendSelectedButton;
      
      private var _list:VBox;
      
      private var _itemList:Array;
      
      private var _memeberList:Array;
      
      private var _onLine:int;
      
      public function ConsortiaMenuView()
      {
         super();
         initView();
         addEvent();
         setMember();
      }
      
      private function initView() : void
      {
         _consortiaBtn = ComponentFactory.Instance.creatComponentByStylename("friends.MenuConsortiaButton");
         _consortiaBtn.text = LanguageMgr.GetTranslation("friends.view.ConsortiaMenuView.consortia","0/0");
         addChild(_consortiaBtn);
         _list = new VBox();
         _list.y = _consortiaBtn.height + 2;
         _list.x = 2;
         _list.spacing = 8;
         _itemList = [];
      }
      
      private function setMember() : void
      {
         var _loc4_:ThaneInfo = null;
         var _loc2_:int = 0;
         var _loc3_:FriendItemButton = null;
         if(playerInfo.consortiaID <= 0)
         {
            return;
         }
         _memeberList = ConsortiaManager.instance.model.consortiaMemberList.getList();
         _memeberList.sortOn(["state","vocationGrades","grades"],[2,2,2]);
         var _loc1_:int = int(_memeberList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = _memeberList[_loc2_] as ThaneInfo;
            _loc3_ = new FriendItemButton(true);
            _loc3_.data = _loc4_;
            _loc3_.canDelete = false;
            if(_loc4_.isOnline)
            {
               _onLine = _onLine + 1;
               _loc3_.enable = true;
            }
            else
            {
               _loc3_.enable = false;
            }
            if(_loc4_.userId == playerInfo.userId)
            {
               _list.addChildAt(_loc3_,0);
               _itemList.unshift(_loc3_);
            }
            else
            {
               _list.addChild(_loc3_);
               _itemList.push(_loc3_);
            }
            _loc2_++;
         }
         _consortiaBtn.text = LanguageMgr.GetTranslation("friends.view.ConsortiaMenuView.consortia",_onLine + "/" + _loc1_);
         _consortiaBtn.dispatchEvent(new MouseEvent("click"));
      }
      
      private function refreshView() : void
      {
         var _loc4_:ThaneInfo = null;
         var _loc2_:int = 0;
         var _loc3_:FriendItemButton = null;
         clean();
         _memeberList = ConsortiaManager.instance.model.consortiaMemberList.getList();
         _memeberList.sortOn(["state","vocationGrades","grades"],[2,2,2]);
         var _loc1_:int = int(_memeberList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = _memeberList[_loc2_] as ThaneInfo;
            _loc3_ = new FriendItemButton(true);
            _loc3_.data = _loc4_;
            _loc3_.canDelete = false;
            if(_loc4_.isOnline)
            {
               _onLine = _onLine + 1;
               _loc3_.enable = true;
            }
            else
            {
               _loc3_.enable = false;
            }
            if(_loc4_.userId == playerInfo.userId)
            {
               _list.addChildAt(_loc3_,0);
               _itemList.unshift(_loc3_);
            }
            else
            {
               _list.addChild(_loc3_);
               _itemList.push(_loc3_);
            }
            _loc2_++;
         }
         _consortiaBtn.text = LanguageMgr.GetTranslation("friends.view.ConsortiaMenuView.consortia",_onLine + "/" + _loc1_);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         _itemList = null;
         _consortiaBtn = null;
      }
      
      private function addEvent() : void
      {
         _consortiaBtn.addEventListener("click",__onConsortiaBtnHandler);
         NotificationManager.instance.addEventListener("UPDE_MEMEBER_STATE",__onMemberStateChange);
         ConsortiaManager.instance.model.addEventListener("UPDATA_CONSORTIA_MEMBER",__onMemberStateChange);
      }
      
      private function removeEvent() : void
      {
         if(_consortiaBtn)
         {
            _consortiaBtn.removeEventListener("click",__onConsortiaBtnHandler);
         }
         NotificationManager.instance.removeEventListener("UPDE_MEMEBER_STATE",__onMemberStateChange);
         ConsortiaManager.instance.model.removeEventListener("UPDATA_CONSORTIA_MEMBER",__onMemberStateChange);
      }
      
      protected function __onMemberStateChange(param1:ConsortiaEvent) : void
      {
         refreshView();
      }
      
      protected function __onConsortiaBtnHandler(param1:MouseEvent) : void
      {
         if(_consortiaBtn.selected)
         {
            addChild(_list);
         }
         else
         {
            removeChild(_list);
         }
         NotificationManager.instance.dispatchEvent(new ConsortiaMenuEvent("SHOW_MEMBER_LIST"));
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function clean() : void
      {
         var _loc1_:DisplayObject = null;
         while(_list.numChildren > 0)
         {
            _loc1_ = _list.getChildAt(0);
            _list.removeChild(_loc1_);
            ObjectUtils.disposeObject(_loc1_);
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

