package farm.view
{
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.data.FarmInfo;
   import farm.data.FarmLandInfo;
   import farm.data.PetLandInfo;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import managers.BuildingSocketOutManager;
   import yishi.manager.WaterManager;
   
   public class FarmAutoMediator
   {
      
      private var _farmInfo:FarmInfo;
      
      private var isRuning:Boolean = false;
      
      private var _timer:Timer;
      
      private var _type:int = -1;
      
      private var _interId:uint = 0;
      
      private var _arr:Array = [];
      
      private var num:int = 0;
      
      private var pos:int;
      
      private var curOper:int;
      
      private var tempOper:int;
      
      private var timeId:int;
      
      public function FarmAutoMediator()
      {
         super();
         _timer = new Timer(1000,1);
         _timer.addEventListener("timer",__onTimer);
         _timer.stop();
      }
      
      public function start(param1:int) : void
      {
         _timer.start();
         _type = param1;
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         var _loc2_:Boolean = false;
         _farmInfo = model.getFarmInfo(info.userId);
         if(_farmInfo)
         {
            isRuning = true;
            _loc2_ = false;
            _loc2_ = Boolean(WaterManager.instance.model.currentSelectedTreeInfo.canPick);
            if(_loc2_ && Boolean(_farmInfo.isMine) && _type == 1)
            {
               BuildingSocketOutManager.pickFruits(0);
            }
            if(WaterManager.instance.isWatered(info.userId) && _type == 1)
            {
               BuildingSocketOutManager.water(info.userId);
            }
            farmFeed(_type);
         }
      }
      
      private function farmOpera() : void
      {
      }
      
      private function farmFeedPet() : void
      {
         var _loc1_:Array = _farmInfo.getPetLandList();
         if(_loc1_.length > 0)
         {
            for each(var _loc2_:PetLandInfo in _loc1_)
            {
               if(_loc2_ && _loc2_.canFeed())
               {
                  FarmManager.instance.sendFarmOper(_loc2_.userId,13,_loc2_.pos,_loc2_.petId,10);
               }
            }
         }
      }
      
      private function farmFeed(param1:int) : void
      {
         num = 0;
         _arr = [];
         _interId = 0;
         pos = 0;
         curOper = 0;
         tempOper = 0;
         var _loc3_:Array = _farmInfo.getLandList();
         var _loc2_:Array = _farmInfo.animalList;
         if(_loc3_.length > 0 && param1 == 1)
         {
            _arr = _arr.concat(_loc3_);
         }
         if(_loc2_.length > 0 && param1 == 2)
         {
            _arr = _arr.concat(_loc2_);
         }
         if(_arr.length > 0)
         {
            timeId = setTimeout(feed,500);
         }
      }
      
      private function feed() : void
      {
         var _loc1_:FarmLandInfo = null;
         clearTimeout(timeId);
         if(num < _arr.length)
         {
            _loc1_ = _arr[num] as FarmLandInfo;
            if(!_loc1_.hasCrop || _loc1_.isDie && Boolean(_loc1_.isSelfLand))
            {
               num = num + 1;
               feed();
               return;
            }
            if(_loc1_.isDie && !_loc1_.isSelfLand)
            {
               curOper = 8;
            }
            else if(_loc1_.is_worm)
            {
               curOper = 2;
            }
            else if(_loc1_.is_grass)
            {
               curOper = 3;
            }
            else if(_loc1_.is_ill)
            {
               curOper = 5;
            }
            else if(_loc1_.is_hunger)
            {
               curOper = 7;
            }
            else if(_loc1_.is_gloomy)
            {
               curOper = 4;
            }
            else
            {
               if(!(_loc1_.is_can_reap || Boolean(_loc1_.isMature)))
               {
                  num = num + 1;
                  feed();
                  return;
               }
               if(_loc1_.isSelfLand)
               {
                  curOper = 6;
               }
               else
               {
                  curOper = 14;
               }
            }
            if(_loc1_.pos == pos && tempOper == curOper)
            {
               num = num + 1;
               feed();
               return;
            }
            FarmManager.instance.sendFarmOper(_loc1_.userId,curOper,_loc1_.pos);
            pos = _loc1_.pos;
            tempOper = curOper;
            timeId = setTimeout(feed,500);
         }
         else
         {
            isRuning = false;
         }
      }
      
      private function get model() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      private function get info() : FarmInfo
      {
         return FarmManager.instance.model.curSelectedFarmInfo;
      }
      
      public function dispose() : void
      {
         clearTimeout(timeId);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimer);
            _timer = null;
         }
         _farmInfo = null;
      }
   }
}

