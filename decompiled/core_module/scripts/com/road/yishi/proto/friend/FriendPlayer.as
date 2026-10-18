package com.road.yishi.proto.friend
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FriendPlayer extends Message implements IExternalizable
   {
      
      private var player_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nick_name$field:String;
      
      private var level$field:int;
      
      private var sex$field:int;
      
      private var attack$field:int;
      
      private var map_name$field:String;
      
      private var trans_grade$field:int;
      
      private var job$field:int;
      
      private var changeBranch$field:int;
      
      public function FriendPlayer()
      {
         super();
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967294;
         player_id$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 1;
         player_id$field = param1;
      }
      
      public function get playerId() : int
      {
         return player_id$field;
      }
      
      public function removeNickName() : void
      {
         nick_name$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nick_name$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nick_name$field = param1;
      }
      
      public function get nickName() : String
      {
         return nick_name$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967293;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 2;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeSex() : void
      {
         hasField$0 &= 4294967291;
         sex$field = new int();
      }
      
      public function get hasSex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set sex(param1:int) : void
      {
         hasField$0 |= 4;
         sex$field = param1;
      }
      
      public function get sex() : int
      {
         return sex$field;
      }
      
      public function removeAttack() : void
      {
         hasField$0 &= 4294967287;
         attack$field = new int();
      }
      
      public function get hasAttack() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set attack(param1:int) : void
      {
         hasField$0 |= 8;
         attack$field = param1;
      }
      
      public function get attack() : int
      {
         return attack$field;
      }
      
      public function removeMapName() : void
      {
         map_name$field = null;
      }
      
      public function get hasMapName() : Boolean
      {
         return map_name$field != null;
      }
      
      public function set mapName(param1:String) : void
      {
         map_name$field = param1;
      }
      
      public function get mapName() : String
      {
         return map_name$field;
      }
      
      public function removeTransGrade() : void
      {
         hasField$0 &= 4294967279;
         trans_grade$field = new int();
      }
      
      public function get hasTransGrade() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set transGrade(param1:int) : void
      {
         hasField$0 |= 16;
         trans_grade$field = param1;
      }
      
      public function get transGrade() : int
      {
         return trans_grade$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967263;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 32;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeChangeBranch() : void
      {
         hasField$0 &= 4294967231;
         changeBranch$field = new int();
      }
      
      public function get hasChangeBranch() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set changeBranch(param1:int) : void
      {
         hasField$0 |= 64;
         changeBranch$field = param1;
      }
      
      public function get changeBranch() : int
      {
         return changeBranch$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,player_id$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasSex)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,sex$field);
         }
         if(hasAttack)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,attack$field);
         }
         if(hasMapName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,map_name$field);
         }
         if(hasTransGrade)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,trans_grade$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasChangeBranch)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,changeBranch$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FriendPlayer.playerId cannot be set twice.");
                  }
                  _loc5_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FriendPlayer.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FriendPlayer.level cannot be set twice.");
                  }
                  _loc3_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FriendPlayer.sex cannot be set twice.");
                  }
                  _loc7_++;
                  sex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FriendPlayer.attack cannot be set twice.");
                  }
                  _loc10_++;
                  attack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FriendPlayer.mapName cannot be set twice.");
                  }
                  _loc11_++;
                  mapName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FriendPlayer.transGrade cannot be set twice.");
                  }
                  _loc8_++;
                  transGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FriendPlayer.job cannot be set twice.");
                  }
                  _loc9_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FriendPlayer.changeBranch cannot be set twice.");
                  }
                  _loc6_++;
                  changeBranch = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

