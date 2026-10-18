package com.road.yishi.proto.allianceregression
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AllianceUserData extends Message implements IExternalizable
   {
      
      private var PlayerType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var PlayerStatus$field:int;
      
      private var RevokeDate$field:String;
      
      private var OracleExp$field:int;
      
      private var DailyNum$field:int;
      
      private var DailyProcess$field:String;
      
      private var WeekNum$field:int;
      
      private var WeekProcess$field:String;
      
      private var MilestoneScore$field:int;
      
      private var MilestoneProcess$field:String;
      
      public function AllianceUserData()
      {
         super();
      }
      
      public function removePlayerType() : void
      {
         hasField$0 &= 4294967294;
         PlayerType$field = new int();
      }
      
      public function get hasPlayerType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set playerType(param1:int) : void
      {
         hasField$0 |= 1;
         PlayerType$field = param1;
      }
      
      public function get playerType() : int
      {
         return PlayerType$field;
      }
      
      public function removePlayerStatus() : void
      {
         hasField$0 &= 4294967293;
         PlayerStatus$field = new int();
      }
      
      public function get hasPlayerStatus() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set playerStatus(param1:int) : void
      {
         hasField$0 |= 2;
         PlayerStatus$field = param1;
      }
      
      public function get playerStatus() : int
      {
         return PlayerStatus$field;
      }
      
      public function removeRevokeDate() : void
      {
         RevokeDate$field = null;
      }
      
      public function get hasRevokeDate() : Boolean
      {
         return RevokeDate$field != null;
      }
      
      public function set revokeDate(param1:String) : void
      {
         RevokeDate$field = param1;
      }
      
      public function get revokeDate() : String
      {
         return RevokeDate$field;
      }
      
      public function removeOracleExp() : void
      {
         hasField$0 &= 4294967291;
         OracleExp$field = new int();
      }
      
      public function get hasOracleExp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set oracleExp(param1:int) : void
      {
         hasField$0 |= 4;
         OracleExp$field = param1;
      }
      
      public function get oracleExp() : int
      {
         return OracleExp$field;
      }
      
      public function removeDailyNum() : void
      {
         hasField$0 &= 4294967287;
         DailyNum$field = new int();
      }
      
      public function get hasDailyNum() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set dailyNum(param1:int) : void
      {
         hasField$0 |= 8;
         DailyNum$field = param1;
      }
      
      public function get dailyNum() : int
      {
         return DailyNum$field;
      }
      
      public function removeDailyProcess() : void
      {
         DailyProcess$field = null;
      }
      
      public function get hasDailyProcess() : Boolean
      {
         return DailyProcess$field != null;
      }
      
      public function set dailyProcess(param1:String) : void
      {
         DailyProcess$field = param1;
      }
      
      public function get dailyProcess() : String
      {
         return DailyProcess$field;
      }
      
      public function removeWeekNum() : void
      {
         hasField$0 &= 4294967279;
         WeekNum$field = new int();
      }
      
      public function get hasWeekNum() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set weekNum(param1:int) : void
      {
         hasField$0 |= 16;
         WeekNum$field = param1;
      }
      
      public function get weekNum() : int
      {
         return WeekNum$field;
      }
      
      public function removeWeekProcess() : void
      {
         WeekProcess$field = null;
      }
      
      public function get hasWeekProcess() : Boolean
      {
         return WeekProcess$field != null;
      }
      
      public function set weekProcess(param1:String) : void
      {
         WeekProcess$field = param1;
      }
      
      public function get weekProcess() : String
      {
         return WeekProcess$field;
      }
      
      public function removeMilestoneScore() : void
      {
         hasField$0 &= 4294967263;
         MilestoneScore$field = new int();
      }
      
      public function get hasMilestoneScore() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set milestoneScore(param1:int) : void
      {
         hasField$0 |= 32;
         MilestoneScore$field = param1;
      }
      
      public function get milestoneScore() : int
      {
         return MilestoneScore$field;
      }
      
      public function removeMilestoneProcess() : void
      {
         MilestoneProcess$field = null;
      }
      
      public function get hasMilestoneProcess() : Boolean
      {
         return MilestoneProcess$field != null;
      }
      
      public function set milestoneProcess(param1:String) : void
      {
         MilestoneProcess$field = param1;
      }
      
      public function get milestoneProcess() : String
      {
         return MilestoneProcess$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPlayerType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,PlayerType$field);
         }
         if(hasPlayerStatus)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,PlayerStatus$field);
         }
         if(hasRevokeDate)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,RevokeDate$field);
         }
         if(hasOracleExp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,OracleExp$field);
         }
         if(hasDailyNum)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,DailyNum$field);
         }
         if(hasDailyProcess)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,DailyProcess$field);
         }
         if(hasWeekNum)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,WeekNum$field);
         }
         if(hasWeekProcess)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,WeekProcess$field);
         }
         if(hasMilestoneScore)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,MilestoneScore$field);
         }
         if(hasMilestoneProcess)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,MilestoneProcess$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:uint = 0;
         var _loc12_:uint = 0;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AllianceUserData.playerType cannot be set twice.");
                  }
                  _loc5_++;
                  playerType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AllianceUserData.playerStatus cannot be set twice.");
                  }
                  _loc8_++;
                  playerStatus = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AllianceUserData.revokeDate cannot be set twice.");
                  }
                  _loc6_++;
                  revokeDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: AllianceUserData.oracleExp cannot be set twice.");
                  }
                  _loc13_++;
                  oracleExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AllianceUserData.dailyNum cannot be set twice.");
                  }
                  _loc4_++;
                  dailyNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: AllianceUserData.dailyProcess cannot be set twice.");
                  }
                  _loc12_++;
                  dailyProcess = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: AllianceUserData.weekNum cannot be set twice.");
                  }
                  _loc10_++;
                  weekNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: AllianceUserData.weekProcess cannot be set twice.");
                  }
                  _loc9_++;
                  weekProcess = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AllianceUserData.milestoneScore cannot be set twice.");
                  }
                  _loc3_++;
                  milestoneScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AllianceUserData.milestoneProcess cannot be set twice.");
                  }
                  _loc7_++;
                  milestoneProcess = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

