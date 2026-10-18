package com.road.yishi.proto.antaeus
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AntaeusMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var assistantData$field:String;
      
      [ArrayElementType("com.road.yishi.proto.antaeus.AntaeusAssistantMsg")]
      public var assistantList:Array = [];
      
      public function AntaeusMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeAssistantData() : void
      {
         assistantData$field = null;
      }
      
      public function get hasAssistantData() : Boolean
      {
         return assistantData$field != null;
      }
      
      public function set assistantData(param1:String) : void
      {
         assistantData$field = param1;
      }
      
      public function get assistantData() : String
      {
         return assistantData$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasAssistantData)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,assistantData$field);
         }
         _loc2_ = 0;
         while(_loc2_ < assistantList.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,assistantList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:AntaeusAssistantMsg = null;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AntaeusMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AntaeusMsg.assistantData cannot be set twice.");
                  }
                  _loc4_++;
                  assistantData = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  _loc3_ = new AntaeusAssistantMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  assistantList.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

