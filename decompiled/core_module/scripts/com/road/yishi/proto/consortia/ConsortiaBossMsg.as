package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaBossMsg extends Message implements IExternalizable
   {
      
      private var grade$field:int;
      
      private var hasField$0:uint = 0;
      
      private var spirit$field:Int64;
      
      private var state$field:int;
      
      private var end_time$field:String;
      
      private var total_hp$field:Int64;
      
      private var call_grade$field:int;
      
      public function ConsortiaBossMsg()
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
      
      public function removeSpirit() : void
      {
         spirit$field = null;
      }
      
      public function get hasSpirit() : Boolean
      {
         return spirit$field != null;
      }
      
      public function set spirit(param1:Int64) : void
      {
         spirit$field = param1;
      }
      
      public function get spirit() : Int64
      {
         return spirit$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967293;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 2;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeEndTime() : void
      {
         end_time$field = null;
      }
      
      public function get hasEndTime() : Boolean
      {
         return end_time$field != null;
      }
      
      public function set endTime(param1:String) : void
      {
         end_time$field = param1;
      }
      
      public function get endTime() : String
      {
         return end_time$field;
      }
      
      public function removeTotalHp() : void
      {
         total_hp$field = null;
      }
      
      public function get hasTotalHp() : Boolean
      {
         return total_hp$field != null;
      }
      
      public function set totalHp(param1:Int64) : void
      {
         total_hp$field = param1;
      }
      
      public function get totalHp() : Int64
      {
         return total_hp$field;
      }
      
      public function removeCallGrade() : void
      {
         hasField$0 &= 4294967291;
         call_grade$field = new int();
      }
      
      public function get hasCallGrade() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set callGrade(param1:int) : void
      {
         hasField$0 |= 4;
         call_grade$field = param1;
      }
      
      public function get callGrade() : int
      {
         return call_grade$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasSpirit)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT64(param1,spirit$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,end_time$field);
         }
         if(hasTotalHp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT64(param1,total_hp$field);
         }
         if(hasCallGrade)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,call_grade$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBossMsg.grade cannot be set twice.");
                  }
                  _loc4_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBossMsg.spirit cannot be set twice.");
                  }
                  _loc3_++;
                  spirit = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBossMsg.state cannot be set twice.");
                  }
                  _loc7_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBossMsg.endTime cannot be set twice.");
                  }
                  _loc6_++;
                  endTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBossMsg.totalHp cannot be set twice.");
                  }
                  _loc9_++;
                  totalHp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBossMsg.callGrade cannot be set twice.");
                  }
                  _loc5_++;
                  callGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

