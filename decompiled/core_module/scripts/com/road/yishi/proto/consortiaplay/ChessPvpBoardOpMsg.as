package com.road.yishi.proto.consortiaplay
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChessPvpBoardOpMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var boardUid$field:String;
      
      private var userId$field:int;
      
      private var serverName$field:String;
      
      private var targePos$field:int;
      
      private var chessType$field:int;
      
      public function ChessPvpBoardOpMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeBoardUid() : void
      {
         boardUid$field = null;
      }
      
      public function get hasBoardUid() : Boolean
      {
         return boardUid$field != null;
      }
      
      public function set boardUid(param1:String) : void
      {
         boardUid$field = param1;
      }
      
      public function get boardUid() : String
      {
         return boardUid$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
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
      
      public function removeTargePos() : void
      {
         hasField$0 &= 4294967291;
         targePos$field = new int();
      }
      
      public function get hasTargePos() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set targePos(param1:int) : void
      {
         hasField$0 |= 4;
         targePos$field = param1;
      }
      
      public function get targePos() : int
      {
         return targePos$field;
      }
      
      public function removeChessType() : void
      {
         hasField$0 &= 4294967287;
         chessType$field = new int();
      }
      
      public function get hasChessType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set chessType(param1:int) : void
      {
         hasField$0 |= 8;
         chessType$field = param1;
      }
      
      public function get chessType() : int
      {
         return chessType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasBoardUid)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,boardUid$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasTargePos)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,targePos$field);
         }
         if(hasChessType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,chessType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpBoardOpMsg.op cannot be set twice.");
                  }
                  _loc9_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpBoardOpMsg.boardUid cannot be set twice.");
                  }
                  _loc4_++;
                  boardUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpBoardOpMsg.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpBoardOpMsg.serverName cannot be set twice.");
                  }
                  _loc3_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpBoardOpMsg.targePos cannot be set twice.");
                  }
                  _loc5_++;
                  targePos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpBoardOpMsg.chessType cannot be set twice.");
                  }
                  _loc6_++;
                  chessType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

