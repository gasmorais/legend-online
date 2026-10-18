package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DetailReqMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var server_name$field:String;
      
      private var other_id$field:int;
      
      private var other_name$field:String;
      
      private var item_info$field:Boolean;
      
      private var army_info$field:Boolean;
      
      private var hero_info$field:Boolean;
      
      private var pawn_info$field:Boolean;
      
      public function DetailReqMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
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
      
      public function removeOtherId() : void
      {
         hasField$0 &= 4294967293;
         other_id$field = new int();
      }
      
      public function get hasOtherId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set otherId(param1:int) : void
      {
         hasField$0 |= 2;
         other_id$field = param1;
      }
      
      public function get otherId() : int
      {
         return other_id$field;
      }
      
      public function removeOtherName() : void
      {
         other_name$field = null;
      }
      
      public function get hasOtherName() : Boolean
      {
         return other_name$field != null;
      }
      
      public function set otherName(param1:String) : void
      {
         other_name$field = param1;
      }
      
      public function get otherName() : String
      {
         return other_name$field;
      }
      
      public function removeItemInfo() : void
      {
         hasField$0 &= 4294967291;
         item_info$field = new Boolean();
      }
      
      public function get hasItemInfo() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set itemInfo(param1:Boolean) : void
      {
         hasField$0 |= 4;
         item_info$field = param1;
      }
      
      public function get itemInfo() : Boolean
      {
         return item_info$field;
      }
      
      public function removeArmyInfo() : void
      {
         hasField$0 &= 4294967287;
         army_info$field = new Boolean();
      }
      
      public function get hasArmyInfo() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set armyInfo(param1:Boolean) : void
      {
         hasField$0 |= 8;
         army_info$field = param1;
      }
      
      public function get armyInfo() : Boolean
      {
         return army_info$field;
      }
      
      public function removeHeroInfo() : void
      {
         hasField$0 &= 4294967279;
         hero_info$field = new Boolean();
      }
      
      public function get hasHeroInfo() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set heroInfo(param1:Boolean) : void
      {
         hasField$0 |= 16;
         hero_info$field = param1;
      }
      
      public function get heroInfo() : Boolean
      {
         return hero_info$field;
      }
      
      public function removePawnInfo() : void
      {
         hasField$0 &= 4294967263;
         pawn_info$field = new Boolean();
      }
      
      public function get hasPawnInfo() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set pawnInfo(param1:Boolean) : void
      {
         hasField$0 |= 32;
         pawn_info$field = param1;
      }
      
      public function get pawnInfo() : Boolean
      {
         return pawn_info$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasOtherId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,other_id$field);
         }
         if(hasOtherName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,other_name$field);
         }
         if(hasItemInfo)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,item_info$field);
         }
         if(hasArmyInfo)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,army_info$field);
         }
         if(hasHeroInfo)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,hero_info$field);
         }
         if(hasPawnInfo)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,pawn_info$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DetailReqMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DetailReqMsg.serverName cannot be set twice.");
                  }
                  _loc8_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: DetailReqMsg.otherId cannot be set twice.");
                  }
                  _loc10_++;
                  otherId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: DetailReqMsg.otherName cannot be set twice.");
                  }
                  _loc11_++;
                  otherName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DetailReqMsg.itemInfo cannot be set twice.");
                  }
                  _loc9_++;
                  itemInfo = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DetailReqMsg.armyInfo cannot be set twice.");
                  }
                  _loc4_++;
                  armyInfo = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DetailReqMsg.heroInfo cannot be set twice.");
                  }
                  _loc3_++;
                  heroInfo = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DetailReqMsg.pawnInfo cannot be set twice.");
                  }
                  _loc6_++;
                  pawnInfo = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

