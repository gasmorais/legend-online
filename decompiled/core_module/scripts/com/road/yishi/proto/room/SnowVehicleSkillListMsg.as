package com.road.yishi.proto.room
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SnowVehicleSkillListMsg extends Message implements IExternalizable
   {
      
      private var skillIdW$field:int;
      
      private var hasField$0:uint = 0;
      
      private var stateW$field:int;
      
      private var curSumW$field:int;
      
      private var skillIdE$field:int;
      
      private var stateE$field:int;
      
      private var curSumE$field:int;
      
      private var playerId$field:int;
      
      private var serverName$field:String;
      
      public function SnowVehicleSkillListMsg()
      {
         super();
      }
      
      public function removeSkillIdW() : void
      {
         hasField$0 &= 4294967294;
         skillIdW$field = new int();
      }
      
      public function get hasSkillIdW() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set skillIdW(param1:int) : void
      {
         hasField$0 |= 1;
         skillIdW$field = param1;
      }
      
      public function get skillIdW() : int
      {
         return skillIdW$field;
      }
      
      public function removeStateW() : void
      {
         hasField$0 &= 4294967293;
         stateW$field = new int();
      }
      
      public function get hasStateW() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set stateW(param1:int) : void
      {
         hasField$0 |= 2;
         stateW$field = param1;
      }
      
      public function get stateW() : int
      {
         return stateW$field;
      }
      
      public function removeCurSumW() : void
      {
         hasField$0 &= 4294967291;
         curSumW$field = new int();
      }
      
      public function get hasCurSumW() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set curSumW(param1:int) : void
      {
         hasField$0 |= 4;
         curSumW$field = param1;
      }
      
      public function get curSumW() : int
      {
         return curSumW$field;
      }
      
      public function removeSkillIdE() : void
      {
         hasField$0 &= 4294967287;
         skillIdE$field = new int();
      }
      
      public function get hasSkillIdE() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set skillIdE(param1:int) : void
      {
         hasField$0 |= 8;
         skillIdE$field = param1;
      }
      
      public function get skillIdE() : int
      {
         return skillIdE$field;
      }
      
      public function removeStateE() : void
      {
         hasField$0 &= 4294967279;
         stateE$field = new int();
      }
      
      public function get hasStateE() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set stateE(param1:int) : void
      {
         hasField$0 |= 16;
         stateE$field = param1;
      }
      
      public function get stateE() : int
      {
         return stateE$field;
      }
      
      public function removeCurSumE() : void
      {
         hasField$0 &= 4294967263;
         curSumE$field = new int();
      }
      
      public function get hasCurSumE() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set curSumE(param1:int) : void
      {
         hasField$0 |= 32;
         curSumE$field = param1;
      }
      
      public function get curSumE() : int
      {
         return curSumE$field;
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967231;
         playerId$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 64;
         playerId$field = param1;
      }
      
      public function get playerId() : int
      {
         return playerId$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSkillIdW)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,skillIdW$field);
         }
         if(hasStateW)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,stateW$field);
         }
         if(hasCurSumW)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,curSumW$field);
         }
         if(hasSkillIdE)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,skillIdE$field);
         }
         if(hasStateE)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,stateE$field);
         }
         if(hasCurSumE)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,curSumE$field);
         }
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,playerId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleSkillListMsg.skillIdW cannot be set twice.");
                  }
                  _loc3_++;
                  skillIdW = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleSkillListMsg.stateW cannot be set twice.");
                  }
                  _loc11_++;
                  stateW = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleSkillListMsg.curSumW cannot be set twice.");
                  }
                  _loc9_++;
                  curSumW = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleSkillListMsg.skillIdE cannot be set twice.");
                  }
                  _loc6_++;
                  skillIdE = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleSkillListMsg.stateE cannot be set twice.");
                  }
                  _loc4_++;
                  stateE = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleSkillListMsg.curSumE cannot be set twice.");
                  }
                  _loc8_++;
                  curSumE = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleSkillListMsg.playerId cannot be set twice.");
                  }
                  _loc7_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleSkillListMsg.serverName cannot be set twice.");
                  }
                  _loc5_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

