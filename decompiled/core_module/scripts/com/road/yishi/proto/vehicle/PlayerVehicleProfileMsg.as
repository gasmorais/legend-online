package com.road.yishi.proto.vehicle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerVehicleProfileMsg extends Message implements IExternalizable
   {
      
      private var exp$field:int;
      
      private var hasField$0:uint = 0;
      
      private var score$field:int;
      
      private var defaultVehicle$field:int;
      
      public function PlayerVehicleProfileMsg()
      {
         super();
      }
      
      public function removeExp() : void
      {
         hasField$0 &= 4294967294;
         exp$field = new int();
      }
      
      public function get hasExp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set exp(param1:int) : void
      {
         hasField$0 |= 1;
         exp$field = param1;
      }
      
      public function get exp() : int
      {
         return exp$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967293;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 2;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeDefaultVehicle() : void
      {
         hasField$0 &= 4294967291;
         defaultVehicle$field = new int();
      }
      
      public function get hasDefaultVehicle() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set defaultVehicle(param1:int) : void
      {
         hasField$0 |= 4;
         defaultVehicle$field = param1;
      }
      
      public function get defaultVehicle() : int
      {
         return defaultVehicle$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasExp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,exp$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasDefaultVehicle)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,defaultVehicle$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleProfileMsg.exp cannot be set twice.");
                  }
                  _loc3_++;
                  exp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleProfileMsg.score cannot be set twice.");
                  }
                  _loc5_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleProfileMsg.defaultVehicle cannot be set twice.");
                  }
                  _loc6_++;
                  defaultVehicle = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

