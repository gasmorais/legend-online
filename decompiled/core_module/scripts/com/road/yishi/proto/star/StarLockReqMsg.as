package com.road.yishi.proto.star
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StarLockReqMsg extends Message implements IExternalizable
   {
      
      private var star_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pos$field:int;
      
      public function StarLockReqMsg()
      {
         super();
      }
      
      public function removeStarType() : void
      {
         hasField$0 &= 4294967294;
         star_type$field = new int();
      }
      
      public function get hasStarType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set starType(param1:int) : void
      {
         hasField$0 |= 1;
         star_type$field = param1;
      }
      
      public function get starType() : int
      {
         return star_type$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967293;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 2;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasStarType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,star_type$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
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
                     throw new IOError("Bad data format: StarLockReqMsg.starType cannot be set twice.");
                  }
                  _loc5_++;
                  starType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StarLockReqMsg.pos cannot be set twice.");
                  }
                  _loc3_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

