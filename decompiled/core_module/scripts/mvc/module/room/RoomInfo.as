package mvc.module.room
{
   import events.RoomEvent;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import map.campaign.data.CampaignArmy;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class RoomInfo extends SimpleRoomInfo
   {
      
      private var _houseOwnerId:int;
      
      private var _campaignId:int;
      
      private var _armyFightPos:Array;
      
      public var isCross:Boolean = false;
      
      private var memberId:Array = [];
      
      public var masterName:String;
      
      public var masterScore:int;
      
      private var _selectedMapTemplate:CampaignTemplate;
      
      private var _armyList:Dictionary = new Dictionary(true);
      
      public function RoomInfo(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get armyFightPos() : Array
      {
         return _armyFightPos;
      }
      
      public function set armyFightPos(param1:Array) : void
      {
         if(_armyFightPos != param1)
         {
            _armyFightPos = param1;
            dispatchEvent(new RoomEvent("UPDATE_TEAM_FIGHT_POS",param1));
         }
      }
      
      public function set campaignId(param1:int) : void
      {
         if(_campaignId != param1)
         {
            _campaignId = param1;
            dispatchEvent(new RoomEvent("UPDATE_ROOM_MAP",this));
         }
      }
      
      public function get campaignId() : int
      {
         return _campaignId;
      }
      
      public function get mapTemplate() : CampaignTemplate
      {
         var _loc1_:CampaignTemplate = TempleteManager.instance.campaignTemplateDic[campaignId];
         if(!_loc1_)
         {
            _loc1_ = TempleteManager.instance.vehicleCampaignDic[campaignId];
         }
         return _loc1_;
      }
      
      public function set selectedMapTemplate(param1:CampaignTemplate) : void
      {
         _selectedMapTemplate = param1;
      }
      
      public function get selectedMapTemplate() : CampaignTemplate
      {
         return _selectedMapTemplate;
      }
      
      public function addArmy(param1:CampaignArmy, param2:Boolean = true) : void
      {
         var _loc3_:String = "";
         if(isCross)
         {
            _loc3_ = param1.baseHero.serviceName;
         }
         for each(var _loc4_:CampaignArmy in _armyList)
         {
            if(_loc4_.baseHero.userId == param1.userId)
            {
               if(isCross)
               {
                  delete _armyList["_" + param1.baseHero.userId];
               }
               else
               {
                  delete _armyList[param1.baseHero.serviceName + "_" + param1.baseHero.userId];
               }
            }
         }
         _armyList[_loc3_ + "_" + param1.baseHero.userId] = param1;
         this.dispatchEvent(new RoomEvent("ADD_PLAYER_ROOM",param1));
         if(isCross)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CROSS_ADD_GOONBTN"));
         }
      }
      
      public function removePlayerByUserId(param1:int, param2:String = "") : CampaignArmy
      {
         if(!isCross)
         {
            param2 = "";
         }
         var _loc3_:String = param2 + "_" + param1;
         var _loc4_:CampaignArmy = _armyList[_loc3_] as CampaignArmy;
         delete _armyList[_loc3_];
         curCount = curCount > 1 ? curCount - 1 : 1;
         roomState = 1;
         this.dispatchEvent(new RoomEvent("REMOVE_PLAYER_ROOM",_loc4_));
         if(isCross)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CROSS_ADD_GOONBTN"));
         }
         return _loc4_;
      }
      
      public function getPlayerByPos(param1:int) : CampaignArmy
      {
         for each(var _loc2_:CampaignArmy in _armyList)
         {
            if(_loc2_.pos == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getPlayerByUserId(param1:int, param2:String = "") : CampaignArmy
      {
         if(!isCross)
         {
            param2 = "";
         }
         return _armyList[param2 + "_" + param1] as CampaignArmy;
      }
      
      public function getPlayerByArmyId(param1:int, param2:String = "") : CampaignArmy
      {
         var _loc3_:CampaignArmy = null;
         if(param2 == null || !isCross)
         {
            param2 = "";
         }
         if(!isCross)
         {
            var _loc7_:int = 0;
            var _loc6_:Dictionary = _armyList;
            do
            {
               if(§§hasnext(_loc6_,_loc7_))
               {
                  continue;
               }
            }
            while(_loc3_ = §§nextvalue(_loc7_,_loc6_), _loc3_.id != param1);
            return _loc3_;
         }
         for each(_loc3_ in _armyList)
         {
            if(_loc3_.id == param1 && _loc3_.baseHero.serviceName == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function get playerList() : Dictionary
      {
         return _armyList;
      }
      
      public function get playerCount() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:CampaignArmy in _armyList)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function get allPlayerReader() : Boolean
      {
         for each(var _loc1_:CampaignArmy in _armyList)
         {
            if(_loc1_.roomState == 0 && houseOwnerId != _loc1_.baseHero.userId)
            {
               return false;
            }
         }
         return true;
      }
      
      public function checkRoomPlayerCount() : Boolean
      {
         var _loc1_:int = 0;
         for each(var _loc2_:CampaignArmy in _armyList)
         {
            _loc1_++;
         }
         if(_loc1_ == capacity)
         {
            return true;
         }
         return false;
      }
      
      public function set houseOwnerId(param1:int) : void
      {
         if(_houseOwnerId != param1)
         {
            _houseOwnerId = param1;
            dispatchEvent(new RoomEvent("room_HouseOwner_change",null));
            if(isCross)
            {
               NotificationManager.instance.dispatchEvent(new NotificationEvent("CROSS_ADD_GOONBTN"));
            }
         }
      }
      
      public function get houseOwnerId() : int
      {
         return _houseOwnerId;
      }
   }
}

