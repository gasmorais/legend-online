package com.road.yishi.proto.marriage
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MarriageDataMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var type$field:int;
      
      private var marriage_state$field:int;
      
      private var happy$field:MarriageHappyMsg;
      
      private var mate_happy$field:MarriageHappyMsg;
      
      private var ring$field:MarriageRingMsg;
      
      private var god_tree$field:MarriageGodTreeMsg;
      
      public function MarriageDataMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967293;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 2;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeMarriageState() : void
      {
         hasField$0 &= 4294967291;
         marriage_state$field = new int();
      }
      
      public function get hasMarriageState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set marriageState(param1:int) : void
      {
         hasField$0 |= 4;
         marriage_state$field = param1;
      }
      
      public function get marriageState() : int
      {
         return marriage_state$field;
      }
      
      public function removeHappy() : void
      {
         happy$field = null;
      }
      
      public function get hasHappy() : Boolean
      {
         return happy$field != null;
      }
      
      public function set happy(param1:MarriageHappyMsg) : void
      {
         happy$field = param1;
      }
      
      public function get happy() : MarriageHappyMsg
      {
         return happy$field;
      }
      
      public function removeMateHappy() : void
      {
         mate_happy$field = null;
      }
      
      public function get hasMateHappy() : Boolean
      {
         return mate_happy$field != null;
      }
      
      public function set mateHappy(param1:MarriageHappyMsg) : void
      {
         mate_happy$field = param1;
      }
      
      public function get mateHappy() : MarriageHappyMsg
      {
         return mate_happy$field;
      }
      
      public function removeRing() : void
      {
         ring$field = null;
      }
      
      public function get hasRing() : Boolean
      {
         return ring$field != null;
      }
      
      public function set ring(param1:MarriageRingMsg) : void
      {
         ring$field = param1;
      }
      
      public function get ring() : MarriageRingMsg
      {
         return ring$field;
      }
      
      public function removeGodTree() : void
      {
         god_tree$field = null;
      }
      
      public function get hasGodTree() : Boolean
      {
         return god_tree$field != null;
      }
      
      public function set godTree(param1:MarriageGodTreeMsg) : void
      {
         god_tree$field = param1;
      }
      
      public function get godTree() : MarriageGodTreeMsg
      {
         return god_tree$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasMarriageState)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,marriage_state$field);
         }
         if(hasHappy)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,happy$field);
         }
         if(hasMateHappy)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,mate_happy$field);
         }
         if(hasRing)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,ring$field);
         }
         if(hasGodTree)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,god_tree$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageDataMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageDataMsg.type cannot be set twice.");
                  }
                  _loc7_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageDataMsg.marriageState cannot be set twice.");
                  }
                  _loc10_++;
                  marriageState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageDataMsg.happy cannot be set twice.");
                  }
                  _loc3_++;
                  happy = new MarriageHappyMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,happy);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageDataMsg.mateHappy cannot be set twice.");
                  }
                  _loc4_++;
                  mateHappy = new MarriageHappyMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,mateHappy);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageDataMsg.ring cannot be set twice.");
                  }
                  _loc5_++;
                  ring = new MarriageRingMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,ring);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageDataMsg.godTree cannot be set twice.");
                  }
                  _loc9_++;
                  godTree = new MarriageGodTreeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,godTree);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

