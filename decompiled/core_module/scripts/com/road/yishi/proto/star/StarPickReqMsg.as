package com.road.yishi.proto.star
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StarPickReqMsg extends Message implements IExternalizable
   {
      
      private var dropsite$field:int;
      
      private var hasField$0:uint = 0;
      
      private var way$field:int;
      
      public function StarPickReqMsg()
      {
         super();
      }
      
      public function removeDropsite() : void
      {
         hasField$0 &= 4294967294;
         dropsite$field = new int();
      }
      
      public function get hasDropsite() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set dropsite(param1:int) : void
      {
         hasField$0 |= 1;
         dropsite$field = param1;
      }
      
      public function get dropsite() : int
      {
         return dropsite$field;
      }
      
      public function removeWay() : void
      {
         hasField$0 &= 4294967293;
         way$field = new int();
      }
      
      public function get hasWay() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set way(param1:int) : void
      {
         hasField$0 |= 2;
         way$field = param1;
      }
      
      public function get way() : int
      {
         return way$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasDropsite)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,dropsite$field);
         }
         if(hasWay)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,way$field);
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
                     throw new IOError("Bad data format: StarPickReqMsg.dropsite cannot be set twice.");
                  }
                  _loc3_++;
                  dropsite = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StarPickReqMsg.way cannot be set twice.");
                  }
                  _loc4_++;
                  way = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

