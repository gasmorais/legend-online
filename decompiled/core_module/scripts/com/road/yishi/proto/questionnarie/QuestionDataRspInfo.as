package com.road.yishi.proto.questionnarie
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class QuestionDataRspInfo extends Message implements IExternalizable
   {
      
      private var questId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var answer$field:String;
      
      public function QuestionDataRspInfo()
      {
         super();
      }
      
      public function removeQuestId() : void
      {
         hasField$0 &= 4294967294;
         questId$field = new int();
      }
      
      public function get hasQuestId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set questId(param1:int) : void
      {
         hasField$0 |= 1;
         questId$field = param1;
      }
      
      public function get questId() : int
      {
         return questId$field;
      }
      
      public function removeAnswer() : void
      {
         answer$field = null;
      }
      
      public function get hasAnswer() : Boolean
      {
         return answer$field != null;
      }
      
      public function set answer(param1:String) : void
      {
         answer$field = param1;
      }
      
      public function get answer() : String
      {
         return answer$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasQuestId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,questId$field);
         }
         if(hasAnswer)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,answer$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionDataRspInfo.questId cannot be set twice.");
                  }
                  _loc3_++;
                  questId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionDataRspInfo.answer cannot be set twice.");
                  }
                  _loc5_++;
                  answer = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

