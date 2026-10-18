package dragonBones.objects
{
   import dragonBones.utils.dragonBones_internal;
   
   use namespace dragonBones_internal;
   
   public class AnimationData
   {
      
      dragonBones_internal var _movementDataList:DataList;
      
      public function AnimationData()
      {
         super();
         this._movementDataList = new DataList();
      }
      
      public function get movementList() : Vector.<String>
      {
         return this._movementDataList.dataNames.concat();
      }
      
      public function dispose() : void
      {
         var _loc1_:String = null;
         var _loc2_:MovementData = null;
         for each(_loc1_ in this._movementDataList.dataNames)
         {
            _loc2_ = this._movementDataList.getData(_loc1_) as MovementData;
            _loc2_.dispose();
         }
         this._movementDataList.dispose();
      }
      
      public function getMovementData(param1:String) : MovementData
      {
         return this._movementDataList.getData(param1) as MovementData;
      }
   }
}

