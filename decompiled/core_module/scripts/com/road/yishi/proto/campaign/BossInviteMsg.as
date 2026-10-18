package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BossInviteMsg extends Message implements IExternalizable
   {
      
      private var nick_name$field:String;
      
      private var boss_nick$field:String;
      
      private var level$field:int;
      
      private var hasField$0:uint = 0;
      
      private var template_id$field:int;
      
      private var left_fight_time$field:int;
      
      private var pos_x$field:int;
      
      private var pos_y$field:int;
      
      public function BossInviteMsg()
      {
         super();
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
      
      public function removeBossNick() : void
      {
         boss_nick$field = null;
      }
      
      public function get hasBossNick() : Boolean
      {
         return boss_nick$field != null;
      }
      
      public function set bossNick(param1:String) : void
      {
         boss_nick$field = param1;
      }
      
      public function get bossNick() : String
      {
         return boss_nick$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967294;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 1;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removeLeftFightTime() : void
      {
         hasField$0 &= 4294967291;
         left_fight_time$field = new int();
      }
      
      public function get hasLeftFightTime() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set leftFightTime(param1:int) : void
      {
         hasField$0 |= 4;
         left_fight_time$field = param1;
      }
      
      public function get leftFightTime() : int
      {
         return left_fight_time$field;
      }
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967287;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 8;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967279;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 16;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasBossNick)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,boss_nick$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasLeftFightTime)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,left_fight_time$field);
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BossInviteMsg.nickName cannot be set twice.");
                  }
                  _loc6_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BossInviteMsg.bossNick cannot be set twice.");
                  }
                  _loc7_++;
                  bossNick = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BossInviteMsg.level cannot be set twice.");
                  }
                  _loc3_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: BossInviteMsg.templateId cannot be set twice.");
                  }
                  _loc8_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BossInviteMsg.leftFightTime cannot be set twice.");
                  }
                  _loc4_++;
                  leftFightTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: BossInviteMsg.posX cannot be set twice.");
                  }
                  _loc10_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BossInviteMsg.posY cannot be set twice.");
                  }
                  _loc5_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

