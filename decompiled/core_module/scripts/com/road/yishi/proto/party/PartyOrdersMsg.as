package com.road.yishi.proto.party
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PartyOrdersMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.party.OrderInfoMsg")]
      public var info:Array = [];
      
      private var myOrder$field:int;
      
      private var hasField$0:uint = 0;
      
      private var updateTime$field:String;
      
      public function PartyOrdersMsg()
      {
         super();
      }
      
      public function removeMyOrder() : void
      {
         hasField$0 &= 4294967294;
         myOrder$field = new int();
      }
      
      public function get hasMyOrder() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set myOrder(param1:int) : void
      {
         hasField$0 |= 1;
         myOrder$field = param1;
      }
      
      public function get myOrder() : int
      {
         return myOrder$field;
      }
      
      public function removeUpdateTime() : void
      {
         updateTime$field = null;
      }
      
      public function get hasUpdateTime() : Boolean
      {
         return updateTime$field != null;
      }
      
      public function set updateTime(param1:String) : void
      {
         updateTime$field = param1;
      }
      
      public function get updateTime() : String
      {
         return updateTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < info.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,info[_loc2_]);
            _loc2_++;
         }
         if(hasMyOrder)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,myOrder$field);
         }
         if(hasUpdateTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,updateTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:OrderInfoMsg = null;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new OrderInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  info.push(_loc4_);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PartyOrdersMsg.myOrder cannot be set twice.");
                  }
                  _loc5_++;
                  myOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PartyOrdersMsg.updateTime cannot be set twice.");
                  }
                  _loc3_++;
                  updateTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

