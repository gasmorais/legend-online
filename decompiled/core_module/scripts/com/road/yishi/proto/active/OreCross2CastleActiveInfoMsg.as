package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class OreCross2CastleActiveInfoMsg extends Message implements IExternalizable
   {
      
      private var openTime$field:String;
      
      private var closeTime$field:String;
      
      public function OreCross2CastleActiveInfoMsg()
      {
         super();
      }
      
      public function removeOpenTime() : void
      {
         openTime$field = null;
      }
      
      public function get hasOpenTime() : Boolean
      {
         return openTime$field != null;
      }
      
      public function set openTime(param1:String) : void
      {
         openTime$field = param1;
      }
      
      public function get openTime() : String
      {
         return openTime$field;
      }
      
      public function removeCloseTime() : void
      {
         closeTime$field = null;
      }
      
      public function get hasCloseTime() : Boolean
      {
         return closeTime$field != null;
      }
      
      public function set closeTime(param1:String) : void
      {
         closeTime$field = param1;
      }
      
      public function get closeTime() : String
      {
         return closeTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasCloseTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,closeTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: OreCross2CastleActiveInfoMsg.openTime cannot be set twice.");
                  }
                  _loc5_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: OreCross2CastleActiveInfoMsg.closeTime cannot be set twice.");
                  }
                  _loc3_++;
                  closeTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

