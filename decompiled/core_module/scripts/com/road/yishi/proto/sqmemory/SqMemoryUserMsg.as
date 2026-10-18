package com.road.yishi.proto.sqmemory
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SqMemoryUserMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var beginInfo$field:String;
      
      private var friendShipInfo$field:String;
      
      private var growthInfo$field:String;
      
      private var honourInfo$field:String;
      
      private var legendInfo$field:String;
      
      private var shareInfo$field:String;
      
      private var isReward$field:Boolean;
      
      public function SqMemoryUserMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeBeginInfo() : void
      {
         beginInfo$field = null;
      }
      
      public function get hasBeginInfo() : Boolean
      {
         return beginInfo$field != null;
      }
      
      public function set beginInfo(param1:String) : void
      {
         beginInfo$field = param1;
      }
      
      public function get beginInfo() : String
      {
         return beginInfo$field;
      }
      
      public function removeFriendShipInfo() : void
      {
         friendShipInfo$field = null;
      }
      
      public function get hasFriendShipInfo() : Boolean
      {
         return friendShipInfo$field != null;
      }
      
      public function set friendShipInfo(param1:String) : void
      {
         friendShipInfo$field = param1;
      }
      
      public function get friendShipInfo() : String
      {
         return friendShipInfo$field;
      }
      
      public function removeGrowthInfo() : void
      {
         growthInfo$field = null;
      }
      
      public function get hasGrowthInfo() : Boolean
      {
         return growthInfo$field != null;
      }
      
      public function set growthInfo(param1:String) : void
      {
         growthInfo$field = param1;
      }
      
      public function get growthInfo() : String
      {
         return growthInfo$field;
      }
      
      public function removeHonourInfo() : void
      {
         honourInfo$field = null;
      }
      
      public function get hasHonourInfo() : Boolean
      {
         return honourInfo$field != null;
      }
      
      public function set honourInfo(param1:String) : void
      {
         honourInfo$field = param1;
      }
      
      public function get honourInfo() : String
      {
         return honourInfo$field;
      }
      
      public function removeLegendInfo() : void
      {
         legendInfo$field = null;
      }
      
      public function get hasLegendInfo() : Boolean
      {
         return legendInfo$field != null;
      }
      
      public function set legendInfo(param1:String) : void
      {
         legendInfo$field = param1;
      }
      
      public function get legendInfo() : String
      {
         return legendInfo$field;
      }
      
      public function removeShareInfo() : void
      {
         shareInfo$field = null;
      }
      
      public function get hasShareInfo() : Boolean
      {
         return shareInfo$field != null;
      }
      
      public function set shareInfo(param1:String) : void
      {
         shareInfo$field = param1;
      }
      
      public function get shareInfo() : String
      {
         return shareInfo$field;
      }
      
      public function removeIsReward() : void
      {
         hasField$0 &= 4294967293;
         isReward$field = new Boolean();
      }
      
      public function get hasIsReward() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isReward(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isReward$field = param1;
      }
      
      public function get isReward() : Boolean
      {
         return isReward$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasBeginInfo)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,beginInfo$field);
         }
         if(hasFriendShipInfo)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,friendShipInfo$field);
         }
         if(hasGrowthInfo)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,growthInfo$field);
         }
         if(hasHonourInfo)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,honourInfo$field);
         }
         if(hasLegendInfo)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,legendInfo$field);
         }
         if(hasShareInfo)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,shareInfo$field);
         }
         if(hasIsReward)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,isReward$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SqMemoryUserMsg.opType cannot be set twice.");
                  }
                  _loc4_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SqMemoryUserMsg.beginInfo cannot be set twice.");
                  }
                  _loc3_++;
                  beginInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SqMemoryUserMsg.friendShipInfo cannot be set twice.");
                  }
                  _loc5_++;
                  friendShipInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SqMemoryUserMsg.growthInfo cannot be set twice.");
                  }
                  _loc8_++;
                  growthInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SqMemoryUserMsg.honourInfo cannot be set twice.");
                  }
                  _loc9_++;
                  honourInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SqMemoryUserMsg.legendInfo cannot be set twice.");
                  }
                  _loc10_++;
                  legendInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SqMemoryUserMsg.shareInfo cannot be set twice.");
                  }
                  _loc7_++;
                  shareInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SqMemoryUserMsg.isReward cannot be set twice.");
                  }
                  _loc6_++;
                  isReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

