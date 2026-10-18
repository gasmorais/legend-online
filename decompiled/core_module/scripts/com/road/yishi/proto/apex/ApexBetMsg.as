package com.road.yishi.proto.apex
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ApexBetMsg extends Message implements IExternalizable
   {
      
      private var selfBetTeamUid$field:String;
      
      private var selfBetCount$field:int;
      
      private var hasField$0:uint = 0;
      
      private var lastBetWinningCount$field:Int64;
      
      private var currentBonusPool$field:Int64;
      
      private var rankList$field:ApexRankMsg;
      
      private var guessGroup$field:int;
      
      private var guessRank$field:int;
      
      public function ApexBetMsg()
      {
         super();
      }
      
      public function removeSelfBetTeamUid() : void
      {
         selfBetTeamUid$field = null;
      }
      
      public function get hasSelfBetTeamUid() : Boolean
      {
         return selfBetTeamUid$field != null;
      }
      
      public function set selfBetTeamUid(param1:String) : void
      {
         selfBetTeamUid$field = param1;
      }
      
      public function get selfBetTeamUid() : String
      {
         return selfBetTeamUid$field;
      }
      
      public function removeSelfBetCount() : void
      {
         hasField$0 &= 4294967294;
         selfBetCount$field = new int();
      }
      
      public function get hasSelfBetCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set selfBetCount(param1:int) : void
      {
         hasField$0 |= 1;
         selfBetCount$field = param1;
      }
      
      public function get selfBetCount() : int
      {
         return selfBetCount$field;
      }
      
      public function removeLastBetWinningCount() : void
      {
         lastBetWinningCount$field = null;
      }
      
      public function get hasLastBetWinningCount() : Boolean
      {
         return lastBetWinningCount$field != null;
      }
      
      public function set lastBetWinningCount(param1:Int64) : void
      {
         lastBetWinningCount$field = param1;
      }
      
      public function get lastBetWinningCount() : Int64
      {
         return lastBetWinningCount$field;
      }
      
      public function removeCurrentBonusPool() : void
      {
         currentBonusPool$field = null;
      }
      
      public function get hasCurrentBonusPool() : Boolean
      {
         return currentBonusPool$field != null;
      }
      
      public function set currentBonusPool(param1:Int64) : void
      {
         currentBonusPool$field = param1;
      }
      
      public function get currentBonusPool() : Int64
      {
         return currentBonusPool$field;
      }
      
      public function removeRankList() : void
      {
         rankList$field = null;
      }
      
      public function get hasRankList() : Boolean
      {
         return rankList$field != null;
      }
      
      public function set rankList(param1:ApexRankMsg) : void
      {
         rankList$field = param1;
      }
      
      public function get rankList() : ApexRankMsg
      {
         return rankList$field;
      }
      
      public function removeGuessGroup() : void
      {
         hasField$0 &= 4294967293;
         guessGroup$field = new int();
      }
      
      public function get hasGuessGroup() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set guessGroup(param1:int) : void
      {
         hasField$0 |= 2;
         guessGroup$field = param1;
      }
      
      public function get guessGroup() : int
      {
         return guessGroup$field;
      }
      
      public function removeGuessRank() : void
      {
         hasField$0 &= 4294967291;
         guessRank$field = new int();
      }
      
      public function get hasGuessRank() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set guessRank(param1:int) : void
      {
         hasField$0 |= 4;
         guessRank$field = param1;
      }
      
      public function get guessRank() : int
      {
         return guessRank$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSelfBetTeamUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,selfBetTeamUid$field);
         }
         if(hasSelfBetCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,selfBetCount$field);
         }
         if(hasLastBetWinningCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT64(param1,lastBetWinningCount$field);
         }
         if(hasCurrentBonusPool)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT64(param1,currentBonusPool$field);
         }
         if(hasRankList)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,rankList$field);
         }
         if(hasGuessGroup)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,guessGroup$field);
         }
         if(hasGuessRank)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,guessRank$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ApexBetMsg.selfBetTeamUid cannot be set twice.");
                  }
                  _loc4_++;
                  selfBetTeamUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ApexBetMsg.selfBetCount cannot be set twice.");
                  }
                  _loc3_++;
                  selfBetCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ApexBetMsg.lastBetWinningCount cannot be set twice.");
                  }
                  _loc9_++;
                  lastBetWinningCount = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ApexBetMsg.currentBonusPool cannot be set twice.");
                  }
                  _loc10_++;
                  currentBonusPool = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ApexBetMsg.rankList cannot be set twice.");
                  }
                  _loc5_++;
                  rankList = new ApexRankMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,rankList);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ApexBetMsg.guessGroup cannot be set twice.");
                  }
                  _loc7_++;
                  guessGroup = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ApexBetMsg.guessRank cannot be set twice.");
                  }
                  _loc6_++;
                  guessRank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

