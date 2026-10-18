package com.road.yishi.proto.dungeon
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DungeonMsg extends Message implements IExternalizable
   {
      
      public var op:int;
      
      private var score$field:int;
      
      private var hasField$0:uint = 0;
      
      private var week_score$field:int;
      
      [ArrayElementType("Boolean")]
      public var scoreBoxState:Array = [];
      
      private var treasure_count$field:int;
      
      private var event_left$field:int;
      
      private var step_left$field:int;
      
      private var revive_left$field:int;
      
      private var dungeon_type$field:int;
      
      private var dungeon_process$field:int;
      
      private var dead$field:Boolean;
      
      private var has_next$field:Boolean;
      
      private var paralysis_time$field:Int64;
      
      private var event_info$field:DungeonEventMsg;
      
      [ArrayElementType("int")]
      public var itemFly:Array = [];
      
      private var pos_x$field:int;
      
      private var pos_y$field:int;
      
      private var order_score$field:int;
      
      private var current_order$field:int;
      
      private var next_event_count$field:int;
      
      public function DungeonMsg()
      {
         super();
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967294;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 1;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeWeekScore() : void
      {
         hasField$0 &= 4294967293;
         week_score$field = new int();
      }
      
      public function get hasWeekScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set weekScore(param1:int) : void
      {
         hasField$0 |= 2;
         week_score$field = param1;
      }
      
      public function get weekScore() : int
      {
         return week_score$field;
      }
      
      public function removeTreasureCount() : void
      {
         hasField$0 &= 4294967291;
         treasure_count$field = new int();
      }
      
      public function get hasTreasureCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set treasureCount(param1:int) : void
      {
         hasField$0 |= 4;
         treasure_count$field = param1;
      }
      
      public function get treasureCount() : int
      {
         return treasure_count$field;
      }
      
      public function removeEventLeft() : void
      {
         hasField$0 &= 4294967287;
         event_left$field = new int();
      }
      
      public function get hasEventLeft() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set eventLeft(param1:int) : void
      {
         hasField$0 |= 8;
         event_left$field = param1;
      }
      
      public function get eventLeft() : int
      {
         return event_left$field;
      }
      
      public function removeStepLeft() : void
      {
         hasField$0 &= 4294967279;
         step_left$field = new int();
      }
      
      public function get hasStepLeft() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set stepLeft(param1:int) : void
      {
         hasField$0 |= 16;
         step_left$field = param1;
      }
      
      public function get stepLeft() : int
      {
         return step_left$field;
      }
      
      public function removeReviveLeft() : void
      {
         hasField$0 &= 4294967263;
         revive_left$field = new int();
      }
      
      public function get hasReviveLeft() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set reviveLeft(param1:int) : void
      {
         hasField$0 |= 32;
         revive_left$field = param1;
      }
      
      public function get reviveLeft() : int
      {
         return revive_left$field;
      }
      
      public function removeDungeonType() : void
      {
         hasField$0 &= 4294967231;
         dungeon_type$field = new int();
      }
      
      public function get hasDungeonType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set dungeonType(param1:int) : void
      {
         hasField$0 |= 64;
         dungeon_type$field = param1;
      }
      
      public function get dungeonType() : int
      {
         return dungeon_type$field;
      }
      
      public function removeDungeonProcess() : void
      {
         hasField$0 &= 4294967167;
         dungeon_process$field = new int();
      }
      
      public function get hasDungeonProcess() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set dungeonProcess(param1:int) : void
      {
         hasField$0 |= 128;
         dungeon_process$field = param1;
      }
      
      public function get dungeonProcess() : int
      {
         return dungeon_process$field;
      }
      
      public function removeDead() : void
      {
         hasField$0 &= 4294967039;
         dead$field = new Boolean();
      }
      
      public function get hasDead() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set dead(param1:Boolean) : void
      {
         hasField$0 |= 256;
         dead$field = param1;
      }
      
      public function get dead() : Boolean
      {
         return dead$field;
      }
      
      public function removeHasNext() : void
      {
         hasField$0 &= 4294966783;
         has_next$field = new Boolean();
      }
      
      public function get hasHasNext() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set hasNext(param1:Boolean) : void
      {
         hasField$0 |= 512;
         has_next$field = param1;
      }
      
      public function get hasNext() : Boolean
      {
         return has_next$field;
      }
      
      public function removeParalysisTime() : void
      {
         paralysis_time$field = null;
      }
      
      public function get hasParalysisTime() : Boolean
      {
         return paralysis_time$field != null;
      }
      
      public function set paralysisTime(param1:Int64) : void
      {
         paralysis_time$field = param1;
      }
      
      public function get paralysisTime() : Int64
      {
         return paralysis_time$field;
      }
      
      public function removeEventInfo() : void
      {
         event_info$field = null;
      }
      
      public function get hasEventInfo() : Boolean
      {
         return event_info$field != null;
      }
      
      public function set eventInfo(param1:DungeonEventMsg) : void
      {
         event_info$field = param1;
      }
      
      public function get eventInfo() : DungeonEventMsg
      {
         return event_info$field;
      }
      
      public function removePosX() : void
      {
         hasField$0 &= 4294966271;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 1024;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294965247;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 2048;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      public function removeOrderScore() : void
      {
         hasField$0 &= 4294963199;
         order_score$field = new int();
      }
      
      public function get hasOrderScore() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set orderScore(param1:int) : void
      {
         hasField$0 |= 4096;
         order_score$field = param1;
      }
      
      public function get orderScore() : int
      {
         return order_score$field;
      }
      
      public function removeCurrentOrder() : void
      {
         hasField$0 &= 4294959103;
         current_order$field = new int();
      }
      
      public function get hasCurrentOrder() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set currentOrder(param1:int) : void
      {
         hasField$0 |= 8192;
         current_order$field = param1;
      }
      
      public function get currentOrder() : int
      {
         return current_order$field;
      }
      
      public function removeNextEventCount() : void
      {
         hasField$0 &= 4294950911;
         next_event_count$field = new int();
      }
      
      public function get hasNextEventCount() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set nextEventCount(param1:int) : void
      {
         hasField$0 |= 16384;
         next_event_count$field = param1;
      }
      
      public function get nextEventCount() : int
      {
         return next_event_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_INT32(param1,op);
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasWeekScore)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,week_score$field);
         }
         _loc3_ = 0;
         while(_loc3_ < scoreBoxState.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,scoreBoxState[_loc3_]);
            _loc3_++;
         }
         if(hasTreasureCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,treasure_count$field);
         }
         if(hasEventLeft)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,event_left$field);
         }
         if(hasStepLeft)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,step_left$field);
         }
         if(hasReviveLeft)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,revive_left$field);
         }
         if(hasDungeonType)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,dungeon_type$field);
         }
         if(hasDungeonProcess)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,dungeon_process$field);
         }
         if(hasDead)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_BOOL(param1,dead$field);
         }
         if(hasHasNext)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,has_next$field);
         }
         if(hasParalysisTime)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT64(param1,paralysis_time$field);
         }
         if(hasEventInfo)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_MESSAGE(param1,event_info$field);
         }
         _loc2_ = 0;
         while(_loc2_ < itemFly.length)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,itemFly[_loc2_]);
            _loc2_++;
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
         if(hasOrderScore)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,order_score$field);
         }
         if(hasCurrentOrder)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,current_order$field);
         }
         if(hasNextEventCount)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,next_event_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc21_:uint = 0;
         var _loc19_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc13_:uint = 0;
         var _loc20_:uint = 0;
         var _loc8_:uint = 0;
         var _loc14_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc15_:uint = 0;
         var _loc18_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc16_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.op cannot be set twice.");
                  }
                  _loc21_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.score cannot be set twice.");
                  }
                  _loc19_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.weekScore cannot be set twice.");
                  }
                  _loc4_++;
                  weekScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if((_loc17_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_BOOL,scoreBoxState);
                  }
                  else
                  {
                     scoreBoxState.push(ReadUtils.read$TYPE_BOOL(param1));
                  }
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.treasureCount cannot be set twice.");
                  }
                  _loc6_++;
                  treasureCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.eventLeft cannot be set twice.");
                  }
                  _loc3_++;
                  eventLeft = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.stepLeft cannot be set twice.");
                  }
                  _loc13_++;
                  stepLeft = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.reviveLeft cannot be set twice.");
                  }
                  _loc20_++;
                  reviveLeft = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.dungeonType cannot be set twice.");
                  }
                  _loc8_++;
                  dungeonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.dungeonProcess cannot be set twice.");
                  }
                  _loc14_++;
                  dungeonProcess = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.dead cannot be set twice.");
                  }
                  _loc7_++;
                  dead = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 12:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.hasNext cannot be set twice.");
                  }
                  _loc9_++;
                  hasNext = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 13:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.paralysisTime cannot be set twice.");
                  }
                  _loc15_++;
                  paralysisTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 14:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.eventInfo cannot be set twice.");
                  }
                  _loc18_++;
                  eventInfo = new DungeonEventMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,eventInfo);
                  break;
               case 15:
                  if((_loc17_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,itemFly);
                  }
                  else
                  {
                     itemFly.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 16:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.posX cannot be set twice.");
                  }
                  _loc10_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.posY cannot be set twice.");
                  }
                  _loc5_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.orderScore cannot be set twice.");
                  }
                  _loc16_++;
                  orderScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.currentOrder cannot be set twice.");
                  }
                  _loc11_++;
                  currentOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonMsg.nextEventCount cannot be set twice.");
                  }
                  _loc12_++;
                  nextEventCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
         if(_loc21_ != 1)
         {
            throw new IOError("Bad data format: DungeonMsg.op must be set.");
         }
      }
   }
}

