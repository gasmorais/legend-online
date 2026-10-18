package yishi.datas.playerinfo
{
   import flash.events.EventDispatcher;
   import yishi.events.PlayerEvent;
   
   public class TowerInfo extends EventDispatcher
   {
      
      public var campaignId:int;
      
      public var enterCount:int;
      
      public var maxIndex:int;
      
      public var order:int;
      
      public var totalGp:int;
      
      public var towerIndex:int;
      
      public var itemTempIds:String;
      
      public var maxEnterCount:int;
      
      public var freeEnterCount:int;
      
      public var index:int;
      
      public var firstBloodId:int;
      
      public var firstBloodName:String;
      
      public function TowerInfo()
      {
         super();
      }
      
      public function commit() : void
      {
         this.dispatchEvent(new PlayerEvent("UPDATE_TOWER_INFO",null));
      }
   }
}

