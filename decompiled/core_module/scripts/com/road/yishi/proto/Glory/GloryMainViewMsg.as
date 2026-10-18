package com.road.yishi.proto.Glory
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GloryMainViewMsg extends Message implements IExternalizable
   {
      
      private var selfSignUp$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.Glory.GloryPlayerViewMsg")]
      public var player:Array = [];
      
      private var state$field:String;
      
      public function GloryMainViewMsg()
      {
         super();
      }
      
      public function removeSelfSignUp() : void
      {
         hasField$0 &= 4294967294;
         selfSignUp$field = new Boolean();
      }
      
      public function get hasSelfSignUp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set selfSignUp(param1:Boolean) : void
      {
         hasField$0 |= 1;
         selfSignUp$field = param1;
      }
      
      public function get selfSignUp() : Boolean
      {
         return selfSignUp$field;
      }
      
      public function removeState() : void
      {
         state$field = null;
      }
      
      public function get hasState() : Boolean
      {
         return state$field != null;
      }
      
      public function set state(param1:String) : void
      {
         state$field = param1;
      }
      
      public function get state() : String
      {
         return state$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasSelfSignUp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,selfSignUp$field);
         }
         _loc2_ = 0;
         while(_loc2_ < player.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,player[_loc2_]);
            _loc2_++;
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,state$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:GloryPlayerViewMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GloryMainViewMsg.selfSignUp cannot be set twice.");
                  }
                  _loc3_++;
                  selfSignUp = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  _loc6_ = new GloryPlayerViewMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  player.push(_loc6_);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GloryMainViewMsg.state cannot be set twice.");
                  }
                  _loc4_++;
                  state = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

