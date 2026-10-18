package dragonBones.objects
{
   import dragonBones.utils.dragonBones_internal;
   
   use namespace dragonBones_internal;
   
   public class ArmatureData
   {
      
      dragonBones_internal var _boneDataList:DataList;
      
      private var _rideBloodY:Number = 0;
      
      private var _bloodY:Number = 0;
      
      private var _scale:Number = 1;
      
      private var _frameRate:int;
      
      public function ArmatureData()
      {
         super();
         this._boneDataList = new DataList();
         this._scale = 1;
      }
      
      public function get boneNames() : Vector.<String>
      {
         return this._boneDataList.dataNames.concat();
      }
      
      public function dispose() : void
      {
         var _loc1_:String = null;
         var _loc2_:BoneData = null;
         for each(_loc1_ in this._boneDataList.dataNames)
         {
            _loc2_ = this._boneDataList.getData(_loc1_) as BoneData;
            _loc2_.dispose();
         }
         this._boneDataList.dispose();
      }
      
      public function getBoneData(param1:String) : BoneData
      {
         return this._boneDataList.getData(param1) as BoneData;
      }
      
      public function updateBoneList() : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:BoneData = null;
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc1_:Vector.<String> = this._boneDataList.dataNames;
         var _loc2_:Array = [];
         for each(_loc3_ in _loc1_)
         {
            _loc5_ = this._boneDataList.getData(_loc3_) as BoneData;
            _loc6_ = _loc5_.node.z;
            _loc7_ = 0;
            while(_loc5_)
            {
               _loc7_++;
               _loc6_ += 1000 * _loc7_;
               _loc5_ = this.getBoneData(_loc5_.parent);
            }
            _loc2_.push({
               "level":_loc6_,
               "boneName":_loc3_
            });
         }
         _loc4_ = int(_loc2_.length);
         if(_loc4_ > 0)
         {
            _loc2_.sortOn("level",Array.NUMERIC);
            _loc1_.length = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc4_)
            {
               _loc1_[_loc8_] = _loc2_[_loc8_].boneName;
               _loc8_++;
            }
         }
      }
      
      public function get bloodY() : Number
      {
         return this._bloodY;
      }
      
      public function set bloodY(param1:Number) : void
      {
         this._bloodY = param1;
      }
      
      public function get frameRate() : int
      {
         return this._frameRate;
      }
      
      public function set frameRate(param1:int) : void
      {
         this._frameRate = param1;
      }
      
      public function get scale() : Number
      {
         return this._scale;
      }
      
      public function set scale(param1:Number) : void
      {
         if(param1 != 0 && param1 != this._scale)
         {
            this._scale = param1;
         }
      }
      
      public function get rideBloodY() : Number
      {
         return this._rideBloodY;
      }
      
      public function set rideBloodY(param1:Number) : void
      {
         this._rideBloodY = param1;
      }
   }
}

