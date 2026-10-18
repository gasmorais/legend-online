package farm.data
{
   import farm.event.FarmEvent;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class FarmLandInfo extends EventDispatcher
   {
      
      public var userId:int;
      
      public var type:int;
      
      public var pos:int;
      
      private var _item_template_id:int;
      
      public var add_time:Date;
      
      public var feed_time:Date;
      
      public var mature_time:Date;
      
      public var crop_state:int;
      
      public var accelerate_count:int;
      
      public var stolenCount:int;
      
      public var is_worm:Boolean;
      
      public var is_grass:Boolean;
      
      public var is_gloomy:Boolean;
      
      public var is_ill:Boolean;
      
      public var is_can_reap:Boolean;
      
      private var _is_hunger:Boolean;
      
      public var stolenList:Array;
      
      public var reward_count:int;
      
      public var op_type:int;
      
      private var _result:int;
      
      public var param1:String;
      
      public var param2:String;
      
      private var _cropTemp:GoodsTemplateInfo;
      
      public function FarmLandInfo()
      {
         super();
      }
      
      public function get is_hunger() : Boolean
      {
         return _is_hunger;
      }
      
      public function set is_hunger(param1:Boolean) : void
      {
         _is_hunger = param1;
      }
      
      public function get item_template_id() : int
      {
         return _item_template_id;
      }
      
      public function set item_template_id(param1:int) : void
      {
         _item_template_id = param1;
         _cropTemp = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_item_template_id);
      }
      
      public function get cropTemp() : GoodsTemplateInfo
      {
         return _cropTemp;
      }
      
      public function get cropPhase() : int
      {
         if(!hasCrop)
         {
            return 1;
         }
         if(isDie)
         {
            return 4;
         }
         if(isMature && cropState == 2)
         {
            return 3;
         }
         return 2;
      }
      
      public function get cropPhaseString() : String
      {
         var _loc1_:String = "";
         switch(cropPhase - 3)
         {
            case 0:
               if(pos >= 1000)
               {
                  return "";
               }
               return LanguageMgr.GetTranslation("farm.data.FarmLandInfo.mature");
               break;
            case 1:
               if(pos >= 1000)
               {
                  return "";
               }
               return LanguageMgr.GetTranslation("farm.data.FarmLandInfo.canRevive");
               break;
            default:
               return LanguageMgr.GetTranslation("farm.data.FarmLandInfo.grow");
         }
      }
      
      public function get cropState() : int
      {
         if(!hasCrop)
         {
            return 1;
         }
         if(is_worm)
         {
            return 3;
         }
         if(is_grass)
         {
            return 4;
         }
         if(is_hunger)
         {
            return 7;
         }
         if(is_ill)
         {
            return 6;
         }
         if(is_gloomy)
         {
            return 5;
         }
         return 2;
      }
      
      public function get cropStateString() : String
      {
         switch(cropState - 3)
         {
            case 0:
               return LanguageMgr.GetTranslation("farm.data.FarmLandInfo.canWorm");
            case 1:
               return LanguageMgr.GetTranslation("farm.data.FarmLandInfo.canWeed");
            default:
               return LanguageMgr.GetTranslation("farm.data.FarmLandInfo.healthy");
         }
      }
      
      public function get curOper() : int
      {
         if(!hasCrop)
         {
            if(isSelfLand)
            {
               return 1;
            }
            return 21;
         }
         if(isDie)
         {
            if(isSelfLand)
            {
               return 10;
            }
            return 8;
         }
         if(is_worm)
         {
            return 2;
         }
         if(is_grass)
         {
            return 3;
         }
         if(is_ill)
         {
            return 5;
         }
         if(is_hunger)
         {
            return 7;
         }
         if(is_gloomy)
         {
            return 4;
         }
         if(is_can_reap || isMature)
         {
            if(isSelfLand)
            {
               return 6;
            }
            return 14;
         }
         if(isSelfLand)
         {
            return 22;
         }
         return 21;
      }
      
      public function get hasCrop() : Boolean
      {
         return item_template_id > 0;
      }
      
      public function get hasAccelerate() : Boolean
      {
         return accelerate_count > 0;
      }
      
      public function get isMature() : Boolean
      {
         return hasCrop && remainMatureTime <= 0 && !isDie;
      }
      
      public function get remainMatureTime() : int
      {
         var _loc1_:int = mature_time.time / 1000 - sysCurTimeBySecond;
         return _loc1_ > 0 ? _loc1_ : 0;
      }
      
      public function get totalMatureTime() : int
      {
         var _loc1_:int = mature_time.time / 1000 - add_time.time / 1000;
         return _loc1_ > 0 ? _loc1_ : 0;
      }
      
      public function get animalTotalMatureTime() : int
      {
         var _loc1_:int = mature_time.time / 1000 - feed_time.time / 1000;
         return _loc1_ > 0 ? _loc1_ : 0;
      }
      
      public function get remainMatureMinutes() : int
      {
         return Math.ceil(remainMatureTime / 60);
      }
      
      public function get totalMatureMinutes() : int
      {
         return Math.ceil(totalMatureTime / 60);
      }
      
      public function get animalTotalMatureMinutes() : int
      {
         return Math.ceil(animalTotalMatureTime / 60);
      }
      
      public function get growTime() : int
      {
         var _loc1_:int = sysCurTimeBySecond - add_time.time / 1000;
         return _loc1_ > 0 ? _loc1_ : 0;
      }
      
      public function get growMinutes() : int
      {
         return Math.floor(growTime / 60);
      }
      
      public function get animalGrowMinutes() : int
      {
         var _loc1_:int = sysCurTimeBySecond - feed_time.time / 1000;
         _loc1_ = int(_loc1_ > 0 ? _loc1_ : 0);
         return Math.floor(_loc1_ / 60);
      }
      
      public function get isDie() : Boolean
      {
         if(this.pos >= 1000)
         {
            return false;
         }
         if(!_cropTemp)
         {
            return false;
         }
         var _loc1_:Number = mature_time.time / 1000 + _cropTemp.Property1 * 60;
         return sysCurTimeBySecond > _loc1_;
      }
      
      public function get canBeStolen() : String
      {
         for each(var _loc1_:int in stolenList)
         {
            if(_loc1_ == thane.userId)
            {
               return LanguageMgr.GetTranslation("farm.data.FarmLandInfo.hasStolen");
            }
         }
         if(stolenCount >= 3)
         {
            return LanguageMgr.GetTranslation("farm.data.FarmLandInfo.notMuchLeft");
         }
         return "";
      }
      
      public function get isSelfLand() : Boolean
      {
         return userId == thane.userId;
      }
      
      public function get result() : int
      {
         return _result;
      }
      
      public function set result(param1:int) : void
      {
         _result = param1;
         dispatchEvent(new FarmEvent("OPER_BACK"));
      }
      
      public function beginChanges() : void
      {
      }
      
      public function commitChanges() : void
      {
         dispatchEvent(new FarmEvent("LANDINFO_UPDATE"));
      }
      
      private function get sysCurTimeBySecond() : Number
      {
         return PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

