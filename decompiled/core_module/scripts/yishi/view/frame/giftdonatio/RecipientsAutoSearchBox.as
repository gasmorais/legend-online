package yishi.view.frame.giftdonatio
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FriendManager;
   import yishi.utils.StringHelper;
   
   public class RecipientsAutoSearchBox extends Sprite implements Disposeable
   {
      
      public static const MAX_LIST_NUM:int = 8;
      
      private var _list:ListPanel;
      
      private var _resultList:Array;
      
      private var _searchString:String;
      
      private var _searchRange:int = 0;
      
      public function RecipientsAutoSearchBox()
      {
         super();
         _resultList = [];
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _list = ComponentFactory.Instance.creatComponentByStylename("email.RecipientsSearchListPanel");
         addChild(_list);
      }
      
      private function addEvent() : void
      {
         _list.list.addEventListener("listItemMouseDown",__onListItemMouseDown);
      }
      
      private function removeEvent() : void
      {
         _list.list.removeEventListener("listItemMouseDown",__onListItemMouseDown);
      }
      
      private function __onListItemMouseDown(param1:ListItemEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function removeList() : void
      {
         _resultList = [];
         _list.vectorListModel.clear();
      }
      
      private function refreshList() : void
      {
         var _loc1_:Array = null;
         removeList();
         switch(_searchRange)
         {
            case 0:
               _loc1_ = FriendManager.getInstance().friendListByArray.concat(ConsortiaManager.instance.model.consortiaMemberList.getList());
               break;
            case 1:
               _loc1_ = FriendManager.getInstance().friendListByArray;
               break;
            case 2:
               _loc1_ = ConsortiaManager.instance.model.consortiaMemberList.getList();
         }
         for each(var _loc2_:ThaneInfo in _loc1_)
         {
            if(_loc2_.userId != thane.userId)
            {
               if(_loc2_.nickName.toLowerCase().indexOf(_searchString.toLowerCase()) > -1 && !checkIsExist(_loc2_))
               {
                  _resultList.push(_loc2_);
                  if(_resultList.length >= 8)
                  {
                     return;
                  }
               }
            }
         }
      }
      
      private function checkIsExist(param1:ThaneInfo) : Boolean
      {
         for each(var _loc2_:ThaneInfo in _resultList)
         {
            if(param1.nickName == _loc2_.nickName)
            {
               return true;
            }
         }
         return false;
      }
      
      private function refreshView() : void
      {
         if(_resultList.length == 0)
         {
            return;
         }
         _list.vectorListModel.appendAll(_resultList);
         _list.height = _resultList.length * 24;
         _list.invalidateViewport();
      }
      
      public function get searchRange() : int
      {
         return _searchRange;
      }
      
      public function set searchRange(param1:int) : void
      {
         _searchRange = param1;
      }
      
      public function setSearchString(param1:String, param2:int = 0) : void
      {
         _searchString = param1;
         _searchRange = param2;
         if(StringHelper.isNullOrEmpty(_searchString))
         {
            removeList();
         }
         else
         {
            refreshList();
         }
         refreshView();
      }
      
      public function get resultList() : Array
      {
         return _resultList;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(_list)
         {
            _list.dispose();
         }
         _list = null;
         _resultList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

