package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CampaignExitMsg extends Message implements IExternalizable
   {
      
      private var result$field:int;
      
      private var hasField$0:uint = 0;
      
      private var player_id$field:int;
      
      private var army_id$field:int;
      
      private var server_name$field:String;
      
      public function CampaignExitMsg()
      {
         super();
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967294;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 1;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967293;
         player_id$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 2;
         player_id$field = param1;
      }
      
      public function get playerId() : int
      {
         return player_id$field;
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294967291;
         army_id$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 4;
         army_id$field = param1;
      }
      
      public function get armyId() : int
      {
         return army_id$field;
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
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,player_id$field);
         }
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignExitMsg.result cannot be set twice.");
                  }
                  _loc5_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignExitMsg.playerId cannot be set twice.");
                  }
                  _loc3_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignExitMsg.armyId cannot be set twice.");
                  }
                  _loc4_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignExitMsg.serverName cannot be set twice.");
                  }
                  _loc7_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

