package com.road.yishi.proto.planes
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlanesWarListMsg extends Message implements IExternalizable
   {
      
      public var op:int;
      
      private var max_planes_own$field:int;
      
      private var hasField$0:uint = 0;
      
      private var energy_left$field:int;
      
      private var buy_energy_count$field:int;
      
      [ArrayElementType("com.road.yishi.proto.planes.PlanesInfoMsg")]
      public var planesList:Array = [];
      
      public function PlanesWarListMsg()
      {
         super();
      }
      
      public function removeMaxPlanesOwn() : void
      {
         hasField$0 &= 4294967294;
         max_planes_own$field = new int();
      }
      
      public function get hasMaxPlanesOwn() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set maxPlanesOwn(param1:int) : void
      {
         hasField$0 |= 1;
         max_planes_own$field = param1;
      }
      
      public function get maxPlanesOwn() : int
      {
         return max_planes_own$field;
      }
      
      public function removeEnergyLeft() : void
      {
         hasField$0 &= 4294967293;
         energy_left$field = new int();
      }
      
      public function get hasEnergyLeft() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set energyLeft(param1:int) : void
      {
         hasField$0 |= 2;
         energy_left$field = param1;
      }
      
      public function get energyLeft() : int
      {
         return energy_left$field;
      }
      
      public function removeBuyEnergyCount() : void
      {
         hasField$0 &= 4294967291;
         buy_energy_count$field = new int();
      }
      
      public function get hasBuyEnergyCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set buyEnergyCount(param1:int) : void
      {
         hasField$0 |= 4;
         buy_energy_count$field = param1;
      }
      
      public function get buyEnergyCount() : int
      {
         return buy_energy_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_INT32(param1,op);
         if(hasMaxPlanesOwn)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,max_planes_own$field);
         }
         if(hasEnergyLeft)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,energy_left$field);
         }
         if(hasBuyEnergyCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,buy_energy_count$field);
         }
         _loc2_ = 0;
         while(_loc2_ < planesList.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,planesList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:PlanesInfoMsg = null;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarListMsg.op cannot be set twice.");
                  }
                  _loc8_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarListMsg.maxPlanesOwn cannot be set twice.");
                  }
                  _loc7_++;
                  maxPlanesOwn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarListMsg.energyLeft cannot be set twice.");
                  }
                  _loc4_++;
                  energyLeft = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarListMsg.buyEnergyCount cannot be set twice.");
                  }
                  _loc6_++;
                  buyEnergyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc3_ = new PlanesInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  planesList.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
         if(_loc8_ != 1)
         {
            throw new IOError("Bad data format: PlanesWarListMsg.op must be set.");
         }
      }
   }
}

