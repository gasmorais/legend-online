package com.road.yishi.proto.fate
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FateInfoMsg extends Message implements IExternalizable
   {
      
      private var template_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var fate_types$field:int;
      
      private var total_gp$field:Int64;
      
      private var grades$field:int;
      
      private var property1$field:String;
      
      private var property2$field:String;
      
      private var turn_count$field:int;
      
      private var index$field:int;
      
      public function FateInfoMsg()
      {
         super();
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967294;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 1;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removeFateTypes() : void
      {
         hasField$0 &= 4294967293;
         fate_types$field = new int();
      }
      
      public function get hasFateTypes() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set fateTypes(param1:int) : void
      {
         hasField$0 |= 2;
         fate_types$field = param1;
      }
      
      public function get fateTypes() : int
      {
         return fate_types$field;
      }
      
      public function removeTotalGp() : void
      {
         total_gp$field = null;
      }
      
      public function get hasTotalGp() : Boolean
      {
         return total_gp$field != null;
      }
      
      public function set totalGp(param1:Int64) : void
      {
         total_gp$field = param1;
      }
      
      public function get totalGp() : Int64
      {
         return total_gp$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294967291;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 4;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
      }
      
      public function removeProperty1() : void
      {
         property1$field = null;
      }
      
      public function get hasProperty1() : Boolean
      {
         return property1$field != null;
      }
      
      public function set property1(param1:String) : void
      {
         property1$field = param1;
      }
      
      public function get property1() : String
      {
         return property1$field;
      }
      
      public function removeProperty2() : void
      {
         property2$field = null;
      }
      
      public function get hasProperty2() : Boolean
      {
         return property2$field != null;
      }
      
      public function set property2(param1:String) : void
      {
         property2$field = param1;
      }
      
      public function get property2() : String
      {
         return property2$field;
      }
      
      public function removeTurnCount() : void
      {
         hasField$0 &= 4294967287;
         turn_count$field = new int();
      }
      
      public function get hasTurnCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set turnCount(param1:int) : void
      {
         hasField$0 |= 8;
         turn_count$field = param1;
      }
      
      public function get turnCount() : int
      {
         return turn_count$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967279;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 16;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasFateTypes)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,fate_types$field);
         }
         if(hasTotalGp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT64(param1,total_gp$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,property1$field);
         }
         if(hasProperty2)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,property2$field);
         }
         if(hasTurnCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,turn_count$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FateInfoMsg.templateId cannot be set twice.");
                  }
                  _loc7_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FateInfoMsg.fateTypes cannot be set twice.");
                  }
                  _loc4_++;
                  fateTypes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FateInfoMsg.totalGp cannot be set twice.");
                  }
                  _loc3_++;
                  totalGp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FateInfoMsg.grades cannot be set twice.");
                  }
                  _loc9_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FateInfoMsg.property1 cannot be set twice.");
                  }
                  _loc6_++;
                  property1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FateInfoMsg.property2 cannot be set twice.");
                  }
                  _loc11_++;
                  property2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FateInfoMsg.turnCount cannot be set twice.");
                  }
                  _loc10_++;
                  turnCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FateInfoMsg.index cannot be set twice.");
                  }
                  _loc5_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

