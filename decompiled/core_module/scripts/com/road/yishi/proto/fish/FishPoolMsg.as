package com.road.yishi.proto.fish
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FishPoolMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var level$field:int;
      
      private var gp$field:int;
      
      private var score$field:int;
      
      private var cd$field:Int64;
      
      private var count$field:int;
      
      private var maxCount$field:int;
      
      private var tool1$field:int;
      
      private var tool2$field:int;
      
      private var tool3$field:int;
      
      private var tool4$field:int;
      
      private var hookState$field:int;
      
      private var order$field:int;
      
      [ArrayElementType("com.road.yishi.proto.fish.FishPlayer")]
      public var fishplayers:Array = [];
      
      public function FishPoolMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967293;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 2;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeGp() : void
      {
         hasField$0 &= 4294967291;
         gp$field = new int();
      }
      
      public function get hasGp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set gp(param1:int) : void
      {
         hasField$0 |= 4;
         gp$field = param1;
      }
      
      public function get gp() : int
      {
         return gp$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967287;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 8;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeCd() : void
      {
         cd$field = null;
      }
      
      public function get hasCd() : Boolean
      {
         return cd$field != null;
      }
      
      public function set cd(param1:Int64) : void
      {
         cd$field = param1;
      }
      
      public function get cd() : Int64
      {
         return cd$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967279;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 16;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeMaxCount() : void
      {
         hasField$0 &= 4294967263;
         maxCount$field = new int();
      }
      
      public function get hasMaxCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set maxCount(param1:int) : void
      {
         hasField$0 |= 32;
         maxCount$field = param1;
      }
      
      public function get maxCount() : int
      {
         return maxCount$field;
      }
      
      public function removeTool1() : void
      {
         hasField$0 &= 4294967231;
         tool1$field = new int();
      }
      
      public function get hasTool1() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set tool1(param1:int) : void
      {
         hasField$0 |= 64;
         tool1$field = param1;
      }
      
      public function get tool1() : int
      {
         return tool1$field;
      }
      
      public function removeTool2() : void
      {
         hasField$0 &= 4294967167;
         tool2$field = new int();
      }
      
      public function get hasTool2() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set tool2(param1:int) : void
      {
         hasField$0 |= 128;
         tool2$field = param1;
      }
      
      public function get tool2() : int
      {
         return tool2$field;
      }
      
      public function removeTool3() : void
      {
         hasField$0 &= 4294967039;
         tool3$field = new int();
      }
      
      public function get hasTool3() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set tool3(param1:int) : void
      {
         hasField$0 |= 256;
         tool3$field = param1;
      }
      
      public function get tool3() : int
      {
         return tool3$field;
      }
      
      public function removeTool4() : void
      {
         hasField$0 &= 4294966783;
         tool4$field = new int();
      }
      
      public function get hasTool4() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set tool4(param1:int) : void
      {
         hasField$0 |= 512;
         tool4$field = param1;
      }
      
      public function get tool4() : int
      {
         return tool4$field;
      }
      
      public function removeHookState() : void
      {
         hasField$0 &= 4294966271;
         hookState$field = new int();
      }
      
      public function get hasHookState() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set hookState(param1:int) : void
      {
         hasField$0 |= 1024;
         hookState$field = param1;
      }
      
      public function get hookState() : int
      {
         return hookState$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294965247;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 2048;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,gp$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasCd)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT64(param1,cd$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasMaxCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,maxCount$field);
         }
         if(hasTool1)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,tool1$field);
         }
         if(hasTool2)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,tool2$field);
         }
         if(hasTool3)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,tool3$field);
         }
         if(hasTool4)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,tool4$field);
         }
         if(hasHookState)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,hookState$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         _loc2_ = 0;
         while(_loc2_ < fishplayers.length)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_MESSAGE(param1,fishplayers[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc17_:FishPlayer = null;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FishPoolMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FishPoolMsg.level cannot be set twice.");
                  }
                  _loc3_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: FishPoolMsg.gp cannot be set twice.");
                  }
                  _loc15_++;
                  gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: FishPoolMsg.score cannot be set twice.");
                  }
                  _loc16_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FishPoolMsg.cd cannot be set twice.");
                  }
                  _loc10_++;
                  cd = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FishPoolMsg.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FishPoolMsg.maxCount cannot be set twice.");
                  }
                  _loc6_++;
                  maxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FishPoolMsg.tool1 cannot be set twice.");
                  }
                  _loc7_++;
                  tool1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FishPoolMsg.tool2 cannot be set twice.");
                  }
                  _loc9_++;
                  tool2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FishPoolMsg.tool3 cannot be set twice.");
                  }
                  _loc8_++;
                  tool3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: FishPoolMsg.tool4 cannot be set twice.");
                  }
                  _loc13_++;
                  tool4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FishPoolMsg.hookState cannot be set twice.");
                  }
                  _loc11_++;
                  hookState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: FishPoolMsg.order cannot be set twice.");
                  }
                  _loc12_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  _loc17_ = new FishPlayer();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc17_);
                  fishplayers.push(_loc17_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

