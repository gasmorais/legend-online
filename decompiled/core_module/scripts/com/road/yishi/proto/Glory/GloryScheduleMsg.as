package com.road.yishi.proto.Glory
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GloryScheduleMsg extends Message implements IExternalizable
   {
      
      private var scheduleUid$field:String;
      
      private var teamUid1$field:String;
      
      private var teamName1$field:String;
      
      private var serverName1$field:String;
      
      private var score1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var teamUid2$field:String;
      
      private var teamName2$field:String;
      
      private var serverName2$field:String;
      
      private var score2$field:int;
      
      private var round$field:int;
      
      private var group$field:int;
      
      public function GloryScheduleMsg()
      {
         super();
      }
      
      public function removeScheduleUid() : void
      {
         scheduleUid$field = null;
      }
      
      public function get hasScheduleUid() : Boolean
      {
         return scheduleUid$field != null;
      }
      
      public function set scheduleUid(param1:String) : void
      {
         scheduleUid$field = param1;
      }
      
      public function get scheduleUid() : String
      {
         return scheduleUid$field;
      }
      
      public function removeTeamUid1() : void
      {
         teamUid1$field = null;
      }
      
      public function get hasTeamUid1() : Boolean
      {
         return teamUid1$field != null;
      }
      
      public function set teamUid1(param1:String) : void
      {
         teamUid1$field = param1;
      }
      
      public function get teamUid1() : String
      {
         return teamUid1$field;
      }
      
      public function removeTeamName1() : void
      {
         teamName1$field = null;
      }
      
      public function get hasTeamName1() : Boolean
      {
         return teamName1$field != null;
      }
      
      public function set teamName1(param1:String) : void
      {
         teamName1$field = param1;
      }
      
      public function get teamName1() : String
      {
         return teamName1$field;
      }
      
      public function removeServerName1() : void
      {
         serverName1$field = null;
      }
      
      public function get hasServerName1() : Boolean
      {
         return serverName1$field != null;
      }
      
      public function set serverName1(param1:String) : void
      {
         serverName1$field = param1;
      }
      
      public function get serverName1() : String
      {
         return serverName1$field;
      }
      
      public function removeScore1() : void
      {
         hasField$0 &= 4294967294;
         score1$field = new int();
      }
      
      public function get hasScore1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set score1(param1:int) : void
      {
         hasField$0 |= 1;
         score1$field = param1;
      }
      
      public function get score1() : int
      {
         return score1$field;
      }
      
      public function removeTeamUid2() : void
      {
         teamUid2$field = null;
      }
      
      public function get hasTeamUid2() : Boolean
      {
         return teamUid2$field != null;
      }
      
      public function set teamUid2(param1:String) : void
      {
         teamUid2$field = param1;
      }
      
      public function get teamUid2() : String
      {
         return teamUid2$field;
      }
      
      public function removeTeamName2() : void
      {
         teamName2$field = null;
      }
      
      public function get hasTeamName2() : Boolean
      {
         return teamName2$field != null;
      }
      
      public function set teamName2(param1:String) : void
      {
         teamName2$field = param1;
      }
      
      public function get teamName2() : String
      {
         return teamName2$field;
      }
      
      public function removeServerName2() : void
      {
         serverName2$field = null;
      }
      
      public function get hasServerName2() : Boolean
      {
         return serverName2$field != null;
      }
      
      public function set serverName2(param1:String) : void
      {
         serverName2$field = param1;
      }
      
      public function get serverName2() : String
      {
         return serverName2$field;
      }
      
      public function removeScore2() : void
      {
         hasField$0 &= 4294967293;
         score2$field = new int();
      }
      
      public function get hasScore2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set score2(param1:int) : void
      {
         hasField$0 |= 2;
         score2$field = param1;
      }
      
      public function get score2() : int
      {
         return score2$field;
      }
      
      public function removeRound() : void
      {
         hasField$0 &= 4294967291;
         round$field = new int();
      }
      
      public function get hasRound() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set round(param1:int) : void
      {
         hasField$0 |= 4;
         round$field = param1;
      }
      
      public function get round() : int
      {
         return round$field;
      }
      
      public function removeGroup() : void
      {
         hasField$0 &= 4294967287;
         group$field = new int();
      }
      
      public function get hasGroup() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set group(param1:int) : void
      {
         hasField$0 |= 8;
         group$field = param1;
      }
      
      public function get group() : int
      {
         return group$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasScheduleUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,scheduleUid$field);
         }
         if(hasTeamUid1)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,teamUid1$field);
         }
         if(hasTeamName1)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,teamName1$field);
         }
         if(hasServerName1)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,serverName1$field);
         }
         if(hasScore1)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,score1$field);
         }
         if(hasTeamUid2)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,teamUid2$field);
         }
         if(hasTeamName2)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,teamName2$field);
         }
         if(hasServerName2)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,serverName2$field);
         }
         if(hasScore2)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,score2$field);
         }
         if(hasRound)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,round$field);
         }
         if(hasGroup)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,group$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc14_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GloryScheduleMsg.scheduleUid cannot be set twice.");
                  }
                  _loc6_++;
                  scheduleUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GloryScheduleMsg.teamUid1 cannot be set twice.");
                  }
                  _loc11_++;
                  teamUid1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GloryScheduleMsg.teamName1 cannot be set twice.");
                  }
                  _loc7_++;
                  teamName1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GloryScheduleMsg.serverName1 cannot be set twice.");
                  }
                  _loc9_++;
                  serverName1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GloryScheduleMsg.score1 cannot be set twice.");
                  }
                  _loc4_++;
                  score1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: GloryScheduleMsg.teamUid2 cannot be set twice.");
                  }
                  _loc14_++;
                  teamUid2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GloryScheduleMsg.teamName2 cannot be set twice.");
                  }
                  _loc5_++;
                  teamName2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GloryScheduleMsg.serverName2 cannot be set twice.");
                  }
                  _loc8_++;
                  serverName2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GloryScheduleMsg.score2 cannot be set twice.");
                  }
                  _loc12_++;
                  score2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GloryScheduleMsg.round cannot be set twice.");
                  }
                  _loc3_++;
                  round = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GloryScheduleMsg.group cannot be set twice.");
                  }
                  _loc10_++;
                  group = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

