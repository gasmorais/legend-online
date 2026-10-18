package mvc.module.ancientartifact
{
   import com.road.yishi.proto.player.ArmoryPosMsg;
   import flash.events.EventDispatcher;
   
   public class AncientArtifactModel extends EventDispatcher
   {
      
      public var artifactList:Array = [];
      
      public var armorylist:Array = [];
      
      public var resonatePosList:Array = [];
      
      public var armoryPosList:Array = [];
      
      public var skillList:String;
      
      public var currentArmoryIndx:int = 0;
      
      public var chooseId:int = 0;
      
      public var chooseList:Array = [];
      
      public var isGradeItemInfo:Boolean = false;
      
      public function AncientArtifactModel()
      {
         super();
      }
      
      public function getArtifactInfoById(param1:int) : AncientArtifactInfo
      {
         for each(var _loc2_:AncientArtifactInfo in artifactList)
         {
            if(_loc2_.templateId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getEquipArtifactInfo() : AncientArtifactInfo
      {
         for each(var _loc1_:AncientArtifactInfo in artifactList)
         {
            if(_loc1_.isEquip)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function deleteArtifactInfoById(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:AncientArtifactInfo = null;
         var _loc2_:int = int(artifactList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = artifactList[_loc3_];
            if(_loc4_.templateId == param1)
            {
               artifactList.splice(_loc3_,1);
               break;
            }
            _loc3_ += 1;
         }
      }
      
      public function getIsEquipResonateByPos(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:AncientResonateInfo = null;
         var _loc2_:int = int(resonatePosList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = resonatePosList[_loc3_];
            if(_loc4_.pos == param1 && _loc4_.equipArtifactId > 0)
            {
               return true;
            }
            _loc3_ += 1;
         }
         return false;
      }
      
      public function getArmoryInfoById(param1:int) : AncientArmoryInfo
      {
         for each(var _loc2_:AncientArmoryInfo in armorylist)
         {
            if(_loc2_.armoryId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function deleteArmoryInfoById(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:AncientArmoryInfo = null;
         var _loc2_:int = int(armorylist.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = armorylist[_loc3_];
            if(_loc4_.armoryId == param1)
            {
               armorylist.splice(_loc3_,1);
               break;
            }
            _loc3_ += 1;
         }
      }
      
      public function getArmoryEquipIdByPos(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:ArmoryPosMsg = null;
         var _loc2_:int = int(armoryPosList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = armoryPosList[_loc3_];
            if(_loc4_.pos == param1)
            {
               return _loc4_.armoryId;
            }
            _loc3_ += 1;
         }
         return 0;
      }
      
      public function getResonateInfoByPos(param1:int) : AncientResonateInfo
      {
         var _loc3_:int = 0;
         var _loc4_:AncientResonateInfo = null;
         var _loc2_:int = int(resonatePosList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = resonatePosList[_loc3_];
            if(_loc4_.pos == param1)
            {
               return _loc4_;
            }
            _loc3_ += 1;
         }
         return null;
      }
      
      public function getResonateInfoByEquipId(param1:int) : AncientResonateInfo
      {
         var _loc3_:int = 0;
         var _loc4_:AncientResonateInfo = null;
         var _loc2_:int = int(resonatePosList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = resonatePosList[_loc3_];
            if(_loc4_.equipArtifactId == param1)
            {
               return _loc4_;
            }
            _loc3_ += 1;
         }
         return null;
      }
   }
}

