package com.road.yishi.proto.pvp
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PvpInfoMsg extends Message implements IExternalizable
   {
      
      private var teamUid$field:String;
      
      private var teamName$field:String;
      
      private var site$field:String;
      
      private var ready1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var ready2$field:int;
      
      private var ready3$field:int;
      
      private var ready4$field:int;
      
      private var final1$field:int;
      
      private var final2$field:int;
      
      private var final3$field:int;
      
      private var final4$field:int;
      
      private var readyScore$field:int;
      
      private var finalScore$field:int;
      
      private var readyOrder$field:int;
      
      private var finalOrder$field:int;
      
      private var groupId$field:int;
      
      private var serverId$field:int;
      
      private var fightPower$field:int;
      
      private var finalTeam$field:int;
      
      private var property1$field:String;
      
      private var property2$field:String;
      
      private var property3$field:String;
      
      public function PvpInfoMsg()
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
      
      public function removeReady1() : void
      {
         hasField$0 &= 4294967294;
         ready1$field = new int();
      }
      
      public function get hasReady1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set ready1(param1:int) : void
      {
         hasField$0 |= 1;
         ready1$field = param1;
      }
      
      public function get ready1() : int
      {
         return ready1$field;
      }
      
      public function removeReady2() : void
      {
         hasField$0 &= 4294967293;
         ready2$field = new int();
      }
      
      public function get hasReady2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set ready2(param1:int) : void
      {
         hasField$0 |= 2;
         ready2$field = param1;
      }
      
      public function get ready2() : int
      {
         return ready2$field;
      }
      
      public function removeReady3() : void
      {
         hasField$0 &= 4294967291;
         ready3$field = new int();
      }
      
      public function get hasReady3() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set ready3(param1:int) : void
      {
         hasField$0 |= 4;
         ready3$field = param1;
      }
      
      public function get ready3() : int
      {
         return ready3$field;
      }
      
      public function removeReady4() : void
      {
         hasField$0 &= 4294967287;
         ready4$field = new int();
      }
      
      public function get hasReady4() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set ready4(param1:int) : void
      {
         hasField$0 |= 8;
         ready4$field = param1;
      }
      
      public function get ready4() : int
      {
         return ready4$field;
      }
      
      public function removeFinal1() : void
      {
         hasField$0 &= 4294967279;
         final1$field = new int();
      }
      
      public function get hasFinal1() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set final1(param1:int) : void
      {
         hasField$0 |= 16;
         final1$field = param1;
      }
      
      public function get final1() : int
      {
         return final1$field;
      }
      
      public function removeFinal2() : void
      {
         hasField$0 &= 4294967263;
         final2$field = new int();
      }
      
      public function get hasFinal2() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set final2(param1:int) : void
      {
         hasField$0 |= 32;
         final2$field = param1;
      }
      
      public function get final2() : int
      {
         return final2$field;
      }
      
      public function removeFinal3() : void
      {
         hasField$0 &= 4294967231;
         final3$field = new int();
      }
      
      public function get hasFinal3() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set final3(param1:int) : void
      {
         hasField$0 |= 64;
         final3$field = param1;
      }
      
      public function get final3() : int
      {
         return final3$field;
      }
      
      public function removeFinal4() : void
      {
         hasField$0 &= 4294967167;
         final4$field = new int();
      }
      
      public function get hasFinal4() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set final4(param1:int) : void
      {
         hasField$0 |= 128;
         final4$field = param1;
      }
      
      public function get final4() : int
      {
         return final4$field;
      }
      
      public function removeReadyScore() : void
      {
         hasField$0 &= 4294967039;
         readyScore$field = new int();
      }
      
      public function get hasReadyScore() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set readyScore(param1:int) : void
      {
         hasField$0 |= 256;
         readyScore$field = param1;
      }
      
      public function get readyScore() : int
      {
         return readyScore$field;
      }
      
      public function removeFinalScore() : void
      {
         hasField$0 &= 4294966783;
         finalScore$field = new int();
      }
      
      public function get hasFinalScore() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set finalScore(param1:int) : void
      {
         hasField$0 |= 512;
         finalScore$field = param1;
      }
      
      public function get finalScore() : int
      {
         return finalScore$field;
      }
      
      public function removeReadyOrder() : void
      {
         hasField$0 &= 4294966271;
         readyOrder$field = new int();
      }
      
      public function get hasReadyOrder() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set readyOrder(param1:int) : void
      {
         hasField$0 |= 1024;
         readyOrder$field = param1;
      }
      
      public function get readyOrder() : int
      {
         return readyOrder$field;
      }
      
      public function removeFinalOrder() : void
      {
         hasField$0 &= 4294965247;
         finalOrder$field = new int();
      }
      
      public function get hasFinalOrder() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set finalOrder(param1:int) : void
      {
         hasField$0 |= 2048;
         finalOrder$field = param1;
      }
      
      public function get finalOrder() : int
      {
         return finalOrder$field;
      }
      
      public function removeGroupId() : void
      {
         hasField$0 &= 4294963199;
         groupId$field = new int();
      }
      
      public function get hasGroupId() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set groupId(param1:int) : void
      {
         hasField$0 |= 4096;
         groupId$field = param1;
      }
      
      public function get groupId() : int
      {
         return groupId$field;
      }
      
      public function removeServerId() : void
      {
         hasField$0 &= 4294959103;
         serverId$field = new int();
      }
      
      public function get hasServerId() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set serverId(param1:int) : void
      {
         hasField$0 |= 8192;
         serverId$field = param1;
      }
      
      public function get serverId() : int
      {
         return serverId$field;
      }
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294950911;
         fightPower$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 16384;
         fightPower$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fightPower$field;
      }
      
      public function removeFinalTeam() : void
      {
         hasField$0 &= 4294934527;
         finalTeam$field = new int();
      }
      
      public function get hasFinalTeam() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set finalTeam(param1:int) : void
      {
         hasField$0 |= 32768;
         finalTeam$field = param1;
      }
      
      public function get finalTeam() : int
      {
         return finalTeam$field;
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
         if(hasSite)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,site$field);
         }
         if(hasReady1)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,ready1$field);
         }
         if(hasReady2)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,ready2$field);
         }
         if(hasReady3)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,ready3$field);
         }
         if(hasReady4)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,ready4$field);
         }
         if(hasFinal1)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,final1$field);
         }
         if(hasFinal2)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,final2$field);
         }
         if(hasFinal3)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,final3$field);
         }
         if(hasFinal4)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,final4$field);
         }
         if(hasReadyScore)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,readyScore$field);
         }
         if(hasFinalScore)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,finalScore$field);
         }
         if(hasReadyOrder)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,readyOrder$field);
         }
         if(hasFinalOrder)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,finalOrder$field);
         }
         if(hasGroupId)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,groupId$field);
         }
         if(hasServerId)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,serverId$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
         if(hasFinalTeam)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,finalTeam$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,2,21);
            WriteUtils.write$TYPE_STRING(param1,property1$field);
         }
         if(hasProperty2)
         {
            WriteUtils.writeTag(param1,2,22);
            WriteUtils.write$TYPE_STRING(param1,property2$field);
         }
         if(hasProperty3)
         {
            WriteUtils.writeTag(param1,2,23);
            WriteUtils.write$TYPE_STRING(param1,property3$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc15_:uint = 0;
         var _loc5_:uint = 0;
         var _loc19_:uint = 0;
         var _loc14_:uint = 0;
         var _loc24_:uint = 0;
         var _loc10_:uint = 0;
         var _loc20_:uint = 0;
         var _loc7_:uint = 0;
         var _loc23_:uint = 0;
         var _loc17_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc25_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc18_:uint = 0;
         var _loc16_:uint = 0;
         var _loc12_:uint = 0;
         var _loc22_:uint = 0;
         var _loc13_:uint = 0;
         var _loc21_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.teamUid cannot be set twice.");
                  }
                  _loc15_++;
                  teamUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.teamName cannot be set twice.");
                  }
                  _loc5_++;
                  teamName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.site cannot be set twice.");
                  }
                  _loc19_++;
                  site = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.ready1 cannot be set twice.");
                  }
                  _loc14_++;
                  ready1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.ready2 cannot be set twice.");
                  }
                  _loc24_++;
                  ready2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.ready3 cannot be set twice.");
                  }
                  _loc10_++;
                  ready3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.ready4 cannot be set twice.");
                  }
                  _loc20_++;
                  ready4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.final1 cannot be set twice.");
                  }
                  _loc7_++;
                  final1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.final2 cannot be set twice.");
                  }
                  _loc23_++;
                  final2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.final3 cannot be set twice.");
                  }
                  _loc17_++;
                  final3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.final4 cannot be set twice.");
                  }
                  _loc3_++;
                  final4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.readyScore cannot be set twice.");
                  }
                  _loc4_++;
                  readyScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.finalScore cannot be set twice.");
                  }
                  _loc6_++;
                  finalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.readyOrder cannot be set twice.");
                  }
                  _loc25_++;
                  readyOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.finalOrder cannot be set twice.");
                  }
                  _loc8_++;
                  finalOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.groupId cannot be set twice.");
                  }
                  _loc11_++;
                  groupId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.serverId cannot be set twice.");
                  }
                  _loc18_++;
                  serverId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.fightPower cannot be set twice.");
                  }
                  _loc16_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.finalTeam cannot be set twice.");
                  }
                  _loc12_++;
                  finalTeam = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.property1 cannot be set twice.");
                  }
                  _loc22_++;
                  property1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 22:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.property2 cannot be set twice.");
                  }
                  _loc13_++;
                  property2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 23:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: PvpInfoMsg.property3 cannot be set twice.");
                  }
                  _loc21_++;
                  property3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

