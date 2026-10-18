package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaUserInviteInfoMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var consortia_id$field:int;
      
      private var consortia_name$field:String;
      
      private var create_date$field:String;
      
      private var user_id$field:int;
      
      private var user_nickname$field:String;
      
      private var invite_id$field:int;
      
      private var invite_nickname$field:String;
      
      private var chairman_nickname$field:String;
      
      private var invite_date$field:String;
      
      private var from_type$field:Boolean;
      
      private var isexist$field:Boolean;
      
      public function ConsortiaUserInviteInfoMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294967293;
         consortia_id$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 2;
         consortia_id$field = param1;
      }
      
      public function get consortiaId() : int
      {
         return consortia_id$field;
      }
      
      public function removeConsortiaName() : void
      {
         consortia_name$field = null;
      }
      
      public function get hasConsortiaName() : Boolean
      {
         return consortia_name$field != null;
      }
      
      public function set consortiaName(param1:String) : void
      {
         consortia_name$field = param1;
      }
      
      public function get consortiaName() : String
      {
         return consortia_name$field;
      }
      
      public function removeCreateDate() : void
      {
         create_date$field = null;
      }
      
      public function get hasCreateDate() : Boolean
      {
         return create_date$field != null;
      }
      
      public function set createDate(param1:String) : void
      {
         create_date$field = param1;
      }
      
      public function get createDate() : String
      {
         return create_date$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967291;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 4;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeUserNickname() : void
      {
         user_nickname$field = null;
      }
      
      public function get hasUserNickname() : Boolean
      {
         return user_nickname$field != null;
      }
      
      public function set userNickname(param1:String) : void
      {
         user_nickname$field = param1;
      }
      
      public function get userNickname() : String
      {
         return user_nickname$field;
      }
      
      public function removeInviteId() : void
      {
         hasField$0 &= 4294967287;
         invite_id$field = new int();
      }
      
      public function get hasInviteId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set inviteId(param1:int) : void
      {
         hasField$0 |= 8;
         invite_id$field = param1;
      }
      
      public function get inviteId() : int
      {
         return invite_id$field;
      }
      
      public function removeInviteNickname() : void
      {
         invite_nickname$field = null;
      }
      
      public function get hasInviteNickname() : Boolean
      {
         return invite_nickname$field != null;
      }
      
      public function set inviteNickname(param1:String) : void
      {
         invite_nickname$field = param1;
      }
      
      public function get inviteNickname() : String
      {
         return invite_nickname$field;
      }
      
      public function removeChairmanNickname() : void
      {
         chairman_nickname$field = null;
      }
      
      public function get hasChairmanNickname() : Boolean
      {
         return chairman_nickname$field != null;
      }
      
      public function set chairmanNickname(param1:String) : void
      {
         chairman_nickname$field = param1;
      }
      
      public function get chairmanNickname() : String
      {
         return chairman_nickname$field;
      }
      
      public function removeInviteDate() : void
      {
         invite_date$field = null;
      }
      
      public function get hasInviteDate() : Boolean
      {
         return invite_date$field != null;
      }
      
      public function set inviteDate(param1:String) : void
      {
         invite_date$field = param1;
      }
      
      public function get inviteDate() : String
      {
         return invite_date$field;
      }
      
      public function removeFromType() : void
      {
         hasField$0 &= 4294967279;
         from_type$field = new Boolean();
      }
      
      public function get hasFromType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set fromType(param1:Boolean) : void
      {
         hasField$0 |= 16;
         from_type$field = param1;
      }
      
      public function get fromType() : Boolean
      {
         return from_type$field;
      }
      
      public function removeIsexist() : void
      {
         hasField$0 &= 4294967263;
         isexist$field = new Boolean();
      }
      
      public function get hasIsexist() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isexist(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isexist$field = param1;
      }
      
      public function get isexist() : Boolean
      {
         return isexist$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,consortia_id$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,consortia_name$field);
         }
         if(hasCreateDate)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,create_date$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasUserNickname)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,user_nickname$field);
         }
         if(hasInviteId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,invite_id$field);
         }
         if(hasInviteNickname)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,invite_nickname$field);
         }
         if(hasChairmanNickname)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,chairman_nickname$field);
         }
         if(hasInviteDate)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,invite_date$field);
         }
         if(hasFromType)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_BOOL(param1,from_type$field);
         }
         if(hasIsexist)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,isexist$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc15_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserInviteInfoMsg.id cannot be set twice.");
                  }
                  _loc5_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserInviteInfoMsg.consortiaId cannot be set twice.");
                  }
                  _loc10_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserInviteInfoMsg.consortiaName cannot be set twice.");
                  }
                  _loc6_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserInviteInfoMsg.createDate cannot be set twice.");
                  }
                  _loc12_++;
                  createDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserInviteInfoMsg.userId cannot be set twice.");
                  }
                  _loc13_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserInviteInfoMsg.userNickname cannot be set twice.");
                  }
                  _loc4_++;
                  userNickname = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserInviteInfoMsg.inviteId cannot be set twice.");
                  }
                  _loc9_++;
                  inviteId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserInviteInfoMsg.inviteNickname cannot be set twice.");
                  }
                  _loc15_++;
                  inviteNickname = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserInviteInfoMsg.chairmanNickname cannot be set twice.");
                  }
                  _loc3_++;
                  chairmanNickname = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserInviteInfoMsg.inviteDate cannot be set twice.");
                  }
                  _loc11_++;
                  inviteDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserInviteInfoMsg.fromType cannot be set twice.");
                  }
                  _loc7_++;
                  fromType = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 11:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserInviteInfoMsg.isexist cannot be set twice.");
                  }
                  _loc8_++;
                  isexist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

