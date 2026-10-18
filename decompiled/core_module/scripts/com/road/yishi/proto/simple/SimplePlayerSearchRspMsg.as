package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SimplePlayerSearchRspMsg extends Message implements IExternalizable
   {
      
      private var info$field:SimplePlayerInfoMsg;
      
      public function SimplePlayerSearchRspMsg()
      {
         super();
      }
      
      public function removeInfo() : void
      {
         info$field = null;
      }
      
      public function get hasInfo() : Boolean
      {
         return info$field != null;
      }
      
      public function set info(param1:SimplePlayerInfoMsg) : void
      {
         info$field = param1;
      }
      
      public function get info() : SimplePlayerInfoMsg
      {
         return info$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasInfo)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,info$field);
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
                     throw new IOError("Bad data format: SimplePlayerSearchRspMsg.info cannot be set twice.");
                  }
                  _loc3_++;
                  info = new SimplePlayerInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,info);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

