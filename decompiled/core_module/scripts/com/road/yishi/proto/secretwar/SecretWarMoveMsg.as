package com.road.yishi.proto.secretwar
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SecretWarMoveMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var serverName$field:String;
      
      private var nickName$field:String;
      
      private var curNodeId$field:int;
      
      private var toNodeId$field:int;
      
      private var moveStep$field:int;
      
      private var headId$field:int;
      
      public function SecretWarMoveMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
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
      
      public function removeCurNodeId() : void
      {
         hasField$0 &= 4294967293;
         curNodeId$field = new int();
      }
      
      public function get hasCurNodeId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set curNodeId(param1:int) : void
      {
         hasField$0 |= 2;
         curNodeId$field = param1;
      }
      
      public function get curNodeId() : int
      {
         return curNodeId$field;
      }
      
      public function removeToNodeId() : void
      {
         hasField$0 &= 4294967291;
         toNodeId$field = new int();
      }
      
      public function get hasToNodeId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set toNodeId(param1:int) : void
      {
         hasField$0 |= 4;
         toNodeId$field = param1;
      }
      
      public function get toNodeId() : int
      {
         return toNodeId$field;
      }
      
      public function removeMoveStep() : void
      {
         hasField$0 &= 4294967287;
         moveStep$field = new int();
      }
      
      public function get hasMoveStep() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set moveStep(param1:int) : void
      {
         hasField$0 |= 8;
         moveStep$field = param1;
      }
      
      public function get moveStep() : int
      {
         return moveStep$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4294967279;
         headId$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 16;
         headId$field = param1;
      }
      
      public function get headId() : int
      {
         return headId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasCurNodeId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,curNodeId$field);
         }
         if(hasToNodeId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,toNodeId$field);
         }
         if(hasMoveStep)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,moveStep$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,headId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarMoveMsg.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarMoveMsg.serverName cannot be set twice.");
                  }
                  _loc4_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarMoveMsg.nickName cannot be set twice.");
                  }
                  _loc5_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarMoveMsg.curNodeId cannot be set twice.");
                  }
                  _loc10_++;
                  curNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarMoveMsg.toNodeId cannot be set twice.");
                  }
                  _loc3_++;
                  toNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarMoveMsg.moveStep cannot be set twice.");
                  }
                  _loc8_++;
                  moveStep = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarMoveMsg.headId cannot be set twice.");
                  }
                  _loc6_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

