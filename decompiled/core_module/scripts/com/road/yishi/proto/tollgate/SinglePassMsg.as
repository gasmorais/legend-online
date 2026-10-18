package com.road.yishi.proto.tollgate
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SinglePassMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var area$field:int;
      
      private var max_index$field:int;
      
      private var area_reward$field:String;
      
      [ArrayElementType("com.road.yishi.proto.tollgate.RankInfoMsg")]
      public var rankInfo:Array = [];
      
      private var count$field:int;
      
      private var item_count$field:int;
      
      public function SinglePassMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeArea() : void
      {
         hasField$0 &= 4294967293;
         area$field = new int();
      }
      
      public function get hasArea() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set area(param1:int) : void
      {
         hasField$0 |= 2;
         area$field = param1;
      }
      
      public function get area() : int
      {
         return area$field;
      }
      
      public function removeMaxIndex() : void
      {
         hasField$0 &= 4294967291;
         max_index$field = new int();
      }
      
      public function get hasMaxIndex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set maxIndex(param1:int) : void
      {
         hasField$0 |= 4;
         max_index$field = param1;
      }
      
      public function get maxIndex() : int
      {
         return max_index$field;
      }
      
      public function removeAreaReward() : void
      {
         area_reward$field = null;
      }
      
      public function get hasAreaReward() : Boolean
      {
         return area_reward$field != null;
      }
      
      public function set areaReward(param1:String) : void
      {
         area_reward$field = param1;
      }
      
      public function get areaReward() : String
      {
         return area_reward$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967287;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 8;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeItemCount() : void
      {
         hasField$0 &= 4294967279;
         item_count$field = new int();
      }
      
      public function get hasItemCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set itemCount(param1:int) : void
      {
         hasField$0 |= 16;
         item_count$field = param1;
      }
      
      public function get itemCount() : int
      {
         return item_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasArea)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,area$field);
         }
         if(hasMaxIndex)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,max_index$field);
         }
         if(hasAreaReward)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,area_reward$field);
         }
         _loc2_ = 0;
         while(_loc2_ < rankInfo.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,rankInfo[_loc2_]);
            _loc2_++;
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasItemCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,item_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:RankInfoMsg = null;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SinglePassMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SinglePassMsg.area cannot be set twice.");
                  }
                  _loc8_++;
                  area = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SinglePassMsg.maxIndex cannot be set twice.");
                  }
                  _loc9_++;
                  maxIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SinglePassMsg.areaReward cannot be set twice.");
                  }
                  _loc4_++;
                  areaReward = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  _loc3_ = new RankInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  rankInfo.push(_loc3_);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SinglePassMsg.count cannot be set twice.");
                  }
                  _loc5_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SinglePassMsg.itemCount cannot be set twice.");
                  }
                  _loc10_++;
                  itemCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

