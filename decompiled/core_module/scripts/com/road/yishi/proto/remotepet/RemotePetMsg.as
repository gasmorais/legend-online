package com.road.yishi.proto.remotepet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RemotePetMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nowIndex$field:int;
      
      private var MaxIndex$field:int;
      
      private var order$field:int;
      
      private var skills$field:String;
      
      private var items$field:String;
      
      private var sweepTime$field:String;
      
      private var specialIndex$field:String;
      
      private var pos$field:String;
      
      private var pets$field:String;
      
      private var sweepIndex$field:int;
      
      private var isFirst$field:Boolean;
      
      private var fight$field:int;
      
      private var lastOrder$field:int;
      
      private var isGet$field:Boolean;
      
      private var resetTime$field:String;
      
      public function RemotePetMsg()
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
      
      public function removeNowIndex() : void
      {
         hasField$0 &= 4294967293;
         nowIndex$field = new int();
      }
      
      public function get hasNowIndex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set nowIndex(param1:int) : void
      {
         hasField$0 |= 2;
         nowIndex$field = param1;
      }
      
      public function get nowIndex() : int
      {
         return nowIndex$field;
      }
      
      public function removeMaxIndex() : void
      {
         hasField$0 &= 4294967291;
         MaxIndex$field = new int();
      }
      
      public function get hasMaxIndex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set maxIndex(param1:int) : void
      {
         hasField$0 |= 4;
         MaxIndex$field = param1;
      }
      
      public function get maxIndex() : int
      {
         return MaxIndex$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967287;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 8;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removeSkills() : void
      {
         skills$field = null;
      }
      
      public function get hasSkills() : Boolean
      {
         return skills$field != null;
      }
      
      public function set skills(param1:String) : void
      {
         skills$field = param1;
      }
      
      public function get skills() : String
      {
         return skills$field;
      }
      
      public function removeItems() : void
      {
         items$field = null;
      }
      
      public function get hasItems() : Boolean
      {
         return items$field != null;
      }
      
      public function set items(param1:String) : void
      {
         items$field = param1;
      }
      
      public function get items() : String
      {
         return items$field;
      }
      
      public function removeSweepTime() : void
      {
         sweepTime$field = null;
      }
      
      public function get hasSweepTime() : Boolean
      {
         return sweepTime$field != null;
      }
      
      public function set sweepTime(param1:String) : void
      {
         sweepTime$field = param1;
      }
      
      public function get sweepTime() : String
      {
         return sweepTime$field;
      }
      
      public function removeSpecialIndex() : void
      {
         specialIndex$field = null;
      }
      
      public function get hasSpecialIndex() : Boolean
      {
         return specialIndex$field != null;
      }
      
      public function set specialIndex(param1:String) : void
      {
         specialIndex$field = param1;
      }
      
      public function get specialIndex() : String
      {
         return specialIndex$field;
      }
      
      public function removePos() : void
      {
         pos$field = null;
      }
      
      public function get hasPos() : Boolean
      {
         return pos$field != null;
      }
      
      public function set pos(param1:String) : void
      {
         pos$field = param1;
      }
      
      public function get pos() : String
      {
         return pos$field;
      }
      
      public function removePets() : void
      {
         pets$field = null;
      }
      
      public function get hasPets() : Boolean
      {
         return pets$field != null;
      }
      
      public function set pets(param1:String) : void
      {
         pets$field = param1;
      }
      
      public function get pets() : String
      {
         return pets$field;
      }
      
      public function removeSweepIndex() : void
      {
         hasField$0 &= 4294967279;
         sweepIndex$field = new int();
      }
      
      public function get hasSweepIndex() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set sweepIndex(param1:int) : void
      {
         hasField$0 |= 16;
         sweepIndex$field = param1;
      }
      
      public function get sweepIndex() : int
      {
         return sweepIndex$field;
      }
      
      public function removeIsFirst() : void
      {
         hasField$0 &= 4294967263;
         isFirst$field = new Boolean();
      }
      
      public function get hasIsFirst() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isFirst(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isFirst$field = param1;
      }
      
      public function get isFirst() : Boolean
      {
         return isFirst$field;
      }
      
      public function removeFight() : void
      {
         hasField$0 &= 4294967231;
         fight$field = new int();
      }
      
      public function get hasFight() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set fight(param1:int) : void
      {
         hasField$0 |= 64;
         fight$field = param1;
      }
      
      public function get fight() : int
      {
         return fight$field;
      }
      
      public function removeLastOrder() : void
      {
         hasField$0 &= 4294967167;
         lastOrder$field = new int();
      }
      
      public function get hasLastOrder() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set lastOrder(param1:int) : void
      {
         hasField$0 |= 128;
         lastOrder$field = param1;
      }
      
      public function get lastOrder() : int
      {
         return lastOrder$field;
      }
      
      public function removeIsGet() : void
      {
         hasField$0 &= 4294967039;
         isGet$field = new Boolean();
      }
      
      public function get hasIsGet() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isGet(param1:Boolean) : void
      {
         hasField$0 |= 256;
         isGet$field = param1;
      }
      
      public function get isGet() : Boolean
      {
         return isGet$field;
      }
      
      public function removeResetTime() : void
      {
         resetTime$field = null;
      }
      
      public function get hasResetTime() : Boolean
      {
         return resetTime$field != null;
      }
      
      public function set resetTime(param1:String) : void
      {
         resetTime$field = param1;
      }
      
      public function get resetTime() : String
      {
         return resetTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasNowIndex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,nowIndex$field);
         }
         if(hasMaxIndex)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,MaxIndex$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasSkills)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,skills$field);
         }
         if(hasItems)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,items$field);
         }
         if(hasSweepTime)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,sweepTime$field);
         }
         if(hasSpecialIndex)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,specialIndex$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,pos$field);
         }
         if(hasPets)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,pets$field);
         }
         if(hasSweepIndex)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,sweepIndex$field);
         }
         if(hasIsFirst)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,isFirst$field);
         }
         if(hasFight)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,fight$field);
         }
         if(hasLastOrder)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,lastOrder$field);
         }
         if(hasIsGet)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_BOOL(param1,isGet$field);
         }
         if(hasResetTime)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_STRING(param1,resetTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc18_:* = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc15_:uint = 0;
         var _loc10_:uint = 0;
         var _loc19_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc14_:uint = 0;
         var _loc16_:uint = 0;
         var _loc8_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         var _loc17_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc18_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetMsg.nowIndex cannot be set twice.");
                  }
                  _loc9_++;
                  nowIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetMsg.maxIndex cannot be set twice.");
                  }
                  _loc3_++;
                  maxIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetMsg.order cannot be set twice.");
                  }
                  _loc15_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetMsg.skills cannot be set twice.");
                  }
                  _loc10_++;
                  skills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetMsg.items cannot be set twice.");
                  }
                  _loc19_++;
                  items = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetMsg.sweepTime cannot be set twice.");
                  }
                  _loc11_++;
                  sweepTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetMsg.specialIndex cannot be set twice.");
                  }
                  _loc7_++;
                  specialIndex = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetMsg.pos cannot be set twice.");
                  }
                  _loc5_++;
                  pos = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetMsg.pets cannot be set twice.");
                  }
                  _loc14_++;
                  pets = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetMsg.sweepIndex cannot be set twice.");
                  }
                  _loc16_++;
                  sweepIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetMsg.isFirst cannot be set twice.");
                  }
                  _loc8_++;
                  isFirst = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 12:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetMsg.fight cannot be set twice.");
                  }
                  _loc12_++;
                  fight = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetMsg.lastOrder cannot be set twice.");
                  }
                  _loc4_++;
                  lastOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetMsg.isGet cannot be set twice.");
                  }
                  _loc13_++;
                  isGet = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 15:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetMsg.resetTime cannot be set twice.");
                  }
                  _loc17_++;
                  resetTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc18_ & 7);
            }
         }
      }
   }
}

