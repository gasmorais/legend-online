package com.road.yishi.proto.pvp
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildPvpRankMsg extends Message implements IExternalizable
   {
      
      private var rank$field:int;
      
      private var hasField$0:uint = 0;
      
      private var integral$field:int;
      
      private var pvpId$field:int;
      
      private var nickName$field:String;
      
      private var serverName$field:String;
      
      private var job$field:int;
      
      private var fightCapacity$field:int;
      
      private var uuid$field:String;
      
      private var site$field:String;
      
      public function ChildPvpRankMsg()
      {
         super();
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967294;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 1;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removeIntegral() : void
      {
         hasField$0 &= 4294967293;
         integral$field = new int();
      }
      
      public function get hasIntegral() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set integral(param1:int) : void
      {
         hasField$0 |= 2;
         integral$field = param1;
      }
      
      public function get integral() : int
      {
         return integral$field;
      }
      
      public function removePvpId() : void
      {
         hasField$0 &= 4294967291;
         pvpId$field = new int();
      }
      
      public function get hasPvpId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set pvpId(param1:int) : void
      {
         hasField$0 |= 4;
         pvpId$field = param1;
      }
      
      public function get pvpId() : int
      {
         return pvpId$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
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
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967287;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 8;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeFightCapacity() : void
      {
         hasField$0 &= 4294967279;
         fightCapacity$field = new int();
      }
      
      public function get hasFightCapacity() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set fightCapacity(param1:int) : void
      {
         hasField$0 |= 16;
         fightCapacity$field = param1;
      }
      
      public function get fightCapacity() : int
      {
         return fightCapacity$field;
      }
      
      public function removeUuid() : void
      {
         uuid$field = null;
      }
      
      public function get hasUuid() : Boolean
      {
         return uuid$field != null;
      }
      
      public function set uuid(param1:String) : void
      {
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasIntegral)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,integral$field);
         }
         if(hasPvpId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pvpId$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,fightCapacity$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasSite)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,site$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpRankMsg.rank cannot be set twice.");
                  }
                  _loc6_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpRankMsg.integral cannot be set twice.");
                  }
                  _loc10_++;
                  integral = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpRankMsg.pvpId cannot be set twice.");
                  }
                  _loc7_++;
                  pvpId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpRankMsg.nickName cannot be set twice.");
                  }
                  _loc8_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpRankMsg.serverName cannot be set twice.");
                  }
                  _loc4_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpRankMsg.job cannot be set twice.");
                  }
                  _loc9_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpRankMsg.fightCapacity cannot be set twice.");
                  }
                  _loc12_++;
                  fightCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpRankMsg.uuid cannot be set twice.");
                  }
                  _loc5_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpRankMsg.site cannot be set twice.");
                  }
                  _loc3_++;
                  site = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

