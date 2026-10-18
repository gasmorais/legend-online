package com.road.yishi.proto.leed
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LeedFinishedReqMsg extends Message implements IExternalizable
   {
      
      private var site$field:int;
      
      private var hasField$0:uint = 0;
      
      private var isWeek$field:Boolean;
      
      public function LeedFinishedReqMsg()
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
      
      public function removeIsWeek() : void
      {
         hasField$0 &= 4294967293;
         isWeek$field = new Boolean();
      }
      
      public function get hasIsWeek() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isWeek(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isWeek$field = param1;
      }
      
      public function get isWeek() : Boolean
      {
         return isWeek$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSite)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,site$field);
         }
         if(hasIsWeek)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,isWeek$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LeedFinishedReqMsg.site cannot be set twice.");
                  }
                  _loc3_++;
                  site = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LeedFinishedReqMsg.isWeek cannot be set twice.");
                  }
                  _loc5_++;
                  isWeek = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

