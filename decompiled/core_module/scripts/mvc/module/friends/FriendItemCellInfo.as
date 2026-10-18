package mvc.module.friends
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   import events.FriendUpdateEvent;
   import flash.events.Event;
   import managers.IMManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.FriendManager;
   import yishi.manager.PlayerManager;
   
   public class FriendItemCellInfo extends ThaneInfo implements INotSameHeightListCellData
   {
      
      public static const GROUP:String = "GROUP";
      
      public var type:int;
      
      public var title:String;
      
      private var _groupId:int;
      
      private var _selected:Boolean;
      
      public function FriendItemCellInfo()
      {
         super();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function set groupId(param1:int) : void
      {
         if(_groupId == param1)
         {
            return;
         }
         _groupId = param1;
         _changeObj["GROUP"] = true;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         dispatchEvent(new Event("change"));
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get isShine() : Boolean
      {
         var _loc2_:String = isCross ? serviceName + "_" + userId : userId + "";
         var _loc1_:Vector.<BaseIMInfo> = IMManager.instance.model.unreadMsgDic[_loc2_];
         if(_loc1_ && _loc1_.length > 0)
         {
            return true;
         }
         return false;
      }
      
      override public function commit() : void
      {
         if(_changeObj["GROUP"])
         {
            FriendManager.getInstance().dispatchEvent(new FriendUpdateEvent("FRIEND_UPDATE",null));
         }
         super.commit();
      }
      
      public function getCellHeight() : Number
      {
         if(_groupId == -2)
         {
            return 85;
         }
         switch(type - 1)
         {
            case 0:
               return 23;
            default:
               return 50;
         }
      }
      
      public function get isCross() : Boolean
      {
         if(serviceName != "" && serviceName != PlayerManager.instance.currentPlayerModel.playerInfo.serviceName)
         {
            return true;
         }
         return false;
      }
   }
}

