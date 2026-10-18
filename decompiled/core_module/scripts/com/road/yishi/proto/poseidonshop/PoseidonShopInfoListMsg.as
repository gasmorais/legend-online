package com.road.yishi.proto.poseidonshop
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PoseidonShopInfoListMsg extends Message implements IExternalizable
   {
      
      private var currLevel$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.poseidonshop.PoseidonShopInfoMsg")]
      public var list:Array = [];
      
      public function PoseidonShopInfoListMsg()
      {
         super();
      }
      
      public function removeCurrLevel() : void
      {
         hasField$0 &= 4294967294;
         currLevel$field = new int();
      }
      
      public function get hasCurrLevel() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set currLevel(param1:int) : void
      {
         hasField$0 |= 1;
         currLevel$field = param1;
      }
      
      public function get currLevel() : int
      {
         return currLevel$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasCurrLevel)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,currLevel$field);
         }
         _loc2_ = 0;
         while(_loc2_ < list.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,list[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:PoseidonShopInfoMsg = null;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PoseidonShopInfoListMsg.currLevel cannot be set twice.");
                  }
                  _loc5_++;
                  currLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc3_ = new PoseidonShopInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  list.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

