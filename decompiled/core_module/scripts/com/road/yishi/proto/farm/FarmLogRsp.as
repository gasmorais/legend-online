package com.road.yishi.proto.farm
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FarmLogRsp extends Message implements IExternalizable
   {
      
      private var player_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var oper_user_id$field:int;
      
      private var oper_nick_name$field:String;
      
      private var desc$field:String;
      
      private var oper_date$field:String;
      
      private var oper_count$field:int;
      
      private var isAddFavGp$field:Boolean;
      
      private var type$field:int;
      
      public function FarmLogRsp()
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
      
      public function removeOperUserId() : void
      {
         hasField$0 &= 4294967293;
         oper_user_id$field = new int();
      }
      
      public function get hasOperUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set operUserId(param1:int) : void
      {
         hasField$0 |= 2;
         oper_user_id$field = param1;
      }
      
      public function get operUserId() : int
      {
         return oper_user_id$field;
      }
      
      public function removeOperNickName() : void
      {
         oper_nick_name$field = null;
      }
      
      public function get hasOperNickName() : Boolean
      {
         return oper_nick_name$field != null;
      }
      
      public function set operNickName(param1:String) : void
      {
         oper_nick_name$field = param1;
      }
      
      public function get operNickName() : String
      {
         return oper_nick_name$field;
      }
      
      public function removeDesc() : void
      {
         desc$field = null;
      }
      
      public function get hasDesc() : Boolean
      {
         return desc$field != null;
      }
      
      public function set desc(param1:String) : void
      {
         desc$field = param1;
      }
      
      public function get desc() : String
      {
         return desc$field;
      }
      
      public function removeOperDate() : void
      {
         oper_date$field = null;
      }
      
      public function get hasOperDate() : Boolean
      {
         return oper_date$field != null;
      }
      
      public function set operDate(param1:String) : void
      {
         oper_date$field = param1;
      }
      
      public function get operDate() : String
      {
         return oper_date$field;
      }
      
      public function removeOperCount() : void
      {
         hasField$0 &= 4294967291;
         oper_count$field = new int();
      }
      
      public function get hasOperCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set operCount(param1:int) : void
      {
         hasField$0 |= 4;
         oper_count$field = param1;
      }
      
      public function get operCount() : int
      {
         return oper_count$field;
      }
      
      public function removeIsAddFavGp() : void
      {
         hasField$0 &= 4294967287;
         isAddFavGp$field = new Boolean();
      }
      
      public function get hasIsAddFavGp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isAddFavGp(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isAddFavGp$field = param1;
      }
      
      public function get isAddFavGp() : Boolean
      {
         return isAddFavGp$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967279;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 16;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,player_id$field);
         }
         if(hasOperUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,oper_user_id$field);
         }
         if(hasOperNickName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,oper_nick_name$field);
         }
         if(hasDesc)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,desc$field);
         }
         if(hasOperDate)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,oper_date$field);
         }
         if(hasOperCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,oper_count$field);
         }
         if(hasIsAddFavGp)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,isAddFavGp$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLogRsp.playerId cannot be set twice.");
                  }
                  _loc4_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLogRsp.operUserId cannot be set twice.");
                  }
                  _loc10_++;
                  operUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLogRsp.operNickName cannot be set twice.");
                  }
                  _loc11_++;
                  operNickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLogRsp.desc cannot be set twice.");
                  }
                  _loc6_++;
                  desc = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLogRsp.operDate cannot be set twice.");
                  }
                  _loc3_++;
                  operDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLogRsp.operCount cannot be set twice.");
                  }
                  _loc5_++;
                  operCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLogRsp.isAddFavGp cannot be set twice.");
                  }
                  _loc7_++;
                  isAddFavGp = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLogRsp.type cannot be set twice.");
                  }
                  _loc8_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

