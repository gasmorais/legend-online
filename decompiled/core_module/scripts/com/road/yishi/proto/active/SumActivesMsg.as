package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SumActivesMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.active.SumActiveinfoMsg")]
      public var actives:Array = [];
      
      public var dataStamp:int;
      
      public var curPage:int;
      
      public var maxPage:int;
      
      public function SumActivesMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < actives.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,actives[_loc2_]);
            _loc2_++;
         }
         WriteUtils.writeTag(param1,0,2);
         WriteUtils.write$TYPE_INT32(param1,dataStamp);
         WriteUtils.writeTag(param1,0,3);
         WriteUtils.write$TYPE_INT32(param1,curPage);
         WriteUtils.writeTag(param1,0,4);
         WriteUtils.write$TYPE_INT32(param1,maxPage);
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:SumActiveinfoMsg = null;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new SumActiveinfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  actives.push(_loc4_);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SumActivesMsg.dataStamp cannot be set twice.");
                  }
                  _loc6_++;
                  dataStamp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SumActivesMsg.curPage cannot be set twice.");
                  }
                  _loc3_++;
                  curPage = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SumActivesMsg.maxPage cannot be set twice.");
                  }
                  _loc7_++;
                  maxPage = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
         if(_loc6_ != 1)
         {
            throw new IOError("Bad data format: SumActivesMsg.dataStamp must be set.");
         }
         if(_loc3_ != 1)
         {
            throw new IOError("Bad data format: SumActivesMsg.curPage must be set.");
         }
         if(_loc7_ != 1)
         {
            throw new IOError("Bad data format: SumActivesMsg.maxPage must be set.");
         }
      }
   }
}

