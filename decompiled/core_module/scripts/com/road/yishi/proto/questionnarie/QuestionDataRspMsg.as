package com.road.yishi.proto.questionnarie
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class QuestionDataRspMsg extends Message implements IExternalizable
   {
      
      private var isFirst$field:int;
      
      private var hasField$0:uint = 0;
      
      private var id$field:int;
      
      [ArrayElementType("com.road.yishi.proto.questionnarie.QuestionDataRspInfo")]
      public var infolist:Array = [];
      
      public function QuestionDataRspMsg()
      {
         super();
      }
      
      public function removeIsFirst() : void
      {
         hasField$0 &= 4294967294;
         isFirst$field = new int();
      }
      
      public function get hasIsFirst() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isFirst(param1:int) : void
      {
         hasField$0 |= 1;
         isFirst$field = param1;
      }
      
      public function get isFirst() : int
      {
         return isFirst$field;
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967293;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 2;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasIsFirst)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,isFirst$field);
         }
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < infolist.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,infolist[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:QuestionDataRspInfo = null;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionDataRspMsg.isFirst cannot be set twice.");
                  }
                  _loc6_++;
                  isFirst = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionDataRspMsg.id cannot be set twice.");
                  }
                  _loc4_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc3_ = new QuestionDataRspInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  infolist.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

