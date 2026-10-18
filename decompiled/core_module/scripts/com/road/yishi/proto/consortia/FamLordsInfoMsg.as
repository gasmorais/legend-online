package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FamLordsInfoMsg extends Message implements IExternalizable
   {
      
      private var isCanCall$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var order$field:int;
      
      private var expairtDate$field:String;
      
      private var isOpenLordsNode$field:Boolean;
      
      private var currentTurns$field:int;
      
      private var leftTime$field:int;
      
      [ArrayElementType("int")]
      public var userIds:Array = [];
      
      public function FamLordsInfoMsg()
      {
         super();
      }
      
      public function removeIsCanCall() : void
      {
         hasField$0 &= 4294967294;
         isCanCall$field = new Boolean();
      }
      
      public function get hasIsCanCall() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isCanCall(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isCanCall$field = param1;
      }
      
      public function get isCanCall() : Boolean
      {
         return isCanCall$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967293;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 2;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removeExpairtDate() : void
      {
         expairtDate$field = null;
      }
      
      public function get hasExpairtDate() : Boolean
      {
         return expairtDate$field != null;
      }
      
      public function set expairtDate(param1:String) : void
      {
         expairtDate$field = param1;
      }
      
      public function get expairtDate() : String
      {
         return expairtDate$field;
      }
      
      public function removeIsOpenLordsNode() : void
      {
         hasField$0 &= 4294967291;
         isOpenLordsNode$field = new Boolean();
      }
      
      public function get hasIsOpenLordsNode() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isOpenLordsNode(param1:Boolean) : void
      {
         hasField$0 |= 4;
         isOpenLordsNode$field = param1;
      }
      
      public function get isOpenLordsNode() : Boolean
      {
         return isOpenLordsNode$field;
      }
      
      public function removeCurrentTurns() : void
      {
         hasField$0 &= 4294967287;
         currentTurns$field = new int();
      }
      
      public function get hasCurrentTurns() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set currentTurns(param1:int) : void
      {
         hasField$0 |= 8;
         currentTurns$field = param1;
      }
      
      public function get currentTurns() : int
      {
         return currentTurns$field;
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967279;
         leftTime$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 16;
         leftTime$field = param1;
      }
      
      public function get leftTime() : int
      {
         return leftTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasIsCanCall)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,isCanCall$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasExpairtDate)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,expairtDate$field);
         }
         if(hasIsOpenLordsNode)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isOpenLordsNode$field);
         }
         if(hasCurrentTurns)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,currentTurns$field);
         }
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,leftTime$field);
         }
         _loc2_ = 0;
         while(_loc2_ < userIds.length)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,userIds[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FamLordsInfoMsg.isCanCall cannot be set twice.");
                  }
                  _loc4_++;
                  isCanCall = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FamLordsInfoMsg.order cannot be set twice.");
                  }
                  _loc5_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FamLordsInfoMsg.expairtDate cannot be set twice.");
                  }
                  _loc7_++;
                  expairtDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FamLordsInfoMsg.isOpenLordsNode cannot be set twice.");
                  }
                  _loc6_++;
                  isOpenLordsNode = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FamLordsInfoMsg.currentTurns cannot be set twice.");
                  }
                  _loc3_++;
                  currentTurns = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FamLordsInfoMsg.leftTime cannot be set twice.");
                  }
                  _loc9_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,userIds);
                  }
                  else
                  {
                     userIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

