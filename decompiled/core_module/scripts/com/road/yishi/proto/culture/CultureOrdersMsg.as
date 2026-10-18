package com.road.yishi.proto.culture
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CultureOrdersMsg extends Message implements IExternalizable
   {
      
      private var myOrder$field:int;
      
      private var hasField$0:uint = 0;
      
      private var myScore$field:int;
      
      private var rankType$field:int;
      
      [ArrayElementType("com.road.yishi.proto.culture.CultureOrderInfoMsg")]
      public var info:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.culture.OrderRewardMsg")]
      public var orderReward:Array = [];
      
      private var updateTime$field:String;
      
      public function CultureOrdersMsg()
      {
         super();
      }
      
      public function removeMyOrder() : void
      {
         hasField$0 &= 4294967294;
         myOrder$field = new int();
      }
      
      public function get hasMyOrder() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set myOrder(param1:int) : void
      {
         hasField$0 |= 1;
         myOrder$field = param1;
      }
      
      public function get myOrder() : int
      {
         return myOrder$field;
      }
      
      public function removeMyScore() : void
      {
         hasField$0 &= 4294967293;
         myScore$field = new int();
      }
      
      public function get hasMyScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set myScore(param1:int) : void
      {
         hasField$0 |= 2;
         myScore$field = param1;
      }
      
      public function get myScore() : int
      {
         return myScore$field;
      }
      
      public function removeRankType() : void
      {
         hasField$0 &= 4294967291;
         rankType$field = new int();
      }
      
      public function get hasRankType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rankType(param1:int) : void
      {
         hasField$0 |= 4;
         rankType$field = param1;
      }
      
      public function get rankType() : int
      {
         return rankType$field;
      }
      
      public function removeUpdateTime() : void
      {
         updateTime$field = null;
      }
      
      public function get hasUpdateTime() : Boolean
      {
         return updateTime$field != null;
      }
      
      public function set updateTime(param1:String) : void
      {
         updateTime$field = param1;
      }
      
      public function get updateTime() : String
      {
         return updateTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasMyOrder)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,myOrder$field);
         }
         if(hasMyScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,myScore$field);
         }
         if(hasRankType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,rankType$field);
         }
         _loc3_ = 0;
         while(_loc3_ < info.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,info[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < orderReward.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,orderReward[_loc2_]);
            _loc2_++;
         }
         if(hasUpdateTime)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,updateTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc5_:CultureOrderInfoMsg = null;
         var _loc9_:OrderRewardMsg = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CultureOrdersMsg.myOrder cannot be set twice.");
                  }
                  _loc6_++;
                  myOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CultureOrdersMsg.myScore cannot be set twice.");
                  }
                  _loc7_++;
                  myScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CultureOrdersMsg.rankType cannot be set twice.");
                  }
                  _loc4_++;
                  rankType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc5_ = new CultureOrderInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  info.push(_loc5_);
                  break;
               case 4:
                  _loc9_ = new OrderRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  orderReward.push(_loc9_);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CultureOrdersMsg.updateTime cannot be set twice.");
                  }
                  _loc3_++;
                  updateTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

