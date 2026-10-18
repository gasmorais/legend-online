package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConditionSpeakMsg extends Message implements IExternalizable
   {
      
      private var speak$field:String;
      
      public function ConditionSpeakMsg()
      {
         super();
      }
      
      public function removeSpeak() : void
      {
         speak$field = null;
      }
      
      public function get hasSpeak() : Boolean
      {
         return speak$field != null;
      }
      
      public function set speak(param1:String) : void
      {
         speak$field = param1;
      }
      
      public function get speak() : String
      {
         return speak$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSpeak)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,speak$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConditionSpeakMsg.speak cannot be set twice.");
                  }
                  _loc4_++;
                  speak = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

