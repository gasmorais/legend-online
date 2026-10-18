package com.road.yishi.proto.expedition
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ExpeditionEditMsg extends Message implements IExternalizable
   {
      
      private var childId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var energy$field:int;
      
      private var pos$field:int;
      
      private var skills$field:String;
      
      private var cdTime$field:String;
      
      public function ExpeditionEditMsg()
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
      
      public function removeEnergy() : void
      {
         hasField$0 &= 4294967293;
         energy$field = new int();
      }
      
      public function get hasEnergy() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set energy(param1:int) : void
      {
         hasField$0 |= 2;
         energy$field = param1;
      }
      
      public function get energy() : int
      {
         return energy$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967291;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 4;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
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
      
      public function removeCdTime() : void
      {
         cdTime$field = null;
      }
      
      public function get hasCdTime() : Boolean
      {
         return cdTime$field != null;
      }
      
      public function set cdTime(param1:String) : void
      {
         cdTime$field = param1;
      }
      
      public function get cdTime() : String
      {
         return cdTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasChildId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,childId$field);
         }
         if(hasEnergy)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,energy$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasSkills)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,skills$field);
         }
         if(hasCdTime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,cdTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ExpeditionEditMsg.childId cannot be set twice.");
                  }
                  _loc3_++;
                  childId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ExpeditionEditMsg.energy cannot be set twice.");
                  }
                  _loc7_++;
                  energy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ExpeditionEditMsg.pos cannot be set twice.");
                  }
                  _loc5_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ExpeditionEditMsg.skills cannot be set twice.");
                  }
                  _loc8_++;
                  skills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ExpeditionEditMsg.cdTime cannot be set twice.");
                  }
                  _loc4_++;
                  cdTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

