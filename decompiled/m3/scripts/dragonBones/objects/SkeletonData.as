package dragonBones.objects
{
   import dragonBones.utils.dragonBones_internal;
   
   use namespace dragonBones_internal;
   
   public class SkeletonData
   {
      
      dragonBones_internal var _armatureDataList:DataList;
      
      dragonBones_internal var _animationDataList:DataList;
      
      dragonBones_internal var _displayDataList:DataList;
      
      dragonBones_internal var _name:String;
      
      dragonBones_internal var _frameRate:uint;
      
      public function SkeletonData()
      {
         super();
         this._armatureDataList = new DataList();
         this._animationDataList = new DataList();
         this._displayDataList = new DataList();
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get frameRate() : uint
      {
         return this._frameRate;
      }
      
      public function get armatureNames() : Vector.<String>
      {
         return this._armatureDataList.dataNames.concat();
      }
      
      public function get animationNames() : Vector.<String>
      {
         return this._animationDataList.dataNames.concat();
      }
      
      public function dispose() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:ArmatureData = null;
         var _loc4_:AnimationData = null;
         for each(_loc1_ in this._armatureDataList.dataNames)
         {
            _loc3_ = this._armatureDataList.getData(_loc1_) as ArmatureData;
            _loc3_.dispose();
         }
         for each(_loc2_ in this._animationDataList.dataNames)
         {
            _loc4_ = this._animationDataList.getData(_loc2_) as AnimationData;
            _loc4_.dispose();
         }
         this._armatureDataList.dispose();
         this._animationDataList.dispose();
         this._displayDataList.dispose();
      }
      
      public function getArmatureData(param1:String) : ArmatureData
      {
         return this._armatureDataList.getData(param1) as ArmatureData;
      }
      
      public function getAnimationData(param1:String) : AnimationData
      {
         return this._animationDataList.getData(param1) as AnimationData;
      }
      
      public function getDisplayData(param1:String) : DisplayData
      {
         return this._displayDataList.getData(param1) as DisplayData;
      }
   }
}

