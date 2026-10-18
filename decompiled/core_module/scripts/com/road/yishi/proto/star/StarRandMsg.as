package com.road.yishi.proto.star
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StarRandMsg extends Message implements IExternalizable
   {
      
      private var dropSite$field:int;
      
      private var hasField$0:uint = 0;
      
      private var starInfo$field:StarInfoMsg;
      
      public function StarRandMsg()
      {
         super();
      }
      
      public function removeDropSite() : void
      {
         hasField$0 &= 4294967294;
         dropSite$field = new int();
      }
      
      public function get hasDropSite() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set dropSite(param1:int) : void
      {
         hasField$0 |= 1;
         dropSite$field = param1;
      }
      
      public function get dropSite() : int
      {
         return dropSite$field;
      }
      
      public function removeStarInfo() : void
      {
         starInfo$field = null;
      }
      
      public function get hasStarInfo() : Boolean
      {
         return starInfo$field != null;
      }
      
      public function set starInfo(param1:StarInfoMsg) : void
      {
         starInfo$field = param1;
      }
      
      public function get starInfo() : StarInfoMsg
      {
         return starInfo$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasDropSite)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,dropSite$field);
         }
         if(hasStarInfo)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,starInfo$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StarRandMsg.dropSite cannot be set twice.");
                  }
                  _loc3_++;
                  dropSite = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StarRandMsg.starInfo cannot be set twice.");
                  }
                  _loc4_++;
                  starInfo = new StarInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,starInfo);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

