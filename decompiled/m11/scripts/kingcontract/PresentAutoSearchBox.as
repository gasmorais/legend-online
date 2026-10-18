package kingcontract
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FriendManager;
   import yishi.utils.StringHelper;
   
   public class PresentAutoSearchBox extends Sprite implements Disposeable
   {
      
      public static const MAX_LIST_NUM:int = 8;
      
      private var _list:ListPanel;
      
      private var _resultList:Array;
      
      private var _searchString:String;
      
      public function PresentAutoSearchBox()
      {
         super();
         _resultList = [];
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _list = ComponentFactory.Instance.creatComponentByStylename("kingcontract.KingContractPresentFrame.SearchListPanel");
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
      
      private function refreshList(param1:Boolean = false) : void
      {
         var _loc3_:Array = null;
         var _loc2_:String = null;
         removeList();
         if(param1)
         {
            _loc3_ = ConsortiaManager.instance.model.consortiaMemberList.getList();
         }
         else
         {
            _loc3_ = FriendManager.getInstance().friendListByArray.concat(ConsortiaManager.instance.model.consortiaMemberList.getList());
         }
         for each(var _loc4_:ThaneInfo in _loc3_)
         {
            _loc2_ = _loc4_.nickName.substr(0,_searchString.length).toLowerCase();
            if(_loc2_ == _searchString.toLowerCase() && !checkIsExist(_loc4_))
            {
               _resultList.push(_loc4_);
               if(_resultList.length >= 8)
               {
                  return;
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
      
      public function setSearchString(param1:String, param2:Boolean = false) : void
      {
         _searchString = param1;
         if(StringHelper.isNullOrEmpty(_searchString))
         {
            removeList();
         }
         else
         {
            refreshList(param2);
         }
         refreshView();
      }
      
      public function get resultList() : Array
      {
         return _resultList;
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

