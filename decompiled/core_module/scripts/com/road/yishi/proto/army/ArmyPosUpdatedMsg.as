package com.road.yishi.proto.army
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArmyPosUpdatedMsg extends Message implements IExternalizable
   {
      
      private var army_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var cur_pos_x$field:int;
      
      private var cur_pos_y$field:int;
      
      private var end_pos_x$field:int;
      
      private var end_pos_y$field:int;
      
      [ArrayElementType("int")]
      public var userIds:Array = [];
      
      private var server_name$field:String;
      
      public function ArmyPosUpdatedMsg()
      {
         super();
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294967294;
         army_id$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 1;
         army_id$field = param1;
      }
      
      public function get armyId() : int
      {
         return army_id$field;
      }
      
      public function removeCurPosX() : void
      {
         hasField$0 &= 4294967293;
         cur_pos_x$field = new int();
      }
      
      public function get hasCurPosX() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set curPosX(param1:int) : void
      {
         hasField$0 |= 2;
         cur_pos_x$field = param1;
      }
      
      public function get curPosX() : int
      {
         return cur_pos_x$field;
      }
      
      public function removeCurPosY() : void
      {
         hasField$0 &= 4294967291;
         cur_pos_y$field = new int();
      }
      
      public function get hasCurPosY() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set curPosY(param1:int) : void
      {
         hasField$0 |= 4;
         cur_pos_y$field = param1;
      }
      
      public function get curPosY() : int
      {
         return cur_pos_y$field;
      }
      
      public function removeEndPosX() : void
      {
         hasField$0 &= 4294967287;
         end_pos_x$field = new int();
      }
      
      public function get hasEndPosX() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set endPosX(param1:int) : void
      {
         hasField$0 |= 8;
         end_pos_x$field = param1;
      }
      
      public function get endPosX() : int
      {
         return end_pos_x$field;
      }
      
      public function removeEndPosY() : void
      {
         hasField$0 &= 4294967279;
         end_pos_y$field = new int();
      }
      
      public function get hasEndPosY() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set endPosY(param1:int) : void
      {
         hasField$0 |= 16;
         end_pos_y$field = param1;
      }
      
      public function get endPosY() : int
      {
         return end_pos_y$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
         if(hasCurPosX)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,cur_pos_x$field);
         }
         if(hasCurPosY)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,cur_pos_y$field);
         }
         if(hasEndPosX)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,end_pos_x$field);
         }
         if(hasEndPosY)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,end_pos_y$field);
         }
         _loc2_ = 0;
         while(_loc2_ < userIds.length)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,userIds[_loc2_]);
            _loc2_++;
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPosUpdatedMsg.armyId cannot be set twice.");
                  }
                  _loc5_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPosUpdatedMsg.curPosX cannot be set twice.");
                  }
                  _loc6_++;
                  curPosX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPosUpdatedMsg.curPosY cannot be set twice.");
                  }
                  _loc4_++;
                  curPosY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPosUpdatedMsg.endPosX cannot be set twice.");
                  }
                  _loc7_++;
                  endPosX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPosUpdatedMsg.endPosY cannot be set twice.");
                  }
                  _loc3_++;
                  endPosY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,userIds);
                  }
                  else
                  {
                     userIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPosUpdatedMsg.serverName cannot be set twice.");
                  }
                  _loc9_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

