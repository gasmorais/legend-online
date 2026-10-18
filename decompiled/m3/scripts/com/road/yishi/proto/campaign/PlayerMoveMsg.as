package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerMoveMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var map_id$field:int;
      
      private var tar_x$field:int;
      
      private var tar_y$field:int;
      
      private var ismove_camera$field:Boolean;
      
      public function PlayerMoveMsg()
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
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967293;
         map_id$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 2;
         map_id$field = param1;
      }
      
      public function get mapId() : int
      {
         return map_id$field;
      }
      
      public function removeTarX() : void
      {
         hasField$0 &= 4294967291;
         tar_x$field = new int();
      }
      
      public function get hasTarX() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set tarX(param1:int) : void
      {
         hasField$0 |= 4;
         tar_x$field = param1;
      }
      
      public function get tarX() : int
      {
         return tar_x$field;
      }
      
      public function removeTarY() : void
      {
         hasField$0 &= 4294967287;
         tar_y$field = new int();
      }
      
      public function get hasTarY() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set tarY(param1:int) : void
      {
         hasField$0 |= 8;
         tar_y$field = param1;
      }
      
      public function get tarY() : int
      {
         return tar_y$field;
      }
      
      public function removeIsmoveCamera() : void
      {
         hasField$0 &= 4294967279;
         ismove_camera$field = new Boolean();
      }
      
      public function get hasIsmoveCamera() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set ismoveCamera(param1:Boolean) : void
      {
         hasField$0 |= 16;
         ismove_camera$field = param1;
      }
      
      public function get ismoveCamera() : Boolean
      {
         return ismove_camera$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,map_id$field);
         }
         if(hasTarX)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,tar_x$field);
         }
         if(hasTarY)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,tar_y$field);
         }
         if(hasIsmoveCamera)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,ismove_camera$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMoveMsg.userId cannot be set twice.");
                  }
                  _loc4_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMoveMsg.mapId cannot be set twice.");
                  }
                  _loc5_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMoveMsg.tarX cannot be set twice.");
                  }
                  _loc3_++;
                  tarX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMoveMsg.tarY cannot be set twice.");
                  }
                  _loc8_++;
                  tarY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMoveMsg.ismoveCamera cannot be set twice.");
                  }
                  _loc7_++;
                  ismoveCamera = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

