package farm.data
{
   import farm.event.FarmEvent;
   import flash.events.EventDispatcher;
   import mvc.module.marry.MarryTreeInfo;
   import yishi.datas.playerinfo.TreeInfo;
   import yishi.manager.ArmyManager;
   import yishi.utils.SimpleDictionary;
   
   public class FarmInfo extends EventDispatcher
   {
      
      public var userId:int;
      
      public var nickName:String;
      
      public var treeInfo:TreeInfo;
      
      public var dayStealCount:int;
      
      private var _grade:int;
      
      private var _landGrade:int;
      
      private var _gp:int;
      
      private var _dayGpFromFriend:int;
      
      private var _landList:SimpleDictionary;
      
      private var _animalList:SimpleDictionary;
      
      public var animalPosCount:int;
      
      public var animalCount:int;
      
      private var _petLandList:Array;
      
      private var _marryTreeInfo:MarryTreeInfo;
      
      private var _defender:PetLandInfo;
      
      public function FarmInfo()
      {
         super();
         _landList = new SimpleDictionary();
         _animalList = new SimpleDictionary();
         _petLandList = [];
      }
      
      public function get marryTreeInfo() : MarryTreeInfo
      {
         return _marryTreeInfo;
      }
      
      public function set marryTreeInfo(param1:MarryTreeInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(_marryTreeInfo)
         {
            _marryTreeInfo.stopTimer();
         }
         _marryTreeInfo = param1;
         _marryTreeInfo.startTimer();
      }
      
      public function get grade() : int
      {
         return _grade;
      }
      
      public function set grade(param1:int) : void
      {
         if(_grade == param1)
         {
            return;
         }
         _grade = param1;
         dispatchEvent(new FarmEvent("FARM_GRADE_CHANGE"));
      }
      
      public function get landGrade() : int
      {
         return _landGrade;
      }
      
      public function set landGrade(param1:int) : void
      {
         if(_landGrade == param1)
         {
            return;
         }
         _landGrade = param1;
         dispatchEvent(new FarmEvent("LAND_GRADE_CHANGE"));
      }
      
      public function get gp() : int
      {
         return _gp;
      }
      
      public function set gp(param1:int) : void
      {
         if(_gp == param1)
         {
            return;
         }
         _gp = param1;
         dispatchEvent(new FarmEvent("FARM_GP_CHANGE"));
      }
      
      public function get dayGpFromFriend() : int
      {
         return _dayGpFromFriend;
      }
      
      public function set dayGpFromFriend(param1:int) : void
      {
         if(_dayGpFromFriend == param1)
         {
            return;
         }
         _dayGpFromFriend = param1;
      }
      
      public function getLandList() : Array
      {
         return _landList.getList();
      }
      
      public function getLandInfo(param1:int) : FarmLandInfo
      {
         return _landList[param1];
      }
      
      public function addLandInfo(param1:FarmLandInfo) : void
      {
         if(param1)
         {
            if(param1.pos >= 1000)
            {
               addAnimalInfo(param1);
               return;
            }
            if(_landList[param1.pos])
            {
               return;
            }
            _landList.add(param1.pos,param1);
            dispatchEvent(new FarmEvent("LAND_OPEN",param1));
         }
      }
      
      public function delLandInfo(param1:int) : void
      {
         _landList.del(param1);
      }
      
      public function get animalList() : Array
      {
         return _animalList.getList();
      }
      
      public function addAnimalInfo(param1:FarmLandInfo) : void
      {
         _animalList.add(param1.pos,param1);
         dealAnimalCount();
      }
      
      public function delAnimalInfo(param1:int) : void
      {
         _animalList.del(param1);
         dealAnimalCount();
      }
      
      private function dealAnimalCount() : void
      {
         animalPosCount = 0;
         animalCount = 0;
         for each(var _loc1_:FarmLandInfo in _animalList)
         {
            animalPosCount = animalPosCount + 1;
            if(_loc1_.item_template_id > 0)
            {
               animalCount = animalCount + 1;
            }
         }
         dispatchEvent(new FarmEvent("LAND_OPEN"));
      }
      
      public function getAnimalInfo(param1:int) : FarmLandInfo
      {
         return _animalList[param1];
      }
      
      public function hasAnimalPosByType(param1:int) : int
      {
         var _loc4_:FarmLandInfo = null;
         var _loc3_:int = -1;
         for(var _loc2_:String in _animalList)
         {
            _loc4_ = _animalList[_loc2_];
            if(!_loc4_.hasCrop)
            {
               _loc3_ = int(_loc2_);
               break;
            }
         }
         return _loc3_;
      }
      
      public function getPetLandList() : Array
      {
         return _petLandList;
      }
      
      public function addPetLandInfo(param1:PetLandInfo) : void
      {
         if(!param1)
         {
            return;
         }
         if(!_petLandList[param1.pos])
         {
            _petLandList[param1.pos] = param1;
            dispatchEvent(new FarmEvent("PET_LAND_OPEN",param1));
         }
         else
         {
            dispatchEvent(new FarmEvent("PET_LAND_UPDATE",param1));
         }
      }
      
      public function getPetLandInfo(param1:int) : PetLandInfo
      {
         return _petLandList[param1];
      }
      
      public function get defender() : PetLandInfo
      {
         return _defender;
      }
      
      public function set defender(param1:PetLandInfo) : void
      {
         _defender = param1;
         dispatchEvent(new FarmEvent("FARM_DEFENDER_CHANGE",param1));
      }
      
      public function get isMine() : Boolean
      {
         return userId == ArmyManager.instance.thane.userId;
      }
   }
}

