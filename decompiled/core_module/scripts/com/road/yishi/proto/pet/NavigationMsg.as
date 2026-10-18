package com.road.yishi.proto.pet
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class NavigationMsg extends Message implements IExternalizable
   {
      
      private var strength$field:int;
      
      private var hasField$0:uint = 0;
      
      private var currency$field:int;
      
      private var dayBuyShopNum$field:int;
      
      private var dayBuyStrengthNum$field:int;
      
      private var shopRefreshCD$field:Int64;
      
      private var inviteNum$field:int;
      
      private var assistNum$field:int;
      
      [ArrayElementType("com.road.yishi.proto.pet.NavigationBuyDataMsg")]
      public var buyData:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.pet.NavigationPortMsg")]
      public var port:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.pet.NavigationBoatMsg")]
      public var boat:Array = [];
      
      private var fishingTime$field:int;
      
      [ArrayElementType("String")]
      public var fishingTipsList:Array = [];
      
      public function NavigationMsg()
      {
         super();
      }
      
      public function removeStrength() : void
      {
         hasField$0 &= 4294967294;
         strength$field = new int();
      }
      
      public function get hasStrength() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set strength(param1:int) : void
      {
         hasField$0 |= 1;
         strength$field = param1;
      }
      
      public function get strength() : int
      {
         return strength$field;
      }
      
      public function removeCurrency() : void
      {
         hasField$0 &= 4294967293;
         currency$field = new int();
      }
      
      public function get hasCurrency() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set currency(param1:int) : void
      {
         hasField$0 |= 2;
         currency$field = param1;
      }
      
      public function get currency() : int
      {
         return currency$field;
      }
      
      public function removeDayBuyShopNum() : void
      {
         hasField$0 &= 4294967291;
         dayBuyShopNum$field = new int();
      }
      
      public function get hasDayBuyShopNum() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set dayBuyShopNum(param1:int) : void
      {
         hasField$0 |= 4;
         dayBuyShopNum$field = param1;
      }
      
      public function get dayBuyShopNum() : int
      {
         return dayBuyShopNum$field;
      }
      
      public function removeDayBuyStrengthNum() : void
      {
         hasField$0 &= 4294967287;
         dayBuyStrengthNum$field = new int();
      }
      
      public function get hasDayBuyStrengthNum() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set dayBuyStrengthNum(param1:int) : void
      {
         hasField$0 |= 8;
         dayBuyStrengthNum$field = param1;
      }
      
      public function get dayBuyStrengthNum() : int
      {
         return dayBuyStrengthNum$field;
      }
      
      public function removeShopRefreshCD() : void
      {
         shopRefreshCD$field = null;
      }
      
      public function get hasShopRefreshCD() : Boolean
      {
         return shopRefreshCD$field != null;
      }
      
      public function set shopRefreshCD(param1:Int64) : void
      {
         shopRefreshCD$field = param1;
      }
      
      public function get shopRefreshCD() : Int64
      {
         return shopRefreshCD$field;
      }
      
      public function removeInviteNum() : void
      {
         hasField$0 &= 4294967279;
         inviteNum$field = new int();
      }
      
      public function get hasInviteNum() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set inviteNum(param1:int) : void
      {
         hasField$0 |= 16;
         inviteNum$field = param1;
      }
      
      public function get inviteNum() : int
      {
         return inviteNum$field;
      }
      
      public function removeAssistNum() : void
      {
         hasField$0 &= 4294967263;
         assistNum$field = new int();
      }
      
      public function get hasAssistNum() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set assistNum(param1:int) : void
      {
         hasField$0 |= 32;
         assistNum$field = param1;
      }
      
      public function get assistNum() : int
      {
         return assistNum$field;
      }
      
      public function removeFishingTime() : void
      {
         hasField$0 &= 4294967231;
         fishingTime$field = new int();
      }
      
      public function get hasFishingTime() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set fishingTime(param1:int) : void
      {
         hasField$0 |= 64;
         fishingTime$field = param1;
      }
      
      public function get fishingTime() : int
      {
         return fishingTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc5_:* = 0;
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         if(hasStrength)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,strength$field);
         }
         if(hasCurrency)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,currency$field);
         }
         if(hasDayBuyShopNum)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,dayBuyShopNum$field);
         }
         if(hasDayBuyStrengthNum)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,dayBuyStrengthNum$field);
         }
         if(hasShopRefreshCD)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT64(param1,shopRefreshCD$field);
         }
         if(hasInviteNum)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,inviteNum$field);
         }
         if(hasAssistNum)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,assistNum$field);
         }
         _loc5_ = 0;
         while(_loc5_ < buyData.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,buyData[_loc5_]);
            _loc5_++;
         }
         _loc2_ = 0;
         while(_loc2_ < port.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,port[_loc2_]);
            _loc2_++;
         }
         _loc4_ = 0;
         while(_loc4_ < boat.length)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_MESSAGE(param1,boat[_loc4_]);
            _loc4_++;
         }
         if(hasFishingTime)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,fishingTime$field);
         }
         _loc3_ = 0;
         while(_loc3_ < fishingTipsList.length)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,fishingTipsList[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc8_:NavigationBuyDataMsg = null;
         var _loc14_:NavigationPortMsg = null;
         var _loc10_:NavigationBoatMsg = null;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationMsg.strength cannot be set twice.");
                  }
                  _loc11_++;
                  strength = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationMsg.currency cannot be set twice.");
                  }
                  _loc7_++;
                  currency = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationMsg.dayBuyShopNum cannot be set twice.");
                  }
                  _loc9_++;
                  dayBuyShopNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationMsg.dayBuyStrengthNum cannot be set twice.");
                  }
                  _loc5_++;
                  dayBuyStrengthNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationMsg.shopRefreshCD cannot be set twice.");
                  }
                  _loc4_++;
                  shopRefreshCD = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationMsg.inviteNum cannot be set twice.");
                  }
                  _loc3_++;
                  inviteNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationMsg.assistNum cannot be set twice.");
                  }
                  _loc6_++;
                  assistNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  _loc8_ = new NavigationBuyDataMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  buyData.push(_loc8_);
                  break;
               case 8:
                  _loc14_ = new NavigationPortMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc14_);
                  port.push(_loc14_);
                  break;
               case 9:
                  _loc10_ = new NavigationBoatMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  boat.push(_loc10_);
                  break;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationMsg.fishingTime cannot be set twice.");
                  }
                  _loc12_++;
                  fishingTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  fishingTipsList.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

