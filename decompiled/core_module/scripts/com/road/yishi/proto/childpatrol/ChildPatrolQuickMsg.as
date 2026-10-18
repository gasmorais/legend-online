package com.road.yishi.proto.childpatrol
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildPatrolQuickMsg extends Message implements IExternalizable
   {
      
      private var idle_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var total_count$field:int;
      
      private var reward$field:Boolean;
      
      public function ChildPatrolQuickMsg()
      {
         super();
      }
      
      public function removeIdleCount() : void
      {
         hasField$0 &= 4294967294;
         idle_count$field = new int();
      }
      
      public function get hasIdleCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set idleCount(param1:int) : void
      {
         hasField$0 |= 1;
         idle_count$field = param1;
      }
      
      public function get idleCount() : int
      {
         return idle_count$field;
      }
      
      public function removeTotalCount() : void
      {
         hasField$0 &= 4294967293;
         total_count$field = new int();
      }
      
      public function get hasTotalCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalCount(param1:int) : void
      {
         hasField$0 |= 2;
         total_count$field = param1;
      }
      
      public function get totalCount() : int
      {
         return total_count$field;
      }
      
      public function removeReward() : void
      {
         hasField$0 &= 4294967291;
         reward$field = new Boolean();
      }
      
      public function get hasReward() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set reward(param1:Boolean) : void
      {
         hasField$0 |= 4;
         reward$field = param1;
      }
      
      public function get reward() : Boolean
      {
         return reward$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIdleCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,idle_count$field);
         }
         if(hasTotalCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,total_count$field);
         }
         if(hasReward)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,reward$field);
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
                     throw new IOError("Bad data format: ChildPatrolQuickMsg.idleCount cannot be set twice.");
                  }
                  _loc6_++;
                  idleCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolQuickMsg.totalCount cannot be set twice.");
                  }
                  _loc3_++;
                  totalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolQuickMsg.reward cannot be set twice.");
                  }
                  _loc4_++;
                  reward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

