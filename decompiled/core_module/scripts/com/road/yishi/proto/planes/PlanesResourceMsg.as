package com.road.yishi.proto.planes
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlanesResourceMsg extends Message implements IExternalizable
   {
      
      private var layer_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pos_x$field:int;
      
      private var pos_y$field:int;
      
      private var event_id$field:int;
      
      private var total_count_down$field:Int64;
      
      private var next_reward_count_down$field:Int64;
      
      private var can_reward_count$field:int;
      
      public function PlanesResourceMsg()
      {
         super();
      }
      
      public function removeLayerId() : void
      {
         hasField$0 &= 4294967294;
         layer_id$field = new int();
      }
      
      public function get hasLayerId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set layerId(param1:int) : void
      {
         hasField$0 |= 1;
         layer_id$field = param1;
      }
      
      public function get layerId() : int
      {
         return layer_id$field;
      }
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967293;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 2;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967291;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 4;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      public function removeEventId() : void
      {
         hasField$0 &= 4294967287;
         event_id$field = new int();
      }
      
      public function get hasEventId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set eventId(param1:int) : void
      {
         hasField$0 |= 8;
         event_id$field = param1;
      }
      
      public function get eventId() : int
      {
         return event_id$field;
      }
      
      public function removeTotalCountDown() : void
      {
         total_count_down$field = null;
      }
      
      public function get hasTotalCountDown() : Boolean
      {
         return total_count_down$field != null;
      }
      
      public function set totalCountDown(param1:Int64) : void
      {
         total_count_down$field = param1;
      }
      
      public function get totalCountDown() : Int64
      {
         return total_count_down$field;
      }
      
      public function removeNextRewardCountDown() : void
      {
         next_reward_count_down$field = null;
      }
      
      public function get hasNextRewardCountDown() : Boolean
      {
         return next_reward_count_down$field != null;
      }
      
      public function set nextRewardCountDown(param1:Int64) : void
      {
         next_reward_count_down$field = param1;
      }
      
      public function get nextRewardCountDown() : Int64
      {
         return next_reward_count_down$field;
      }
      
      public function removeCanRewardCount() : void
      {
         hasField$0 &= 4294967279;
         can_reward_count$field = new int();
      }
      
      public function get hasCanRewardCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set canRewardCount(param1:int) : void
      {
         hasField$0 |= 16;
         can_reward_count$field = param1;
      }
      
      public function get canRewardCount() : int
      {
         return can_reward_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasLayerId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,layer_id$field);
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
         if(hasEventId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,event_id$field);
         }
         if(hasTotalCountDown)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT64(param1,total_count_down$field);
         }
         if(hasNextRewardCountDown)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT64(param1,next_reward_count_down$field);
         }
         if(hasCanRewardCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,can_reward_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesResourceMsg.layerId cannot be set twice.");
                  }
                  _loc4_++;
                  layerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesResourceMsg.posX cannot be set twice.");
                  }
                  _loc10_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesResourceMsg.posY cannot be set twice.");
                  }
                  _loc3_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesResourceMsg.eventId cannot be set twice.");
                  }
                  _loc5_++;
                  eventId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesResourceMsg.totalCountDown cannot be set twice.");
                  }
                  _loc6_++;
                  totalCountDown = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesResourceMsg.nextRewardCountDown cannot be set twice.");
                  }
                  _loc7_++;
                  nextRewardCountDown = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesResourceMsg.canRewardCount cannot be set twice.");
                  }
                  _loc9_++;
                  canRewardCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

