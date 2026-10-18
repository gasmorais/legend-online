package com.road.yishi.proto.unrealshooting
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class UnrealShootingMsg extends Message implements IExternalizable
   {
      
      private var gameState$field:int;
      
      private var hasField$0:uint = 0;
      
      private var leftTime$field:int;
      
      private var score$field:int;
      
      private var week_score$field:int;
      
      private var enterCount$field:int;
      
      [ArrayElementType("com.road.yishi.proto.unrealshooting.UnrealShootingPlayerMsg")]
      public var list:Array = [];
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      private var param3$field:String;
      
      private var param4$field:String;
      
      private var server_name$field:String;
      
      private var user_id$field:int;
      
      public function UnrealShootingMsg()
      {
         super();
      }
      
      public function removeGameState() : void
      {
         hasField$0 &= 4294967294;
         gameState$field = new int();
      }
      
      public function get hasGameState() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set gameState(param1:int) : void
      {
         hasField$0 |= 1;
         gameState$field = param1;
      }
      
      public function get gameState() : int
      {
         return gameState$field;
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967293;
         leftTime$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 2;
         leftTime$field = param1;
      }
      
      public function get leftTime() : int
      {
         return leftTime$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967291;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 4;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeWeekScore() : void
      {
         hasField$0 &= 4294967287;
         week_score$field = new int();
      }
      
      public function get hasWeekScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set weekScore(param1:int) : void
      {
         hasField$0 |= 8;
         week_score$field = param1;
      }
      
      public function get weekScore() : int
      {
         return week_score$field;
      }
      
      public function removeEnterCount() : void
      {
         hasField$0 &= 4294967279;
         enterCount$field = new int();
      }
      
      public function get hasEnterCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set enterCount(param1:int) : void
      {
         hasField$0 |= 16;
         enterCount$field = param1;
      }
      
      public function get enterCount() : int
      {
         return enterCount$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967263;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 32;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967231;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 64;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         param3$field = null;
      }
      
      public function get hasParam3() : Boolean
      {
         return param3$field != null;
      }
      
      public function set param3(param1:String) : void
      {
         param3$field = param1;
      }
      
      public function get param3() : String
      {
         return param3$field;
      }
      
      public function removeParam4() : void
      {
         param4$field = null;
      }
      
      public function get hasParam4() : Boolean
      {
         return param4$field != null;
      }
      
      public function set param4(param1:String) : void
      {
         param4$field = param1;
      }
      
      public function get param4() : String
      {
         return param4$field;
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
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967167;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 128;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasGameState)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,gameState$field);
         }
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,leftTime$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasWeekScore)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,week_score$field);
         }
         if(hasEnterCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,enterCount$field);
         }
         _loc2_ = 0;
         while(_loc2_ < list.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,list[_loc2_]);
            _loc2_++;
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,param3$field);
         }
         if(hasParam4)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,param4$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc11_:UnrealShootingPlayerMsg = null;
         var _loc9_:uint = 0;
         var _loc14_:uint = 0;
         var _loc13_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc15_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingMsg.gameState cannot be set twice.");
                  }
                  _loc9_++;
                  gameState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingMsg.leftTime cannot be set twice.");
                  }
                  _loc14_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingMsg.score cannot be set twice.");
                  }
                  _loc13_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingMsg.weekScore cannot be set twice.");
                  }
                  _loc3_++;
                  weekScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingMsg.enterCount cannot be set twice.");
                  }
                  _loc4_++;
                  enterCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  _loc11_ = new UnrealShootingPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  list.push(_loc11_);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingMsg.param1 cannot be set twice.");
                  }
                  _loc5_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingMsg.param2 cannot be set twice.");
                  }
                  _loc15_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingMsg.param3 cannot be set twice.");
                  }
                  _loc6_++;
                  param3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingMsg.param4 cannot be set twice.");
                  }
                  _loc8_++;
                  param4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingMsg.serverName cannot be set twice.");
                  }
                  _loc7_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingMsg.userId cannot be set twice.");
                  }
                  _loc10_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

