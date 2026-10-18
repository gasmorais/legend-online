package com.road.yishi.proto.reward
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RewardFreshReqMsg extends Message implements IExternalizable
   {
      
      private var isButton$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var pay_type$field:int;
      
      public function RewardFreshReqMsg()
      {
         super();
      }
      
      public function removeIsButton() : void
      {
         hasField$0 &= 4294967294;
         isButton$field = new Boolean();
      }
      
      public function get hasIsButton() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isButton(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isButton$field = param1;
      }
      
      public function get isButton() : Boolean
      {
         return isButton$field;
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
         if(hasIsButton)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,isButton$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
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
                     throw new IOError("Bad data format: RewardFreshReqMsg.isButton cannot be set twice.");
                  }
                  _loc3_++;
                  isButton = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RewardFreshReqMsg.payType cannot be set twice.");
                  }
                  _loc5_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

