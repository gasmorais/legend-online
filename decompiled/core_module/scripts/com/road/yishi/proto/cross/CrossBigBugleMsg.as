package com.road.yishi.proto.cross
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CrossBigBugleMsg extends Message implements IExternalizable
   {
      
      private var server_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var server_name$field:String;
      
      private var uid$field:String;
      
      private var user_id$field:int;
      
      private var nick_name$field:String;
      
      private var is_lookInfo$field:Boolean;
      
      private var content$field:String;
      
      private var param1$field:int;
      
      private var param2$field:String;
      
      private var friendUserId$field:int;
      
      private var uuid$field:String;
      
      private var site$field:String;
      
      private var grade$field:int;
      
      public function CrossBigBugleMsg()
      {
         super();
      }
      
      public function removeServerId() : void
      {
         hasField$0 &= 4294967294;
         server_id$field = new int();
      }
      
      public function get hasServerId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set serverId(param1:int) : void
      {
         hasField$0 |= 1;
         server_id$field = param1;
      }
      
      public function get serverId() : int
      {
         return server_id$field;
      }
      
      public function removeServerName() : void
      {
         server_name$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return server_name$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         server_name$field = param1;
      }
      
      public function get serverName() : String
      {
         return server_name$field;
      }
      
      public function removeUid() : void
      {
         uid$field = null;
      }
      
      public function get hasUid() : Boolean
      {
         return uid$field != null;
      }
      
      public function set uid(param1:String) : void
      {
         uid$field = param1;
      }
      
      public function get uid() : String
      {
         return uid$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
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
      
      public function removeIsLookInfo() : void
      {
         hasField$0 &= 4294967291;
         is_lookInfo$field = new Boolean();
      }
      
      public function get hasIsLookInfo() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isLookInfo(param1:Boolean) : void
      {
         hasField$0 |= 4;
         is_lookInfo$field = param1;
      }
      
      public function get isLookInfo() : Boolean
      {
         return is_lookInfo$field;
      }
      
      public function removeContent() : void
      {
         content$field = null;
      }
      
      public function get hasContent() : Boolean
      {
         return content$field != null;
      }
      
      public function set content(param1:String) : void
      {
         content$field = param1;
      }
      
      public function get content() : String
      {
         return content$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967287;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 8;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         param2$field = null;
      }
      
      public function get hasParam2() : Boolean
      {
         return param2$field != null;
      }
      
      public function set param2(param1:String) : void
      {
         param2$field = param1;
      }
      
      public function get param2() : String
      {
         return param2$field;
      }
      
      public function removeFriendUserId() : void
      {
         hasField$0 &= 4294967279;
         friendUserId$field = new int();
      }
      
      public function get hasFriendUserId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set friendUserId(param1:int) : void
      {
         hasField$0 |= 16;
         friendUserId$field = param1;
      }
      
      public function get friendUserId() : int
      {
         return friendUserId$field;
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
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967263;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 32;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasServerId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,server_id$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasUid)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,uid$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasIsLookInfo)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,is_lookInfo$field);
         }
         if(hasContent)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,content$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,param2$field);
         }
         if(hasFriendUserId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,friendUserId$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasSite)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,site$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc15_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc16_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CrossBigBugleMsg.serverId cannot be set twice.");
                  }
                  _loc3_++;
                  serverId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CrossBigBugleMsg.serverName cannot be set twice.");
                  }
                  _loc9_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: CrossBigBugleMsg.uid cannot be set twice.");
                  }
                  _loc15_++;
                  uid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CrossBigBugleMsg.userId cannot be set twice.");
                  }
                  _loc12_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CrossBigBugleMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: CrossBigBugleMsg.isLookInfo cannot be set twice.");
                  }
                  _loc13_++;
                  isLookInfo = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CrossBigBugleMsg.content cannot be set twice.");
                  }
                  _loc5_++;
                  content = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CrossBigBugleMsg.param1 cannot be set twice.");
                  }
                  _loc8_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: CrossBigBugleMsg.param2 cannot be set twice.");
                  }
                  _loc16_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CrossBigBugleMsg.friendUserId cannot be set twice.");
                  }
                  _loc6_++;
                  friendUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CrossBigBugleMsg.uuid cannot be set twice.");
                  }
                  _loc11_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CrossBigBugleMsg.site cannot be set twice.");
                  }
                  _loc10_++;
                  site = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CrossBigBugleMsg.grade cannot be set twice.");
                  }
                  _loc7_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

