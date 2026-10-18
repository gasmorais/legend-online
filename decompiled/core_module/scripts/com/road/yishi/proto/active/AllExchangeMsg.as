package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AllExchangeMsg extends Message implements IExternalizable
   {
      
      private var id$field:String;
      
      private var begin$field:String;
      
      private var end$field:String;
      
      private var isopen$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var allPoint$field:int;
      
      private var boxChangeCount$field:String;
      
      private var allChangeCount$field:int;
      
      private var changeNeedPoint$field:String;
      
      private var point$field:String;
      
      private var exchangeCount$field:String;
      
      private var totalExchangeCount$field:String;
      
      private var serverAwardState$field:String;
      
      private var changeItemCount$field:int;
      
      private var allPointAward$field:String;
      
      [ArrayElementType("com.road.yishi.proto.active.AllExchangeItemInfoMsg")]
      public var boxAward:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.AllExchangeItemInfoMsg")]
      public var serverAward:Array = [];
      
      private var changeItem$field:int;
      
      public function AllExchangeMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         id$field = null;
      }
      
      public function get hasId() : Boolean
      {
         return id$field != null;
      }
      
      public function set id(param1:String) : void
      {
         id$field = param1;
      }
      
      public function get id() : String
      {
         return id$field;
      }
      
      public function removeBegin() : void
      {
         begin$field = null;
      }
      
      public function get hasBegin() : Boolean
      {
         return begin$field != null;
      }
      
      public function set begin(param1:String) : void
      {
         begin$field = param1;
      }
      
      public function get begin() : String
      {
         return begin$field;
      }
      
      public function removeEnd() : void
      {
         end$field = null;
      }
      
      public function get hasEnd() : Boolean
      {
         return end$field != null;
      }
      
      public function set end(param1:String) : void
      {
         end$field = param1;
      }
      
      public function get end() : String
      {
         return end$field;
      }
      
      public function removeIsopen() : void
      {
         hasField$0 &= 4294967294;
         isopen$field = new Boolean();
      }
      
      public function get hasIsopen() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isopen(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isopen$field = param1;
      }
      
      public function get isopen() : Boolean
      {
         return isopen$field;
      }
      
      public function removeAllPoint() : void
      {
         hasField$0 &= 4294967293;
         allPoint$field = new int();
      }
      
      public function get hasAllPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set allPoint(param1:int) : void
      {
         hasField$0 |= 2;
         allPoint$field = param1;
      }
      
      public function get allPoint() : int
      {
         return allPoint$field;
      }
      
      public function removeBoxChangeCount() : void
      {
         boxChangeCount$field = null;
      }
      
      public function get hasBoxChangeCount() : Boolean
      {
         return boxChangeCount$field != null;
      }
      
      public function set boxChangeCount(param1:String) : void
      {
         boxChangeCount$field = param1;
      }
      
      public function get boxChangeCount() : String
      {
         return boxChangeCount$field;
      }
      
      public function removeAllChangeCount() : void
      {
         hasField$0 &= 4294967291;
         allChangeCount$field = new int();
      }
      
      public function get hasAllChangeCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set allChangeCount(param1:int) : void
      {
         hasField$0 |= 4;
         allChangeCount$field = param1;
      }
      
      public function get allChangeCount() : int
      {
         return allChangeCount$field;
      }
      
      public function removeChangeNeedPoint() : void
      {
         changeNeedPoint$field = null;
      }
      
      public function get hasChangeNeedPoint() : Boolean
      {
         return changeNeedPoint$field != null;
      }
      
      public function set changeNeedPoint(param1:String) : void
      {
         changeNeedPoint$field = param1;
      }
      
      public function get changeNeedPoint() : String
      {
         return changeNeedPoint$field;
      }
      
      public function removePoint() : void
      {
         point$field = null;
      }
      
      public function get hasPoint() : Boolean
      {
         return point$field != null;
      }
      
      public function set point(param1:String) : void
      {
         point$field = param1;
      }
      
      public function get point() : String
      {
         return point$field;
      }
      
      public function removeExchangeCount() : void
      {
         exchangeCount$field = null;
      }
      
      public function get hasExchangeCount() : Boolean
      {
         return exchangeCount$field != null;
      }
      
      public function set exchangeCount(param1:String) : void
      {
         exchangeCount$field = param1;
      }
      
      public function get exchangeCount() : String
      {
         return exchangeCount$field;
      }
      
      public function removeTotalExchangeCount() : void
      {
         totalExchangeCount$field = null;
      }
      
      public function get hasTotalExchangeCount() : Boolean
      {
         return totalExchangeCount$field != null;
      }
      
      public function set totalExchangeCount(param1:String) : void
      {
         totalExchangeCount$field = param1;
      }
      
      public function get totalExchangeCount() : String
      {
         return totalExchangeCount$field;
      }
      
      public function removeServerAwardState() : void
      {
         serverAwardState$field = null;
      }
      
      public function get hasServerAwardState() : Boolean
      {
         return serverAwardState$field != null;
      }
      
      public function set serverAwardState(param1:String) : void
      {
         serverAwardState$field = param1;
      }
      
      public function get serverAwardState() : String
      {
         return serverAwardState$field;
      }
      
      public function removeChangeItemCount() : void
      {
         hasField$0 &= 4294967287;
         changeItemCount$field = new int();
      }
      
      public function get hasChangeItemCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set changeItemCount(param1:int) : void
      {
         hasField$0 |= 8;
         changeItemCount$field = param1;
      }
      
      public function get changeItemCount() : int
      {
         return changeItemCount$field;
      }
      
      public function removeAllPointAward() : void
      {
         allPointAward$field = null;
      }
      
      public function get hasAllPointAward() : Boolean
      {
         return allPointAward$field != null;
      }
      
      public function set allPointAward(param1:String) : void
      {
         allPointAward$field = param1;
      }
      
      public function get allPointAward() : String
      {
         return allPointAward$field;
      }
      
      public function removeChangeItem() : void
      {
         hasField$0 &= 4294967279;
         changeItem$field = new int();
      }
      
      public function get hasChangeItem() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set changeItem(param1:int) : void
      {
         hasField$0 |= 16;
         changeItem$field = param1;
      }
      
      public function get changeItem() : int
      {
         return changeItem$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,id$field);
         }
         if(hasBegin)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,begin$field);
         }
         if(hasEnd)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,end$field);
         }
         if(hasIsopen)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isopen$field);
         }
         if(hasAllPoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,allPoint$field);
         }
         if(hasBoxChangeCount)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,boxChangeCount$field);
         }
         if(hasAllChangeCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,allChangeCount$field);
         }
         if(hasChangeNeedPoint)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,changeNeedPoint$field);
         }
         if(hasPoint)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,point$field);
         }
         if(hasExchangeCount)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,exchangeCount$field);
         }
         if(hasTotalExchangeCount)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,totalExchangeCount$field);
         }
         if(hasServerAwardState)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,serverAwardState$field);
         }
         if(hasChangeItemCount)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,changeItemCount$field);
         }
         if(hasAllPointAward)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,allPointAward$field);
         }
         _loc3_ = 0;
         while(_loc3_ < boxAward.length)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_MESSAGE(param1,boxAward[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < serverAward.length)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_MESSAGE(param1,serverAward[_loc2_]);
            _loc2_++;
         }
         if(hasChangeItem)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,changeItem$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc18_:* = 0;
         var _loc7_:AllExchangeItemInfoMsg = null;
         var _loc16_:AllExchangeItemInfoMsg = null;
         var _loc6_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         var _loc9_:uint = 0;
         var _loc19_:uint = 0;
         var _loc8_:uint = 0;
         var _loc17_:uint = 0;
         var _loc15_:uint = 0;
         var _loc20_:uint = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc18_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeMsg.id cannot be set twice.");
                  }
                  _loc6_++;
                  id = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeMsg.begin cannot be set twice.");
                  }
                  _loc14_++;
                  begin = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeMsg.end cannot be set twice.");
                  }
                  _loc3_++;
                  end = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeMsg.isopen cannot be set twice.");
                  }
                  _loc4_++;
                  isopen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeMsg.allPoint cannot be set twice.");
                  }
                  _loc13_++;
                  allPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeMsg.boxChangeCount cannot be set twice.");
                  }
                  _loc9_++;
                  boxChangeCount = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeMsg.allChangeCount cannot be set twice.");
                  }
                  _loc19_++;
                  allChangeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeMsg.changeNeedPoint cannot be set twice.");
                  }
                  _loc8_++;
                  changeNeedPoint = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeMsg.point cannot be set twice.");
                  }
                  _loc17_++;
                  point = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeMsg.exchangeCount cannot be set twice.");
                  }
                  _loc15_++;
                  exchangeCount = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeMsg.totalExchangeCount cannot be set twice.");
                  }
                  _loc20_++;
                  totalExchangeCount = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeMsg.serverAwardState cannot be set twice.");
                  }
                  _loc11_++;
                  serverAwardState = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeMsg.changeItemCount cannot be set twice.");
                  }
                  _loc5_++;
                  changeItemCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeMsg.allPointAward cannot be set twice.");
                  }
                  _loc12_++;
                  allPointAward = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  _loc7_ = new AllExchangeItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  boxAward.push(_loc7_);
                  break;
               case 15:
                  _loc16_ = new AllExchangeItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc16_);
                  serverAward.push(_loc16_);
                  break;
               case 16:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeMsg.changeItem cannot be set twice.");
                  }
                  _loc10_++;
                  changeItem = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc18_ & 7);
            }
         }
      }
   }
}

