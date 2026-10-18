package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class QuickPassRankMsg extends Message implements IExternalizable
   {
      
      private var updateTime$field:String;
      
      private var myOrder$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.campaign.RankInfoMsg")]
      public var pass:Array = [];
      
      public function QuickPassRankMsg()
      {
         super();
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUpdateTime)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,updateTime$field);
         }
         if(hasMyOrder)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,myOrder$field);
         }
         _loc2_ = 0;
         while(_loc2_ < pass.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,pass[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:RankInfoMsg = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: QuickPassRankMsg.updateTime cannot be set twice.");
                  }
                  _loc4_++;
                  updateTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: QuickPassRankMsg.myOrder cannot be set twice.");
                  }
                  _loc5_++;
                  myOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc3_ = new RankInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  pass.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

