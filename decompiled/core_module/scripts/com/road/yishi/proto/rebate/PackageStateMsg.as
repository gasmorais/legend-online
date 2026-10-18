package com.road.yishi.proto.rebate
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PackageStateMsg extends Message implements IExternalizable
   {
      
      private var id$field:String;
      
      private var isget$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      public function PackageStateMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         id$field = null;
      }
      
      public function get hasId() : Boolean
      {
         return id$field != null;
      }
      
      public function set id(param1:String) : void
      {
         id$field = param1;
      }
      
      public function get id() : String
      {
         return id$field;
      }
      
      public function removeIsget() : void
      {
         hasField$0 &= 4294967294;
         isget$field = new Boolean();
      }
      
      public function get hasIsget() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isget(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isget$field = param1;
      }
      
      public function get isget() : Boolean
      {
         return isget$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,id$field);
         }
         if(hasIsget)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,isget$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PackageStateMsg.id cannot be set twice.");
                  }
                  _loc4_++;
                  id = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PackageStateMsg.isget cannot be set twice.");
                  }
                  _loc3_++;
                  isget = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

