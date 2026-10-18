package com.road.yishi.proto.powcard
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PowCardSuiteMsg extends Message implements IExternalizable
   {
      
      private var suiteId$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.powcard.PowCardBufMsg")]
      public var bufInfos:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.powcard.PowCardInfoMsg")]
      public var cardInfos:Array = [];
      
      public function PowCardSuiteMsg()
      {
         super();
      }
      
      public function removeSuiteId() : void
      {
         hasField$0 &= 4294967294;
         suiteId$field = new int();
      }
      
      public function get hasSuiteId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set suiteId(param1:int) : void
      {
         hasField$0 |= 1;
         suiteId$field = param1;
      }
      
      public function get suiteId() : int
      {
         return suiteId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasSuiteId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,suiteId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < bufInfos.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,bufInfos[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < cardInfos.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,cardInfos[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:PowCardBufMsg = null;
         var _loc6_:PowCardInfoMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PowCardSuiteMsg.suiteId cannot be set twice.");
                  }
                  _loc3_++;
                  suiteId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc5_ = new PowCardBufMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  bufInfos.push(_loc5_);
                  break;
               case 2:
                  _loc6_ = new PowCardInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  cardInfos.push(_loc6_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

