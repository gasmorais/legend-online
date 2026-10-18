package com.road.yishi.proto.children
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerChildMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.children.ChildrenMsg")]
      public var child:Array = [];
      
      private var firstChildId$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.children.ChildCollectInfoMsg")]
      public var info:Array = [];
      
      private var totalGrowth$field:int;
      
      public function PlayerChildMsg()
      {
         super();
      }
      
      public function removeFirstChildId() : void
      {
         hasField$0 &= 4294967294;
         firstChildId$field = new int();
      }
      
      public function get hasFirstChildId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set firstChildId(param1:int) : void
      {
         hasField$0 |= 1;
         firstChildId$field = param1;
      }
      
      public function get firstChildId() : int
      {
         return firstChildId$field;
      }
      
      public function removeTotalGrowth() : void
      {
         hasField$0 &= 4294967293;
         totalGrowth$field = new int();
      }
      
      public function get hasTotalGrowth() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalGrowth(param1:int) : void
      {
         hasField$0 |= 2;
         totalGrowth$field = param1;
      }
      
      public function get totalGrowth() : int
      {
         return totalGrowth$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < child.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,child[_loc3_]);
            _loc3_++;
         }
         if(hasFirstChildId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,firstChildId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < info.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,info[_loc2_]);
            _loc2_++;
         }
         if(hasTotalGrowth)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,totalGrowth$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:ChildrenMsg = null;
         var _loc5_:ChildCollectInfoMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc7_ = new ChildrenMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  child.push(_loc7_);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerChildMsg.firstChildId cannot be set twice.");
                  }
                  _loc3_++;
                  firstChildId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc5_ = new ChildCollectInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  info.push(_loc5_);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerChildMsg.totalGrowth cannot be set twice.");
                  }
                  _loc4_++;
                  totalGrowth = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

