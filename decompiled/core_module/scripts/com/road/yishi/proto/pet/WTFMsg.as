package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WTFMsg extends Message implements IExternalizable
   {
      
      private var cash$field:int;
      
      private var hasField$0:uint = 0;
      
      private var action$field:TableActMsg;
      
      public function WTFMsg()
      {
         super();
      }
      
      public function removeCash() : void
      {
         hasField$0 &= 4294967294;
         cash$field = new int();
      }
      
      public function get hasCash() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set cash(param1:int) : void
      {
         hasField$0 |= 1;
         cash$field = param1;
      }
      
      public function get cash() : int
      {
         return cash$field;
      }
      
      public function removeAction() : void
      {
         action$field = null;
      }
      
      public function get hasAction() : Boolean
      {
         return action$field != null;
      }
      
      public function set action(param1:TableActMsg) : void
      {
         action$field = param1;
      }
      
      public function get action() : TableActMsg
      {
         return action$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCash)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,cash$field);
         }
         if(hasAction)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,action$field);
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
                     throw new IOError("Bad data format: WTFMsg.cash cannot be set twice.");
                  }
                  _loc3_++;
                  cash = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WTFMsg.action cannot be set twice.");
                  }
                  _loc5_++;
                  action = new TableActMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,action);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

