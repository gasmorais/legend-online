package com.road.yishi.proto.marriage
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MarriageHeartMsg extends Message implements IExternalizable
   {
      
      private var cur_question$field:HeartMsg;
      
      [ArrayElementType("com.road.yishi.proto.marriage.HeartMsg")]
      public var lastQuestions:Array = [];
      
      private var sync_rate$field:int;
      
      private var hasField$0:uint = 0;
      
      private var max_order$field:int;
      
      public function MarriageHeartMsg()
      {
         super();
      }
      
      public function removeCurQuestion() : void
      {
         cur_question$field = null;
      }
      
      public function get hasCurQuestion() : Boolean
      {
         return cur_question$field != null;
      }
      
      public function set curQuestion(param1:HeartMsg) : void
      {
         cur_question$field = param1;
      }
      
      public function get curQuestion() : HeartMsg
      {
         return cur_question$field;
      }
      
      public function removeSyncRate() : void
      {
         hasField$0 &= 4294967294;
         sync_rate$field = new int();
      }
      
      public function get hasSyncRate() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set syncRate(param1:int) : void
      {
         hasField$0 |= 1;
         sync_rate$field = param1;
      }
      
      public function get syncRate() : int
      {
         return sync_rate$field;
      }
      
      public function removeMaxOrder() : void
      {
         hasField$0 &= 4294967293;
         max_order$field = new int();
      }
      
      public function get hasMaxOrder() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set maxOrder(param1:int) : void
      {
         hasField$0 |= 2;
         max_order$field = param1;
      }
      
      public function get maxOrder() : int
      {
         return max_order$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasCurQuestion)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,cur_question$field);
         }
         _loc2_ = 0;
         while(_loc2_ < lastQuestions.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,lastQuestions[_loc2_]);
            _loc2_++;
         }
         if(hasSyncRate)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,sync_rate$field);
         }
         if(hasMaxOrder)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,max_order$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:HeartMsg = null;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageHeartMsg.curQuestion cannot be set twice.");
                  }
                  _loc4_++;
                  curQuestion = new HeartMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,curQuestion);
                  break;
               case 1:
                  _loc7_ = new HeartMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  lastQuestions.push(_loc7_);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageHeartMsg.syncRate cannot be set twice.");
                  }
                  _loc3_++;
                  syncRate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageHeartMsg.maxOrder cannot be set twice.");
                  }
                  _loc5_++;
                  maxOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

