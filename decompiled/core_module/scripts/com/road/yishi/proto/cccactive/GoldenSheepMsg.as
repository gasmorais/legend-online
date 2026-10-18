package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GoldenSheepMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var index$field:int;
      
      private var myCount$field:int;
      
      private var isReward$field:int;
      
      private var rewardId$field:int;
      
      private var totalCount$field:int;
      
      private var curCount$field:int;
      
      [ArrayElementType("com.road.yishi.proto.cccactive.GoldenSheepPlayerMsg")]
      public var sheepData:Array = [];
      
      private var isOpen$field:int;
      
      private var state$field:int;
      
      private var openTime$field:String;
      
      private var stopTime$field:String;
      
      public function GoldenSheepMsg()
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
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967293;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 2;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeMyCount() : void
      {
         hasField$0 &= 4294967291;
         myCount$field = new int();
      }
      
      public function get hasMyCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set myCount(param1:int) : void
      {
         hasField$0 |= 4;
         myCount$field = param1;
      }
      
      public function get myCount() : int
      {
         return myCount$field;
      }
      
      public function removeIsReward() : void
      {
         hasField$0 &= 4294967287;
         isReward$field = new int();
      }
      
      public function get hasIsReward() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isReward(param1:int) : void
      {
         hasField$0 |= 8;
         isReward$field = param1;
      }
      
      public function get isReward() : int
      {
         return isReward$field;
      }
      
      public function removeRewardId() : void
      {
         hasField$0 &= 4294967279;
         rewardId$field = new int();
      }
      
      public function get hasRewardId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set rewardId(param1:int) : void
      {
         hasField$0 |= 16;
         rewardId$field = param1;
      }
      
      public function get rewardId() : int
      {
         return rewardId$field;
      }
      
      public function removeTotalCount() : void
      {
         hasField$0 &= 4294967263;
         totalCount$field = new int();
      }
      
      public function get hasTotalCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set totalCount(param1:int) : void
      {
         hasField$0 |= 32;
         totalCount$field = param1;
      }
      
      public function get totalCount() : int
      {
         return totalCount$field;
      }
      
      public function removeCurCount() : void
      {
         hasField$0 &= 4294967231;
         curCount$field = new int();
      }
      
      public function get hasCurCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set curCount(param1:int) : void
      {
         hasField$0 |= 64;
         curCount$field = param1;
      }
      
      public function get curCount() : int
      {
         return curCount$field;
      }
      
      public function removeIsOpen() : void
      {
         hasField$0 &= 4294967167;
         isOpen$field = new int();
      }
      
      public function get hasIsOpen() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isOpen(param1:int) : void
      {
         hasField$0 |= 128;
         isOpen$field = param1;
      }
      
      public function get isOpen() : int
      {
         return isOpen$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967039;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 256;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeOpenTime() : void
      {
         openTime$field = null;
      }
      
      public function get hasOpenTime() : Boolean
      {
         return openTime$field != null;
      }
      
      public function set openTime(param1:String) : void
      {
         openTime$field = param1;
      }
      
      public function get openTime() : String
      {
         return openTime$field;
      }
      
      public function removeStopTime() : void
      {
         stopTime$field = null;
      }
      
      public function get hasStopTime() : Boolean
      {
         return stopTime$field != null;
      }
      
      public function set stopTime(param1:String) : void
      {
         stopTime$field = param1;
      }
      
      public function get stopTime() : String
      {
         return stopTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasMyCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,myCount$field);
         }
         if(hasIsReward)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,isReward$field);
         }
         if(hasRewardId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,rewardId$field);
         }
         if(hasTotalCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,totalCount$field);
         }
         if(hasCurCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,curCount$field);
         }
         _loc2_ = 0;
         while(_loc2_ < sheepData.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,sheepData[_loc2_]);
            _loc2_++;
         }
         if(hasIsOpen)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,isOpen$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,stopTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc10_:GoldenSheepPlayerMsg = null;
         var _loc15_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc14_:uint = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenSheepMsg.op cannot be set twice.");
                  }
                  _loc15_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenSheepMsg.index cannot be set twice.");
                  }
                  _loc8_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenSheepMsg.myCount cannot be set twice.");
                  }
                  _loc4_++;
                  myCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenSheepMsg.isReward cannot be set twice.");
                  }
                  _loc11_++;
                  isReward = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenSheepMsg.rewardId cannot be set twice.");
                  }
                  _loc6_++;
                  rewardId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenSheepMsg.totalCount cannot be set twice.");
                  }
                  _loc3_++;
                  totalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenSheepMsg.curCount cannot be set twice.");
                  }
                  _loc14_++;
                  curCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  _loc10_ = new GoldenSheepPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  sheepData.push(_loc10_);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenSheepMsg.isOpen cannot be set twice.");
                  }
                  _loc9_++;
                  isOpen = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenSheepMsg.state cannot be set twice.");
                  }
                  _loc12_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenSheepMsg.openTime cannot be set twice.");
                  }
                  _loc5_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GoldenSheepMsg.stopTime cannot be set twice.");
                  }
                  _loc7_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

