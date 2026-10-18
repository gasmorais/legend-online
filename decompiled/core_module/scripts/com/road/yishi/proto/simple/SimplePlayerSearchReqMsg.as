package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SimplePlayerSearchReqMsg extends Message implements IExternalizable
   {
      
      private var other_nickname$field:String;
      
      public function SimplePlayerSearchReqMsg()
      {
         super();
      }
      
      public function removeOtherNickname() : void
      {
         other_nickname$field = null;
      }
      
      public function get hasOtherNickname() : Boolean
      {
         return other_nickname$field != null;
      }
      
      public function set otherNickname(param1:String) : void
      {
         other_nickname$field = param1;
      }
      
      public function get otherNickname() : String
      {
         return other_nickname$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOtherNickname)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,other_nickname$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerSearchReqMsg.otherNickname cannot be set twice.");
                  }
                  _loc4_++;
                  otherNickname = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

