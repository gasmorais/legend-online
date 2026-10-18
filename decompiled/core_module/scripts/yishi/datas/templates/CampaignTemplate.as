package yishi.datas.templates
{
   import manager.LanguageMgr;
   import yishi.manager.InfoTipsManager;
   
   public class CampaignTemplate
   {
      
      public var CampaignId:int;
      
      public var CampaignName:String;
      
      public var Types:int;
      
      public var OpenTime:String;
      
      public var StopTime:String;
      
      public var MapIds:String;
      
      public var LandId:int;
      
      public var DungeonId:int;
      
      public var AreaId:int;
      
      public var MinLevel:int;
      
      public var MaxLevel:int;
      
      public var PreCampaignId:int;
      
      public var NextCampaignId:int;
      
      public var Capacity:int;
      
      public var DifficultyGrade:int;
      
      public var Description:String;
      
      public var CardPayment:int;
      
      public var PosX:int;
      
      public var PosY:int;
      
      public var Item:String;
      
      public var StandSecond:int;
      
      public var BaseGp:int;
      
      public var StandardDamage:int;
      
      public var StandardHurt:int;
      
      public var SonTypes:int;
      
      public var NeedTransfer:Boolean;
      
      public var NeedFightPower:int;
      
      public var NeedChangeJob:int;
      
      private var _state:int;
      
      public var NeedThirdTransfer:int;
      
      public var NeedTransferType:int;
      
      public var EnterNumb:int;
      
      private var _timeValue:Number = 0;
      
      public function CampaignTemplate()
      {
         super();
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
         InfoTipsManager.instance.dealData(20);
      }
      
      public function get stateValue() : String
      {
         if(state == 0)
         {
            return LanguageMgr.GetTranslation("yishi.datas.templates.stateValue01");
         }
         if(state == 1)
         {
            return LanguageMgr.GetTranslation("yishi.datas.templates.stateValue02");
         }
         if(state == 2)
         {
            return LanguageMgr.GetTranslation("yishi.datas.templates.stateValue03");
         }
         return "";
      }
      
      public function get TimeValue() : Number
      {
         if(_timeValue != 0)
         {
            return _timeValue;
         }
         var _loc1_:Array = OpenTime.split(":");
         var _loc4_:int = int(_loc1_[0]);
         var _loc2_:int = int(_loc1_[1]);
         var _loc3_:Date = new Date();
         _loc3_.setHours(_loc4_,_loc2_,0,0);
         return _loc3_.time;
      }
      
      public function set TimeValue(param1:Number) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         _timeValue = param1;
      }
      
      public function get isTrailTower() : Boolean
      {
         if(SonTypes == 301)
         {
            return true;
         }
         return false;
      }
      
      public function get isBloodyPandemoniue() : Boolean
      {
         var _loc1_:Boolean = false;
         if(SonTypes == 304)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get isSpacetimeFault() : Boolean
      {
         var _loc1_:Boolean = false;
         if(SonTypes == 306)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get isNaLan() : Boolean
      {
         var _loc1_:Boolean = false;
         if(AreaId == 401)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get isTaila() : Boolean
      {
         var _loc1_:Boolean = false;
         if(AreaId == 400)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get isWasteCampaign() : Boolean
      {
         var _loc1_:Boolean = false;
         if(AreaId == 402)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get isSacristyCampaign() : Boolean
      {
         var _loc1_:Boolean = false;
         if(AreaId == 403)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get isMolongCampaign() : Boolean
      {
         var _loc1_:Boolean = false;
         if(SonTypes == 303)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get isFantasyMatrix() : Boolean
      {
         if(SonTypes == 305)
         {
            return true;
         }
         return false;
      }
      
      public function get isActiveCampaign() : Boolean
      {
         if(SonTypes == 301 || SonTypes == 303 || SonTypes == 304 || SonTypes == 305 || SonTypes == 309)
         {
            return true;
         }
         return false;
      }
      
      public function get isChildWarCampaign() : Boolean
      {
         var _loc1_:Boolean = false;
         if(AreaId == 404)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get isDungeoTurn() : Boolean
      {
         if(SonTypes == 307)
         {
            return true;
         }
         return false;
      }
      
      public function get isDeepPrison() : Boolean
      {
         if(AreaId == 405)
         {
            return true;
         }
         return false;
      }
      
      public function get isDarkKing() : Boolean
      {
         if(AreaId == 308)
         {
            return true;
         }
         return false;
      }
      
      public function get isRaceAgainstTime() : Boolean
      {
         if(SonTypes == 309)
         {
            return true;
         }
         return false;
      }
      
      public function get isForest() : Boolean
      {
         if(SonTypes == 310)
         {
            return true;
         }
         return false;
      }
      
      public function get isSkyStepCampaign() : Boolean
      {
         var _loc1_:Boolean = false;
         if(AreaId == 406)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get NeedFourTransfer() : Boolean
      {
         return NeedTransferType == 4;
      }
   }
}

