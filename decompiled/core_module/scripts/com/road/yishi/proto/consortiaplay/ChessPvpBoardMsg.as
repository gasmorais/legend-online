package com.road.yishi.proto.consortiaplay
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChessPvpBoardMsg extends Message implements IExternalizable
   {
      
      private var boardUid$field:String;
      
      private var currTime$field:String;
      
      private var endTime$field:String;
      
      [ArrayElementType("com.road.yishi.proto.consortiaplay.ChessPvpTeamMsg")]
      public var teams:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.consortiaplay.ChessPvpBoxMsg")]
      public var boxes:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.consortiaplay.ChessPvpRoleMsg")]
      public var roles:Array = [];
      
      public function ChessPvpBoardMsg()
      {
         super();
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
      
      public function removeCurrTime() : void
      {
         currTime$field = null;
      }
      
      public function get hasCurrTime() : Boolean
      {
         return currTime$field != null;
      }
      
      public function set currTime(param1:String) : void
      {
         currTime$field = param1;
      }
      
      public function get currTime() : String
      {
         return currTime$field;
      }
      
      public function removeEndTime() : void
      {
         endTime$field = null;
      }
      
      public function get hasEndTime() : Boolean
      {
         return endTime$field != null;
      }
      
      public function set endTime(param1:String) : void
      {
         endTime$field = param1;
      }
      
      public function get endTime() : String
      {
         return endTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         if(hasBoardUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,boardUid$field);
         }
         if(hasCurrTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,currTime$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,endTime$field);
         }
         _loc3_ = 0;
         while(_loc3_ < teams.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,teams[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < boxes.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,boxes[_loc2_]);
            _loc2_++;
         }
         _loc4_ = 0;
         while(_loc4_ < roles.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,roles[_loc4_]);
            _loc4_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc5_:ChessPvpTeamMsg = null;
         var _loc6_:ChessPvpBoxMsg = null;
         var _loc8_:ChessPvpRoleMsg = null;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpBoardMsg.boardUid cannot be set twice.");
                  }
                  _loc4_++;
                  boardUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpBoardMsg.currTime cannot be set twice.");
                  }
                  _loc7_++;
                  currTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpBoardMsg.endTime cannot be set twice.");
                  }
                  _loc3_++;
                  endTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  _loc5_ = new ChessPvpTeamMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  teams.push(_loc5_);
                  break;
               case 4:
                  _loc6_ = new ChessPvpBoxMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  boxes.push(_loc6_);
                  break;
               case 5:
                  _loc8_ = new ChessPvpRoleMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  roles.push(_loc8_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

