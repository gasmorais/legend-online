package com.road.yishi.proto.team
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class JoinTeamReqMsg extends Message implements IExternalizable
   {
      
      private var tar_userId$field:int;
      
      private var hasField$0:uint = 0;
      
      public function JoinTeamReqMsg()
      {
         super();
      }
      
      public function removeTarUserId() : void
      {
         hasField$0 &= 4294967294;
         tar_userId$field = new int();
      }
      
      public function get hasTarUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set tarUserId(param1:int) : void
      {
         hasField$0 |= 1;
         tar_userId$field = param1;
      }
      
      public function get tarUserId() : int
      {
         return tar_userId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTarUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,tar_userId$field);
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
                     throw new IOError("Bad data format: JoinTeamReqMsg.tarUserId cannot be set twice.");
                  }
                  _loc3_++;
                  tarUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

