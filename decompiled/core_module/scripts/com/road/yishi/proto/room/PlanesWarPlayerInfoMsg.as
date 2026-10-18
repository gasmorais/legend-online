package com.road.yishi.proto.room
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlanesWarPlayerInfoMsg extends Message implements IExternalizable
   {
      
      public var userid:int;
      
      private var player_info$field:RoomPlayerMsg;
      
      private var pos_x$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pos_y$field:int;
      
      [ArrayElementType("int")]
      public var walkPath:Array = [];
      
      private var dead$field:Boolean;
      
      public function PlanesWarPlayerInfoMsg()
      {
         super();
      }
      
      public function removePlayerInfo() : void
      {
         player_info$field = null;
      }
      
      public function get hasPlayerInfo() : Boolean
      {
         return player_info$field != null;
      }
      
      public function set playerInfo(param1:RoomPlayerMsg) : void
      {
         player_info$field = param1;
      }
      
      public function get playerInfo() : RoomPlayerMsg
      {
         return player_info$field;
      }
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967294;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 1;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967293;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 2;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      public function removeDead() : void
      {
         hasField$0 &= 4294967291;
         dead$field = new Boolean();
      }
      
      public function get hasDead() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set dead(param1:Boolean) : void
      {
         hasField$0 |= 4;
         dead$field = param1;
      }
      
      public function get dead() : Boolean
      {
         return dead$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_INT32(param1,userid);
         if(hasPlayerInfo)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,player_info$field);
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
         _loc2_ = 0;
         while(_loc2_ < walkPath.length)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,walkPath[_loc2_]);
            _loc2_++;
         }
         if(hasDead)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,dead$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarPlayerInfoMsg.userid cannot be set twice.");
                  }
                  _loc3_++;
                  userid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarPlayerInfoMsg.playerInfo cannot be set twice.");
                  }
                  _loc4_++;
                  playerInfo = new RoomPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,playerInfo);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarPlayerInfoMsg.posX cannot be set twice.");
                  }
                  _loc8_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarPlayerInfoMsg.posY cannot be set twice.");
                  }
                  _loc5_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if((_loc7_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,walkPath);
                  }
                  else
                  {
                     walkPath.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarPlayerInfoMsg.dead cannot be set twice.");
                  }
                  _loc6_++;
                  dead = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
         if(_loc3_ != 1)
         {
            throw new IOError("Bad data format: PlanesWarPlayerInfoMsg.userid must be set.");
         }
      }
   }
}

