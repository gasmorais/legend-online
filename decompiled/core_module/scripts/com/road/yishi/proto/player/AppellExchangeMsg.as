package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AppellExchangeMsg extends Message implements IExternalizable
   {
      
      private var appellId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var look$field:Boolean;
      
      public function AppellExchangeMsg()
      {
         super();
      }
      
      public function removeAppellId() : void
      {
         hasField$0 &= 4294967294;
         appellId$field = new int();
      }
      
      public function get hasAppellId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set appellId(param1:int) : void
      {
         hasField$0 |= 1;
         appellId$field = param1;
      }
      
      public function get appellId() : int
      {
         return appellId$field;
      }
      
      public function removeLook() : void
      {
         hasField$0 &= 4294967293;
         look$field = new Boolean();
      }
      
      public function get hasLook() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set look(param1:Boolean) : void
      {
         hasField$0 |= 2;
         look$field = param1;
      }
      
      public function get look() : Boolean
      {
         return look$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasAppellId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,appellId$field);
         }
         if(hasLook)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,look$field);
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
                     throw new IOError("Bad data format: AppellExchangeMsg.appellId cannot be set twice.");
                  }
                  _loc5_++;
                  appellId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AppellExchangeMsg.look cannot be set twice.");
                  }
                  _loc3_++;
                  look = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

