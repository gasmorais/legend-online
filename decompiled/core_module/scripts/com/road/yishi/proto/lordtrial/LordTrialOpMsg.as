package com.road.yishi.proto.lordtrial
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LordTrialOpMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var payType$field:int;
      
      private var errorID$field:int;
      
      [ArrayElementType("String")]
      public var debuffs:Array = [];
      
      private var sweepIndex$field:int;
      
      private var nowType$field:int;
      
      private var nowIndex$field:int;
      
      private var resetTime$field:String;
      
      private var items$field:String;
      
      private var petId$field:int;
      
      private var childPetId$field:int;
      
      private var secondChildPetId$field:int;
      
      private var childId$field:int;
      
      private var secondChildId$field:int;
      
      private var hpPercent$field:int;
      
      private var keyCount$field:int;
      
      private var prayCount$field:int;
      
      private var sacrificeCount$field:int;
      
      private var cards$field:String;
      
      [ArrayElementType("int")]
      public var maxIndexs:Array = [];
      
      [ArrayElementType("int")]
      public var orders:Array = [];
      
      private var indexItems$field:String;
      
      private var prayStatus$field:int;
      
      public function LordTrialOpMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967293;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 2;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      public function removeErrorID() : void
      {
         hasField$0 &= 4294967291;
         errorID$field = new int();
      }
      
      public function get hasErrorID() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set errorID(param1:int) : void
      {
         hasField$0 |= 4;
         errorID$field = param1;
      }
      
      public function get errorID() : int
      {
         return errorID$field;
      }
      
      public function removeSweepIndex() : void
      {
         hasField$0 &= 4294967287;
         sweepIndex$field = new int();
      }
      
      public function get hasSweepIndex() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set sweepIndex(param1:int) : void
      {
         hasField$0 |= 8;
         sweepIndex$field = param1;
      }
      
      public function get sweepIndex() : int
      {
         return sweepIndex$field;
      }
      
      public function removeNowType() : void
      {
         hasField$0 &= 4294967279;
         nowType$field = new int();
      }
      
      public function get hasNowType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set nowType(param1:int) : void
      {
         hasField$0 |= 16;
         nowType$field = param1;
      }
      
      public function get nowType() : int
      {
         return nowType$field;
      }
      
      public function removeNowIndex() : void
      {
         hasField$0 &= 4294967263;
         nowIndex$field = new int();
      }
      
      public function get hasNowIndex() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set nowIndex(param1:int) : void
      {
         hasField$0 |= 32;
         nowIndex$field = param1;
      }
      
      public function get nowIndex() : int
      {
         return nowIndex$field;
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
      
      public function removePetId() : void
      {
         hasField$0 &= 4294967231;
         petId$field = new int();
      }
      
      public function get hasPetId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set petId(param1:int) : void
      {
         hasField$0 |= 64;
         petId$field = param1;
      }
      
      public function get petId() : int
      {
         return petId$field;
      }
      
      public function removeChildPetId() : void
      {
         hasField$0 &= 4294967167;
         childPetId$field = new int();
      }
      
      public function get hasChildPetId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set childPetId(param1:int) : void
      {
         hasField$0 |= 128;
         childPetId$field = param1;
      }
      
      public function get childPetId() : int
      {
         return childPetId$field;
      }
      
      public function removeSecondChildPetId() : void
      {
         hasField$0 &= 4294967039;
         secondChildPetId$field = new int();
      }
      
      public function get hasSecondChildPetId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set secondChildPetId(param1:int) : void
      {
         hasField$0 |= 256;
         secondChildPetId$field = param1;
      }
      
      public function get secondChildPetId() : int
      {
         return secondChildPetId$field;
      }
      
      public function removeChildId() : void
      {
         hasField$0 &= 4294966783;
         childId$field = new int();
      }
      
      public function get hasChildId() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set childId(param1:int) : void
      {
         hasField$0 |= 512;
         childId$field = param1;
      }
      
      public function get childId() : int
      {
         return childId$field;
      }
      
      public function removeSecondChildId() : void
      {
         hasField$0 &= 4294966271;
         secondChildId$field = new int();
      }
      
      public function get hasSecondChildId() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set secondChildId(param1:int) : void
      {
         hasField$0 |= 1024;
         secondChildId$field = param1;
      }
      
      public function get secondChildId() : int
      {
         return secondChildId$field;
      }
      
      public function removeHpPercent() : void
      {
         hasField$0 &= 4294965247;
         hpPercent$field = new int();
      }
      
      public function get hasHpPercent() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set hpPercent(param1:int) : void
      {
         hasField$0 |= 2048;
         hpPercent$field = param1;
      }
      
      public function get hpPercent() : int
      {
         return hpPercent$field;
      }
      
      public function removeKeyCount() : void
      {
         hasField$0 &= 4294963199;
         keyCount$field = new int();
      }
      
      public function get hasKeyCount() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set keyCount(param1:int) : void
      {
         hasField$0 |= 4096;
         keyCount$field = param1;
      }
      
      public function get keyCount() : int
      {
         return keyCount$field;
      }
      
      public function removePrayCount() : void
      {
         hasField$0 &= 4294959103;
         prayCount$field = new int();
      }
      
      public function get hasPrayCount() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set prayCount(param1:int) : void
      {
         hasField$0 |= 8192;
         prayCount$field = param1;
      }
      
      public function get prayCount() : int
      {
         return prayCount$field;
      }
      
      public function removeSacrificeCount() : void
      {
         hasField$0 &= 4294950911;
         sacrificeCount$field = new int();
      }
      
      public function get hasSacrificeCount() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set sacrificeCount(param1:int) : void
      {
         hasField$0 |= 16384;
         sacrificeCount$field = param1;
      }
      
      public function get sacrificeCount() : int
      {
         return sacrificeCount$field;
      }
      
      public function removeCards() : void
      {
         cards$field = null;
      }
      
      public function get hasCards() : Boolean
      {
         return cards$field != null;
      }
      
      public function set cards(param1:String) : void
      {
         cards$field = param1;
      }
      
      public function get cards() : String
      {
         return cards$field;
      }
      
      public function removeIndexItems() : void
      {
         indexItems$field = null;
      }
      
      public function get hasIndexItems() : Boolean
      {
         return indexItems$field != null;
      }
      
      public function set indexItems(param1:String) : void
      {
         indexItems$field = param1;
      }
      
      public function get indexItems() : String
      {
         return indexItems$field;
      }
      
      public function removePrayStatus() : void
      {
         hasField$0 &= 4294934527;
         prayStatus$field = new int();
      }
      
      public function get hasPrayStatus() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set prayStatus(param1:int) : void
      {
         hasField$0 |= 32768;
         prayStatus$field = param1;
      }
      
      public function get prayStatus() : int
      {
         return prayStatus$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_ENUM(param1,op$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
         if(hasErrorID)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_ENUM(param1,errorID$field);
         }
         _loc3_ = 0;
         while(_loc3_ < debuffs.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,debuffs[_loc3_]);
            _loc3_++;
         }
         if(hasSweepIndex)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,sweepIndex$field);
         }
         if(hasNowType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,nowType$field);
         }
         if(hasNowIndex)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,nowIndex$field);
         }
         if(hasResetTime)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,resetTime$field);
         }
         if(hasItems)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,items$field);
         }
         if(hasPetId)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,petId$field);
         }
         if(hasChildPetId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,childPetId$field);
         }
         if(hasSecondChildPetId)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,secondChildPetId$field);
         }
         if(hasChildId)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,childId$field);
         }
         if(hasSecondChildId)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,secondChildId$field);
         }
         if(hasHpPercent)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,hpPercent$field);
         }
         if(hasKeyCount)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,keyCount$field);
         }
         if(hasPrayCount)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,prayCount$field);
         }
         if(hasSacrificeCount)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,sacrificeCount$field);
         }
         if(hasCards)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_STRING(param1,cards$field);
         }
         _loc4_ = 0;
         while(_loc4_ < maxIndexs.length)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,maxIndexs[_loc4_]);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < orders.length)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,orders[_loc2_]);
            _loc2_++;
         }
         if(hasIndexItems)
         {
            WriteUtils.writeTag(param1,2,22);
            WriteUtils.write$TYPE_STRING(param1,indexItems$field);
         }
         if(hasPrayStatus)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,prayStatus$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc21_:* = 0;
         var _loc23_:uint = 0;
         var _loc15_:uint = 0;
         var _loc6_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc9_:uint = 0;
         var _loc20_:uint = 0;
         var _loc22_:uint = 0;
         var _loc3_:uint = 0;
         var _loc14_:uint = 0;
         var _loc12_:uint = 0;
         var _loc16_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc17_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc21_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.op cannot be set twice.");
                  }
                  _loc23_++;
                  op = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 2:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.payType cannot be set twice.");
                  }
                  _loc15_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.errorID cannot be set twice.");
                  }
                  _loc6_++;
                  errorID = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 4:
                  debuffs.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 5:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.sweepIndex cannot be set twice.");
                  }
                  _loc18_++;
                  sweepIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.nowType cannot be set twice.");
                  }
                  _loc19_++;
                  nowType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.nowIndex cannot be set twice.");
                  }
                  _loc9_++;
                  nowIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.resetTime cannot be set twice.");
                  }
                  _loc20_++;
                  resetTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.items cannot be set twice.");
                  }
                  _loc22_++;
                  items = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.petId cannot be set twice.");
                  }
                  _loc3_++;
                  petId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.childPetId cannot be set twice.");
                  }
                  _loc14_++;
                  childPetId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.secondChildPetId cannot be set twice.");
                  }
                  _loc12_++;
                  secondChildPetId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.childId cannot be set twice.");
                  }
                  _loc16_++;
                  childId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.secondChildId cannot be set twice.");
                  }
                  _loc8_++;
                  secondChildId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.hpPercent cannot be set twice.");
                  }
                  _loc13_++;
                  hpPercent = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.keyCount cannot be set twice.");
                  }
                  _loc5_++;
                  keyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.prayCount cannot be set twice.");
                  }
                  _loc4_++;
                  prayCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.sacrificeCount cannot be set twice.");
                  }
                  _loc7_++;
                  sacrificeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.cards cannot be set twice.");
                  }
                  _loc17_++;
                  cards = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 20:
                  if((_loc21_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,maxIndexs);
                  }
                  else
                  {
                     maxIndexs.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 21:
                  if((_loc21_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,orders);
                  }
                  else
                  {
                     orders.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 22:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.indexItems cannot be set twice.");
                  }
                  _loc11_++;
                  indexItems = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 23:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: LordTrialOpMsg.prayStatus cannot be set twice.");
                  }
                  _loc10_++;
                  prayStatus = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc21_ & 7);
            }
         }
      }
   }
}

