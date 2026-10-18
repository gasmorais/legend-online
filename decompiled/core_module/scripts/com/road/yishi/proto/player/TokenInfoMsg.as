package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TokenInfoMsg extends Message implements IExternalizable
   {
      
      private var masterType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var amount$field:int;
      
      private var expiredDate$field:String;
      
      public function TokenInfoMsg()
      {
         super();
      }
      
      public function removeMasterType() : void
      {
         hasField$0 &= 4294967294;
         masterType$field = new int();
      }
      
      public function get hasMasterType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set masterType(param1:int) : void
      {
         hasField$0 |= 1;
         masterType$field = param1;
      }
      
      public function get masterType() : int
      {
         return masterType$field;
      }
      
      public function removeAmount() : void
      {
         hasField$0 &= 4294967293;
         amount$field = new int();
      }
      
      public function get hasAmount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set amount(param1:int) : void
      {
         hasField$0 |= 2;
         amount$field = param1;
      }
      
      public function get amount() : int
      {
         return amount$field;
      }
      
      public function removeExpiredDate() : void
      {
         expiredDate$field = null;
      }
      
      public function get hasExpiredDate() : Boolean
      {
         return expiredDate$field != null;
      }
      
      public function set expiredDate(param1:String) : void
      {
         expiredDate$field = param1;
      }
      
      public function get expiredDate() : String
      {
         return expiredDate$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMasterType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,masterType$field);
         }
         if(hasAmount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,amount$field);
         }
         if(hasExpiredDate)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,expiredDate$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TokenInfoMsg.masterType cannot be set twice.");
                  }
                  _loc3_++;
                  masterType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TokenInfoMsg.amount cannot be set twice.");
                  }
                  _loc4_++;
                  amount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TokenInfoMsg.expiredDate cannot be set twice.");
                  }
                  _loc6_++;
                  expiredDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

