package com.road.yishi.proto.gateway
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GatewayMsg extends Message implements IExternalizable
   {
      
      private var notify_msg$field:String;
      
      public function GatewayMsg()
      {
         super();
      }
      
      public function removeNotifyMsg() : void
      {
         notify_msg$field = null;
      }
      
      public function get hasNotifyMsg() : Boolean
      {
         return notify_msg$field != null;
      }
      
      public function set notifyMsg(param1:String) : void
      {
         notify_msg$field = param1;
      }
      
      public function get notifyMsg() : String
      {
         return notify_msg$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNotifyMsg)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,notify_msg$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GatewayMsg.notifyMsg cannot be set twice.");
                  }
                  _loc3_++;
                  notifyMsg = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

