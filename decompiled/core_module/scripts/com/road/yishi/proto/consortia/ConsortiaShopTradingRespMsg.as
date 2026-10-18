package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaShopTradingRespMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.consortia.ConsortiaShopRespMsg")]
      public var shopInfo:Array = [];
      
      private var refreshCounts$field:int;
      
      private var hasField$0:uint = 0;
      
      private var state$field:Boolean;
      
      private var newState$field:int;
      
      public function ConsortiaShopTradingRespMsg()
      {
         super();
      }
      
      public function removeRefreshCounts() : void
      {
         hasField$0 &= 4294967294;
         refreshCounts$field = new int();
      }
      
      public function get hasRefreshCounts() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set refreshCounts(param1:int) : void
      {
         hasField$0 |= 1;
         refreshCounts$field = param1;
      }
      
      public function get refreshCounts() : int
      {
         return refreshCounts$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967293;
         state$field = new Boolean();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set state(param1:Boolean) : void
      {
         hasField$0 |= 2;
         state$field = param1;
      }
      
      public function get state() : Boolean
      {
         return state$field;
      }
      
      public function removeNewState() : void
      {
         hasField$0 &= 4294967291;
         newState$field = new int();
      }
      
      public function get hasNewState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set newState(param1:int) : void
      {
         hasField$0 |= 4;
         newState$field = param1;
      }
      
      public function get newState() : int
      {
         return newState$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < shopInfo.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,shopInfo[_loc2_]);
            _loc2_++;
         }
         if(hasRefreshCounts)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,refreshCounts$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,state$field);
         }
         if(hasNewState)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,newState$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc7_:ConsortiaShopRespMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc7_ = new ConsortiaShopRespMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  shopInfo.push(_loc7_);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaShopTradingRespMsg.refreshCounts cannot be set twice.");
                  }
                  _loc3_++;
                  refreshCounts = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaShopTradingRespMsg.state cannot be set twice.");
                  }
                  _loc4_++;
                  state = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaShopTradingRespMsg.newState cannot be set twice.");
                  }
                  _loc6_++;
                  newState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

