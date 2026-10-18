package com.road.yishi.proto.carnival
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CarnivalMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var score$field:int;
      
      private var scoreRewardInfo$field:String;
      
      private var totalCharge$field:int;
      
      private var lotteryCount$field:int;
      
      private var dayCharge$field:int;
      
      private var giftBuyInfo$field:String;
      
      private var dayOnline$field:int;
      
      private var onlineDate$field:String;
      
      private var onlineRewardInfo$field:String;
      
      private var luckCount$field:int;
      
      private var luckNum$field:int;
      
      private var gameInfo$field:String;
      
      private var result$field:String;
      
      public function CarnivalMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967293;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 2;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeScoreRewardInfo() : void
      {
         scoreRewardInfo$field = null;
      }
      
      public function get hasScoreRewardInfo() : Boolean
      {
         return scoreRewardInfo$field != null;
      }
      
      public function set scoreRewardInfo(param1:String) : void
      {
         scoreRewardInfo$field = param1;
      }
      
      public function get scoreRewardInfo() : String
      {
         return scoreRewardInfo$field;
      }
      
      public function removeTotalCharge() : void
      {
         hasField$0 &= 4294967291;
         totalCharge$field = new int();
      }
      
      public function get hasTotalCharge() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set totalCharge(param1:int) : void
      {
         hasField$0 |= 4;
         totalCharge$field = param1;
      }
      
      public function get totalCharge() : int
      {
         return totalCharge$field;
      }
      
      public function removeLotteryCount() : void
      {
         hasField$0 &= 4294967287;
         lotteryCount$field = new int();
      }
      
      public function get hasLotteryCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set lotteryCount(param1:int) : void
      {
         hasField$0 |= 8;
         lotteryCount$field = param1;
      }
      
      public function get lotteryCount() : int
      {
         return lotteryCount$field;
      }
      
      public function removeDayCharge() : void
      {
         hasField$0 &= 4294967279;
         dayCharge$field = new int();
      }
      
      public function get hasDayCharge() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set dayCharge(param1:int) : void
      {
         hasField$0 |= 16;
         dayCharge$field = param1;
      }
      
      public function get dayCharge() : int
      {
         return dayCharge$field;
      }
      
      public function removeGiftBuyInfo() : void
      {
         giftBuyInfo$field = null;
      }
      
      public function get hasGiftBuyInfo() : Boolean
      {
         return giftBuyInfo$field != null;
      }
      
      public function set giftBuyInfo(param1:String) : void
      {
         giftBuyInfo$field = param1;
      }
      
      public function get giftBuyInfo() : String
      {
         return giftBuyInfo$field;
      }
      
      public function removeDayOnline() : void
      {
         hasField$0 &= 4294967263;
         dayOnline$field = new int();
      }
      
      public function get hasDayOnline() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set dayOnline(param1:int) : void
      {
         hasField$0 |= 32;
         dayOnline$field = param1;
      }
      
      public function get dayOnline() : int
      {
         return dayOnline$field;
      }
      
      public function removeOnlineDate() : void
      {
         onlineDate$field = null;
      }
      
      public function get hasOnlineDate() : Boolean
      {
         return onlineDate$field != null;
      }
      
      public function set onlineDate(param1:String) : void
      {
         onlineDate$field = param1;
      }
      
      public function get onlineDate() : String
      {
         return onlineDate$field;
      }
      
      public function removeOnlineRewardInfo() : void
      {
         onlineRewardInfo$field = null;
      }
      
      public function get hasOnlineRewardInfo() : Boolean
      {
         return onlineRewardInfo$field != null;
      }
      
      public function set onlineRewardInfo(param1:String) : void
      {
         onlineRewardInfo$field = param1;
      }
      
      public function get onlineRewardInfo() : String
      {
         return onlineRewardInfo$field;
      }
      
      public function removeLuckCount() : void
      {
         hasField$0 &= 4294967231;
         luckCount$field = new int();
      }
      
      public function get hasLuckCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set luckCount(param1:int) : void
      {
         hasField$0 |= 64;
         luckCount$field = param1;
      }
      
      public function get luckCount() : int
      {
         return luckCount$field;
      }
      
      public function removeLuckNum() : void
      {
         hasField$0 &= 4294967167;
         luckNum$field = new int();
      }
      
      public function get hasLuckNum() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set luckNum(param1:int) : void
      {
         hasField$0 |= 128;
         luckNum$field = param1;
      }
      
      public function get luckNum() : int
      {
         return luckNum$field;
      }
      
      public function removeGameInfo() : void
      {
         gameInfo$field = null;
      }
      
      public function get hasGameInfo() : Boolean
      {
         return gameInfo$field != null;
      }
      
      public function set gameInfo(param1:String) : void
      {
         gameInfo$field = param1;
      }
      
      public function get gameInfo() : String
      {
         return gameInfo$field;
      }
      
      public function removeResult() : void
      {
         result$field = null;
      }
      
      public function get hasResult() : Boolean
      {
         return result$field != null;
      }
      
      public function set result(param1:String) : void
      {
         result$field = param1;
      }
      
      public function get result() : String
      {
         return result$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasScoreRewardInfo)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,scoreRewardInfo$field);
         }
         if(hasTotalCharge)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,totalCharge$field);
         }
         if(hasLotteryCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,lotteryCount$field);
         }
         if(hasDayCharge)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,dayCharge$field);
         }
         if(hasGiftBuyInfo)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,giftBuyInfo$field);
         }
         if(hasDayOnline)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,dayOnline$field);
         }
         if(hasOnlineDate)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,onlineDate$field);
         }
         if(hasOnlineRewardInfo)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,onlineRewardInfo$field);
         }
         if(hasLuckCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,luckCount$field);
         }
         if(hasLuckNum)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,luckNum$field);
         }
         if(hasGameInfo)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,gameInfo$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,result$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc10_:uint = 0;
         var _loc15_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc12_:uint = 0;
         var _loc16_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc17_:uint = 0;
         var _loc11_:uint = 0;
         var _loc13_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CarnivalMsg.opType cannot be set twice.");
                  }
                  _loc10_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: CarnivalMsg.score cannot be set twice.");
                  }
                  _loc15_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CarnivalMsg.scoreRewardInfo cannot be set twice.");
                  }
                  _loc3_++;
                  scoreRewardInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CarnivalMsg.totalCharge cannot be set twice.");
                  }
                  _loc8_++;
                  totalCharge = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CarnivalMsg.lotteryCount cannot be set twice.");
                  }
                  _loc12_++;
                  lotteryCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: CarnivalMsg.dayCharge cannot be set twice.");
                  }
                  _loc16_++;
                  dayCharge = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CarnivalMsg.giftBuyInfo cannot be set twice.");
                  }
                  _loc7_++;
                  giftBuyInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CarnivalMsg.dayOnline cannot be set twice.");
                  }
                  _loc5_++;
                  dayOnline = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CarnivalMsg.onlineDate cannot be set twice.");
                  }
                  _loc4_++;
                  onlineDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: CarnivalMsg.onlineRewardInfo cannot be set twice.");
                  }
                  _loc17_++;
                  onlineRewardInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CarnivalMsg.luckCount cannot be set twice.");
                  }
                  _loc11_++;
                  luckCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: CarnivalMsg.luckNum cannot be set twice.");
                  }
                  _loc13_++;
                  luckNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CarnivalMsg.gameInfo cannot be set twice.");
                  }
                  _loc9_++;
                  gameInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CarnivalMsg.result cannot be set twice.");
                  }
                  _loc6_++;
                  result = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

