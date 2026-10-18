package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StackHeadBattleDefenceMsg extends Message implements IExternalizable
   {
      
      private var defence_army_alive$field:int;
      
      private var hasField$0:uint = 0;
      
      private var defence_army_total$field:int;
      
      private var defence_property$field:int;
      
      [ArrayElementType("com.road.yishi.proto.hugehead.StackHeadSeniorGeneralMsg")]
      public var defenceSeniorGeneral:Array = [];
      
      public function StackHeadBattleDefenceMsg()
      {
         super();
      }
      
      public function removeDefenceArmyAlive() : void
      {
         hasField$0 &= 4294967294;
         defence_army_alive$field = new int();
      }
      
      public function get hasDefenceArmyAlive() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set defenceArmyAlive(param1:int) : void
      {
         hasField$0 |= 1;
         defence_army_alive$field = param1;
      }
      
      public function get defenceArmyAlive() : int
      {
         return defence_army_alive$field;
      }
      
      public function removeDefenceArmyTotal() : void
      {
         hasField$0 &= 4294967293;
         defence_army_total$field = new int();
      }
      
      public function get hasDefenceArmyTotal() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set defenceArmyTotal(param1:int) : void
      {
         hasField$0 |= 2;
         defence_army_total$field = param1;
      }
      
      public function get defenceArmyTotal() : int
      {
         return defence_army_total$field;
      }
      
      public function removeDefenceProperty() : void
      {
         hasField$0 &= 4294967291;
         defence_property$field = new int();
      }
      
      public function get hasDefenceProperty() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set defenceProperty(param1:int) : void
      {
         hasField$0 |= 4;
         defence_property$field = param1;
      }
      
      public function get defenceProperty() : int
      {
         return defence_property$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasDefenceArmyAlive)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,defence_army_alive$field);
         }
         if(hasDefenceArmyTotal)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,defence_army_total$field);
         }
         if(hasDefenceProperty)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,defence_property$field);
         }
         _loc2_ = 0;
         while(_loc2_ < defenceSeniorGeneral.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,defenceSeniorGeneral[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:StackHeadSeniorGeneralMsg = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadBattleDefenceMsg.defenceArmyAlive cannot be set twice.");
                  }
                  _loc5_++;
                  defenceArmyAlive = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadBattleDefenceMsg.defenceArmyTotal cannot be set twice.");
                  }
                  _loc6_++;
                  defenceArmyTotal = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadBattleDefenceMsg.defenceProperty cannot be set twice.");
                  }
                  _loc4_++;
                  defenceProperty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc3_ = new StackHeadSeniorGeneralMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  defenceSeniorGeneral.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

