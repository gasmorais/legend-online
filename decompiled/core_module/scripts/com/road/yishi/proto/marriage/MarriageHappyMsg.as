package com.road.yishi.proto.marriage
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MarriageHappyMsg extends Message implements IExternalizable
   {
      
      private var happy_gp$field:int;
      
      private var hasField$0:uint = 0;
      
      private var happy_grade$field:int;
      
      private var happy_help$field:int;
      
      public function MarriageHappyMsg()
      {
         super();
      }
      
      public function removeHappyGp() : void
      {
         hasField$0 &= 4294967294;
         happy_gp$field = new int();
      }
      
      public function get hasHappyGp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set happyGp(param1:int) : void
      {
         hasField$0 |= 1;
         happy_gp$field = param1;
      }
      
      public function get happyGp() : int
      {
         return happy_gp$field;
      }
      
      public function removeHappyGrade() : void
      {
         hasField$0 &= 4294967293;
         happy_grade$field = new int();
      }
      
      public function get hasHappyGrade() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set happyGrade(param1:int) : void
      {
         hasField$0 |= 2;
         happy_grade$field = param1;
      }
      
      public function get happyGrade() : int
      {
         return happy_grade$field;
      }
      
      public function removeHappyHelp() : void
      {
         hasField$0 &= 4294967291;
         happy_help$field = new int();
      }
      
      public function get hasHappyHelp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set happyHelp(param1:int) : void
      {
         hasField$0 |= 4;
         happy_help$field = param1;
      }
      
      public function get happyHelp() : int
      {
         return happy_help$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasHappyGp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,happy_gp$field);
         }
         if(hasHappyGrade)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,happy_grade$field);
         }
         if(hasHappyHelp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,happy_help$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageHappyMsg.happyGp cannot be set twice.");
                  }
                  _loc4_++;
                  happyGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageHappyMsg.happyGrade cannot be set twice.");
                  }
                  _loc6_++;
                  happyGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageHappyMsg.happyHelp cannot be set twice.");
                  }
                  _loc3_++;
                  happyHelp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

