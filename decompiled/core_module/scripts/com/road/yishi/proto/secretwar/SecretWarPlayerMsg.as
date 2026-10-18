package com.road.yishi.proto.secretwar
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SecretWarPlayerMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var serverName$field:String;
      
      private var nickName$field:String;
      
      private var camp$field:int;
      
      private var state$field:int;
      
      private var curNodeId$field:int;
      
      private var toNodeId$field:int;
      
      private var headId$field:int;
      
      private var job$field:int;
      
      private var cdTime$field:int;
      
      private var fightUserId$field:int;
      
      private var fightNickName$field:String;
      
      private var fightServerName$field:String;
      
      private var moveStep$field:int;
      
      public function SecretWarPlayerMsg()
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
      
      public function removeCamp() : void
      {
         hasField$0 &= 4294967293;
         camp$field = new int();
      }
      
      public function get hasCamp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set camp(param1:int) : void
      {
         hasField$0 |= 2;
         camp$field = param1;
      }
      
      public function get camp() : int
      {
         return camp$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967291;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 4;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeCurNodeId() : void
      {
         hasField$0 &= 4294967287;
         curNodeId$field = new int();
      }
      
      public function get hasCurNodeId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set curNodeId(param1:int) : void
      {
         hasField$0 |= 8;
         curNodeId$field = param1;
      }
      
      public function get curNodeId() : int
      {
         return curNodeId$field;
      }
      
      public function removeToNodeId() : void
      {
         hasField$0 &= 4294967279;
         toNodeId$field = new int();
      }
      
      public function get hasToNodeId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set toNodeId(param1:int) : void
      {
         hasField$0 |= 16;
         toNodeId$field = param1;
      }
      
      public function get toNodeId() : int
      {
         return toNodeId$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4294967263;
         headId$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 32;
         headId$field = param1;
      }
      
      public function get headId() : int
      {
         return headId$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967231;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 64;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeCdTime() : void
      {
         hasField$0 &= 4294967167;
         cdTime$field = new int();
      }
      
      public function get hasCdTime() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set cdTime(param1:int) : void
      {
         hasField$0 |= 128;
         cdTime$field = param1;
      }
      
      public function get cdTime() : int
      {
         return cdTime$field;
      }
      
      public function removeFightUserId() : void
      {
         hasField$0 &= 4294967039;
         fightUserId$field = new int();
      }
      
      public function get hasFightUserId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set fightUserId(param1:int) : void
      {
         hasField$0 |= 256;
         fightUserId$field = param1;
      }
      
      public function get fightUserId() : int
      {
         return fightUserId$field;
      }
      
      public function removeFightNickName() : void
      {
         fightNickName$field = null;
      }
      
      public function get hasFightNickName() : Boolean
      {
         return fightNickName$field != null;
      }
      
      public function set fightNickName(param1:String) : void
      {
         fightNickName$field = param1;
      }
      
      public function get fightNickName() : String
      {
         return fightNickName$field;
      }
      
      public function removeFightServerName() : void
      {
         fightServerName$field = null;
      }
      
      public function get hasFightServerName() : Boolean
      {
         return fightServerName$field != null;
      }
      
      public function set fightServerName(param1:String) : void
      {
         fightServerName$field = param1;
      }
      
      public function get fightServerName() : String
      {
         return fightServerName$field;
      }
      
      public function removeMoveStep() : void
      {
         hasField$0 &= 4294966783;
         moveStep$field = new int();
      }
      
      public function get hasMoveStep() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set moveStep(param1:int) : void
      {
         hasField$0 |= 512;
         moveStep$field = param1;
      }
      
      public function get moveStep() : int
      {
         return moveStep$field;
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
         if(hasCamp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,camp$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasCurNodeId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,curNodeId$field);
         }
         if(hasToNodeId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,toNodeId$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,headId$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasCdTime)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,cdTime$field);
         }
         if(hasFightUserId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,fightUserId$field);
         }
         if(hasFightNickName)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,fightNickName$field);
         }
         if(hasFightServerName)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,fightServerName$field);
         }
         if(hasMoveStep)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,moveStep$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc6_:uint = 0;
         var _loc14_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc15_:uint = 0;
         var _loc4_:uint = 0;
         var _loc16_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarPlayerMsg.userId cannot be set twice.");
                  }
                  _loc9_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarPlayerMsg.serverName cannot be set twice.");
                  }
                  _loc11_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarPlayerMsg.nickName cannot be set twice.");
                  }
                  _loc12_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarPlayerMsg.camp cannot be set twice.");
                  }
                  _loc6_++;
                  camp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarPlayerMsg.state cannot be set twice.");
                  }
                  _loc14_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarPlayerMsg.curNodeId cannot be set twice.");
                  }
                  _loc10_++;
                  curNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarPlayerMsg.toNodeId cannot be set twice.");
                  }
                  _loc3_++;
                  toNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarPlayerMsg.headId cannot be set twice.");
                  }
                  _loc8_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarPlayerMsg.job cannot be set twice.");
                  }
                  _loc13_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarPlayerMsg.cdTime cannot be set twice.");
                  }
                  _loc5_++;
                  cdTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarPlayerMsg.fightUserId cannot be set twice.");
                  }
                  _loc7_++;
                  fightUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarPlayerMsg.fightNickName cannot be set twice.");
                  }
                  _loc15_++;
                  fightNickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarPlayerMsg.fightServerName cannot be set twice.");
                  }
                  _loc4_++;
                  fightServerName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarPlayerMsg.moveStep cannot be set twice.");
                  }
                  _loc16_++;
                  moveStep = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
      }
   }
}

