package com.road.yishi.proto.room
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RoomExitMsg extends Message implements IExternalizable
   {
      
      private var msg$field:String;
      
      public function RoomExitMsg()
      {
         super();
      }
      
      public function removeMsg() : void
      {
         msg$field = null;
      }
      
      public function get hasMsg() : Boolean
      {
         return msg$field != null;
      }
      
      public function set msg(param1:String) : void
      {
         msg$field = param1;
      }
      
      public function get msg() : String
      {
         return msg$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMsg)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,msg$field);
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
                     throw new IOError("Bad data format: RoomExitMsg.msg cannot be set twice.");
                  }
                  _loc4_++;
                  msg = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

