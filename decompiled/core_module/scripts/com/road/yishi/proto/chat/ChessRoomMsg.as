package com.road.yishi.proto.chat
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChessRoomMsg extends Message implements IExternalizable
   {
      
      private var roomUuid$field:String;
      
      private var round$field:int;
      
      private var hasField$0:uint = 0;
      
      private var state$field:int;
      
      private var op$field:int;
      
      [ArrayElementType("com.road.yishi.proto.chat.SelfChessPlayerMsg")]
      public var playerList:Array = [];
      
      public function ChessRoomMsg()
      {
         super();
      }
      
      public function removeRoomUuid() : void
      {
         roomUuid$field = null;
      }
      
      public function get hasRoomUuid() : Boolean
      {
         return roomUuid$field != null;
      }
      
      public function set roomUuid(param1:String) : void
      {
         roomUuid$field = param1;
      }
      
      public function get roomUuid() : String
      {
         return roomUuid$field;
      }
      
      public function removeRound() : void
      {
         hasField$0 &= 4294967294;
         round$field = new int();
      }
      
      public function get hasRound() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set round(param1:int) : void
      {
         hasField$0 |= 1;
         round$field = param1;
      }
      
      public function get round() : int
      {
         return round$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967293;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 2;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967291;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 4;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasRoomUuid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,roomUuid$field);
         }
         if(hasRound)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,round$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         _loc2_ = 0;
         while(_loc2_ < playerList.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,playerList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc8_:SelfChessPlayerMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChessRoomMsg.roomUuid cannot be set twice.");
                  }
                  _loc3_++;
                  roomUuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChessRoomMsg.round cannot be set twice.");
                  }
                  _loc4_++;
                  round = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChessRoomMsg.state cannot be set twice.");
                  }
                  _loc5_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChessRoomMsg.op cannot be set twice.");
                  }
                  _loc7_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc8_ = new SelfChessPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  playerList.push(_loc8_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

