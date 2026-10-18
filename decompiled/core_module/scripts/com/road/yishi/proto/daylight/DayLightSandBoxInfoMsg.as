package com.road.yishi.proto.daylight
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DayLightSandBoxInfoMsg extends Message implements IExternalizable
   {
      
      private var redTeam$field:DayLightTeamInfoMsg;
      
      private var blueTeam$field:DayLightTeamInfoMsg;
      
      private var fightBeginCd$field:int;
      
      private var hasField$0:uint = 0;
      
      private var fightEndCd$field:int;
      
      public function DayLightSandBoxInfoMsg()
      {
         super();
      }
      
      public function removeRedTeam() : void
      {
         redTeam$field = null;
      }
      
      public function get hasRedTeam() : Boolean
      {
         return redTeam$field != null;
      }
      
      public function set redTeam(param1:DayLightTeamInfoMsg) : void
      {
         redTeam$field = param1;
      }
      
      public function get redTeam() : DayLightTeamInfoMsg
      {
         return redTeam$field;
      }
      
      public function removeBlueTeam() : void
      {
         blueTeam$field = null;
      }
      
      public function get hasBlueTeam() : Boolean
      {
         return blueTeam$field != null;
      }
      
      public function set blueTeam(param1:DayLightTeamInfoMsg) : void
      {
         blueTeam$field = param1;
      }
      
      public function get blueTeam() : DayLightTeamInfoMsg
      {
         return blueTeam$field;
      }
      
      public function removeFightBeginCd() : void
      {
         hasField$0 &= 4294967294;
         fightBeginCd$field = new int();
      }
      
      public function get hasFightBeginCd() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set fightBeginCd(param1:int) : void
      {
         hasField$0 |= 1;
         fightBeginCd$field = param1;
      }
      
      public function get fightBeginCd() : int
      {
         return fightBeginCd$field;
      }
      
      public function removeFightEndCd() : void
      {
         hasField$0 &= 4294967293;
         fightEndCd$field = new int();
      }
      
      public function get hasFightEndCd() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set fightEndCd(param1:int) : void
      {
         hasField$0 |= 2;
         fightEndCd$field = param1;
      }
      
      public function get fightEndCd() : int
      {
         return fightEndCd$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRedTeam)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,redTeam$field);
         }
         if(hasBlueTeam)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,blueTeam$field);
         }
         if(hasFightBeginCd)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,fightBeginCd$field);
         }
         if(hasFightEndCd)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,fightEndCd$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightSandBoxInfoMsg.redTeam cannot be set twice.");
                  }
                  _loc5_++;
                  redTeam = new DayLightTeamInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,redTeam);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightSandBoxInfoMsg.blueTeam cannot be set twice.");
                  }
                  _loc3_++;
                  blueTeam = new DayLightTeamInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,blueTeam);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightSandBoxInfoMsg.fightBeginCd cannot be set twice.");
                  }
                  _loc7_++;
                  fightBeginCd = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightSandBoxInfoMsg.fightEndCd cannot be set twice.");
                  }
                  _loc4_++;
                  fightEndCd = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

