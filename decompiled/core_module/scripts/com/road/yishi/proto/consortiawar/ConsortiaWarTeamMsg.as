package com.road.yishi.proto.consortiawar
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaWarTeamMsg extends Message implements IExternalizable
   {
      
      private var consortiaName$field:String;
      
      private var serverName$field:String;
      
      private var blood$field:int;
      
      private var hasField$0:uint = 0;
      
      private var maxBlood$field:int;
      
      private var defendBufferId$field:int;
      
      [ArrayElementType("com.road.yishi.proto.consortiawar.ConsortiaWarTowerMsg")]
      public var towerList:Array = [];
      
      public function ConsortiaWarTeamMsg()
      {
         super();
      }
      
      public function removeConsortiaName() : void
      {
         consortiaName$field = null;
      }
      
      public function get hasConsortiaName() : Boolean
      {
         return consortiaName$field != null;
      }
      
      public function set consortiaName(param1:String) : void
      {
         consortiaName$field = param1;
      }
      
      public function get consortiaName() : String
      {
         return consortiaName$field;
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
      
      public function removeBlood() : void
      {
         hasField$0 &= 4294967294;
         blood$field = new int();
      }
      
      public function get hasBlood() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set blood(param1:int) : void
      {
         hasField$0 |= 1;
         blood$field = param1;
      }
      
      public function get blood() : int
      {
         return blood$field;
      }
      
      public function removeMaxBlood() : void
      {
         hasField$0 &= 4294967293;
         maxBlood$field = new int();
      }
      
      public function get hasMaxBlood() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set maxBlood(param1:int) : void
      {
         hasField$0 |= 2;
         maxBlood$field = param1;
      }
      
      public function get maxBlood() : int
      {
         return maxBlood$field;
      }
      
      public function removeDefendBufferId() : void
      {
         hasField$0 &= 4294967291;
         defendBufferId$field = new int();
      }
      
      public function get hasDefendBufferId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set defendBufferId(param1:int) : void
      {
         hasField$0 |= 4;
         defendBufferId$field = param1;
      }
      
      public function get defendBufferId() : int
      {
         return defendBufferId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,consortiaName$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasBlood)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,blood$field);
         }
         if(hasMaxBlood)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,maxBlood$field);
         }
         if(hasDefendBufferId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,defendBufferId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < towerList.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,towerList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:ConsortiaWarTowerMsg = null;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarTeamMsg.consortiaName cannot be set twice.");
                  }
                  _loc5_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarTeamMsg.serverName cannot be set twice.");
                  }
                  _loc4_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarTeamMsg.blood cannot be set twice.");
                  }
                  _loc8_++;
                  blood = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarTeamMsg.maxBlood cannot be set twice.");
                  }
                  _loc9_++;
                  maxBlood = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarTeamMsg.defendBufferId cannot be set twice.");
                  }
                  _loc3_++;
                  defendBufferId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  _loc6_ = new ConsortiaWarTowerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  towerList.push(_loc6_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

