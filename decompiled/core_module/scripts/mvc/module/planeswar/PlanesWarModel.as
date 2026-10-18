package mvc.module.planeswar
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import map.internals.utils.AStarPathFinderByFour;
   import mvc.module.planeswar.info.PlanesGridInfo;
   import mvc.module.planeswar.info.PlanesInfo;
   import mvc.module.planeswar.info.PlanesLayerInfo;
   import mvc.module.planeswar.info.PlanesWarInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.PlanesEventsTemplateInfo;
   import yishi.datas.templates.PlanesFuncTemplateInfo;
   import yishi.datas.templates.PlanesLayerTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class PlanesWarModel extends EventDispatcher
   {
      
      public static const INDEX_FLAG:uint = 100;
      
      public static const PLANES_ESSENCE:int = 605;
      
      public var maxPlanesCount:int;
      
      public var energyLeft:int;
      
      private var _remainTime:Number;
      
      private var _time:Timer;
      
      public var hasBuyEnergyCount:int;
      
      public var planesInfoList:Array;
      
      public var planesWarInfo:PlanesWarInfo;
      
      public var planesResourceList:Array;
      
      public var planesLayerList:Array;
      
      public var ROW_NUM:int;
      
      public var COLUMN_NUM:int;
      
      private var _currentSize:String;
      
      public var isDraging:Boolean = false;
      
      public var endPoint:Point;
      
      public var isInPlanesWar:Boolean;
      
      public var selfArmy:PlanesArmy;
      
      public var mapTilesData:Object;
      
      public var skillSelectedType:int = 0;
      
      public var skillSelectedTempId:int = 0;
      
      public var funcTempList:Array;
      
      public function PlanesWarModel()
      {
         super();
         planesInfoList = [];
         planesWarInfo = new PlanesWarInfo();
         planesResourceList = [];
         planesLayerList = [];
         selfArmy = new PlanesArmy();
         if(funcTempList == null)
         {
            funcTempList = [];
         }
         setFuncTempData();
      }
      
      private function setFuncTempData() : void
      {
         var _loc1_:Dictionary = TempleteManager.instance.planesFuncTemplateCate.getTemplates();
         for each(var _loc2_:PlanesFuncTemplateInfo in _loc1_)
         {
            funcTempList.push(_loc2_.TemplateId);
         }
         funcTempList.sort(16);
      }
      
      public function getGridByXY(param1:int, param2:int) : PlanesGridInfo
      {
         var _loc5_:int = 0;
         var _loc3_:PlanesGridInfo = null;
         var _loc4_:int = param1 * 100 + param2;
         _loc5_ = 0;
         while(_loc5_ < planesWarInfo.gridArr.length)
         {
            if(PlanesGridInfo(planesWarInfo.gridArr[_loc5_]).index == _loc4_)
            {
               _loc3_ = planesWarInfo.gridArr[_loc5_];
               break;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function checkGridInfoByEventId(param1:int) : PlanesGridInfo
      {
         var _loc3_:int = 0;
         var _loc4_:PlanesGridInfo = null;
         var _loc2_:int = int(planesWarInfo.gridArr.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = planesWarInfo.gridArr[_loc3_];
            if(_loc4_ && _loc4_.eventId == param1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getPlanesInfoById(param1:int) : PlanesInfo
      {
         for each(var _loc2_:PlanesInfo in planesInfoList)
         {
            if(_loc2_.planesId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getPlanesLayerInfoById(param1:int) : PlanesLayerInfo
      {
         for each(var _loc2_:PlanesLayerInfo in planesLayerList)
         {
            if(_loc2_.layerId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getTotalRewards() : SimpleDictionary
      {
         var _loc1_:int = 0;
         var _loc5_:PlanesInfo = null;
         var _loc2_:SimpleDictionary = null;
         var _loc4_:SimpleDictionary = new SimpleDictionary();
         _loc1_ = 0;
         while(_loc1_ < planesInfoList.length)
         {
            _loc5_ = planesInfoList[_loc1_] as PlanesInfo;
            _loc2_ = getSinglePlanesRewardsById(_loc5_.planesId);
            for(var _loc3_:String in _loc2_)
            {
               if(_loc4_[_loc3_])
               {
                  var _loc6_:String = _loc3_;
                  var _loc7_:Number = _loc4_[_loc6_] + int(_loc2_[_loc3_]);
                  _loc4_[_loc6_] = _loc7_;
               }
               else
               {
                  _loc4_[_loc3_] = int(_loc2_[_loc3_]);
               }
            }
            _loc1_++;
         }
         return _loc4_;
      }
      
      public function getSinglePlanesRewardsById(param1:int) : SimpleDictionary
      {
         var _loc2_:PlanesLayerTemplateInfo = null;
         var _loc9_:Array = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc8_:int = 0;
         var _loc10_:PlanesInfo = getPlanesInfoById(param1);
         if(!_loc10_)
         {
            return null;
         }
         var _loc11_:SimpleDictionary = new SimpleDictionary();
         _loc11_[1] = 0;
         _loc11_[2] = 0;
         _loc11_[3] = 0;
         _loc11_[4] = 0;
         _loc11_[5] = 0;
         _loc11_[6] = 0;
         _loc11_[7] = 0;
         for each(var _loc7_:PlanesLayerInfo in _loc10_.planesLayerList)
         {
            if(_loc7_)
            {
               if(_loc7_.occupyUserId == thane.userId)
               {
                  _loc2_ = TempleteManager.instance.planesLayerTemplateCate.getTemplateByID(_loc7_.layerTempId);
                  if(_loc2_)
                  {
                     var _loc12_:* = 1;
                     var _loc13_:* = _loc11_[_loc12_] + _loc2_.ReduceResiBonus;
                     _loc11_[_loc12_] = _loc13_;
                     _loc11_[2] += _loc2_.FireResiBonus;
                     _loc11_[3] += _loc2_.WaterResiBonus;
                     _loc11_[4] += _loc2_.ElectResiBonus;
                     _loc11_[5] += _loc2_.WindResiBonus;
                     _loc11_[6] += _loc2_.DarkResiBonus;
                     _loc11_[7] += _loc2_.LightResiBonus;
                     _loc9_ = _loc2_.DailyRewards.split("|");
                     _loc3_ = int(_loc9_.length);
                     _loc6_ = 0;
                     while(_loc6_ < _loc3_)
                     {
                        _loc4_ = _loc9_[_loc6_];
                        _loc5_ = _loc4_.split(",");
                        if(_loc11_[_loc5_[0]])
                        {
                           _loc13_ = _loc5_[0];
                           _loc12_ = _loc11_[_loc13_] + int(_loc5_[1]);
                           _loc11_[_loc13_] = _loc12_;
                        }
                        else
                        {
                           _loc11_[_loc5_[0]] = int(_loc5_[1]);
                        }
                        _loc6_++;
                     }
                  }
               }
            }
         }
         _loc8_ = 1;
         while(_loc8_ < 8)
         {
            if(_loc11_[_loc8_] && _loc11_[_loc8_] == 0)
            {
               _loc11_.del(_loc8_);
            }
            _loc8_++;
         }
         return _loc11_;
      }
      
      public function createMapData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(mapTilesData)
         {
            return;
         }
         mapTilesData = {};
         _loc1_ = 0;
         while(_loc1_ < COLUMN_NUM)
         {
            _loc2_ = 0;
            while(_loc2_ < ROW_NUM)
            {
               mapTilesData[_loc1_ + "_" + _loc2_] = false;
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      public function updateMapData() : void
      {
         var _loc3_:PlanesEventsTemplateInfo = null;
         var _loc2_:PlanesGridInfo = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(mapTilesData)
         {
            for(var _loc1_:String in mapTilesData)
            {
               _loc4_ = int(_loc1_.split("_")[0]);
               _loc5_ = int(_loc1_.split("_")[1]);
               _loc2_ = getGridByXY(_loc4_,_loc5_);
               if(_loc2_)
               {
                  _loc3_ = TempleteManager.instance.planesEventsTemplateCate.getTemplateByID(_loc2_.eventId);
                  if(_loc3_ && _loc3_.EventType == -1)
                  {
                     mapTilesData[_loc2_.x + "_" + _loc2_.y] = false;
                  }
                  else
                  {
                     mapTilesData[_loc2_.x + "_" + _loc2_.y] = true;
                  }
               }
               else
               {
                  mapTilesData[_loc4_ + "_" + _loc5_] = false;
               }
            }
         }
      }
      
      public function checkIsAround(param1:int, param2:int) : Boolean
      {
         if(param1 == planesWarInfo.posX && param2 == planesWarInfo.posY - 1)
         {
            return true;
         }
         if(param1 == planesWarInfo.posX && param2 == planesWarInfo.posY + 1)
         {
            return true;
         }
         if(param2 == planesWarInfo.posY && param1 == planesWarInfo.posX - 1)
         {
            return true;
         }
         if(param2 == planesWarInfo.posY && param1 == planesWarInfo.posX + 1)
         {
            return true;
         }
         return false;
      }
      
      public function checkIsNineAround(param1:int, param2:int) : Boolean
      {
         if(int(Math.abs(param1 - planesWarInfo.posX)) <= 1 && int(Math.abs(param2 - planesWarInfo.posY)) <= 1)
         {
            return true;
         }
         return false;
      }
      
      public function get currentSize() : String
      {
         return _currentSize;
      }
      
      public function set currentSize(param1:String) : void
      {
         _currentSize = param1;
      }
      
      public function cleanMapData() : void
      {
         mapTilesData = null;
         endPoint = null;
         if(!isInPlanesWar)
         {
            planesInfoList = [];
            planesResourceList = [];
            planesWarInfo.gridArr = [];
            planesLayerList = [];
         }
      }
      
      public function getMovePath(param1:Point, param2:Point) : Array
      {
         if(mapTilesData == null)
         {
            return null;
         }
         var _loc3_:AStarPathFinderByFour = new AStarPathFinderByFour(mapTilesData);
         return _loc3_.find(param1,param2);
      }
      
      public function getStepCostEnergyByResistance(param1:PlanesLayerTemplateInfo) : int
      {
         if(!param1)
         {
            return 0;
         }
         var _loc4_:int = param1.ResistType;
         var _loc3_:Array = [thane.baseProperty.totalFireResi,thane.baseProperty.totalWaterResi,thane.baseProperty.totalElecResi,thane.baseProperty.totalWindResi,thane.baseProperty.totalDarkResi,thane.baseProperty.totalLightResi];
         var _loc2_:int = int(_loc3_[_loc4_ - 1]);
         if(_loc2_ <= 0)
         {
            _loc2_ = 0;
         }
         return int((1500 + _loc2_) / (300 + _loc2_));
      }
      
      public function getEventCostEnergyByResistance(param1:PlanesLayerTemplateInfo, param2:PlanesEventsTemplateInfo) : int
      {
         if(!param1 || !param2)
         {
            return 0;
         }
         var _loc5_:int = param1.ResistType;
         var _loc6_:int = param2.EnergyCost;
         var _loc4_:Array = [thane.baseProperty.totalFireResi,thane.baseProperty.totalWaterResi,thane.baseProperty.totalElecResi,thane.baseProperty.totalWindResi,thane.baseProperty.totalDarkResi,thane.baseProperty.totalLightResi];
         var _loc3_:int = int(_loc4_[_loc5_ - 1]);
         if(_loc3_ <= 0)
         {
            _loc3_ = 0;
         }
         return int(_loc6_ * (1500 + _loc3_ * 3) / (1500 + _loc3_ * 4));
      }
      
      public function checkDicIsEmpty(param1:Dictionary) : Boolean
      {
         if(param1)
         {
            for(var _loc2_:String in param1)
            {
               if(param1[_loc2_])
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function walkPath(param1:Point, param2:Point) : Array
      {
         var _loc3_:Array = null;
         var _loc4_:Array = [];
         if(checkIsAround(param2.x,param2.y))
         {
            _loc3_ = [param1,param2];
         }
         else
         {
            _loc3_ = getMovePath(param1,param2);
         }
         return _loc3_;
      }
      
      public function checkIsInStage(param1:int, param2:int) : Boolean
      {
         var _loc3_:* = PlanesWarManager.instance.mapView;
         param1 *= 100;
         param2 *= 100;
         if(_loc3_.x + param1 + 100 > 0 && _loc3_.x + param1 < StageReferance.stageWidth && _loc3_.y + param2 + 100 > 0 && _loc3_.y + param2 < StageReferance.stageHeight)
         {
            return true;
         }
         return false;
      }
      
      public function get remainTime() : Number
      {
         return _remainTime;
      }
      
      public function set remainTime(param1:Number) : void
      {
         _remainTime = param1;
         if(_remainTime > 0)
         {
            if(!_time)
            {
               _time = new Timer(1000);
            }
            _time.addEventListener("timer",__updateEnergyTimeHandler);
            _time.reset();
            _time.start();
         }
      }
      
      private function __updateEnergyTimeHandler(param1:TimerEvent) : void
      {
         _remainTime = _remainTime - 1;
         if(remainTime <= 0)
         {
            PlanesWarManager.instance.sendPlanesOpMsg(32);
            if(_time)
            {
               _time.removeEventListener("timer",__updateEnergyTimeHandler);
               _time.stop();
            }
         }
      }
      
      public function getShowDataByType(param1:int) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Array = [];
         if(!planesWarInfo || !planesWarInfo.layerInfo)
         {
            return _loc3_;
         }
         if(param1 == 2)
         {
            return planesWarInfo.layerInfo.funcArray;
         }
         _loc2_ = 0;
         while(_loc2_ < funcTempList.length)
         {
            if(planesWarInfo.layerInfo.funcArray.indexOf(funcTempList[_loc2_]) == -1)
            {
               _loc3_.push(funcTempList[_loc2_]);
            }
            _loc2_++;
         }
         _loc3_.sort(16);
         return _loc3_;
      }
   }
}

