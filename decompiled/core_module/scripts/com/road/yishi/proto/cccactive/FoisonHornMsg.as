package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FoisonHornMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var itemId$field:int;
      
      private var isOpen$field:Boolean;
      
      private var openTime$field:String;
      
      private var stopTime$field:String;
      
      private var count$field:int;
      
      private var activation$field:String;
      
      private var rewardInfo$field:String;
      
      public function FoisonHornMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeItemId() : void
      {
         hasField$0 &= 4294967293;
         itemId$field = new int();
      }
      
      public function get hasItemId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set itemId(param1:int) : void
      {
         hasField$0 |= 2;
         itemId$field = param1;
      }
      
      public function get itemId() : int
      {
         return itemId$field;
      }
      
      public function removeIsOpen() : void
      {
         hasField$0 &= 4294967291;
         isOpen$field = new Boolean();
      }
      
      public function get hasIsOpen() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         hasField$0 |= 4;
         isOpen$field = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return isOpen$field;
      }
      
      public function removeOpenTime() : void
      {
         openTime$field = null;
      }
      
      public function get hasOpenTime() : Boolean
      {
         return openTime$field != null;
      }
      
      public function set openTime(param1:String) : void
      {
         openTime$field = param1;
      }
      
      public function get openTime() : String
      {
         return openTime$field;
      }
      
      public function removeStopTime() : void
      {
         stopTime$field = null;
      }
      
      public function get hasStopTime() : Boolean
      {
         return stopTime$field != null;
      }
      
      public function set stopTime(param1:String) : void
      {
         stopTime$field = param1;
      }
      
      public function get stopTime() : String
      {
         return stopTime$field;
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
      
      public function removeActivation() : void
      {
         activation$field = null;
      }
      
      public function get hasActivation() : Boolean
      {
         return activation$field != null;
      }
      
      public function set activation(param1:String) : void
      {
         activation$field = param1;
      }
      
      public function get activation() : String
      {
         return activation$field;
      }
      
      public function removeRewardInfo() : void
      {
         rewardInfo$field = null;
      }
      
      public function get hasRewardInfo() : Boolean
      {
         return rewardInfo$field != null;
      }
      
      public function set rewardInfo(param1:String) : void
      {
         rewardInfo$field = param1;
      }
      
      public function get rewardInfo() : String
      {
         return rewardInfo$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasItemId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,itemId$field);
         }
         if(hasIsOpen)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,isOpen$field);
         }
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,stopTime$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasActivation)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,activation$field);
         }
         if(hasRewardInfo)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,rewardInfo$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FoisonHornMsg.op cannot be set twice.");
                  }
                  _loc11_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FoisonHornMsg.itemId cannot be set twice.");
                  }
                  _loc9_++;
                  itemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FoisonHornMsg.isOpen cannot be set twice.");
                  }
                  _loc4_++;
                  isOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FoisonHornMsg.openTime cannot be set twice.");
                  }
                  _loc10_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FoisonHornMsg.stopTime cannot be set twice.");
                  }
                  _loc3_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FoisonHornMsg.count cannot be set twice.");
                  }
                  _loc5_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FoisonHornMsg.activation cannot be set twice.");
                  }
                  _loc6_++;
                  activation = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FoisonHornMsg.rewardInfo cannot be set twice.");
                  }
                  _loc7_++;
                  rewardInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

