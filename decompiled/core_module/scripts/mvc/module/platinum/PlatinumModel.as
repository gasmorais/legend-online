package mvc.module.platinum
{
   import events.PlatinumEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class PlatinumModel extends EventDispatcher
   {
      
      private var _bottleRefuseInvite:Boolean;
      
      private var _bottleRefuseTeamInvite:Boolean;
      
      private var _bottleRefuseInvitation:Boolean;
      
      private var _goldItemInfo:Array;
      
      private var _platinumItemInfo:Array;
      
      public var hasChance:Boolean = false;
      
      private var _luckPassTip:Array = [];
      
      private var _personalTip:Array = [];
      
      private var _itemIds:Array;
      
      public var goldItemNoticeInfo:Array;
      
      public var platinumItemNoticeInfo:Array;
      
      public function PlatinumModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function set itemIds(param1:Array) : void
      {
         _itemIds = param1;
         dispatchEvent(new PlatinumEvent("PLATINA_ACTIVE_ITEMID"));
      }
      
      public function get itemIds() : Array
      {
         return _itemIds;
      }
      
      public function get bottleRefuseInvite() : Boolean
      {
         return _bottleRefuseInvite;
      }
      
      public function set bottleRefuseInvite(param1:Boolean) : void
      {
         _bottleRefuseInvite = param1;
      }
      
      public function get bottleRefuseInvitation() : Boolean
      {
         return _bottleRefuseInvitation;
      }
      
      public function set bottleRefuseInvitation(param1:Boolean) : void
      {
         _bottleRefuseInvitation = param1;
      }
      
      public function get bottleRefuseTeamInvite() : Boolean
      {
         return _bottleRefuseTeamInvite;
      }
      
      public function set bottleRefuseTeamInvite(param1:Boolean) : void
      {
         _bottleRefuseTeamInvite = param1;
      }
      
      public function set goldItemInfo(param1:Array) : void
      {
         _goldItemInfo = param1;
      }
      
      public function get goldItemInfo() : Array
      {
         return _goldItemInfo;
      }
      
      public function set platinumItemInfo(param1:Array) : void
      {
         _platinumItemInfo = param1;
      }
      
      public function get platinumItemInfo() : Array
      {
         return _platinumItemInfo;
      }
      
      public function get luckPassTip() : Array
      {
         return _luckPassTip;
      }
      
      public function set luckPassTip(param1:Array) : void
      {
         _luckPassTip = param1;
         dispatchEvent(new PlatinumEvent("PLATINA_ACTIVE_LUCKPASS_TIP"));
      }
      
      public function get personalTip() : Array
      {
         return _personalTip;
      }
      
      public function set personalTip(param1:Array) : void
      {
         _personalTip = param1;
         dispatchEvent(new PlatinumEvent("PLATINA_ACTIVE_PERSONAL_TIP"));
      }
   }
}

