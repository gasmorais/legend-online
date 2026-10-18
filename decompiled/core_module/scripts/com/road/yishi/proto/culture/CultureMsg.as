package com.road.yishi.proto.culture
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CultureMsg extends Message implements IExternalizable
   {
      
      private var uuid$field:String;
      
      private var openTime$field:String;
      
      private var stopTime$field:String;
      
      private var needScore1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var needScore2$field:int;
      
      [ArrayElementType("com.road.yishi.proto.culture.ConditionMsg")]
      public var condition:Array = [];
      
      private var myTotalScore$field:int;
      
      private var myConsortiaScore$field:int;
      
      private var myServerScore$field:int;
      
      public function CultureMsg()
      {
         super();
      }
      
      public function removeUuid() : void
      {
         uuid$field = null;
      }
      
      public function get hasUuid() : Boolean
      {
         return uuid$field != null;
      }
      
      public function set uuid(param1:String) : void
      {
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
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
      
      public function removeNeedScore1() : void
      {
         hasField$0 &= 4294967294;
         needScore1$field = new int();
      }
      
      public function get hasNeedScore1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set needScore1(param1:int) : void
      {
         hasField$0 |= 1;
         needScore1$field = param1;
      }
      
      public function get needScore1() : int
      {
         return needScore1$field;
      }
      
      public function removeNeedScore2() : void
      {
         hasField$0 &= 4294967293;
         needScore2$field = new int();
      }
      
      public function get hasNeedScore2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set needScore2(param1:int) : void
      {
         hasField$0 |= 2;
         needScore2$field = param1;
      }
      
      public function get needScore2() : int
      {
         return needScore2$field;
      }
      
      public function removeMyTotalScore() : void
      {
         hasField$0 &= 4294967291;
         myTotalScore$field = new int();
      }
      
      public function get hasMyTotalScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set myTotalScore(param1:int) : void
      {
         hasField$0 |= 4;
         myTotalScore$field = param1;
      }
      
      public function get myTotalScore() : int
      {
         return myTotalScore$field;
      }
      
      public function removeMyConsortiaScore() : void
      {
         hasField$0 &= 4294967287;
         myConsortiaScore$field = new int();
      }
      
      public function get hasMyConsortiaScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set myConsortiaScore(param1:int) : void
      {
         hasField$0 |= 8;
         myConsortiaScore$field = param1;
      }
      
      public function get myConsortiaScore() : int
      {
         return myConsortiaScore$field;
      }
      
      public function removeMyServerScore() : void
      {
         hasField$0 &= 4294967279;
         myServerScore$field = new int();
      }
      
      public function get hasMyServerScore() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set myServerScore(param1:int) : void
      {
         hasField$0 |= 16;
         myServerScore$field = param1;
      }
      
      public function get myServerScore() : int
      {
         return myServerScore$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,stopTime$field);
         }
         if(hasNeedScore1)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,needScore1$field);
         }
         if(hasNeedScore2)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,needScore2$field);
         }
         _loc2_ = 0;
         while(_loc2_ < condition.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,condition[_loc2_]);
            _loc2_++;
         }
         if(hasMyTotalScore)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,myTotalScore$field);
         }
         if(hasMyConsortiaScore)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,myConsortiaScore$field);
         }
         if(hasMyServerScore)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,myServerScore$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc7_:ConditionMsg = null;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc12_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CultureMsg.uuid cannot be set twice.");
                  }
                  _loc4_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CultureMsg.openTime cannot be set twice.");
                  }
                  _loc11_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CultureMsg.stopTime cannot be set twice.");
                  }
                  _loc5_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CultureMsg.needScore1 cannot be set twice.");
                  }
                  _loc8_++;
                  needScore1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CultureMsg.needScore2 cannot be set twice.");
                  }
                  _loc12_++;
                  needScore2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  _loc7_ = new ConditionMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  condition.push(_loc7_);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CultureMsg.myTotalScore cannot be set twice.");
                  }
                  _loc6_++;
                  myTotalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CultureMsg.myConsortiaScore cannot be set twice.");
                  }
                  _loc3_++;
                  myConsortiaScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CultureMsg.myServerScore cannot be set twice.");
                  }
                  _loc9_++;
                  myServerScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

