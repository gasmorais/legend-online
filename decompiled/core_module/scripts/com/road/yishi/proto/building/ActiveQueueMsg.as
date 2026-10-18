package com.road.yishi.proto.building
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActiveQueueMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var current$field:int;
      
      private var max$field:int;
      
      private var count_down_time$field:int;
      
      public function ActiveQueueMsg()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeCurrent() : void
      {
         hasField$0 &= 4294967293;
         current$field = new int();
      }
      
      public function get hasCurrent() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set current(param1:int) : void
      {
         hasField$0 |= 2;
         current$field = param1;
      }
      
      public function get current() : int
      {
         return current$field;
      }
      
      public function removeMax() : void
      {
         hasField$0 &= 4294967291;
         max$field = new int();
      }
      
      public function get hasMax() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set max(param1:int) : void
      {
         hasField$0 |= 4;
         max$field = param1;
      }
      
      public function get max() : int
      {
         return max$field;
      }
      
      public function removeCountDownTime() : void
      {
         hasField$0 &= 4294967287;
         count_down_time$field = new int();
      }
      
      public function get hasCountDownTime() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set countDownTime(param1:int) : void
      {
         hasField$0 |= 8;
         count_down_time$field = param1;
      }
      
      public function get countDownTime() : int
      {
         return count_down_time$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasCurrent)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,current$field);
         }
         if(hasMax)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,max$field);
         }
         if(hasCountDownTime)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,count_down_time$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveQueueMsg.type cannot be set twice.");
                  }
                  _loc5_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveQueueMsg.current cannot be set twice.");
                  }
                  _loc3_++;
                  current = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveQueueMsg.max cannot be set twice.");
                  }
                  _loc4_++;
                  max = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveQueueMsg.countDownTime cannot be set twice.");
                  }
                  _loc7_++;
                  countDownTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

