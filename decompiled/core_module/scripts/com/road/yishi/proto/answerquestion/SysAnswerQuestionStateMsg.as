package com.road.yishi.proto.answerquestion
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SysAnswerQuestionStateMsg extends Message implements IExternalizable
   {
      
      private var sysState$field:int;
      
      private var hasField$0:uint = 0;
      
      private var sysAnswerCount$field:int;
      
      private var left_count$field:int;
      
      private var begin_date$field:String;
      
      private var last_date$field:String;
      
      public function SysAnswerQuestionStateMsg()
      {
         super();
      }
      
      public function removeSysState() : void
      {
         hasField$0 &= 4294967294;
         sysState$field = new int();
      }
      
      public function get hasSysState() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set sysState(param1:int) : void
      {
         hasField$0 |= 1;
         sysState$field = param1;
      }
      
      public function get sysState() : int
      {
         return sysState$field;
      }
      
      public function removeSysAnswerCount() : void
      {
         hasField$0 &= 4294967293;
         sysAnswerCount$field = new int();
      }
      
      public function get hasSysAnswerCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set sysAnswerCount(param1:int) : void
      {
         hasField$0 |= 2;
         sysAnswerCount$field = param1;
      }
      
      public function get sysAnswerCount() : int
      {
         return sysAnswerCount$field;
      }
      
      public function removeLeftCount() : void
      {
         hasField$0 &= 4294967291;
         left_count$field = new int();
      }
      
      public function get hasLeftCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set leftCount(param1:int) : void
      {
         hasField$0 |= 4;
         left_count$field = param1;
      }
      
      public function get leftCount() : int
      {
         return left_count$field;
      }
      
      public function removeBeginDate() : void
      {
         begin_date$field = null;
      }
      
      public function get hasBeginDate() : Boolean
      {
         return begin_date$field != null;
      }
      
      public function set beginDate(param1:String) : void
      {
         begin_date$field = param1;
      }
      
      public function get beginDate() : String
      {
         return begin_date$field;
      }
      
      public function removeLastDate() : void
      {
         last_date$field = null;
      }
      
      public function get hasLastDate() : Boolean
      {
         return last_date$field != null;
      }
      
      public function set lastDate(param1:String) : void
      {
         last_date$field = param1;
      }
      
      public function get lastDate() : String
      {
         return last_date$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSysState)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,sysState$field);
         }
         if(hasSysAnswerCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,sysAnswerCount$field);
         }
         if(hasLeftCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,left_count$field);
         }
         if(hasBeginDate)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,begin_date$field);
         }
         if(hasLastDate)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,last_date$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SysAnswerQuestionStateMsg.sysState cannot be set twice.");
                  }
                  _loc4_++;
                  sysState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SysAnswerQuestionStateMsg.sysAnswerCount cannot be set twice.");
                  }
                  _loc3_++;
                  sysAnswerCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SysAnswerQuestionStateMsg.leftCount cannot be set twice.");
                  }
                  _loc8_++;
                  leftCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SysAnswerQuestionStateMsg.beginDate cannot be set twice.");
                  }
                  _loc6_++;
                  beginDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SysAnswerQuestionStateMsg.lastDate cannot be set twice.");
                  }
                  _loc5_++;
                  lastDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

