package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BossMsg extends Message implements IExternalizable
   {
      
      private var bossName$field:String;
      
      private var grade$field:int;
      
      private var hasField$0:uint = 0;
      
      private var type$field:int;
      
      private var x$field:int;
      
      private var y$field:int;
      
      public function BossMsg()
      {
         super();
      }
      
      public function removeBossName() : void
      {
         bossName$field = null;
      }
      
      public function get hasBossName() : Boolean
      {
         return bossName$field != null;
      }
      
      public function set bossName(param1:String) : void
      {
         bossName$field = param1;
      }
      
      public function get bossName() : String
      {
         return bossName$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967294;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 1;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967293;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 2;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeX() : void
      {
         hasField$0 &= 4294967291;
         x$field = new int();
      }
      
      public function get hasX() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set x(param1:int) : void
      {
         hasField$0 |= 4;
         x$field = param1;
      }
      
      public function get x() : int
      {
         return x$field;
      }
      
      public function removeY() : void
      {
         hasField$0 &= 4294967287;
         y$field = new int();
      }
      
      public function get hasY() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set y(param1:int) : void
      {
         hasField$0 |= 8;
         y$field = param1;
      }
      
      public function get y() : int
      {
         return y$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBossName)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,bossName$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasX)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,x$field);
         }
         if(hasY)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,y$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BossMsg.bossName cannot be set twice.");
                  }
                  _loc6_++;
                  bossName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BossMsg.grade cannot be set twice.");
                  }
                  _loc5_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BossMsg.type cannot be set twice.");
                  }
                  _loc7_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BossMsg.x cannot be set twice.");
                  }
                  _loc3_++;
                  x = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BossMsg.y cannot be set twice.");
                  }
                  _loc4_++;
                  y = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

