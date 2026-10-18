package com.road.yishi.proto.childpatrol
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildPatrolMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var userid$field:int;
      
      private var headquarters$field:ChildPatrolTowerMsg;
      
      [ArrayElementType("com.road.yishi.proto.childpatrol.ChildPatrolTowerMsg")]
      public var towerList:Array = [];
      
      private var freeCount$field:int;
      
      public function ChildPatrolMsg()
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
      
      public function removeUserid() : void
      {
         hasField$0 &= 4294967293;
         userid$field = new int();
      }
      
      public function get hasUserid() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userid(param1:int) : void
      {
         hasField$0 |= 2;
         userid$field = param1;
      }
      
      public function get userid() : int
      {
         return userid$field;
      }
      
      public function removeHeadquarters() : void
      {
         headquarters$field = null;
      }
      
      public function get hasHeadquarters() : Boolean
      {
         return headquarters$field != null;
      }
      
      public function set headquarters(param1:ChildPatrolTowerMsg) : void
      {
         headquarters$field = param1;
      }
      
      public function get headquarters() : ChildPatrolTowerMsg
      {
         return headquarters$field;
      }
      
      public function removeFreeCount() : void
      {
         hasField$0 &= 4294967291;
         freeCount$field = new int();
      }
      
      public function get hasFreeCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set freeCount(param1:int) : void
      {
         hasField$0 |= 4;
         freeCount$field = param1;
      }
      
      public function get freeCount() : int
      {
         return freeCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasUserid)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userid$field);
         }
         if(hasHeadquarters)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,headquarters$field);
         }
         _loc2_ = 0;
         while(_loc2_ < towerList.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,towerList[_loc2_]);
            _loc2_++;
         }
         if(hasFreeCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,freeCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:ChildPatrolTowerMsg = null;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolMsg.op cannot be set twice.");
                  }
                  _loc8_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolMsg.userid cannot be set twice.");
                  }
                  _loc3_++;
                  userid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolMsg.headquarters cannot be set twice.");
                  }
                  _loc4_++;
                  headquarters = new ChildPatrolTowerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,headquarters);
                  break;
               case 3:
                  _loc7_ = new ChildPatrolTowerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  towerList.push(_loc7_);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolMsg.freeCount cannot be set twice.");
                  }
                  _loc5_++;
                  freeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

