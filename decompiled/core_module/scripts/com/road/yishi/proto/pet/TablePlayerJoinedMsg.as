package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TablePlayerJoinedMsg extends Message implements IExternalizable
   {
      
      private var table_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var big_blind$field:int;
      
      private var players$field:TablePlayerListMsg;
      
      private var joined_player$field:TablePlayerMsg;
      
      public function TablePlayerJoinedMsg()
      {
         super();
      }
      
      public function removeTableType() : void
      {
         hasField$0 &= 4294967294;
         table_type$field = new int();
      }
      
      public function get hasTableType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set tableType(param1:int) : void
      {
         hasField$0 |= 1;
         table_type$field = param1;
      }
      
      public function get tableType() : int
      {
         return table_type$field;
      }
      
      public function removeBigBlind() : void
      {
         hasField$0 &= 4294967293;
         big_blind$field = new int();
      }
      
      public function get hasBigBlind() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set bigBlind(param1:int) : void
      {
         hasField$0 |= 2;
         big_blind$field = param1;
      }
      
      public function get bigBlind() : int
      {
         return big_blind$field;
      }
      
      public function removePlayers() : void
      {
         players$field = null;
      }
      
      public function get hasPlayers() : Boolean
      {
         return players$field != null;
      }
      
      public function set players(param1:TablePlayerListMsg) : void
      {
         players$field = param1;
      }
      
      public function get players() : TablePlayerListMsg
      {
         return players$field;
      }
      
      public function removeJoinedPlayer() : void
      {
         joined_player$field = null;
      }
      
      public function get hasJoinedPlayer() : Boolean
      {
         return joined_player$field != null;
      }
      
      public function set joinedPlayer(param1:TablePlayerMsg) : void
      {
         joined_player$field = param1;
      }
      
      public function get joinedPlayer() : TablePlayerMsg
      {
         return joined_player$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTableType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,table_type$field);
         }
         if(hasBigBlind)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,big_blind$field);
         }
         if(hasPlayers)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,players$field);
         }
         if(hasJoinedPlayer)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,joined_player$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TablePlayerJoinedMsg.tableType cannot be set twice.");
                  }
                  _loc4_++;
                  tableType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TablePlayerJoinedMsg.bigBlind cannot be set twice.");
                  }
                  _loc5_++;
                  bigBlind = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TablePlayerJoinedMsg.players cannot be set twice.");
                  }
                  _loc3_++;
                  players = new TablePlayerListMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,players);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TablePlayerJoinedMsg.joinedPlayer cannot be set twice.");
                  }
                  _loc7_++;
                  joinedPlayer = new TablePlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,joinedPlayer);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

