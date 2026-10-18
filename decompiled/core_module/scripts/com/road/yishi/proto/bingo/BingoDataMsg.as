package com.road.yishi.proto.bingo
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BingoDataMsg extends Message implements IExternalizable
   {
      
      private var data_info$field:BingoInfoDataMsg;
      
      private var buy_info$field:BingoBuyInfoMsg;
      
      [ArrayElementType("com.road.yishi.proto.bingo.BingoGlobalBuyInfoMsg")]
      public var globalBuyInfo:Array = [];
      
      private var current_pond$field:int;
      
      private var hasField$0:uint = 0;
      
      private var state$field:int;
      
      private var current_data_result$field:BingoResultDataMsg;
      
      public function BingoDataMsg()
      {
         super();
      }
      
      public function removeDataInfo() : void
      {
         data_info$field = null;
      }
      
      public function get hasDataInfo() : Boolean
      {
         return data_info$field != null;
      }
      
      public function set dataInfo(param1:BingoInfoDataMsg) : void
      {
         data_info$field = param1;
      }
      
      public function get dataInfo() : BingoInfoDataMsg
      {
         return data_info$field;
      }
      
      public function removeBuyInfo() : void
      {
         buy_info$field = null;
      }
      
      public function get hasBuyInfo() : Boolean
      {
         return buy_info$field != null;
      }
      
      public function set buyInfo(param1:BingoBuyInfoMsg) : void
      {
         buy_info$field = param1;
      }
      
      public function get buyInfo() : BingoBuyInfoMsg
      {
         return buy_info$field;
      }
      
      public function removeCurrentPond() : void
      {
         hasField$0 &= 4294967294;
         current_pond$field = new int();
      }
      
      public function get hasCurrentPond() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set currentPond(param1:int) : void
      {
         hasField$0 |= 1;
         current_pond$field = param1;
      }
      
      public function get currentPond() : int
      {
         return current_pond$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967293;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 2;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeCurrentDataResult() : void
      {
         current_data_result$field = null;
      }
      
      public function get hasCurrentDataResult() : Boolean
      {
         return current_data_result$field != null;
      }
      
      public function set currentDataResult(param1:BingoResultDataMsg) : void
      {
         current_data_result$field = param1;
      }
      
      public function get currentDataResult() : BingoResultDataMsg
      {
         return current_data_result$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasDataInfo)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,data_info$field);
         }
         if(hasBuyInfo)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,buy_info$field);
         }
         _loc2_ = 0;
         while(_loc2_ < globalBuyInfo.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,globalBuyInfo[_loc2_]);
            _loc2_++;
         }
         if(hasCurrentPond)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,current_pond$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasCurrentDataResult)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,current_data_result$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc3_:BingoGlobalBuyInfoMsg = null;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BingoDataMsg.dataInfo cannot be set twice.");
                  }
                  _loc7_++;
                  dataInfo = new BingoInfoDataMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,dataInfo);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BingoDataMsg.buyInfo cannot be set twice.");
                  }
                  _loc5_++;
                  buyInfo = new BingoBuyInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,buyInfo);
                  break;
               case 2:
                  _loc3_ = new BingoGlobalBuyInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  globalBuyInfo.push(_loc3_);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BingoDataMsg.currentPond cannot be set twice.");
                  }
                  _loc4_++;
                  currentPond = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BingoDataMsg.state cannot be set twice.");
                  }
                  _loc6_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: BingoDataMsg.currentDataResult cannot be set twice.");
                  }
                  _loc9_++;
                  currentDataResult = new BingoResultDataMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,currentDataResult);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

