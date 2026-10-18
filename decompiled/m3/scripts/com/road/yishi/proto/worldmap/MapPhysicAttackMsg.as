package com.road.yishi.proto.worldmap
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MapPhysicAttackMsg extends Message implements IExternalizable
   {
      
      private var map_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pos_x$field:int;
      
      private var pos_y$field:int;
      
      public function MapPhysicAttackMsg()
      {
         super();
      }
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967294;
         map_id$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 1;
         map_id$field = param1;
      }
      
      public function get mapId() : int
      {
         return map_id$field;
      }
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967293;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 2;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967291;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 4;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,map_id$field);
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MapPhysicAttackMsg.mapId cannot be set twice.");
                  }
                  _loc4_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MapPhysicAttackMsg.posX cannot be set twice.");
                  }
                  _loc6_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MapPhysicAttackMsg.posY cannot be set twice.");
                  }
                  _loc3_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

