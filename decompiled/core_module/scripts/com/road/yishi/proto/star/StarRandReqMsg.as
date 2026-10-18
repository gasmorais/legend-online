package com.road.yishi.proto.star
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StarRandReqMsg extends Message implements IExternalizable
   {
      
      private var site$field:int;
      
      private var hasField$0:uint = 0;
      
      public function StarRandReqMsg()
      {
         super();
      }
      
      public function removeSite() : void
      {
         hasField$0 &= 4294967294;
         site$field = new int();
      }
      
      public function get hasSite() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set site(param1:int) : void
      {
         hasField$0 |= 1;
         site$field = param1;
      }
      
      public function get site() : int
      {
         return site$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSite)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,site$field);
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
                     throw new IOError("Bad data format: StarRandReqMsg.site cannot be set twice.");
                  }
                  _loc3_++;
                  site = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

