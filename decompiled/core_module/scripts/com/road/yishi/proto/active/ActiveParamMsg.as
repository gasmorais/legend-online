package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActiveParamMsg extends Message implements IExternalizable
   {
      
      private var level$field:int;
      
      private var hasField$0:uint = 0;
      
      private var costDiamond$field:int;
      
      private var costContract$field:int;
      
      private var getBindingDia$field:int;
      
      private var harvestCount$field:int;
      
      [ArrayElementType("com.road.yishi.proto.active.GItemInfoMsg")]
      public var itemInfos:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.GItemInfoMsg")]
      public var itemInfos2:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.GetItemInfosMsg")]
      public var getInfos:Array = [];
      
      public function ActiveParamMsg()
      {
         super();
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967294;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 1;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeCostDiamond() : void
      {
         hasField$0 &= 4294967293;
         costDiamond$field = new int();
      }
      
      public function get hasCostDiamond() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set costDiamond(param1:int) : void
      {
         hasField$0 |= 2;
         costDiamond$field = param1;
      }
      
      public function get costDiamond() : int
      {
         return costDiamond$field;
      }
      
      public function removeCostContract() : void
      {
         hasField$0 &= 4294967291;
         costContract$field = new int();
      }
      
      public function get hasCostContract() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set costContract(param1:int) : void
      {
         hasField$0 |= 4;
         costContract$field = param1;
      }
      
      public function get costContract() : int
      {
         return costContract$field;
      }
      
      public function removeGetBindingDia() : void
      {
         hasField$0 &= 4294967287;
         getBindingDia$field = new int();
      }
      
      public function get hasGetBindingDia() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set getBindingDia(param1:int) : void
      {
         hasField$0 |= 8;
         getBindingDia$field = param1;
      }
      
      public function get getBindingDia() : int
      {
         return getBindingDia$field;
      }
      
      public function removeHarvestCount() : void
      {
         hasField$0 &= 4294967279;
         harvestCount$field = new int();
      }
      
      public function get hasHarvestCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set harvestCount(param1:int) : void
      {
         hasField$0 |= 16;
         harvestCount$field = param1;
      }
      
      public function get harvestCount() : int
      {
         return harvestCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasCostDiamond)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,costDiamond$field);
         }
         if(hasCostContract)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,costContract$field);
         }
         if(hasGetBindingDia)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,getBindingDia$field);
         }
         if(hasHarvestCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,harvestCount$field);
         }
         _loc3_ = 0;
         while(_loc3_ < itemInfos.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,itemInfos[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < itemInfos2.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,itemInfos2[_loc2_]);
            _loc2_++;
         }
         _loc4_ = 0;
         while(_loc4_ < getInfos.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,getInfos[_loc4_]);
            _loc4_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc4_:GItemInfoMsg = null;
         var _loc6_:GItemInfoMsg = null;
         var _loc5_:GetItemInfosMsg = null;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveParamMsg.level cannot be set twice.");
                  }
                  _loc3_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveParamMsg.costDiamond cannot be set twice.");
                  }
                  _loc9_++;
                  costDiamond = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveParamMsg.costContract cannot be set twice.");
                  }
                  _loc11_++;
                  costContract = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveParamMsg.getBindingDia cannot be set twice.");
                  }
                  _loc8_++;
                  getBindingDia = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveParamMsg.harvestCount cannot be set twice.");
                  }
                  _loc7_++;
                  harvestCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  _loc4_ = new GItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  itemInfos.push(_loc4_);
                  break;
               case 6:
                  _loc6_ = new GItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  itemInfos2.push(_loc6_);
                  break;
               case 7:
                  _loc5_ = new GetItemInfosMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  getInfos.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

