package com.road.yishi.proto.leed
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LeedUpdatedRspMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.leed.LeedData")]
      public var leed:Array = [];
      
      private var leedProcess$field:int;
      
      private var hasField$0:uint = 0;
      
      private var totalNum$field:int;
      
      private var leadExtractTimes$field:int;
      
      private var weekLeedProcess$field:int;
      
      private var weekTotalNum$field:int;
      
      private var buff_stop_date$field:String;
      
      public function LeedUpdatedRspMsg()
      {
         super();
      }
      
      public function removeLeedProcess() : void
      {
         hasField$0 &= 4294967294;
         leedProcess$field = new int();
      }
      
      public function get hasLeedProcess() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set leedProcess(param1:int) : void
      {
         hasField$0 |= 1;
         leedProcess$field = param1;
      }
      
      public function get leedProcess() : int
      {
         return leedProcess$field;
      }
      
      public function removeTotalNum() : void
      {
         hasField$0 &= 4294967293;
         totalNum$field = new int();
      }
      
      public function get hasTotalNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalNum(param1:int) : void
      {
         hasField$0 |= 2;
         totalNum$field = param1;
      }
      
      public function get totalNum() : int
      {
         return totalNum$field;
      }
      
      public function removeLeadExtractTimes() : void
      {
         hasField$0 &= 4294967291;
         leadExtractTimes$field = new int();
      }
      
      public function get hasLeadExtractTimes() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set leadExtractTimes(param1:int) : void
      {
         hasField$0 |= 4;
         leadExtractTimes$field = param1;
      }
      
      public function get leadExtractTimes() : int
      {
         return leadExtractTimes$field;
      }
      
      public function removeWeekLeedProcess() : void
      {
         hasField$0 &= 4294967287;
         weekLeedProcess$field = new int();
      }
      
      public function get hasWeekLeedProcess() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set weekLeedProcess(param1:int) : void
      {
         hasField$0 |= 8;
         weekLeedProcess$field = param1;
      }
      
      public function get weekLeedProcess() : int
      {
         return weekLeedProcess$field;
      }
      
      public function removeWeekTotalNum() : void
      {
         hasField$0 &= 4294967279;
         weekTotalNum$field = new int();
      }
      
      public function get hasWeekTotalNum() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set weekTotalNum(param1:int) : void
      {
         hasField$0 |= 16;
         weekTotalNum$field = param1;
      }
      
      public function get weekTotalNum() : int
      {
         return weekTotalNum$field;
      }
      
      public function removeBuffStopDate() : void
      {
         buff_stop_date$field = null;
      }
      
      public function get hasBuffStopDate() : Boolean
      {
         return buff_stop_date$field != null;
      }
      
      public function set buffStopDate(param1:String) : void
      {
         buff_stop_date$field = param1;
      }
      
      public function get buffStopDate() : String
      {
         return buff_stop_date$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < leed.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,leed[_loc2_]);
            _loc2_++;
         }
         if(hasLeedProcess)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,leedProcess$field);
         }
         if(hasTotalNum)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,totalNum$field);
         }
         if(hasLeadExtractTimes)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,leadExtractTimes$field);
         }
         if(hasWeekLeedProcess)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,weekLeedProcess$field);
         }
         if(hasWeekTotalNum)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,weekTotalNum$field);
         }
         if(hasBuffStopDate)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,buff_stop_date$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc10_:LeedData = null;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc10_ = new LeedData();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  leed.push(_loc10_);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LeedUpdatedRspMsg.leedProcess cannot be set twice.");
                  }
                  _loc5_++;
                  leedProcess = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LeedUpdatedRspMsg.totalNum cannot be set twice.");
                  }
                  _loc8_++;
                  totalNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LeedUpdatedRspMsg.leadExtractTimes cannot be set twice.");
                  }
                  _loc4_++;
                  leadExtractTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LeedUpdatedRspMsg.weekLeedProcess cannot be set twice.");
                  }
                  _loc6_++;
                  weekLeedProcess = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: LeedUpdatedRspMsg.weekTotalNum cannot be set twice.");
                  }
                  _loc9_++;
                  weekTotalNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LeedUpdatedRspMsg.buffStopDate cannot be set twice.");
                  }
                  _loc3_++;
                  buffStopDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

