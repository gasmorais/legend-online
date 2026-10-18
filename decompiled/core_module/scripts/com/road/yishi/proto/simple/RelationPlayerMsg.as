package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RelationPlayerMsg extends Message implements IExternalizable
   {
      
      private var relation$field:int;
      
      private var hasField$0:uint = 0;
      
      private var friend_rp$field:int;
      
      private var friend_grade$field:int;
      
      private var group_id$field:int;
      
      private var player$field:SimplePlayerInfoMsg;
      
      private var sns_info$field:SNSInfoMsg;
      
      private var from$field:int;
      
      private var is_vip$field:int;
      
      private var trans_grade$field:int;
      
      private var changeBranch$field:int;
      
      public function RelationPlayerMsg()
      {
         super();
      }
      
      public function removeRelation() : void
      {
         hasField$0 &= 4294967294;
         relation$field = new int();
      }
      
      public function get hasRelation() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set relation(param1:int) : void
      {
         hasField$0 |= 1;
         relation$field = param1;
      }
      
      public function get relation() : int
      {
         return relation$field;
      }
      
      public function removeFriendRp() : void
      {
         hasField$0 &= 4294967293;
         friend_rp$field = new int();
      }
      
      public function get hasFriendRp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set friendRp(param1:int) : void
      {
         hasField$0 |= 2;
         friend_rp$field = param1;
      }
      
      public function get friendRp() : int
      {
         return friend_rp$field;
      }
      
      public function removeFriendGrade() : void
      {
         hasField$0 &= 4294967291;
         friend_grade$field = new int();
      }
      
      public function get hasFriendGrade() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set friendGrade(param1:int) : void
      {
         hasField$0 |= 4;
         friend_grade$field = param1;
      }
      
      public function get friendGrade() : int
      {
         return friend_grade$field;
      }
      
      public function removeGroupId() : void
      {
         hasField$0 &= 4294967287;
         group_id$field = new int();
      }
      
      public function get hasGroupId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set groupId(param1:int) : void
      {
         hasField$0 |= 8;
         group_id$field = param1;
      }
      
      public function get groupId() : int
      {
         return group_id$field;
      }
      
      public function removePlayer() : void
      {
         player$field = null;
      }
      
      public function get hasPlayer() : Boolean
      {
         return player$field != null;
      }
      
      public function set player(param1:SimplePlayerInfoMsg) : void
      {
         player$field = param1;
      }
      
      public function get player() : SimplePlayerInfoMsg
      {
         return player$field;
      }
      
      public function removeSnsInfo() : void
      {
         sns_info$field = null;
      }
      
      public function get hasSnsInfo() : Boolean
      {
         return sns_info$field != null;
      }
      
      public function set snsInfo(param1:SNSInfoMsg) : void
      {
         sns_info$field = param1;
      }
      
      public function get snsInfo() : SNSInfoMsg
      {
         return sns_info$field;
      }
      
      public function removeFrom() : void
      {
         hasField$0 &= 4294967279;
         from$field = new int();
      }
      
      public function get hasFrom() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set from(param1:int) : void
      {
         hasField$0 |= 16;
         from$field = param1;
      }
      
      public function get from() : int
      {
         return from$field;
      }
      
      public function removeIsVip() : void
      {
         hasField$0 &= 4294967263;
         is_vip$field = new int();
      }
      
      public function get hasIsVip() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isVip(param1:int) : void
      {
         hasField$0 |= 32;
         is_vip$field = param1;
      }
      
      public function get isVip() : int
      {
         return is_vip$field;
      }
      
      public function removeTransGrade() : void
      {
         hasField$0 &= 4294967231;
         trans_grade$field = new int();
      }
      
      public function get hasTransGrade() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set transGrade(param1:int) : void
      {
         hasField$0 |= 64;
         trans_grade$field = param1;
      }
      
      public function get transGrade() : int
      {
         return trans_grade$field;
      }
      
      public function removeChangeBranch() : void
      {
         hasField$0 &= 4294967167;
         changeBranch$field = new int();
      }
      
      public function get hasChangeBranch() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set changeBranch(param1:int) : void
      {
         hasField$0 |= 128;
         changeBranch$field = param1;
      }
      
      public function get changeBranch() : int
      {
         return changeBranch$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRelation)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,relation$field);
         }
         if(hasFriendRp)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,friend_rp$field);
         }
         if(hasFriendGrade)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,friend_grade$field);
         }
         if(hasGroupId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,group_id$field);
         }
         if(hasPlayer)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,player$field);
         }
         if(hasSnsInfo)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,sns_info$field);
         }
         if(hasFrom)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,from$field);
         }
         if(hasIsVip)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,is_vip$field);
         }
         if(hasTransGrade)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,trans_grade$field);
         }
         if(hasChangeBranch)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,changeBranch$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RelationPlayerMsg.relation cannot be set twice.");
                  }
                  _loc7_++;
                  relation = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: RelationPlayerMsg.friendRp cannot be set twice.");
                  }
                  _loc10_++;
                  friendRp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: RelationPlayerMsg.friendGrade cannot be set twice.");
                  }
                  _loc11_++;
                  friendGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RelationPlayerMsg.groupId cannot be set twice.");
                  }
                  _loc8_++;
                  groupId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: RelationPlayerMsg.player cannot be set twice.");
                  }
                  _loc13_++;
                  player = new SimplePlayerInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,player);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RelationPlayerMsg.snsInfo cannot be set twice.");
                  }
                  _loc3_++;
                  snsInfo = new SNSInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,snsInfo);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: RelationPlayerMsg.from cannot be set twice.");
                  }
                  _loc9_++;
                  from = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RelationPlayerMsg.isVip cannot be set twice.");
                  }
                  _loc4_++;
                  isVip = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RelationPlayerMsg.transGrade cannot be set twice.");
                  }
                  _loc6_++;
                  transGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RelationPlayerMsg.changeBranch cannot be set twice.");
                  }
                  _loc5_++;
                  changeBranch = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

