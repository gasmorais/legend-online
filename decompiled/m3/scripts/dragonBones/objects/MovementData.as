package dragonBones.objects
{
   import dragonBones.utils.dragonBones_internal;
   
   use namespace dragonBones_internal;
   
   public class MovementData
   {
      
      dragonBones_internal var _movementBoneDataList:DataList;
      
      dragonBones_internal var _movementFrameList:Vector.<MovementFrameData>;
      
      public var duration:Number;
      
      public var durationTo:Number;
      
      public var durationTween:Number;
      
      public var loop:Boolean;
      
      public var tweenEasing:Number;
      
      public function MovementData()
      {
         super();
         this.duration = 0;
         this.durationTo = 0;
         this.durationTween = 0;
         this._movementBoneDataList = new DataList();
         this._movementFrameList = new Vector.<MovementFrameData>();
      }
      
      public function dispose() : void
      {
         var _loc1_:String = null;
         var _loc2_:MovementBoneData = null;
         for each(_loc1_ in this._movementBoneDataList.dataNames)
         {
            _loc2_ = this._movementBoneDataList.getData(_loc1_) as MovementBoneData;
            _loc2_.dispose();
         }
         this._movementBoneDataList.dispose();
         this._movementFrameList.length = 0;
      }
      
      public function getMovementBoneData(param1:String) : MovementBoneData
      {
         return this._movementBoneDataList.getData(param1) as MovementBoneData;
      }
   }
}

