package com.road.yishi.proto.bingo
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BingoRewardMsg extends Message implements IExternalizable
   {
      
      private var result_data$field:BingoResultDataMsg;
      
      private var detail_data$field:BingoBuyDetailMsg;
      
      private var buy_pond$field:int;
      
      private var hasField$0:uint = 0;
      
      private var addition_pond$field:int;
      
      private var total_pond$field:int;
      
      private var rank$field:int;
      
      private var total_winning$field:int;
      
      private var radio$field:int;
      
      private var reward$field:int;
      
      private var hit_lucky_num$field:int;
      
      private var hit_num$field:int;
      
      public function BingoRewardMsg()
      {
         super();
      }
      
      public function removeResultData() : void
      {
         result_data$field = null;
      }
      
      public function get hasResultData() : Boolean
      {
         return result_data$field != null;
      }
      
      public function set resultData(param1:BingoResultDataMsg) : void
      {
         result_data$field = param1;
      }
      
      public function get resultData() : BingoResultDataMsg
      {
         return result_data$field;
      }
      
      public function removeDetailData() : void
      {
         detail_data$field = null;
      }
      
      public function get hasDetailData() : Boolean
      {
         return detail_data$field != null;
      }
      
      public function set detailData(param1:BingoBuyDetailMsg) : void
      {
         detail_data$field = param1;
      }
      
      public function get detailData() : BingoBuyDetailMsg
      {
         return detail_data$field;
      }
      
      public function removeBuyPond() : void
      {
         hasField$0 &= 4294967294;
         buy_pond$field = new int();
      }
      
      public function get hasBuyPond() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set buyPond(param1:int) : void
      {
         hasField$0 |= 1;
         buy_pond$field = param1;
      }
      
      public function get buyPond() : int
      {
         return buy_pond$field;
      }
      
      public function removeAdditionPond() : void
      {
         hasField$0 &= 4294967293;
         addition_pond$field = new int();
      }
      
      public function get hasAdditionPond() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set additionPond(param1:int) : void
      {
         hasField$0 |= 2;
         addition_pond$field = param1;
      }
      
      public function get additionPond() : int
      {
         return addition_pond$field;
      }
      
      public function removeTotalPond() : void
      {
         hasField$0 &= 4294967291;
         total_pond$field = new int();
      }
      
      public function get hasTotalPond() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set totalPond(param1:int) : void
      {
         hasField$0 |= 4;
         total_pond$field = param1;
      }
      
      public function get totalPond() : int
      {
         return total_pond$field;
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967287;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 8;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removeTotalWinning() : void
      {
         hasField$0 &= 4294967279;
         total_winning$field = new int();
      }
      
      public function get hasTotalWinning() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set totalWinning(param1:int) : void
      {
         hasField$0 |= 16;
         total_winning$field = param1;
      }
      
      public function get totalWinning() : int
      {
         return total_winning$field;
      }
      
      public function removeRadio() : void
      {
         hasField$0 &= 4294967263;
         radio$field = new int();
      }
      
      public function get hasRadio() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set radio(param1:int) : void
      {
         hasField$0 |= 32;
         radio$field = param1;
      }
      
      public function get radio() : int
      {
         return radio$field;
      }
      
      public function removeReward() : void
      {
         hasField$0 &= 4294967231;
         reward$field = new int();
      }
      
      public function get hasReward() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set reward(param1:int) : void
      {
         hasField$0 |= 64;
         reward$field = param1;
      }
      
      public function get reward() : int
      {
         return reward$field;
      }
      
      public function removeHitLuckyNum() : void
      {
         hasField$0 &= 4294967167;
         hit_lucky_num$field = new int();
      }
      
      public function get hasHitLuckyNum() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set hitLuckyNum(param1:int) : void
      {
         hasField$0 |= 128;
         hit_lucky_num$field = param1;
      }
      
      public function get hitLuckyNum() : int
      {
         return hit_lucky_num$field;
      }
      
      public function removeHitNum() : void
      {
         hasField$0 &= 4294967039;
         hit_num$field = new int();
      }
      
      public function get hasHitNum() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set hitNum(param1:int) : void
      {
         hasField$0 |= 256;
         hit_num$field = param1;
      }
      
      public function get hitNum() : int
      {
         return hit_num$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasResultData)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,result_data$field);
         }
         if(hasDetailData)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,detail_data$field);
         }
         if(hasBuyPond)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,buy_pond$field);
         }
         if(hasAdditionPond)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,addition_pond$field);
         }
         if(hasTotalPond)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,total_pond$field);
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasTotalWinning)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,total_winning$field);
         }
         if(hasRadio)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,radio$field);
         }
         if(hasReward)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,reward$field);
         }
         if(hasHitLuckyNum)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,hit_lucky_num$field);
         }
         if(hasHitNum)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,hit_num$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc14_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: BingoRewardMsg.resultData cannot be set twice.");
                  }
                  _loc8_++;
                  resultData = new BingoResultDataMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,resultData);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BingoRewardMsg.detailData cannot be set twice.");
                  }
                  _loc3_++;
                  detailData = new BingoBuyDetailMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,detailData);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: BingoRewardMsg.buyPond cannot be set twice.");
                  }
                  _loc9_++;
                  buyPond = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: BingoRewardMsg.additionPond cannot be set twice.");
                  }
                  _loc12_++;
                  additionPond = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: BingoRewardMsg.totalPond cannot be set twice.");
                  }
                  _loc14_++;
                  totalPond = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BingoRewardMsg.rank cannot be set twice.");
                  }
                  _loc5_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: BingoRewardMsg.totalWinning cannot be set twice.");
                  }
                  _loc11_++;
                  totalWinning = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: BingoRewardMsg.radio cannot be set twice.");
                  }
                  _loc10_++;
                  radio = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BingoRewardMsg.reward cannot be set twice.");
                  }
                  _loc7_++;
                  reward = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BingoRewardMsg.hitLuckyNum cannot be set twice.");
                  }
                  _loc6_++;
                  hitLuckyNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BingoRewardMsg.hitNum cannot be set twice.");
                  }
                  _loc4_++;
                  hitNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

