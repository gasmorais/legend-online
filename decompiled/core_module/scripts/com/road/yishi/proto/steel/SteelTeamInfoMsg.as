package com.road.yishi.proto.steel
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SteelTeamInfoMsg extends Message implements IExternalizable
   {
      
      private var teamUid$field:String;
      
      private var teamName$field:String;
      
      private var serverName$field:String;
      
      private var site$field:String;
      
      private var hostNickName$field:String;
      
      private var counts$field:int;
      
      private var hasField$0:uint = 0;
      
      private var succCount$field:int;
      
      private var lostCount$field:int;
      
      private var scoreMarks$field:String;
      
      private var enterPlayers$field:String;
      
      private var serverId$field:int;
      
      private var groupId$field:int;
      
      private var states$field:int;
      
      private var crossOrder$field:int;
      
      private var otherSide$field:String;
      
      private var property1$field:String;
      
      private var property2$field:String;
      
      private var property3$field:String;
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      private var param3$field:int;
      
      private var param4$field:String;
      
      private var param5$field:String;
      
      private var param6$field:String;
      
      private var fightPower$field:int;
      
      public function SteelTeamInfoMsg()
      {
         super();
      }
      
      public function removeTeamUid() : void
      {
         teamUid$field = null;
      }
      
      public function get hasTeamUid() : Boolean
      {
         return teamUid$field != null;
      }
      
      public function set teamUid(param1:String) : void
      {
         teamUid$field = param1;
      }
      
      public function get teamUid() : String
      {
         return teamUid$field;
      }
      
      public function removeTeamName() : void
      {
         teamName$field = null;
      }
      
      public function get hasTeamName() : Boolean
      {
         return teamName$field != null;
      }
      
      public function set teamName(param1:String) : void
      {
         teamName$field = param1;
      }
      
      public function get teamName() : String
      {
         return teamName$field;
      }
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
      }
      
      public function removeSite() : void
      {
         site$field = null;
      }
      
      public function get hasSite() : Boolean
      {
         return site$field != null;
      }
      
      public function set site(param1:String) : void
      {
         site$field = param1;
      }
      
      public function get site() : String
      {
         return site$field;
      }
      
      public function removeHostNickName() : void
      {
         hostNickName$field = null;
      }
      
      public function get hasHostNickName() : Boolean
      {
         return hostNickName$field != null;
      }
      
      public function set hostNickName(param1:String) : void
      {
         hostNickName$field = param1;
      }
      
      public function get hostNickName() : String
      {
         return hostNickName$field;
      }
      
      public function removeCounts() : void
      {
         hasField$0 &= 4294967294;
         counts$field = new int();
      }
      
      public function get hasCounts() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set counts(param1:int) : void
      {
         hasField$0 |= 1;
         counts$field = param1;
      }
      
      public function get counts() : int
      {
         return counts$field;
      }
      
      public function removeSuccCount() : void
      {
         hasField$0 &= 4294967293;
         succCount$field = new int();
      }
      
      public function get hasSuccCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set succCount(param1:int) : void
      {
         hasField$0 |= 2;
         succCount$field = param1;
      }
      
      public function get succCount() : int
      {
         return succCount$field;
      }
      
      public function removeLostCount() : void
      {
         hasField$0 &= 4294967291;
         lostCount$field = new int();
      }
      
      public function get hasLostCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set lostCount(param1:int) : void
      {
         hasField$0 |= 4;
         lostCount$field = param1;
      }
      
      public function get lostCount() : int
      {
         return lostCount$field;
      }
      
      public function removeScoreMarks() : void
      {
         scoreMarks$field = null;
      }
      
      public function get hasScoreMarks() : Boolean
      {
         return scoreMarks$field != null;
      }
      
      public function set scoreMarks(param1:String) : void
      {
         scoreMarks$field = param1;
      }
      
      public function get scoreMarks() : String
      {
         return scoreMarks$field;
      }
      
      public function removeEnterPlayers() : void
      {
         enterPlayers$field = null;
      }
      
      public function get hasEnterPlayers() : Boolean
      {
         return enterPlayers$field != null;
      }
      
      public function set enterPlayers(param1:String) : void
      {
         enterPlayers$field = param1;
      }
      
      public function get enterPlayers() : String
      {
         return enterPlayers$field;
      }
      
      public function removeServerId() : void
      {
         hasField$0 &= 4294967287;
         serverId$field = new int();
      }
      
      public function get hasServerId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set serverId(param1:int) : void
      {
         hasField$0 |= 8;
         serverId$field = param1;
      }
      
      public function get serverId() : int
      {
         return serverId$field;
      }
      
      public function removeGroupId() : void
      {
         hasField$0 &= 4294967279;
         groupId$field = new int();
      }
      
      public function get hasGroupId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set groupId(param1:int) : void
      {
         hasField$0 |= 16;
         groupId$field = param1;
      }
      
      public function get groupId() : int
      {
         return groupId$field;
      }
      
      public function removeStates() : void
      {
         hasField$0 &= 4294967263;
         states$field = new int();
      }
      
      public function get hasStates() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set states(param1:int) : void
      {
         hasField$0 |= 32;
         states$field = param1;
      }
      
      public function get states() : int
      {
         return states$field;
      }
      
      public function removeCrossOrder() : void
      {
         hasField$0 &= 4294967231;
         crossOrder$field = new int();
      }
      
      public function get hasCrossOrder() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set crossOrder(param1:int) : void
      {
         hasField$0 |= 64;
         crossOrder$field = param1;
      }
      
      public function get crossOrder() : int
      {
         return crossOrder$field;
      }
      
      public function removeOtherSide() : void
      {
         otherSide$field = null;
      }
      
      public function get hasOtherSide() : Boolean
      {
         return otherSide$field != null;
      }
      
      public function set otherSide(param1:String) : void
      {
         otherSide$field = param1;
      }
      
      public function get otherSide() : String
      {
         return otherSide$field;
      }
      
      public function removeProperty1() : void
      {
         property1$field = null;
      }
      
      public function get hasProperty1() : Boolean
      {
         return property1$field != null;
      }
      
      public function set property1(param1:String) : void
      {
         property1$field = param1;
      }
      
      public function get property1() : String
      {
         return property1$field;
      }
      
      public function removeProperty2() : void
      {
         property2$field = null;
      }
      
      public function get hasProperty2() : Boolean
      {
         return property2$field != null;
      }
      
      public function set property2(param1:String) : void
      {
         property2$field = param1;
      }
      
      public function get property2() : String
      {
         return property2$field;
      }
      
      public function removeProperty3() : void
      {
         property3$field = null;
      }
      
      public function get hasProperty3() : Boolean
      {
         return property3$field != null;
      }
      
      public function set property3(param1:String) : void
      {
         property3$field = param1;
      }
      
      public function get property3() : String
      {
         return property3$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967167;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 128;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967039;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 256;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         hasField$0 &= 4294966783;
         param3$field = new int();
      }
      
      public function get hasParam3() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set param3(param1:int) : void
      {
         hasField$0 |= 512;
         param3$field = param1;
      }
      
      public function get param3() : int
      {
         return param3$field;
      }
      
      public function removeParam4() : void
      {
         param4$field = null;
      }
      
      public function get hasParam4() : Boolean
      {
         return param4$field != null;
      }
      
      public function set param4(param1:String) : void
      {
         param4$field = param1;
      }
      
      public function get param4() : String
      {
         return param4$field;
      }
      
      public function removeParam5() : void
      {
         param5$field = null;
      }
      
      public function get hasParam5() : Boolean
      {
         return param5$field != null;
      }
      
      public function set param5(param1:String) : void
      {
         param5$field = param1;
      }
      
      public function get param5() : String
      {
         return param5$field;
      }
      
      public function removeParam6() : void
      {
         param6$field = null;
      }
      
      public function get hasParam6() : Boolean
      {
         return param6$field != null;
      }
      
      public function set param6(param1:String) : void
      {
         param6$field = param1;
      }
      
      public function get param6() : String
      {
         return param6$field;
      }
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294966271;
         fightPower$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 1024;
         fightPower$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fightPower$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTeamUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,teamUid$field);
         }
         if(hasTeamName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,teamName$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasSite)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,site$field);
         }
         if(hasHostNickName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,hostNickName$field);
         }
         if(hasCounts)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,counts$field);
         }
         if(hasSuccCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,succCount$field);
         }
         if(hasLostCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,lostCount$field);
         }
         if(hasScoreMarks)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,scoreMarks$field);
         }
         if(hasEnterPlayers)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,enterPlayers$field);
         }
         if(hasServerId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,serverId$field);
         }
         if(hasGroupId)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,groupId$field);
         }
         if(hasStates)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,states$field);
         }
         if(hasCrossOrder)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,crossOrder$field);
         }
         if(hasOtherSide)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_STRING(param1,otherSide$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_STRING(param1,property1$field);
         }
         if(hasProperty2)
         {
            WriteUtils.writeTag(param1,2,17);
            WriteUtils.write$TYPE_STRING(param1,property2$field);
         }
         if(hasProperty3)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_STRING(param1,property3$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,param3$field);
         }
         if(hasParam4)
         {
            WriteUtils.writeTag(param1,2,22);
            WriteUtils.write$TYPE_STRING(param1,param4$field);
         }
         if(hasParam5)
         {
            WriteUtils.writeTag(param1,2,23);
            WriteUtils.write$TYPE_STRING(param1,param5$field);
         }
         if(hasParam6)
         {
            WriteUtils.writeTag(param1,2,24);
            WriteUtils.write$TYPE_STRING(param1,param6$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc20_:uint = 0;
         var _loc9_:uint = 0;
         var _loc21_:uint = 0;
         var _loc24_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc16_:uint = 0;
         var _loc19_:uint = 0;
         var _loc11_:uint = 0;
         var _loc22_:uint = 0;
         var _loc27_:uint = 0;
         var _loc28_:uint = 0;
         var _loc25_:uint = 0;
         var _loc12_:uint = 0;
         var _loc23_:uint = 0;
         var _loc17_:uint = 0;
         var _loc13_:uint = 0;
         var _loc18_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc26_:uint = 0;
         var _loc15_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.teamUid cannot be set twice.");
                  }
                  _loc14_++;
                  teamUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.teamName cannot be set twice.");
                  }
                  _loc3_++;
                  teamName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.serverName cannot be set twice.");
                  }
                  _loc7_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.site cannot be set twice.");
                  }
                  _loc20_++;
                  site = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.hostNickName cannot be set twice.");
                  }
                  _loc9_++;
                  hostNickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.counts cannot be set twice.");
                  }
                  _loc21_++;
                  counts = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.succCount cannot be set twice.");
                  }
                  _loc24_++;
                  succCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.lostCount cannot be set twice.");
                  }
                  _loc6_++;
                  lostCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.scoreMarks cannot be set twice.");
                  }
                  _loc4_++;
                  scoreMarks = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.enterPlayers cannot be set twice.");
                  }
                  _loc16_++;
                  enterPlayers = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.serverId cannot be set twice.");
                  }
                  _loc19_++;
                  serverId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.groupId cannot be set twice.");
                  }
                  _loc11_++;
                  groupId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.states cannot be set twice.");
                  }
                  _loc22_++;
                  states = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.crossOrder cannot be set twice.");
                  }
                  _loc27_++;
                  crossOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.otherSide cannot be set twice.");
                  }
                  _loc28_++;
                  otherSide = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 16:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.property1 cannot be set twice.");
                  }
                  _loc25_++;
                  property1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 17:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.property2 cannot be set twice.");
                  }
                  _loc12_++;
                  property2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 18:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.property3 cannot be set twice.");
                  }
                  _loc23_++;
                  property3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 19:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.param1 cannot be set twice.");
                  }
                  _loc17_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.param2 cannot be set twice.");
                  }
                  _loc13_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.param3 cannot be set twice.");
                  }
                  _loc18_++;
                  param3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.param4 cannot be set twice.");
                  }
                  _loc5_++;
                  param4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 23:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.param5 cannot be set twice.");
                  }
                  _loc8_++;
                  param5 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 24:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.param6 cannot be set twice.");
                  }
                  _loc26_++;
                  param6 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 25:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SteelTeamInfoMsg.fightPower cannot be set twice.");
                  }
                  _loc15_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

