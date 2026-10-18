package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HeroFastKeyMsg extends Message implements IExternalizable
   {
      
      private var fast_key$field:String;
      
      private var set_result$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      public function HeroFastKeyMsg()
      {
         super();
      }
      
      public function removeFastKey() : void
      {
         fast_key$field = null;
      }
      
      public function get hasFastKey() : Boolean
      {
         return fast_key$field != null;
      }
      
      public function set fastKey(param1:String) : void
      {
         fast_key$field = param1;
      }
      
      public function get fastKey() : String
      {
         return fast_key$field;
      }
      
      public function removeSetResult() : void
      {
         hasField$0 &= 4294967294;
         set_result$field = new Boolean();
      }
      
      public function get hasSetResult() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set setResult(param1:Boolean) : void
      {
         hasField$0 |= 1;
         set_result$field = param1;
      }
      
      public function get setResult() : Boolean
      {
         return set_result$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasFastKey)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,fast_key$field);
         }
         if(hasSetResult)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,set_result$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HeroFastKeyMsg.fastKey cannot be set twice.");
                  }
                  _loc4_++;
                  fastKey = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HeroFastKeyMsg.setResult cannot be set twice.");
                  }
                  _loc5_++;
                  setResult = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

