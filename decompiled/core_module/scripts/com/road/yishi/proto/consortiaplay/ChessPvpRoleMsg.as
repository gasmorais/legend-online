package com.road.yishi.proto.consortiaplay
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChessPvpRoleMsg extends Message implements IExternalizable
   {
      
      private var roleId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var userId$field:int;
      
      private var serverName$field:String;
      
      private var nickName$field:String;
      
      private var team$field:int;
      
      private var currPos$field:int;
      
      private var targetPos$field:int;
      
      private var chessType$field:int;
      
      private var movePassTime$field:int;
      
      private var reiverTime$field:int;
      
      private var reiverCd$field:int;
      
      private var state$field:int;
      
      private var firstMove$field:Boolean;
      
      private var waitCd$field:int;
      
      private var moveTotalTime$field:int;
      
      public function ChessPvpRoleMsg()
      {
         super();
      }
      
      public function removeRoleId() : void
      {
         hasField$0 &= 4294967294;
         roleId$field = new int();
      }
      
      public function get hasRoleId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set roleId(param1:int) : void
      {
         hasField$0 |= 1;
         roleId$field = param1;
      }
      
      public function get roleId() : int
      {
         return roleId$field;
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
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removeTeam() : void
      {
         hasField$0 &= 4294967291;
         team$field = new int();
      }
      
      public function get hasTeam() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set team(param1:int) : void
      {
         hasField$0 |= 4;
         team$field = param1;
      }
      
      public function get team() : int
      {
         return team$field;
      }
      
      public function removeCurrPos() : void
      {
         hasField$0 &= 4294967287;
         currPos$field = new int();
      }
      
      public function get hasCurrPos() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set currPos(param1:int) : void
      {
         hasField$0 |= 8;
         currPos$field = param1;
      }
      
      public function get currPos() : int
      {
         return currPos$field;
      }
      
      public function removeTargetPos() : void
      {
         hasField$0 &= 4294967279;
         targetPos$field = new int();
      }
      
      public function get hasTargetPos() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set targetPos(param1:int) : void
      {
         hasField$0 |= 16;
         targetPos$field = param1;
      }
      
      public function get targetPos() : int
      {
         return targetPos$field;
      }
      
      public function removeChessType() : void
      {
         hasField$0 &= 4294967263;
         chessType$field = new int();
      }
      
      public function get hasChessType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set chessType(param1:int) : void
      {
         hasField$0 |= 32;
         chessType$field = param1;
      }
      
      public function get chessType() : int
      {
         return chessType$field;
      }
      
      public function removeMovePassTime() : void
      {
         hasField$0 &= 4294967231;
         movePassTime$field = new int();
      }
      
      public function get hasMovePassTime() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set movePassTime(param1:int) : void
      {
         hasField$0 |= 64;
         movePassTime$field = param1;
      }
      
      public function get movePassTime() : int
      {
         return movePassTime$field;
      }
      
      public function removeReiverTime() : void
      {
         hasField$0 &= 4294967167;
         reiverTime$field = new int();
      }
      
      public function get hasReiverTime() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set reiverTime(param1:int) : void
      {
         hasField$0 |= 128;
         reiverTime$field = param1;
      }
      
      public function get reiverTime() : int
      {
         return reiverTime$field;
      }
      
      public function removeReiverCd() : void
      {
         hasField$0 &= 4294967039;
         reiverCd$field = new int();
      }
      
      public function get hasReiverCd() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set reiverCd(param1:int) : void
      {
         hasField$0 |= 256;
         reiverCd$field = param1;
      }
      
      public function get reiverCd() : int
      {
         return reiverCd$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294966783;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 512;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeFirstMove() : void
      {
         hasField$0 &= 4294966271;
         firstMove$field = new Boolean();
      }
      
      public function get hasFirstMove() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set firstMove(param1:Boolean) : void
      {
         hasField$0 |= 1024;
         firstMove$field = param1;
      }
      
      public function get firstMove() : Boolean
      {
         return firstMove$field;
      }
      
      public function removeWaitCd() : void
      {
         hasField$0 &= 4294965247;
         waitCd$field = new int();
      }
      
      public function get hasWaitCd() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set waitCd(param1:int) : void
      {
         hasField$0 |= 2048;
         waitCd$field = param1;
      }
      
      public function get waitCd() : int
      {
         return waitCd$field;
      }
      
      public function removeMoveTotalTime() : void
      {
         hasField$0 &= 4294963199;
         moveTotalTime$field = new int();
      }
      
      public function get hasMoveTotalTime() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set moveTotalTime(param1:int) : void
      {
         hasField$0 |= 4096;
         moveTotalTime$field = param1;
      }
      
      public function get moveTotalTime() : int
      {
         return moveTotalTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRoleId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,roleId$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasTeam)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,team$field);
         }
         if(hasCurrPos)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,currPos$field);
         }
         if(hasTargetPos)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,targetPos$field);
         }
         if(hasChessType)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,chessType$field);
         }
         if(hasMovePassTime)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,movePassTime$field);
         }
         if(hasReiverTime)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,reiverTime$field);
         }
         if(hasReiverCd)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,reiverCd$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasFirstMove)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_BOOL(param1,firstMove$field);
         }
         if(hasWaitCd)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,waitCd$field);
         }
         if(hasMoveTotalTime)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,moveTotalTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc15_:* = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc12_:uint = 0;
         var _loc16_:uint = 0;
         var _loc3_:uint = 0;
         var _loc17_:uint = 0;
         var _loc8_:uint = 0;
         var _loc18_:uint = 0;
         var _loc4_:uint = 0;
         var _loc14_:uint = 0;
         var _loc13_:uint = 0;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc15_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRoleMsg.roleId cannot be set twice.");
                  }
                  _loc6_++;
                  roleId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRoleMsg.userId cannot be set twice.");
                  }
                  _loc9_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRoleMsg.serverName cannot be set twice.");
                  }
                  _loc10_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRoleMsg.nickName cannot be set twice.");
                  }
                  _loc12_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRoleMsg.team cannot be set twice.");
                  }
                  _loc16_++;
                  team = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRoleMsg.currPos cannot be set twice.");
                  }
                  _loc3_++;
                  currPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRoleMsg.targetPos cannot be set twice.");
                  }
                  _loc17_++;
                  targetPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRoleMsg.chessType cannot be set twice.");
                  }
                  _loc8_++;
                  chessType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRoleMsg.movePassTime cannot be set twice.");
                  }
                  _loc18_++;
                  movePassTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRoleMsg.reiverTime cannot be set twice.");
                  }
                  _loc4_++;
                  reiverTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRoleMsg.reiverCd cannot be set twice.");
                  }
                  _loc14_++;
                  reiverCd = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRoleMsg.state cannot be set twice.");
                  }
                  _loc13_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRoleMsg.firstMove cannot be set twice.");
                  }
                  _loc7_++;
                  firstMove = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 13:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRoleMsg.waitCd cannot be set twice.");
                  }
                  _loc11_++;
                  waitCd = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRoleMsg.moveTotalTime cannot be set twice.");
                  }
                  _loc5_++;
                  moveTotalTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc15_ & 7);
            }
         }
      }
   }
}

