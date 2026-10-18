package com.road.yishi.proto.bottle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BottleScoreMsg extends Message implements IExternalizable
   {
      
      private var tree_status$field:String;
      
      private var count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var open_view$field:Boolean;
      
      private var alter_bottle$field:Boolean;
      
      public function BottleScoreMsg()
      {
         super();
      }
      
      public function removeTreeStatus() : void
      {
         tree_status$field = null;
      }
      
      public function get hasTreeStatus() : Boolean
      {
         return tree_status$field != null;
      }
      
      public function set treeStatus(param1:String) : void
      {
         tree_status$field = param1;
      }
      
      public function get treeStatus() : String
      {
         return tree_status$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967294;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 1;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeOpenView() : void
      {
         hasField$0 &= 4294967293;
         open_view$field = new Boolean();
      }
      
      public function get hasOpenView() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set openView(param1:Boolean) : void
      {
         hasField$0 |= 2;
         open_view$field = param1;
      }
      
      public function get openView() : Boolean
      {
         return open_view$field;
      }
      
      public function removeAlterBottle() : void
      {
         hasField$0 &= 4294967291;
         alter_bottle$field = new Boolean();
      }
      
      public function get hasAlterBottle() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set alterBottle(param1:Boolean) : void
      {
         hasField$0 |= 4;
         alter_bottle$field = param1;
      }
      
      public function get alterBottle() : Boolean
      {
         return alter_bottle$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTreeStatus)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,tree_status$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasOpenView)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,open_view$field);
         }
         if(hasAlterBottle)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,alter_bottle$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BottleScoreMsg.treeStatus cannot be set twice.");
                  }
                  _loc3_++;
                  treeStatus = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BottleScoreMsg.count cannot be set twice.");
                  }
                  _loc5_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BottleScoreMsg.openView cannot be set twice.");
                  }
                  _loc6_++;
                  openView = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BottleScoreMsg.alterBottle cannot be set twice.");
                  }
                  _loc4_++;
                  alterBottle = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

