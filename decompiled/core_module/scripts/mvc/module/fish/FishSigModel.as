package mvc.module.fish
{
   import flash.events.EventDispatcher;
   import managers.FishManager;
   
   public class FishSigModel extends EventDispatcher
   {
      
      private var _fishSigInfo:FishSigInfo;
      
      private var _fishForkInfo:FishForkInfo;
      
      public function FishSigModel()
      {
         super();
         _fishSigInfo = new FishSigInfo();
      }
      
      public function get fishSigInfo() : FishSigInfo
      {
         return _fishSigInfo;
      }
      
      public function set fishSigInfo(param1:FishSigInfo) : void
      {
         _fishSigInfo = param1;
      }
      
      public function moveFish() : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc1_:* = undefined;
         var _loc4_:Number = NaN;
         if(fishSigInfo.isMove)
         {
            if(fishSigInfo.fish && fishSigInfo.fish.visible == false && fishSigInfo.fishState != 4 && fishSigInfo.fishState != 5)
            {
               fishSigInfo.fish.visible = true;
            }
            if(fishSigInfo.point)
            {
               fishSigInfo.x += fishSigInfo.fishTempInfo.Speed;
            }
            else
            {
               fishSigInfo.x -= fishSigInfo.fishTempInfo.Speed;
            }
         }
         else
         {
            if(_fishForkInfo)
            {
               _loc3_ = _fishForkInfo.x;
               _loc2_ = _fishForkInfo.y;
            }
            else
            {
               _loc3_ = fishModel.fishForkInfo.x;
               _loc2_ = fishModel.fishForkInfo.y;
            }
            _loc1_ = fishSigInfo.fish;
            _loc4_ = 0;
            if(_loc1_)
            {
               _loc4_ = _loc1_.width / 2;
            }
            if(fishSigInfo.point)
            {
               fishSigInfo.x = _loc3_ + _loc4_;
            }
            else
            {
               fishSigInfo.x = _loc3_ - _loc4_;
            }
            fishSigInfo.y = _loc2_;
         }
      }
      
      public function get outFish() : Boolean
      {
         if(!fishSigInfo.fish)
         {
            return false;
         }
         var _loc1_:Boolean = false;
         if(fishSigInfo.point)
         {
            if((fishSigInfo.fishState == 1 || fishSigInfo.fishState == 3) && fishSigInfo.x > 830 + fishSigInfo.fish.width)
            {
               fishSigInfo.fishState = -1;
               _loc1_ = true;
            }
         }
         else if((fishSigInfo.fishState == 1 || fishSigInfo.fishState == 3) && fishSigInfo.x < -fishSigInfo.fish.width)
         {
            fishSigInfo.fishState = -1;
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function updateFish() : void
      {
         if(fishSigInfo.fish)
         {
            fishSigInfo.fish.point = fishSigInfo.point;
            fishSigInfo.fish.path = fishSigInfo.fishTempInfo.Path;
            fishSigInfo.fish.x = fishSigInfo.x;
            fishSigInfo.fish.y = fishSigInfo.y;
         }
      }
      
      public function get catchFishSigInfo() : FishSigInfo
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc5_:* = undefined;
         var _loc4_:Boolean = false;
         for each(var _loc7_:FishForkInfo in fishModel.fishForkList)
         {
            if(!_loc7_.isCatch)
            {
               _loc1_ = _loc7_.x;
               _loc2_ = _loc7_.y;
               _loc3_ = _loc7_.rotation;
               _loc6_ = 25 - Math.cos(Math.abs(_loc3_ * 3.141592653589793 / 180)) * 25;
               if(!fishSigInfo.fish)
               {
                  return null;
               }
               _loc5_ = fishSigInfo.fish;
               _loc4_ = false;
               if(_loc2_ >= _loc5_.y + _loc6_ && _loc2_ <= _loc5_.height + _loc5_.y)
               {
                  if(_loc5_.point)
                  {
                     if(_loc1_ <= _loc5_.x - _loc5_.width / 8 && _loc1_ >= _loc5_.x - _loc5_.width * 7 / 8)
                     {
                        _loc4_ = true;
                     }
                  }
                  else if(_loc1_ >= _loc5_.x + _loc5_.width / 8 && _loc1_ <= _loc5_.x + _loc5_.width * 7 / 8)
                  {
                     _loc4_ = true;
                  }
               }
               if(_loc4_)
               {
                  _fishForkInfo = _loc7_;
                  if(fishModel.fishForkInfo.type != 2)
                  {
                     _loc7_.isCatch = true;
                  }
                  return fishSigInfo;
               }
            }
         }
         return null;
      }
      
      private function get fishModel() : FishModel
      {
         return FishManager.instance.model;
      }
   }
}

