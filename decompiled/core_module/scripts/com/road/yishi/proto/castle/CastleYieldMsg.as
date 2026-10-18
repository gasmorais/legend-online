package com.road.yishi.proto.castle
{
   import com.netease.protobuf.*;
   import com.road.yishi.proto.castle.CastleYieldMsg.WildYieldMsg;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CastleYieldMsg extends Message implements IExternalizable
   {
      
      private var gold_yield$field:int;
      
      private var hasField$0:uint = 0;
      
      private var gold_wild_land_yield$field:int;
      
      private var gold_technology$field:int;
      
      private var gold_wonder$field:int;
      
      private var gold_dower$field:int;
      
      private var gold_total_count$field:int;
      
      private var gold_max$field:int;
      
      private var cur_population$field:int;
      
      private var max_population$field:int;
      
      [ArrayElementType("com.road.yishi.proto.castle.CastleYieldMsg.WildYieldMsg")]
      public var wildYield:Array = [];
      
      private var crystals_count$field:int;
      
      public function CastleYieldMsg()
      {
         super();
      }
      
      public function removeGoldYield() : void
      {
         hasField$0 &= 4294967294;
         gold_yield$field = new int();
      }
      
      public function get hasGoldYield() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set goldYield(param1:int) : void
      {
         hasField$0 |= 1;
         gold_yield$field = param1;
      }
      
      public function get goldYield() : int
      {
         return gold_yield$field;
      }
      
      public function removeGoldWildLandYield() : void
      {
         hasField$0 &= 4294967293;
         gold_wild_land_yield$field = new int();
      }
      
      public function get hasGoldWildLandYield() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set goldWildLandYield(param1:int) : void
      {
         hasField$0 |= 2;
         gold_wild_land_yield$field = param1;
      }
      
      public function get goldWildLandYield() : int
      {
         return gold_wild_land_yield$field;
      }
      
      public function removeGoldTechnology() : void
      {
         hasField$0 &= 4294967291;
         gold_technology$field = new int();
      }
      
      public function get hasGoldTechnology() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set goldTechnology(param1:int) : void
      {
         hasField$0 |= 4;
         gold_technology$field = param1;
      }
      
      public function get goldTechnology() : int
      {
         return gold_technology$field;
      }
      
      public function removeGoldWonder() : void
      {
         hasField$0 &= 4294967287;
         gold_wonder$field = new int();
      }
      
      public function get hasGoldWonder() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set goldWonder(param1:int) : void
      {
         hasField$0 |= 8;
         gold_wonder$field = param1;
      }
      
      public function get goldWonder() : int
      {
         return gold_wonder$field;
      }
      
      public function removeGoldDower() : void
      {
         hasField$0 &= 4294967279;
         gold_dower$field = new int();
      }
      
      public function get hasGoldDower() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set goldDower(param1:int) : void
      {
         hasField$0 |= 16;
         gold_dower$field = param1;
      }
      
      public function get goldDower() : int
      {
         return gold_dower$field;
      }
      
      public function removeGoldTotalCount() : void
      {
         hasField$0 &= 4294967263;
         gold_total_count$field = new int();
      }
      
      public function get hasGoldTotalCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set goldTotalCount(param1:int) : void
      {
         hasField$0 |= 32;
         gold_total_count$field = param1;
      }
      
      public function get goldTotalCount() : int
      {
         return gold_total_count$field;
      }
      
      public function removeGoldMax() : void
      {
         hasField$0 &= 4294967231;
         gold_max$field = new int();
      }
      
      public function get hasGoldMax() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set goldMax(param1:int) : void
      {
         hasField$0 |= 64;
         gold_max$field = param1;
      }
      
      public function get goldMax() : int
      {
         return gold_max$field;
      }
      
      public function removeCurPopulation() : void
      {
         hasField$0 &= 4294967167;
         cur_population$field = new int();
      }
      
      public function get hasCurPopulation() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set curPopulation(param1:int) : void
      {
         hasField$0 |= 128;
         cur_population$field = param1;
      }
      
      public function get curPopulation() : int
      {
         return cur_population$field;
      }
      
      public function removeMaxPopulation() : void
      {
         hasField$0 &= 4294967039;
         max_population$field = new int();
      }
      
      public function get hasMaxPopulation() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set maxPopulation(param1:int) : void
      {
         hasField$0 |= 256;
         max_population$field = param1;
      }
      
      public function get maxPopulation() : int
      {
         return max_population$field;
      }
      
      public function removeCrystalsCount() : void
      {
         hasField$0 &= 4294966783;
         crystals_count$field = new int();
      }
      
      public function get hasCrystalsCount() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set crystalsCount(param1:int) : void
      {
         hasField$0 |= 512;
         crystals_count$field = param1;
      }
      
      public function get crystalsCount() : int
      {
         return crystals_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasGoldYield)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,gold_yield$field);
         }
         if(hasGoldWildLandYield)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,gold_wild_land_yield$field);
         }
         if(hasGoldTechnology)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,gold_technology$field);
         }
         if(hasGoldWonder)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,gold_wonder$field);
         }
         if(hasGoldDower)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,gold_dower$field);
         }
         if(hasGoldTotalCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,gold_total_count$field);
         }
         if(hasGoldMax)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,gold_max$field);
         }
         if(hasCurPopulation)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,cur_population$field);
         }
         if(hasMaxPopulation)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,max_population$field);
         }
         _loc2_ = 0;
         while(_loc2_ < wildYield.length)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_MESSAGE(param1,wildYield[_loc2_]);
            _loc2_++;
         }
         if(hasCrystalsCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,crystals_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc5_:WildYieldMsg = null;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         var _loc13_:uint = 0;
         var _loc8_:uint = 0;
         var _loc14_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CastleYieldMsg.goldYield cannot be set twice.");
                  }
                  _loc4_++;
                  goldYield = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CastleYieldMsg.goldWildLandYield cannot be set twice.");
                  }
                  _loc6_++;
                  goldWildLandYield = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CastleYieldMsg.goldTechnology cannot be set twice.");
                  }
                  _loc10_++;
                  goldTechnology = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CastleYieldMsg.goldWonder cannot be set twice.");
                  }
                  _loc3_++;
                  goldWonder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CastleYieldMsg.goldDower cannot be set twice.");
                  }
                  _loc7_++;
                  goldDower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CastleYieldMsg.goldTotalCount cannot be set twice.");
                  }
                  _loc9_++;
                  goldTotalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CastleYieldMsg.goldMax cannot be set twice.");
                  }
                  _loc11_++;
                  goldMax = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: CastleYieldMsg.curPopulation cannot be set twice.");
                  }
                  _loc13_++;
                  curPopulation = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CastleYieldMsg.maxPopulation cannot be set twice.");
                  }
                  _loc8_++;
                  maxPopulation = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  _loc5_ = new WildYieldMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  wildYield.push(_loc5_);
                  break;
               case 10:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: CastleYieldMsg.crystalsCount cannot be set twice.");
                  }
                  _loc14_++;
                  crystalsCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

