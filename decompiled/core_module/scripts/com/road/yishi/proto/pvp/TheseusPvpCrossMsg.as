package com.road.yishi.proto.pvp
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TheseusPvpCrossMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var userId$field:int;
      
      private var rank$field:int;
      
      private var integral$field:int;
      
      private var pvpId$field:int;
      
      private var lastRank$field:int;
      
      private var lastIntegral$field:int;
      
      private var lastPvpId$field:int;
      
      private var keepWin$field:int;
      
      private var keepWinIntegral$field:int;
      
      private var isWin$field:Boolean;
      
      private var battleProxyId$field:String;
      
      private var report$field:TheseusPvpReportMsg;
      
      public function TheseusPvpCrossMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967291;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 4;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removeIntegral() : void
      {
         hasField$0 &= 4294967287;
         integral$field = new int();
      }
      
      public function get hasIntegral() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set integral(param1:int) : void
      {
         hasField$0 |= 8;
         integral$field = param1;
      }
      
      public function get integral() : int
      {
         return integral$field;
      }
      
      public function removePvpId() : void
      {
         hasField$0 &= 4294967279;
         pvpId$field = new int();
      }
      
      public function get hasPvpId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set pvpId(param1:int) : void
      {
         hasField$0 |= 16;
         pvpId$field = param1;
      }
      
      public function get pvpId() : int
      {
         return pvpId$field;
      }
      
      public function removeLastRank() : void
      {
         hasField$0 &= 4294967263;
         lastRank$field = new int();
      }
      
      public function get hasLastRank() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set lastRank(param1:int) : void
      {
         hasField$0 |= 32;
         lastRank$field = param1;
      }
      
      public function get lastRank() : int
      {
         return lastRank$field;
      }
      
      public function removeLastIntegral() : void
      {
         hasField$0 &= 4294967231;
         lastIntegral$field = new int();
      }
      
      public function get hasLastIntegral() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set lastIntegral(param1:int) : void
      {
         hasField$0 |= 64;
         lastIntegral$field = param1;
      }
      
      public function get lastIntegral() : int
      {
         return lastIntegral$field;
      }
      
      public function removeLastPvpId() : void
      {
         hasField$0 &= 4294967167;
         lastPvpId$field = new int();
      }
      
      public function get hasLastPvpId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set lastPvpId(param1:int) : void
      {
         hasField$0 |= 128;
         lastPvpId$field = param1;
      }
      
      public function get lastPvpId() : int
      {
         return lastPvpId$field;
      }
      
      public function removeKeepWin() : void
      {
         hasField$0 &= 4294967039;
         keepWin$field = new int();
      }
      
      public function get hasKeepWin() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set keepWin(param1:int) : void
      {
         hasField$0 |= 256;
         keepWin$field = param1;
      }
      
      public function get keepWin() : int
      {
         return keepWin$field;
      }
      
      public function removeKeepWinIntegral() : void
      {
         hasField$0 &= 4294966783;
         keepWinIntegral$field = new int();
      }
      
      public function get hasKeepWinIntegral() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set keepWinIntegral(param1:int) : void
      {
         hasField$0 |= 512;
         keepWinIntegral$field = param1;
      }
      
      public function get keepWinIntegral() : int
      {
         return keepWinIntegral$field;
      }
      
      public function removeIsWin() : void
      {
         hasField$0 &= 4294966271;
         isWin$field = new Boolean();
      }
      
      public function get hasIsWin() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set isWin(param1:Boolean) : void
      {
         hasField$0 |= 1024;
         isWin$field = param1;
      }
      
      public function get isWin() : Boolean
      {
         return isWin$field;
      }
      
      public function removeBattleProxyId() : void
      {
         battleProxyId$field = null;
      }
      
      public function get hasBattleProxyId() : Boolean
      {
         return battleProxyId$field != null;
      }
      
      public function set battleProxyId(param1:String) : void
      {
         battleProxyId$field = param1;
      }
      
      public function get battleProxyId() : String
      {
         return battleProxyId$field;
      }
      
      public function removeReport() : void
      {
         report$field = null;
      }
      
      public function get hasReport() : Boolean
      {
         return report$field != null;
      }
      
      public function set report(param1:TheseusPvpReportMsg) : void
      {
         report$field = param1;
      }
      
      public function get report() : TheseusPvpReportMsg
      {
         return report$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasIntegral)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,integral$field);
         }
         if(hasPvpId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,pvpId$field);
         }
         if(hasLastRank)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,lastRank$field);
         }
         if(hasLastIntegral)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,lastIntegral$field);
         }
         if(hasLastPvpId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,lastPvpId$field);
         }
         if(hasKeepWin)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,keepWin$field);
         }
         if(hasKeepWinIntegral)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,keepWinIntegral$field);
         }
         if(hasIsWin)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_BOOL(param1,isWin$field);
         }
         if(hasBattleProxyId)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,battleProxyId$field);
         }
         if(hasReport)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_MESSAGE(param1,report$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc15_:* = 0;
         var _loc16_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc14_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc12_:uint = 0;
         var _loc11_:uint = 0;
         var _loc13_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc15_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpCrossMsg.op cannot be set twice.");
                  }
                  _loc16_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpCrossMsg.userId cannot be set twice.");
                  }
                  _loc9_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpCrossMsg.rank cannot be set twice.");
                  }
                  _loc3_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpCrossMsg.integral cannot be set twice.");
                  }
                  _loc14_++;
                  integral = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpCrossMsg.pvpId cannot be set twice.");
                  }
                  _loc4_++;
                  pvpId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpCrossMsg.lastRank cannot be set twice.");
                  }
                  _loc7_++;
                  lastRank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpCrossMsg.lastIntegral cannot be set twice.");
                  }
                  _loc5_++;
                  lastIntegral = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpCrossMsg.lastPvpId cannot be set twice.");
                  }
                  _loc8_++;
                  lastPvpId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpCrossMsg.keepWin cannot be set twice.");
                  }
                  _loc12_++;
                  keepWin = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpCrossMsg.keepWinIntegral cannot be set twice.");
                  }
                  _loc11_++;
                  keepWinIntegral = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpCrossMsg.isWin cannot be set twice.");
                  }
                  _loc13_++;
                  isWin = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 11:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpCrossMsg.battleProxyId cannot be set twice.");
                  }
                  _loc6_++;
                  battleProxyId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpCrossMsg.report cannot be set twice.");
                  }
                  _loc10_++;
                  report = new TheseusPvpReportMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,report);
                  break;
               default:
                  ReadUtils.skip(param1,_loc15_ & 7);
            }
         }
      }
   }
}

