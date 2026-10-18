package com.road.yishi.proto.finalroad
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FinalRoadEventRspMsg extends Message implements IExternalizable
   {
      
      private var monster$field:int;
      
      private var hasField$0:uint = 0;
      
      private var buff$field:int;
      
      private var reward$field:int;
      
      public function FinalRoadEventRspMsg()
      {
         super();
      }
      
      public function removeMonster() : void
      {
         hasField$0 &= 4294967294;
         monster$field = new int();
      }
      
      public function get hasMonster() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set monster(param1:int) : void
      {
         hasField$0 |= 1;
         monster$field = param1;
      }
      
      public function get monster() : int
      {
         return monster$field;
      }
      
      public function removeBuff() : void
      {
         hasField$0 &= 4294967293;
         buff$field = new int();
      }
      
      public function get hasBuff() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set buff(param1:int) : void
      {
         hasField$0 |= 2;
         buff$field = param1;
      }
      
      public function get buff() : int
      {
         return buff$field;
      }
      
      public function removeReward() : void
      {
         hasField$0 &= 4294967291;
         reward$field = new int();
      }
      
      public function get hasReward() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set reward(param1:int) : void
      {
         hasField$0 |= 4;
         reward$field = param1;
      }
      
      public function get reward() : int
      {
         return reward$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMonster)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,monster$field);
         }
         if(hasBuff)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,buff$field);
         }
         if(hasReward)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,reward$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FinalRoadEventRspMsg.monster cannot be set twice.");
                  }
                  _loc6_++;
                  monster = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FinalRoadEventRspMsg.buff cannot be set twice.");
                  }
                  _loc3_++;
                  buff = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FinalRoadEventRspMsg.reward cannot be set twice.");
                  }
                  _loc4_++;
                  reward = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

