package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaRenameReqMsg extends Message implements IExternalizable
   {
      
      private var same$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var newName$field:String;
      
      private var pay_type$field:int;
      
      public function ConsortiaRenameReqMsg()
      {
         super();
      }
      
      public function removeSame() : void
      {
         hasField$0 &= 4294967294;
         same$field = new Boolean();
      }
      
      public function get hasSame() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set same(param1:Boolean) : void
      {
         hasField$0 |= 1;
         same$field = param1;
      }
      
      public function get same() : Boolean
      {
         return same$field;
      }
      
      public function removeNewName() : void
      {
         newName$field = null;
      }
      
      public function get hasNewName() : Boolean
      {
         return newName$field != null;
      }
      
      public function set newName(param1:String) : void
      {
         newName$field = param1;
      }
      
      public function get newName() : String
      {
         return newName$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967293;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 2;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSame)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,same$field);
         }
         if(hasNewName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,newName$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaRenameReqMsg.same cannot be set twice.");
                  }
                  _loc3_++;
                  same = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaRenameReqMsg.newName cannot be set twice.");
                  }
                  _loc5_++;
                  newName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaRenameReqMsg.payType cannot be set twice.");
                  }
                  _loc6_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

