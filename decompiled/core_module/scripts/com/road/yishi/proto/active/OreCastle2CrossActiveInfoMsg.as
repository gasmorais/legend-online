package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class OreCastle2CrossActiveInfoMsg extends Message implements IExternalizable
   {
      
      private var openTime$field:String;
      
      private var closeTime$field:String;
      
      private var dailyMaxTurns$field:int;
      
      private var hasField$0:uint = 0;
      
      private var dailyMaxSpecialRewardTimes$field:int;
      
      private var countDown$field:int;
      
      private var type$field:int;
      
      [ArrayElementType("com.road.yishi.proto.active.OreRewardTempMsg")]
      public var rewards:Array = [];
      
      public function OreCastle2CrossActiveInfoMsg()
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
      
      public function removeDailyMaxTurns() : void
      {
         hasField$0 &= 4294967294;
         dailyMaxTurns$field = new int();
      }
      
      public function get hasDailyMaxTurns() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set dailyMaxTurns(param1:int) : void
      {
         hasField$0 |= 1;
         dailyMaxTurns$field = param1;
      }
      
      public function get dailyMaxTurns() : int
      {
         return dailyMaxTurns$field;
      }
      
      public function removeDailyMaxSpecialRewardTimes() : void
      {
         hasField$0 &= 4294967293;
         dailyMaxSpecialRewardTimes$field = new int();
      }
      
      public function get hasDailyMaxSpecialRewardTimes() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set dailyMaxSpecialRewardTimes(param1:int) : void
      {
         hasField$0 |= 2;
         dailyMaxSpecialRewardTimes$field = param1;
      }
      
      public function get dailyMaxSpecialRewardTimes() : int
      {
         return dailyMaxSpecialRewardTimes$field;
      }
      
      public function removeCountDown() : void
      {
         hasField$0 &= 4294967291;
         countDown$field = new int();
      }
      
      public function get hasCountDown() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set countDown(param1:int) : void
      {
         hasField$0 |= 4;
         countDown$field = param1;
      }
      
      public function get countDown() : int
      {
         return countDown$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967287;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 8;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
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
         if(hasDailyMaxTurns)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,dailyMaxTurns$field);
         }
         if(hasDailyMaxSpecialRewardTimes)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,dailyMaxSpecialRewardTimes$field);
         }
         if(hasCountDown)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,countDown$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         _loc2_ = 0;
         while(_loc2_ < rewards.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,rewards[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc8_:OreRewardTempMsg = null;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: OreCastle2CrossActiveInfoMsg.openTime cannot be set twice.");
                  }
                  _loc7_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: OreCastle2CrossActiveInfoMsg.closeTime cannot be set twice.");
                  }
                  _loc4_++;
                  closeTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: OreCastle2CrossActiveInfoMsg.dailyMaxTurns cannot be set twice.");
                  }
                  _loc10_++;
                  dailyMaxTurns = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: OreCastle2CrossActiveInfoMsg.dailyMaxSpecialRewardTimes cannot be set twice.");
                  }
                  _loc9_++;
                  dailyMaxSpecialRewardTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: OreCastle2CrossActiveInfoMsg.countDown cannot be set twice.");
                  }
                  _loc3_++;
                  countDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: OreCastle2CrossActiveInfoMsg.type cannot be set twice.");
                  }
                  _loc5_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  _loc8_ = new OreRewardTempMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  rewards.push(_loc8_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

