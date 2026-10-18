package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ReplacementMsg extends Message implements IExternalizable
   {
      
      private var state_str$field:String;
      
      public function ReplacementMsg()
      {
         super();
      }
      
      public function removeStateStr() : void
      {
         state_str$field = null;
      }
      
      public function get hasStateStr() : Boolean
      {
         return state_str$field != null;
      }
      
      public function set stateStr(param1:String) : void
      {
         state_str$field = param1;
      }
      
      public function get stateStr() : String
      {
         return state_str$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasStateStr)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,state_str$field);
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
                     throw new IOError("Bad data format: ReplacementMsg.stateStr cannot be set twice.");
                  }
                  _loc4_++;
                  stateStr = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

