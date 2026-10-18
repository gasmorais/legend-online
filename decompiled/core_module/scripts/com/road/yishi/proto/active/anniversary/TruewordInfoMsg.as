package com.road.yishi.proto.active.anniversary
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TruewordInfoMsg extends Message implements IExternalizable
   {
      
      private var uid$field:String;
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var serverName$field:String;
      
      private var nickName$field:String;
      
      private var content$field:String;
      
      private var praiseNmuber$field:int;
      
      private var user_id$field:int;
      
      private var rank$field:int;
      
      private var createDate$field:String;
      
      private var isVip$field:Boolean;
      
      private var siteGroup$field:String;
      
      public function TruewordInfoMsg()
      {
         super();
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
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
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
      
      public function removePraiseNmuber() : void
      {
         hasField$0 &= 4294967293;
         praiseNmuber$field = new int();
      }
      
      public function get hasPraiseNmuber() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set praiseNmuber(param1:int) : void
      {
         hasField$0 |= 2;
         praiseNmuber$field = param1;
      }
      
      public function get praiseNmuber() : int
      {
         return praiseNmuber$field;
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
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967287;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 8;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removeCreateDate() : void
      {
         createDate$field = null;
      }
      
      public function get hasCreateDate() : Boolean
      {
         return createDate$field != null;
      }
      
      public function set createDate(param1:String) : void
      {
         createDate$field = param1;
      }
      
      public function get createDate() : String
      {
         return createDate$field;
      }
      
      public function removeIsVip() : void
      {
         hasField$0 &= 4294967279;
         isVip$field = new Boolean();
      }
      
      public function get hasIsVip() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isVip(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isVip$field = param1;
      }
      
      public function get isVip() : Boolean
      {
         return isVip$field;
      }
      
      public function removeSiteGroup() : void
      {
         siteGroup$field = null;
      }
      
      public function get hasSiteGroup() : Boolean
      {
         return siteGroup$field != null;
      }
      
      public function set siteGroup(param1:String) : void
      {
         siteGroup$field = param1;
      }
      
      public function get siteGroup() : String
      {
         return siteGroup$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uid$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasContent)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,content$field);
         }
         if(hasPraiseNmuber)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,praiseNmuber$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasCreateDate)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,createDate$field);
         }
         if(hasIsVip)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,isVip$field);
         }
         if(hasSiteGroup)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,siteGroup$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc14_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoMsg.uid cannot be set twice.");
                  }
                  _loc14_++;
                  uid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoMsg.type cannot be set twice.");
                  }
                  _loc7_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoMsg.serverName cannot be set twice.");
                  }
                  _loc9_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoMsg.nickName cannot be set twice.");
                  }
                  _loc10_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoMsg.content cannot be set twice.");
                  }
                  _loc3_++;
                  content = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoMsg.praiseNmuber cannot be set twice.");
                  }
                  _loc5_++;
                  praiseNmuber = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoMsg.userId cannot be set twice.");
                  }
                  _loc12_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoMsg.rank cannot be set twice.");
                  }
                  _loc4_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoMsg.createDate cannot be set twice.");
                  }
                  _loc11_++;
                  createDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoMsg.isVip cannot be set twice.");
                  }
                  _loc8_++;
                  isVip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 10:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TruewordInfoMsg.siteGroup cannot be set twice.");
                  }
                  _loc6_++;
                  siteGroup = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

