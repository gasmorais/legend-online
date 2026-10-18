package com.road.yishi.proto.crisis
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CrisisPlayerInfo extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var preNodeId$field:int;
      
      private var currentNodeId$field:int;
      
      private var crystal$field:int;
      
      private var energy$field:int;
      
      private var isQuit$field:Boolean;
      
      private var buyCount$field:int;
      
      private var isOffline$field:Boolean;
      
      private var diamondBuyCount$field:int;
      
      private var rewardDelRate$field:int;
      
      public function CrisisPlayerInfo()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removePreNodeId() : void
      {
         hasField$0 &= 4294967293;
         preNodeId$field = new int();
      }
      
      public function get hasPreNodeId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set preNodeId(param1:int) : void
      {
         hasField$0 |= 2;
         preNodeId$field = param1;
      }
      
      public function get preNodeId() : int
      {
         return preNodeId$field;
      }
      
      public function removeCurrentNodeId() : void
      {
         hasField$0 &= 4294967291;
         currentNodeId$field = new int();
      }
      
      public function get hasCurrentNodeId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set currentNodeId(param1:int) : void
      {
         hasField$0 |= 4;
         currentNodeId$field = param1;
      }
      
      public function get currentNodeId() : int
      {
         return currentNodeId$field;
      }
      
      public function removeCrystal() : void
      {
         hasField$0 &= 4294967287;
         crystal$field = new int();
      }
      
      public function get hasCrystal() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set crystal(param1:int) : void
      {
         hasField$0 |= 8;
         crystal$field = param1;
      }
      
      public function get crystal() : int
      {
         return crystal$field;
      }
      
      public function removeEnergy() : void
      {
         hasField$0 &= 4294967279;
         energy$field = new int();
      }
      
      public function get hasEnergy() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set energy(param1:int) : void
      {
         hasField$0 |= 16;
         energy$field = param1;
      }
      
      public function get energy() : int
      {
         return energy$field;
      }
      
      public function removeIsQuit() : void
      {
         hasField$0 &= 4294967263;
         isQuit$field = new Boolean();
      }
      
      public function get hasIsQuit() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isQuit(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isQuit$field = param1;
      }
      
      public function get isQuit() : Boolean
      {
         return isQuit$field;
      }
      
      public function removeBuyCount() : void
      {
         hasField$0 &= 4294967231;
         buyCount$field = new int();
      }
      
      public function get hasBuyCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set buyCount(param1:int) : void
      {
         hasField$0 |= 64;
         buyCount$field = param1;
      }
      
      public function get buyCount() : int
      {
         return buyCount$field;
      }
      
      public function removeIsOffline() : void
      {
         hasField$0 &= 4294967167;
         isOffline$field = new Boolean();
      }
      
      public function get hasIsOffline() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isOffline(param1:Boolean) : void
      {
         hasField$0 |= 128;
         isOffline$field = param1;
      }
      
      public function get isOffline() : Boolean
      {
         return isOffline$field;
      }
      
      public function removeDiamondBuyCount() : void
      {
         hasField$0 &= 4294967039;
         diamondBuyCount$field = new int();
      }
      
      public function get hasDiamondBuyCount() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set diamondBuyCount(param1:int) : void
      {
         hasField$0 |= 256;
         diamondBuyCount$field = param1;
      }
      
      public function get diamondBuyCount() : int
      {
         return diamondBuyCount$field;
      }
      
      public function removeRewardDelRate() : void
      {
         hasField$0 &= 4294966783;
         rewardDelRate$field = new int();
      }
      
      public function get hasRewardDelRate() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set rewardDelRate(param1:int) : void
      {
         hasField$0 |= 512;
         rewardDelRate$field = param1;
      }
      
      public function get rewardDelRate() : int
      {
         return rewardDelRate$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasPreNodeId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,preNodeId$field);
         }
         if(hasCurrentNodeId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,currentNodeId$field);
         }
         if(hasCrystal)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,crystal$field);
         }
         if(hasEnergy)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,energy$field);
         }
         if(hasIsQuit)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,isQuit$field);
         }
         if(hasBuyCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,buyCount$field);
         }
         if(hasIsOffline)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,isOffline$field);
         }
         if(hasDiamondBuyCount)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,diamondBuyCount$field);
         }
         if(hasRewardDelRate)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,rewardDelRate$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisPlayerInfo.id cannot be set twice.");
                  }
                  _loc5_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisPlayerInfo.preNodeId cannot be set twice.");
                  }
                  _loc3_++;
                  preNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisPlayerInfo.currentNodeId cannot be set twice.");
                  }
                  _loc11_++;
                  currentNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisPlayerInfo.crystal cannot be set twice.");
                  }
                  _loc6_++;
                  crystal = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisPlayerInfo.energy cannot be set twice.");
                  }
                  _loc13_++;
                  energy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisPlayerInfo.isQuit cannot be set twice.");
                  }
                  _loc4_++;
                  isQuit = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisPlayerInfo.buyCount cannot be set twice.");
                  }
                  _loc10_++;
                  buyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisPlayerInfo.isOffline cannot be set twice.");
                  }
                  _loc8_++;
                  isOffline = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisPlayerInfo.diamondBuyCount cannot be set twice.");
                  }
                  _loc7_++;
                  diamondBuyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisPlayerInfo.rewardDelRate cannot be set twice.");
                  }
                  _loc9_++;
                  rewardDelRate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

