package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BattleReportMsg extends Message implements IExternalizable
   {
      
      private var battle_result$field:int;
      
      private var hasField$0:uint = 0;
      
      private var strategy_bonus$field:int;
      
      private var gp_bonus$field:int;
      
      private var pos_x$field:int;
      
      private var pos_y$field:int;
      
      private var sign_id$field:String;
      
      [ArrayElementType("com.road.yishi.proto.battle.BaseItemMsg")]
      public var baseItem:Array = [];
      
      private var battle_scene$field:int;
      
      private var fail_count$field:int;
      
      private var gold_bonus$field:int;
      
      private var pet_gp_bonus$field:int;
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      public function BattleReportMsg()
      {
         super();
      }
      
      public function removeBattleResult() : void
      {
         hasField$0 &= 4294967294;
         battle_result$field = new int();
      }
      
      public function get hasBattleResult() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set battleResult(param1:int) : void
      {
         hasField$0 |= 1;
         battle_result$field = param1;
      }
      
      public function get battleResult() : int
      {
         return battle_result$field;
      }
      
      public function removeStrategyBonus() : void
      {
         hasField$0 &= 4294967293;
         strategy_bonus$field = new int();
      }
      
      public function get hasStrategyBonus() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set strategyBonus(param1:int) : void
      {
         hasField$0 |= 2;
         strategy_bonus$field = param1;
      }
      
      public function get strategyBonus() : int
      {
         return strategy_bonus$field;
      }
      
      public function removeGpBonus() : void
      {
         hasField$0 &= 4294967291;
         gp_bonus$field = new int();
      }
      
      public function get hasGpBonus() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set gpBonus(param1:int) : void
      {
         hasField$0 |= 4;
         gp_bonus$field = param1;
      }
      
      public function get gpBonus() : int
      {
         return gp_bonus$field;
      }
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967287;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 8;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967279;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 16;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      public function removeSignId() : void
      {
         sign_id$field = null;
      }
      
      public function get hasSignId() : Boolean
      {
         return sign_id$field != null;
      }
      
      public function set signId(param1:String) : void
      {
         sign_id$field = param1;
      }
      
      public function get signId() : String
      {
         return sign_id$field;
      }
      
      public function removeBattleScene() : void
      {
         hasField$0 &= 4294967263;
         battle_scene$field = new int();
      }
      
      public function get hasBattleScene() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set battleScene(param1:int) : void
      {
         hasField$0 |= 32;
         battle_scene$field = param1;
      }
      
      public function get battleScene() : int
      {
         return battle_scene$field;
      }
      
      public function removeFailCount() : void
      {
         hasField$0 &= 4294967231;
         fail_count$field = new int();
      }
      
      public function get hasFailCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set failCount(param1:int) : void
      {
         hasField$0 |= 64;
         fail_count$field = param1;
      }
      
      public function get failCount() : int
      {
         return fail_count$field;
      }
      
      public function removeGoldBonus() : void
      {
         hasField$0 &= 4294967167;
         gold_bonus$field = new int();
      }
      
      public function get hasGoldBonus() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set goldBonus(param1:int) : void
      {
         hasField$0 |= 128;
         gold_bonus$field = param1;
      }
      
      public function get goldBonus() : int
      {
         return gold_bonus$field;
      }
      
      public function removePetGpBonus() : void
      {
         hasField$0 &= 4294967039;
         pet_gp_bonus$field = new int();
      }
      
      public function get hasPetGpBonus() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set petGpBonus(param1:int) : void
      {
         hasField$0 |= 256;
         pet_gp_bonus$field = param1;
      }
      
      public function get petGpBonus() : int
      {
         return pet_gp_bonus$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294966783;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 512;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294966271;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 1024;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasBattleResult)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,battle_result$field);
         }
         if(hasStrategyBonus)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,strategy_bonus$field);
         }
         if(hasGpBonus)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,gp_bonus$field);
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
         if(hasSignId)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,sign_id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < baseItem.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,baseItem[_loc2_]);
            _loc2_++;
         }
         if(hasBattleScene)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,battle_scene$field);
         }
         if(hasFailCount)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,fail_count$field);
         }
         if(hasGoldBonus)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,gold_bonus$field);
         }
         if(hasPetGpBonus)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,pet_gp_bonus$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc14_:BaseItemMsg = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc15_:uint = 0;
         var _loc13_:uint = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         var _loc16_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BattleReportMsg.battleResult cannot be set twice.");
                  }
                  _loc7_++;
                  battleResult = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: BattleReportMsg.strategyBonus cannot be set twice.");
                  }
                  _loc8_++;
                  strategyBonus = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BattleReportMsg.gpBonus cannot be set twice.");
                  }
                  _loc5_++;
                  gpBonus = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: BattleReportMsg.posX cannot be set twice.");
                  }
                  _loc9_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BattleReportMsg.posY cannot be set twice.");
                  }
                  _loc3_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: BattleReportMsg.signId cannot be set twice.");
                  }
                  _loc10_++;
                  signId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  _loc14_ = new BaseItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc14_);
                  baseItem.push(_loc14_);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BattleReportMsg.battleScene cannot be set twice.");
                  }
                  _loc6_++;
                  battleScene = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: BattleReportMsg.failCount cannot be set twice.");
                  }
                  _loc15_++;
                  failCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: BattleReportMsg.goldBonus cannot be set twice.");
                  }
                  _loc13_++;
                  goldBonus = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: BattleReportMsg.petGpBonus cannot be set twice.");
                  }
                  _loc11_++;
                  petGpBonus = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BattleReportMsg.param1 cannot be set twice.");
                  }
                  _loc4_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: BattleReportMsg.param2 cannot be set twice.");
                  }
                  _loc16_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

