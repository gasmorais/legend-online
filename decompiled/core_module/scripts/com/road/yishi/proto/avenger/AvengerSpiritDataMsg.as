package com.road.yishi.proto.avenger
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AvengerSpiritDataMsg extends Message implements IExternalizable
   {
      
      private var childId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var grade$field:int;
      
      private var exp$field:int;
      
      private var stageGrade$field:int;
      
      private var liveGrade$field:int;
      
      private var attackGrade$field:int;
      
      private var defenseGrade$field:int;
      
      private var point$field:int;
      
      private var skills$field:String;
      
      public function AvengerSpiritDataMsg()
      {
         super();
      }
      
      public function removeChildId() : void
      {
         hasField$0 &= 4294967294;
         childId$field = new int();
      }
      
      public function get hasChildId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set childId(param1:int) : void
      {
         hasField$0 |= 1;
         childId$field = param1;
      }
      
      public function get childId() : int
      {
         return childId$field;
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
      
      public function removeStageGrade() : void
      {
         hasField$0 &= 4294967287;
         stageGrade$field = new int();
      }
      
      public function get hasStageGrade() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set stageGrade(param1:int) : void
      {
         hasField$0 |= 8;
         stageGrade$field = param1;
      }
      
      public function get stageGrade() : int
      {
         return stageGrade$field;
      }
      
      public function removeLiveGrade() : void
      {
         hasField$0 &= 4294967279;
         liveGrade$field = new int();
      }
      
      public function get hasLiveGrade() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set liveGrade(param1:int) : void
      {
         hasField$0 |= 16;
         liveGrade$field = param1;
      }
      
      public function get liveGrade() : int
      {
         return liveGrade$field;
      }
      
      public function removeAttackGrade() : void
      {
         hasField$0 &= 4294967263;
         attackGrade$field = new int();
      }
      
      public function get hasAttackGrade() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set attackGrade(param1:int) : void
      {
         hasField$0 |= 32;
         attackGrade$field = param1;
      }
      
      public function get attackGrade() : int
      {
         return attackGrade$field;
      }
      
      public function removeDefenseGrade() : void
      {
         hasField$0 &= 4294967231;
         defenseGrade$field = new int();
      }
      
      public function get hasDefenseGrade() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set defenseGrade(param1:int) : void
      {
         hasField$0 |= 64;
         defenseGrade$field = param1;
      }
      
      public function get defenseGrade() : int
      {
         return defenseGrade$field;
      }
      
      public function removePoint() : void
      {
         hasField$0 &= 4294967167;
         point$field = new int();
      }
      
      public function get hasPoint() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set point(param1:int) : void
      {
         hasField$0 |= 128;
         point$field = param1;
      }
      
      public function get point() : int
      {
         return point$field;
      }
      
      public function removeSkills() : void
      {
         skills$field = null;
      }
      
      public function get hasSkills() : Boolean
      {
         return skills$field != null;
      }
      
      public function set skills(param1:String) : void
      {
         skills$field = param1;
      }
      
      public function get skills() : String
      {
         return skills$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasChildId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,childId$field);
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
         if(hasStageGrade)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,stageGrade$field);
         }
         if(hasLiveGrade)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,liveGrade$field);
         }
         if(hasAttackGrade)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,attackGrade$field);
         }
         if(hasDefenseGrade)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,defenseGrade$field);
         }
         if(hasPoint)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,point$field);
         }
         if(hasSkills)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,skills$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSpiritDataMsg.childId cannot be set twice.");
                  }
                  _loc6_++;
                  childId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSpiritDataMsg.grade cannot be set twice.");
                  }
                  _loc5_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSpiritDataMsg.exp cannot be set twice.");
                  }
                  _loc4_++;
                  exp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSpiritDataMsg.stageGrade cannot be set twice.");
                  }
                  _loc11_++;
                  stageGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSpiritDataMsg.liveGrade cannot be set twice.");
                  }
                  _loc3_++;
                  liveGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSpiritDataMsg.attackGrade cannot be set twice.");
                  }
                  _loc9_++;
                  attackGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSpiritDataMsg.defenseGrade cannot be set twice.");
                  }
                  _loc10_++;
                  defenseGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSpiritDataMsg.point cannot be set twice.");
                  }
                  _loc7_++;
                  point = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSpiritDataMsg.skills cannot be set twice.");
                  }
                  _loc12_++;
                  skills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

