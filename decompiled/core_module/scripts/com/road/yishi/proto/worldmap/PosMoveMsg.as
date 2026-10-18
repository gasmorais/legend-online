package com.road.yishi.proto.worldmap
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PosMoveMsg extends Message implements IExternalizable
   {
      
      private var map_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var army_id$field:int;
      
      [ArrayElementType("com.road.yishi.proto.worldmap.RouteMsg")]
      public var routes:Array = [];
      
      private var grid_str$field:String;
      
      [ArrayElementType("int")]
      public var userId:Array = [];
      
      private var server_name$field:String;
      
      [ArrayElementType("com.road.yishi.proto.worldmap.RouteStateMsg")]
      public var userStates:Array = [];
      
      private var army_state$field:int;
      
      public function PosMoveMsg()
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
      
      public function removeGridStr() : void
      {
         grid_str$field = null;
      }
      
      public function get hasGridStr() : Boolean
      {
         return grid_str$field != null;
      }
      
      public function set gridStr(param1:String) : void
      {
         grid_str$field = param1;
      }
      
      public function get gridStr() : String
      {
         return grid_str$field;
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
      
      public function removeArmyState() : void
      {
         hasField$0 &= 4294967291;
         army_state$field = new int();
      }
      
      public function get hasArmyState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set armyState(param1:int) : void
      {
         hasField$0 |= 4;
         army_state$field = param1;
      }
      
      public function get armyState() : int
      {
         return army_state$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,map_id$field);
         }
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < routes.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,routes[_loc2_]);
            _loc2_++;
         }
         if(hasGridStr)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,grid_str$field);
         }
         _loc3_ = 0;
         while(_loc3_ < userId.length)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,userId[_loc3_]);
            _loc3_++;
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         _loc4_ = 0;
         while(_loc4_ < userStates.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,userStates[_loc4_]);
            _loc4_++;
         }
         if(hasArmyState)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,army_state$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:RouteMsg = null;
         var _loc10_:RouteStateMsg = null;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PosMoveMsg.mapId cannot be set twice.");
                  }
                  _loc7_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PosMoveMsg.armyId cannot be set twice.");
                  }
                  _loc4_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc6_ = new RouteMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  routes.push(_loc6_);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PosMoveMsg.gridStr cannot be set twice.");
                  }
                  _loc5_++;
                  gridStr = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,userId);
                  }
                  else
                  {
                     userId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PosMoveMsg.serverName cannot be set twice.");
                  }
                  _loc9_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  _loc10_ = new RouteStateMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  userStates.push(_loc10_);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PosMoveMsg.armyState cannot be set twice.");
                  }
                  _loc3_++;
                  armyState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

