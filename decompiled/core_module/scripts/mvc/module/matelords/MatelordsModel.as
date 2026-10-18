package mvc.module.matelords
{
   import events.MatelordsEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class MatelordsModel extends EventDispatcher
   {
      
      public static const INSPIRE_MAX:int = 10;
      
      public var isOver:Boolean;
      
      public var isSign:Boolean;
      
      public var isOpen:Boolean;
      
      public var order:int;
      
      public var teamType:int;
      
      public var openTime:String;
      
      public var totalScore:int;
      
      public var altarScore:int;
      
      public var inspirLevel:int;
      
      public var maxTurnCount:int;
      
      public var currentTurn:int;
      
      public var leftTime:int;
      
      public var masterUserId:int;
      
      public var teamUid:String;
      
      public var teamName:String;
      
      public var warIndex:int;
      
      public var topPlayerList:Array = [];
      
      public var demonShopList:Array = [];
      
      public var rankList:Vector.<MatelordsPlayerInfo>;
      
      public var roomRankList:Vector.<MatelordsPlayerInfo>;
      
      public function MatelordsModel(param1:IEventDispatcher = null)
      {
         super(param1);
         rankList = new Vector.<MatelordsPlayerInfo>();
         roomRankList = new Vector.<MatelordsPlayerInfo>();
      }
      
      public function getDemonShoShowList(param1:int) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc2_:MatelordsDemonShopInfo in demonShopList)
         {
            if(param1 == 0 && _loc2_.templateId < 0)
            {
               _loc3_.push(_loc2_);
            }
            else if(param1 == 1 && _loc2_.templateId > 0)
            {
               _loc3_.push(_loc2_);
            }
         }
         _loc3_.sortOn("templateId",16);
         return _loc3_;
      }
      
      public function getRankTeamPlayerInfoByUuid(param1:String) : MatelordsPlayerInfo
      {
         for each(var _loc2_:MatelordsPlayerInfo in rankList)
         {
            if(_loc2_.uuid == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getRoomTeamPlayerInfoByUuid(param1:String) : MatelordsPlayerInfo
      {
         for each(var _loc2_:MatelordsPlayerInfo in roomRankList)
         {
            if(_loc2_.uuid == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function commitChanges() : void
      {
         dispatchEvent(new MatelordsEvent("INFO_UPDATE"));
      }
      
      public function updateShopList() : void
      {
         dispatchEvent(new MatelordsEvent("DEMON_LIST_UPDATE"));
      }
      
      public function updateAltarScore() : void
      {
         dispatchEvent(new MatelordsEvent("DEMON_SCORE_UPDATE"));
      }
   }
}

