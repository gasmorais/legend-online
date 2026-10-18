package com.road.yishi.proto.gamehall
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GameTeamPlayerMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nickName$field:String;
      
      private var grade$field:int;
      
      private var headId$field:int;
      
      private var consortiaName$field:String;
      
      private var posX$field:int;
      
      private var posY$field:int;
      
      private var state$field:int;
      
      private var isPrepare$field:Boolean;
      
      private var avata$field:GameTeamPlayerAvataMsg;
      
      private var buff$field:String;
      
      public function GameTeamPlayerMsg()
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
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967293;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 2;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4294967291;
         headId$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 4;
         headId$field = param1;
      }
      
      public function get headId() : int
      {
         return headId$field;
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
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967287;
         posX$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 8;
         posX$field = param1;
      }
      
      public function get posX() : int
      {
         return posX$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967279;
         posY$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 16;
         posY$field = param1;
      }
      
      public function get posY() : int
      {
         return posY$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967263;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 32;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeIsPrepare() : void
      {
         hasField$0 &= 4294967231;
         isPrepare$field = new Boolean();
      }
      
      public function get hasIsPrepare() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isPrepare(param1:Boolean) : void
      {
         hasField$0 |= 64;
         isPrepare$field = param1;
      }
      
      public function get isPrepare() : Boolean
      {
         return isPrepare$field;
      }
      
      public function removeAvata() : void
      {
         avata$field = null;
      }
      
      public function get hasAvata() : Boolean
      {
         return avata$field != null;
      }
      
      public function set avata(param1:GameTeamPlayerAvataMsg) : void
      {
         avata$field = param1;
      }
      
      public function get avata() : GameTeamPlayerAvataMsg
      {
         return avata$field;
      }
      
      public function removeBuff() : void
      {
         buff$field = null;
      }
      
      public function get hasBuff() : Boolean
      {
         return buff$field != null;
      }
      
      public function set buff(param1:String) : void
      {
         buff$field = param1;
      }
      
      public function get buff() : String
      {
         return buff$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,headId$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,consortiaName$field);
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,posX$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,posY$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasIsPrepare)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,isPrepare$field);
         }
         if(hasAvata)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_MESSAGE(param1,avata$field);
         }
         if(hasBuff)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,buff$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerMsg.userId cannot be set twice.");
                  }
                  _loc9_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerMsg.nickName cannot be set twice.");
                  }
                  _loc12_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerMsg.grade cannot be set twice.");
                  }
                  _loc6_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerMsg.headId cannot be set twice.");
                  }
                  _loc8_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerMsg.consortiaName cannot be set twice.");
                  }
                  _loc5_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerMsg.posX cannot be set twice.");
                  }
                  _loc3_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerMsg.posY cannot be set twice.");
                  }
                  _loc7_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerMsg.state cannot be set twice.");
                  }
                  _loc13_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerMsg.isPrepare cannot be set twice.");
                  }
                  _loc4_++;
                  isPrepare = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerMsg.avata cannot be set twice.");
                  }
                  _loc10_++;
                  avata = new GameTeamPlayerAvataMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,avata);
                  break;
               case 10:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerMsg.buff cannot be set twice.");
                  }
                  _loc11_++;
                  buff = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

