package com.road.yishi.proto.childpatrol
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildCampInfoMsg extends Message implements IExternalizable
   {
      
      private var Id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var Grade$field:int;
      
      private var NowExp$field:int;
      
      private var ChildId$field:int;
      
      private var Difficulty$field:int;
      
      private var SneakCount$field:int;
      
      private var DefenseCount$field:int;
      
      private var StartTime$field:Int64;
      
      private var SneakTime$field:Int64;
      
      private var IsCover$field:int;
      
      public function ChildCampInfoMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         Id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         Id$field = param1;
      }
      
      public function get id() : int
      {
         return Id$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967293;
         Grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 2;
         Grade$field = param1;
      }
      
      public function get grade() : int
      {
         return Grade$field;
      }
      
      public function removeNowExp() : void
      {
         hasField$0 &= 4294967291;
         NowExp$field = new int();
      }
      
      public function get hasNowExp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set nowExp(param1:int) : void
      {
         hasField$0 |= 4;
         NowExp$field = param1;
      }
      
      public function get nowExp() : int
      {
         return NowExp$field;
      }
      
      public function removeChildId() : void
      {
         hasField$0 &= 4294967287;
         ChildId$field = new int();
      }
      
      public function get hasChildId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set childId(param1:int) : void
      {
         hasField$0 |= 8;
         ChildId$field = param1;
      }
      
      public function get childId() : int
      {
         return ChildId$field;
      }
      
      public function removeDifficulty() : void
      {
         hasField$0 &= 4294967279;
         Difficulty$field = new int();
      }
      
      public function get hasDifficulty() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set difficulty(param1:int) : void
      {
         hasField$0 |= 16;
         Difficulty$field = param1;
      }
      
      public function get difficulty() : int
      {
         return Difficulty$field;
      }
      
      public function removeSneakCount() : void
      {
         hasField$0 &= 4294967263;
         SneakCount$field = new int();
      }
      
      public function get hasSneakCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set sneakCount(param1:int) : void
      {
         hasField$0 |= 32;
         SneakCount$field = param1;
      }
      
      public function get sneakCount() : int
      {
         return SneakCount$field;
      }
      
      public function removeDefenseCount() : void
      {
         hasField$0 &= 4294967231;
         DefenseCount$field = new int();
      }
      
      public function get hasDefenseCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set defenseCount(param1:int) : void
      {
         hasField$0 |= 64;
         DefenseCount$field = param1;
      }
      
      public function get defenseCount() : int
      {
         return DefenseCount$field;
      }
      
      public function removeStartTime() : void
      {
         StartTime$field = null;
      }
      
      public function get hasStartTime() : Boolean
      {
         return StartTime$field != null;
      }
      
      public function set startTime(param1:Int64) : void
      {
         StartTime$field = param1;
      }
      
      public function get startTime() : Int64
      {
         return StartTime$field;
      }
      
      public function removeSneakTime() : void
      {
         SneakTime$field = null;
      }
      
      public function get hasSneakTime() : Boolean
      {
         return SneakTime$field != null;
      }
      
      public function set sneakTime(param1:Int64) : void
      {
         SneakTime$field = param1;
      }
      
      public function get sneakTime() : Int64
      {
         return SneakTime$field;
      }
      
      public function removeIsCover() : void
      {
         hasField$0 &= 4294967167;
         IsCover$field = new int();
      }
      
      public function get hasIsCover() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isCover(param1:int) : void
      {
         hasField$0 |= 128;
         IsCover$field = param1;
      }
      
      public function get isCover() : int
      {
         return IsCover$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,Id$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,Grade$field);
         }
         if(hasNowExp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,NowExp$field);
         }
         if(hasChildId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,ChildId$field);
         }
         if(hasDifficulty)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,Difficulty$field);
         }
         if(hasSneakCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,SneakCount$field);
         }
         if(hasDefenseCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,DefenseCount$field);
         }
         if(hasStartTime)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT64(param1,StartTime$field);
         }
         if(hasSneakTime)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT64(param1,SneakTime$field);
         }
         if(hasIsCover)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,IsCover$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc13_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ChildCampInfoMsg.id cannot be set twice.");
                  }
                  _loc13_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChildCampInfoMsg.grade cannot be set twice.");
                  }
                  _loc8_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChildCampInfoMsg.nowExp cannot be set twice.");
                  }
                  _loc6_++;
                  nowExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChildCampInfoMsg.childId cannot be set twice.");
                  }
                  _loc9_++;
                  childId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChildCampInfoMsg.difficulty cannot be set twice.");
                  }
                  _loc10_++;
                  difficulty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChildCampInfoMsg.sneakCount cannot be set twice.");
                  }
                  _loc11_++;
                  sneakCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChildCampInfoMsg.defenseCount cannot be set twice.");
                  }
                  _loc5_++;
                  defenseCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildCampInfoMsg.startTime cannot be set twice.");
                  }
                  _loc3_++;
                  startTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChildCampInfoMsg.sneakTime cannot be set twice.");
                  }
                  _loc7_++;
                  sneakTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 9:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildCampInfoMsg.isCover cannot be set twice.");
                  }
                  _loc4_++;
                  isCover = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

