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
   
   public final class ApexRankTeamMsg extends Message implements IExternalizable
   {
      
      private var teamUid$field:String;
      
      private var teamName$field:String;
      
      private var serverName$field:String;
      
      private var fightCapacity$field:Int64;
      
      private var score$field:int;
      
      private var hasField$0:uint = 0;
      
      private var rank$field:int;
      
      private var vipType$field:int;
      
      private var nextGroup$field:int;
      
      public function ApexRankTeamMsg()
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
      
      public function removeFightCapacity() : void
      {
         fightCapacity$field = null;
      }
      
      public function get hasFightCapacity() : Boolean
      {
         return fightCapacity$field != null;
      }
      
      public function set fightCapacity(param1:Int64) : void
      {
         fightCapacity$field = param1;
      }
      
      public function get fightCapacity() : Int64
      {
         return fightCapacity$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967294;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 1;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967293;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 2;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removeVipType() : void
      {
         hasField$0 &= 4294967291;
         vipType$field = new int();
      }
      
      public function get hasVipType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set vipType(param1:int) : void
      {
         hasField$0 |= 4;
         vipType$field = param1;
      }
      
      public function get vipType() : int
      {
         return vipType$field;
      }
      
      public function removeNextGroup() : void
      {
         hasField$0 &= 4294967287;
         nextGroup$field = new int();
      }
      
      public function get hasNextGroup() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set nextGroup(param1:int) : void
      {
         hasField$0 |= 8;
         nextGroup$field = param1;
      }
      
      public function get nextGroup() : int
      {
         return nextGroup$field;
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
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT64(param1,fightCapacity$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasVipType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,vipType$field);
         }
         if(hasNextGroup)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,nextGroup$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ApexRankTeamMsg.teamUid cannot be set twice.");
                  }
                  _loc6_++;
                  teamUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ApexRankTeamMsg.teamName cannot be set twice.");
                  }
                  _loc7_++;
                  teamName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ApexRankTeamMsg.serverName cannot be set twice.");
                  }
                  _loc3_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ApexRankTeamMsg.fightCapacity cannot be set twice.");
                  }
                  _loc9_++;
                  fightCapacity = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ApexRankTeamMsg.score cannot be set twice.");
                  }
                  _loc10_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ApexRankTeamMsg.rank cannot be set twice.");
                  }
                  _loc5_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ApexRankTeamMsg.vipType cannot be set twice.");
                  }
                  _loc4_++;
                  vipType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ApexRankTeamMsg.nextGroup cannot be set twice.");
                  }
                  _loc11_++;
                  nextGroup = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

