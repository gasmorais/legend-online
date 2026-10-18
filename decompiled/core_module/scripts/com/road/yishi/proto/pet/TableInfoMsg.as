package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TableInfoMsg extends Message implements IExternalizable
   {
      
      private var table_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var big_blind$field:int;
      
      private var players$field:TablePlayerListMsg;
      
      private var active_players$field:TablePlayerListMsg;
      
      private var board$field:TableBoardMsg;
      
      private var dealer_position$field:int;
      
      private var actor$field:TablePlayerMsg;
      
      public function TableInfoMsg()
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
      
      public function removeActivePlayers() : void
      {
         active_players$field = null;
      }
      
      public function get hasActivePlayers() : Boolean
      {
         return active_players$field != null;
      }
      
      public function set activePlayers(param1:TablePlayerListMsg) : void
      {
         active_players$field = param1;
      }
      
      public function get activePlayers() : TablePlayerListMsg
      {
         return active_players$field;
      }
      
      public function removeBoard() : void
      {
         board$field = null;
      }
      
      public function get hasBoard() : Boolean
      {
         return board$field != null;
      }
      
      public function set board(param1:TableBoardMsg) : void
      {
         board$field = param1;
      }
      
      public function get board() : TableBoardMsg
      {
         return board$field;
      }
      
      public function removeDealerPosition() : void
      {
         hasField$0 &= 4294967291;
         dealer_position$field = new int();
      }
      
      public function get hasDealerPosition() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set dealerPosition(param1:int) : void
      {
         hasField$0 |= 4;
         dealer_position$field = param1;
      }
      
      public function get dealerPosition() : int
      {
         return dealer_position$field;
      }
      
      public function removeActor() : void
      {
         actor$field = null;
      }
      
      public function get hasActor() : Boolean
      {
         return actor$field != null;
      }
      
      public function set actor(param1:TablePlayerMsg) : void
      {
         actor$field = param1;
      }
      
      public function get actor() : TablePlayerMsg
      {
         return actor$field;
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
         if(hasActivePlayers)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,active_players$field);
         }
         if(hasBoard)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,board$field);
         }
         if(hasDealerPosition)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,dealer_position$field);
         }
         if(hasActor)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,actor$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TableInfoMsg.tableType cannot be set twice.");
                  }
                  _loc6_++;
                  tableType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TableInfoMsg.bigBlind cannot be set twice.");
                  }
                  _loc7_++;
                  bigBlind = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TableInfoMsg.players cannot be set twice.");
                  }
                  _loc5_++;
                  players = new TablePlayerListMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,players);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TableInfoMsg.activePlayers cannot be set twice.");
                  }
                  _loc4_++;
                  activePlayers = new TablePlayerListMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,activePlayers);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TableInfoMsg.board cannot be set twice.");
                  }
                  _loc9_++;
                  board = new TableBoardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,board);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TableInfoMsg.dealerPosition cannot be set twice.");
                  }
                  _loc3_++;
                  dealerPosition = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TableInfoMsg.actor cannot be set twice.");
                  }
                  _loc10_++;
                  actor = new TablePlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,actor);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

