package com.road.yishi.proto.changejob
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChangePlayerInfoMsg extends Message implements IExternalizable
   {
      
      private var grades$field:int;
      
      private var hasField$0:uint = 0;
      
      private var gp$field:int;
      
      private var branch$field:int;
      
      public function ChangePlayerInfoMsg()
      {
         super();
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294967294;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 1;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
      }
      
      public function removeGp() : void
      {
         hasField$0 &= 4294967293;
         gp$field = new int();
      }
      
      public function get hasGp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set gp(param1:int) : void
      {
         hasField$0 |= 2;
         gp$field = param1;
      }
      
      public function get gp() : int
      {
         return gp$field;
      }
      
      public function removeBranch() : void
      {
         hasField$0 &= 4294967291;
         branch$field = new int();
      }
      
      public function get hasBranch() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set branch(param1:int) : void
      {
         hasField$0 |= 4;
         branch$field = param1;
      }
      
      public function get branch() : int
      {
         return branch$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,gp$field);
         }
         if(hasBranch)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,branch$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChangePlayerInfoMsg.grades cannot be set twice.");
                  }
                  _loc6_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChangePlayerInfoMsg.gp cannot be set twice.");
                  }
                  _loc5_++;
                  gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChangePlayerInfoMsg.branch cannot be set twice.");
                  }
                  _loc3_++;
                  branch = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

