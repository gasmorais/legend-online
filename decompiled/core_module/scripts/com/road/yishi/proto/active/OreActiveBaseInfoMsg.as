package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class OreActiveBaseInfoMsg extends Message implements IExternalizable
   {
      
      private var openTime$field:String;
      
      private var closeTime$field:String;
      
      private var mineOncePrice$field:int;
      
      private var hasField$0:uint = 0;
      
      private var mineTimesPrice$field:int;
      
      [ArrayElementType("com.road.yishi.proto.active.OreRewardTempMsg")]
      public var rewards:Array = [];
      
      public function OreActiveBaseInfoMsg()
      {
         super();
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
      
      public function removeCloseTime() : void
      {
         closeTime$field = null;
      }
      
      public function get hasCloseTime() : Boolean
      {
         return closeTime$field != null;
      }
      
      public function set closeTime(param1:String) : void
      {
         closeTime$field = param1;
      }
      
      public function get closeTime() : String
      {
         return closeTime$field;
      }
      
      public function removeMineOncePrice() : void
      {
         hasField$0 &= 4294967294;
         mineOncePrice$field = new int();
      }
      
      public function get hasMineOncePrice() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mineOncePrice(param1:int) : void
      {
         hasField$0 |= 1;
         mineOncePrice$field = param1;
      }
      
      public function get mineOncePrice() : int
      {
         return mineOncePrice$field;
      }
      
      public function removeMineTimesPrice() : void
      {
         hasField$0 &= 4294967293;
         mineTimesPrice$field = new int();
      }
      
      public function get hasMineTimesPrice() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set mineTimesPrice(param1:int) : void
      {
         hasField$0 |= 2;
         mineTimesPrice$field = param1;
      }
      
      public function get mineTimesPrice() : int
      {
         return mineTimesPrice$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasCloseTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,closeTime$field);
         }
         if(hasMineOncePrice)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,mineOncePrice$field);
         }
         if(hasMineTimesPrice)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,mineTimesPrice$field);
         }
         _loc2_ = 0;
         while(_loc2_ < rewards.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,rewards[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc8_:OreRewardTempMsg = null;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: OreActiveBaseInfoMsg.openTime cannot be set twice.");
                  }
                  _loc6_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: OreActiveBaseInfoMsg.closeTime cannot be set twice.");
                  }
                  _loc4_++;
                  closeTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: OreActiveBaseInfoMsg.mineOncePrice cannot be set twice.");
                  }
                  _loc7_++;
                  mineOncePrice = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: OreActiveBaseInfoMsg.mineTimesPrice cannot be set twice.");
                  }
                  _loc3_++;
                  mineTimesPrice = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc8_ = new OreRewardTempMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  rewards.push(_loc8_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

