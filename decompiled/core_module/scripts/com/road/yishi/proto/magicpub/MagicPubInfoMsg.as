package com.road.yishi.proto.magicpub
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MagicPubInfoMsg extends Message implements IExternalizable
   {
      
      private var templateId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var grades$field:int;
      
      private var gp$field:int;
      
      private var state$field:int;
      
      private var presentCount$field:int;
      
      private var isEvent$field:Boolean;
      
      private var isFirst$field:Boolean;
      
      public function MagicPubInfoMsg()
      {
         super();
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967294;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 1;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294967293;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 2;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
      }
      
      public function removeGp() : void
      {
         hasField$0 &= 4294967291;
         gp$field = new int();
      }
      
      public function get hasGp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set gp(param1:int) : void
      {
         hasField$0 |= 4;
         gp$field = param1;
      }
      
      public function get gp() : int
      {
         return gp$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967287;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 8;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removePresentCount() : void
      {
         hasField$0 &= 4294967279;
         presentCount$field = new int();
      }
      
      public function get hasPresentCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set presentCount(param1:int) : void
      {
         hasField$0 |= 16;
         presentCount$field = param1;
      }
      
      public function get presentCount() : int
      {
         return presentCount$field;
      }
      
      public function removeIsEvent() : void
      {
         hasField$0 &= 4294967263;
         isEvent$field = new Boolean();
      }
      
      public function get hasIsEvent() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isEvent(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isEvent$field = param1;
      }
      
      public function get isEvent() : Boolean
      {
         return isEvent$field;
      }
      
      public function removeIsFirst() : void
      {
         hasField$0 &= 4294967231;
         isFirst$field = new Boolean();
      }
      
      public function get hasIsFirst() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isFirst(param1:Boolean) : void
      {
         hasField$0 |= 64;
         isFirst$field = param1;
      }
      
      public function get isFirst() : Boolean
      {
         return isFirst$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,gp$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasPresentCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,presentCount$field);
         }
         if(hasIsEvent)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,isEvent$field);
         }
         if(hasIsFirst)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,isFirst$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MagicPubInfoMsg.templateId cannot be set twice.");
                  }
                  _loc3_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MagicPubInfoMsg.grades cannot be set twice.");
                  }
                  _loc10_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MagicPubInfoMsg.gp cannot be set twice.");
                  }
                  _loc8_++;
                  gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MagicPubInfoMsg.state cannot be set twice.");
                  }
                  _loc4_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MagicPubInfoMsg.presentCount cannot be set twice.");
                  }
                  _loc6_++;
                  presentCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MagicPubInfoMsg.isEvent cannot be set twice.");
                  }
                  _loc5_++;
                  isEvent = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MagicPubInfoMsg.isFirst cannot be set twice.");
                  }
                  _loc9_++;
                  isFirst = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

