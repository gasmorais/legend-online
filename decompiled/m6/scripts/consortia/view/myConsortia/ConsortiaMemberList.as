package consortia.view.myConsortia
{
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.ConsortiaEvent;
   import flash.display.Sprite;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.PlayerManager;
   
   public class ConsortiaMemberList extends Sprite implements Disposeable
   {
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _data:ConsortiaModel;
      
      private var _memberinfosItemList:Array;
      
      private var _lastSort:String = "dutyId";
      
      public var isFirst:Boolean = true;
      
      public function ConsortiaMemberList()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _memberinfosItemList = [];
         _buttonGroup = new SelectedButtonGroup();
         _data = ConsortiaManager.instance.model;
      }
      
      private function uninit() : void
      {
         clearMemberList();
         ObjectUtils.disposeAllChildren(this);
         _buttonGroup.dispose();
         _buttonGroup = null;
         _data = null;
         _memberinfosItemList = null;
      }
      
      private function addEvent() : void
      {
         _data.addEventListener("UPDATA_CONSORTIA_MEMBER",__onMemberListUpdata);
      }
      
      private function removeEvent() : void
      {
         _data.removeEventListener("UPDATA_CONSORTIA_MEMBER",__onMemberListUpdata);
      }
      
      public function refreshMemberList(param1:String, param2:Boolean = false) : void
      {
         var _loc4_:int = 0;
         _buttonGroup.selectIndex = -1;
         _lastSort = param1;
         sortList(param2);
         var _loc3_:int = int(memberList.length > 15 ? memberList.length : 15);
         setItemLength(_loc3_);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            getItemByIndex(_loc4_).data = memberList[_loc4_];
            _loc4_++;
         }
         dispatchEvent(new ConsortiaEvent("UPDATA_CONSORTIA_MEMBER"));
      }
      
      private function sortList(param1:Boolean) : void
      {
         if(isFirst)
         {
            memberList.sort(sortByValue);
            return;
         }
         sortOnItem(_lastSort,param1);
      }
      
      private function setItemLength(param1:int) : void
      {
         while(_memberinfosItemList.length > param1)
         {
            removeItem(_memberinfosItemList.pop());
         }
      }
      
      private function getItemByIndex(param1:int) : ConsortiaMemberItem
      {
         var _loc2_:ConsortiaMemberItem = null;
         if(_memberinfosItemList.length - 1 >= param1)
         {
            return _memberinfosItemList[param1];
         }
         _loc2_ = new ConsortiaMemberItem();
         _loc2_.y = param1 * (_loc2_.height - 2) + 2;
         addChild(_loc2_);
         _memberinfosItemList.push(_loc2_);
         _buttonGroup.addSelectItem(_loc2_);
         return _loc2_;
      }
      
      private function sortOnItem(param1:String, param2:Boolean = false) : void
      {
         if(param1 == "nickName")
         {
            memberList.sortOn(param1,1);
         }
         else if(param1 == "job")
         {
            memberList.sort(sortOnJob);
         }
         else if(param1 == "grades")
         {
            memberList.sortOn(["vocationGrades",param1],[19,19]);
         }
         else
         {
            memberList.sortOn(param1,19);
         }
         if(param1 == "dutyId")
         {
            memberList.reverse();
         }
         if(param2)
         {
            memberList.reverse();
         }
      }
      
      private function sortOnJob(param1:ThaneInfo, param2:ThaneInfo) : int
      {
         if(param1.templateInfo.Job <= param2.templateInfo.Job)
         {
            return -1;
         }
         return 1;
      }
      
      private function get memberList() : Array
      {
         return _data.consortiaMemberList.getList();
      }
      
      private function sortByValue(param1:ThaneInfo, param2:ThaneInfo) : int
      {
         if(param1.userId == playerInfo.userId)
         {
            return -1;
         }
         if(param2.userId == playerInfo.userId)
         {
            return 1;
         }
         if(param1.dutyId < param2.dutyId)
         {
            return -1;
         }
         if(param1.dutyId > param2.dutyId)
         {
            return 1;
         }
         return 0;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function clearMemberList() : void
      {
         var _loc1_:ConsortiaMemberItem = null;
         if(_memberinfosItemList)
         {
            while(_memberinfosItemList.length > 0)
            {
               _loc1_ = _memberinfosItemList.pop() as ConsortiaMemberItem;
               removeItem(_loc1_);
            }
         }
      }
      
      private function removeItem(param1:ConsortiaMemberItem) : void
      {
         var _loc2_:int = int(_buttonGroup.getSelectIndexByItem(param1));
         if(_loc2_ != -1)
         {
            _buttonGroup.removeSelectItem(param1);
         }
      }
      
      private function __onMemberListUpdata(param1:ConsortiaEvent) : void
      {
         refreshMemberList(_lastSort);
      }
      
      private function getItemById(param1:int) : ConsortiaMemberItem
      {
         for each(var _loc2_:ConsortiaMemberItem in _memberinfosItemList)
         {
            if(_loc2_.data.userId == param1)
            {
               return _loc2_;
            }
         }
         return null;
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

