package com.road.yishi.proto.avenger
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AvengerHoleMsg extends Message implements IExternalizable
   {
      
      private var pos$field:int;
      
      private var hasField$0:uint = 0;
      
      private var grade$field:int;
      
      private var exp$field:int;
      
      private var inlayItem$field:int;
      
      public function AvengerHoleMsg()
      {
         super();
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967294;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 1;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967293;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 2;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeExp() : void
      {
         hasField$0 &= 4294967291;
         exp$field = new int();
      }
      
      public function get hasExp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set exp(param1:int) : void
      {
         hasField$0 |= 4;
         exp$field = param1;
      }
      
      public function get exp() : int
      {
         return exp$field;
      }
      
      public function removeInlayItem() : void
      {
         hasField$0 &= 4294967287;
         inlayItem$field = new int();
      }
      
      public function get hasInlayItem() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set inlayItem(param1:int) : void
      {
         hasField$0 |= 8;
         inlayItem$field = param1;
      }
      
      public function get inlayItem() : int
      {
         return inlayItem$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasExp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,exp$field);
         }
         if(hasInlayItem)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,inlayItem$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerHoleMsg.pos cannot be set twice.");
                  }
                  _loc5_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerHoleMsg.grade cannot be set twice.");
                  }
                  _loc4_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerHoleMsg.exp cannot be set twice.");
                  }
                  _loc3_++;
                  exp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerHoleMsg.inlayItem cannot be set twice.");
                  }
                  _loc7_++;
                  inlayItem = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

