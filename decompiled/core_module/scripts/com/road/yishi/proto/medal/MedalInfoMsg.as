package com.road.yishi.proto.medal
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MedalInfoMsg extends Message implements IExternalizable
   {
      
      private var grade$field:int;
      
      private var hasField$0:uint = 0;
      
      private var gp$field:Int64;
      
      private var tempId$field:int;
      
      private var invalidTime$field:String;
      
      public function MedalInfoMsg()
      {
         super();
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
      
      public function removeGp() : void
      {
         gp$field = null;
      }
      
      public function get hasGp() : Boolean
      {
         return gp$field != null;
      }
      
      public function set gp(param1:Int64) : void
      {
         gp$field = param1;
      }
      
      public function get gp() : Int64
      {
         return gp$field;
      }
      
      public function removeTempId() : void
      {
         hasField$0 &= 4294967293;
         tempId$field = new int();
      }
      
      public function get hasTempId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set tempId(param1:int) : void
      {
         hasField$0 |= 2;
         tempId$field = param1;
      }
      
      public function get tempId() : int
      {
         return tempId$field;
      }
      
      public function removeInvalidTime() : void
      {
         invalidTime$field = null;
      }
      
      public function get hasInvalidTime() : Boolean
      {
         return invalidTime$field != null;
      }
      
      public function set invalidTime(param1:String) : void
      {
         invalidTime$field = param1;
      }
      
      public function get invalidTime() : String
      {
         return invalidTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT64(param1,gp$field);
         }
         if(hasTempId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,tempId$field);
         }
         if(hasInvalidTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,invalidTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MedalInfoMsg.grade cannot be set twice.");
                  }
                  _loc4_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MedalInfoMsg.gp cannot be set twice.");
                  }
                  _loc7_++;
                  gp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MedalInfoMsg.tempId cannot be set twice.");
                  }
                  _loc3_++;
                  tempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MedalInfoMsg.invalidTime cannot be set twice.");
                  }
                  _loc5_++;
                  invalidTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

