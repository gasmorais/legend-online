package com.road.yishi.proto.braveleg
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class InspireTeamInfoMsg extends Message implements IExternalizable
   {
      
      private var groupType1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var groupType2$field:int;
      
      private var groupType3$field:int;
      
      private var groupGrade1$field:int;
      
      private var groupGrade2$field:int;
      
      private var groupGrade3$field:int;
      
      private var inspireCount$field:int;
      
      private var maxInspireCount$field:int;
      
      public function InspireTeamInfoMsg()
      {
         super();
      }
      
      public function removeGroupType1() : void
      {
         hasField$0 &= 4294967294;
         groupType1$field = new int();
      }
      
      public function get hasGroupType1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set groupType1(param1:int) : void
      {
         hasField$0 |= 1;
         groupType1$field = param1;
      }
      
      public function get groupType1() : int
      {
         return groupType1$field;
      }
      
      public function removeGroupType2() : void
      {
         hasField$0 &= 4294967293;
         groupType2$field = new int();
      }
      
      public function get hasGroupType2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set groupType2(param1:int) : void
      {
         hasField$0 |= 2;
         groupType2$field = param1;
      }
      
      public function get groupType2() : int
      {
         return groupType2$field;
      }
      
      public function removeGroupType3() : void
      {
         hasField$0 &= 4294967291;
         groupType3$field = new int();
      }
      
      public function get hasGroupType3() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set groupType3(param1:int) : void
      {
         hasField$0 |= 4;
         groupType3$field = param1;
      }
      
      public function get groupType3() : int
      {
         return groupType3$field;
      }
      
      public function removeGroupGrade1() : void
      {
         hasField$0 &= 4294967287;
         groupGrade1$field = new int();
      }
      
      public function get hasGroupGrade1() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set groupGrade1(param1:int) : void
      {
         hasField$0 |= 8;
         groupGrade1$field = param1;
      }
      
      public function get groupGrade1() : int
      {
         return groupGrade1$field;
      }
      
      public function removeGroupGrade2() : void
      {
         hasField$0 &= 4294967279;
         groupGrade2$field = new int();
      }
      
      public function get hasGroupGrade2() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set groupGrade2(param1:int) : void
      {
         hasField$0 |= 16;
         groupGrade2$field = param1;
      }
      
      public function get groupGrade2() : int
      {
         return groupGrade2$field;
      }
      
      public function removeGroupGrade3() : void
      {
         hasField$0 &= 4294967263;
         groupGrade3$field = new int();
      }
      
      public function get hasGroupGrade3() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set groupGrade3(param1:int) : void
      {
         hasField$0 |= 32;
         groupGrade3$field = param1;
      }
      
      public function get groupGrade3() : int
      {
         return groupGrade3$field;
      }
      
      public function removeInspireCount() : void
      {
         hasField$0 &= 4294967231;
         inspireCount$field = new int();
      }
      
      public function get hasInspireCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set inspireCount(param1:int) : void
      {
         hasField$0 |= 64;
         inspireCount$field = param1;
      }
      
      public function get inspireCount() : int
      {
         return inspireCount$field;
      }
      
      public function removeMaxInspireCount() : void
      {
         hasField$0 &= 4294967167;
         maxInspireCount$field = new int();
      }
      
      public function get hasMaxInspireCount() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set maxInspireCount(param1:int) : void
      {
         hasField$0 |= 128;
         maxInspireCount$field = param1;
      }
      
      public function get maxInspireCount() : int
      {
         return maxInspireCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGroupType1)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,groupType1$field);
         }
         if(hasGroupType2)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,groupType2$field);
         }
         if(hasGroupType3)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,groupType3$field);
         }
         if(hasGroupGrade1)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,groupGrade1$field);
         }
         if(hasGroupGrade2)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,groupGrade2$field);
         }
         if(hasGroupGrade3)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,groupGrade3$field);
         }
         if(hasInspireCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,inspireCount$field);
         }
         if(hasMaxInspireCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,maxInspireCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: InspireTeamInfoMsg.groupType1 cannot be set twice.");
                  }
                  _loc8_++;
                  groupType1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: InspireTeamInfoMsg.groupType2 cannot be set twice.");
                  }
                  _loc7_++;
                  groupType2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: InspireTeamInfoMsg.groupType3 cannot be set twice.");
                  }
                  _loc6_++;
                  groupType3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: InspireTeamInfoMsg.groupGrade1 cannot be set twice.");
                  }
                  _loc11_++;
                  groupGrade1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: InspireTeamInfoMsg.groupGrade2 cannot be set twice.");
                  }
                  _loc9_++;
                  groupGrade2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: InspireTeamInfoMsg.groupGrade3 cannot be set twice.");
                  }
                  _loc3_++;
                  groupGrade3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: InspireTeamInfoMsg.inspireCount cannot be set twice.");
                  }
                  _loc4_++;
                  inspireCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: InspireTeamInfoMsg.maxInspireCount cannot be set twice.");
                  }
                  _loc5_++;
                  maxInspireCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

