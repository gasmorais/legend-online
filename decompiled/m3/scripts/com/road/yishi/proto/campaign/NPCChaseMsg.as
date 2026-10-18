package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class NPCChaseMsg extends Message implements IExternalizable
   {
      
      private var node_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var army_id$field:int;
      
      private var cur_pos_x$field:int;
      
      private var cur_pos_y$field:int;
      
      private var server_name$field:String;
      
      public function NPCChaseMsg()
      {
         super();
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967294;
         node_id$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 1;
         node_id$field = param1;
      }
      
      public function get nodeId() : int
      {
         return node_id$field;
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294967293;
         army_id$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 2;
         army_id$field = param1;
      }
      
      public function get armyId() : int
      {
         return army_id$field;
      }
      
      public function removeCurPosX() : void
      {
         hasField$0 &= 4294967291;
         cur_pos_x$field = new int();
      }
      
      public function get hasCurPosX() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set curPosX(param1:int) : void
      {
         hasField$0 |= 4;
         cur_pos_x$field = param1;
      }
      
      public function get curPosX() : int
      {
         return cur_pos_x$field;
      }
      
      public function removeCurPosY() : void
      {
         hasField$0 &= 4294967287;
         cur_pos_y$field = new int();
      }
      
      public function get hasCurPosY() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set curPosY(param1:int) : void
      {
         hasField$0 |= 8;
         cur_pos_y$field = param1;
      }
      
      public function get curPosY() : int
      {
         return cur_pos_y$field;
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
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,node_id$field);
         }
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
         if(hasCurPosX)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,cur_pos_x$field);
         }
         if(hasCurPosY)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,cur_pos_y$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: NPCChaseMsg.nodeId cannot be set twice.");
                  }
                  _loc6_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: NPCChaseMsg.armyId cannot be set twice.");
                  }
                  _loc4_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: NPCChaseMsg.curPosX cannot be set twice.");
                  }
                  _loc5_++;
                  curPosX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: NPCChaseMsg.curPosY cannot be set twice.");
                  }
                  _loc3_++;
                  curPosY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: NPCChaseMsg.serverName cannot be set twice.");
                  }
                  _loc8_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

