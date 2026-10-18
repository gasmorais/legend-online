package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WarFightFlagEndTimeMsg extends Message implements IExternalizable
   {
      
      private var endTime$field:String;
      
      public function WarFightFlagEndTimeMsg()
      {
         super();
      }
      
      public function removeEndTime() : void
      {
         endTime$field = null;
      }
      
      public function get hasEndTime() : Boolean
      {
         return endTime$field != null;
      }
      
      public function set endTime(param1:String) : void
      {
         endTime$field = param1;
      }
      
      public function get endTime() : String
      {
         return endTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,endTime$field);
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
                     throw new IOError("Bad data format: WarFightFlagEndTimeMsg.endTime cannot be set twice.");
                  }
                  _loc3_++;
                  endTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

