package com.road.yishi.proto.skytrial
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SkyTrialInfoMsg extends Message implements IExternalizable
   {
      
      public var op:int;
      
      [ArrayElementType("com.road.yishi.proto.skytrial.SkyTrialLayerMsg")]
      public var layerList:Array = [];
      
      [ArrayElementType("int")]
      public var skillCountList:Array = [];
      
      [ArrayElementType("int")]
      public var buffList:Array = [];
      
      private var search_point$field:int;
      
      private var hasField$0:uint = 0;
      
      private var energy$field:int;
      
      private var buy_energy_count$field:int;
      
      public function SkyTrialInfoMsg()
      {
         super();
      }
      
      public function removeSearchPoint() : void
      {
         hasField$0 &= 4294967294;
         search_point$field = new int();
      }
      
      public function get hasSearchPoint() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set searchPoint(param1:int) : void
      {
         hasField$0 |= 1;
         search_point$field = param1;
      }
      
      public function get searchPoint() : int
      {
         return search_point$field;
      }
      
      public function removeEnergy() : void
      {
         hasField$0 &= 4294967293;
         energy$field = new int();
      }
      
      public function get hasEnergy() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set energy(param1:int) : void
      {
         hasField$0 |= 2;
         energy$field = param1;
      }
      
      public function get energy() : int
      {
         return energy$field;
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
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_INT32(param1,op);
         _loc3_ = 0;
         while(_loc3_ < layerList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,layerList[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < skillCountList.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,skillCountList[_loc2_]);
            _loc2_++;
         }
         _loc4_ = 0;
         while(_loc4_ < buffList.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,buffList[_loc4_]);
            _loc4_++;
         }
         if(hasSearchPoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,search_point$field);
         }
         if(hasEnergy)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,energy$field);
         }
         if(hasBuyEnergyCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,buy_energy_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc8_:SkyTrialLayerMsg = null;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialInfoMsg.op cannot be set twice.");
                  }
                  _loc7_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc8_ = new SkyTrialLayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  layerList.push(_loc8_);
                  break;
               case 2:
                  if((_loc4_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,skillCountList);
                  }
                  else
                  {
                     skillCountList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 3:
                  if((_loc4_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,buffList);
                  }
                  else
                  {
                     buffList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialInfoMsg.searchPoint cannot be set twice.");
                  }
                  _loc3_++;
                  searchPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialInfoMsg.energy cannot be set twice.");
                  }
                  _loc6_++;
                  energy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialInfoMsg.buyEnergyCount cannot be set twice.");
                  }
                  _loc5_++;
                  buyEnergyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
         if(_loc7_ != 1)
         {
            throw new IOError("Bad data format: SkyTrialInfoMsg.op must be set.");
         }
      }
   }
}

