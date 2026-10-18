package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class VicePasswordMsg extends Message implements IExternalizable
   {
      
      private var op_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var input_pass$field:String;
      
      private var pre_pass$field:String;
      
      private var new_pass$field:String;
      
      private var result$field:int;
      
      public function VicePasswordMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         op_type$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         op_type$field = param1;
      }
      
      public function get opType() : int
      {
         return op_type$field;
      }
      
      public function removeInputPass() : void
      {
         input_pass$field = null;
      }
      
      public function get hasInputPass() : Boolean
      {
         return input_pass$field != null;
      }
      
      public function set inputPass(param1:String) : void
      {
         input_pass$field = param1;
      }
      
      public function get inputPass() : String
      {
         return input_pass$field;
      }
      
      public function removePrePass() : void
      {
         pre_pass$field = null;
      }
      
      public function get hasPrePass() : Boolean
      {
         return pre_pass$field != null;
      }
      
      public function set prePass(param1:String) : void
      {
         pre_pass$field = param1;
      }
      
      public function get prePass() : String
      {
         return pre_pass$field;
      }
      
      public function removeNewPass() : void
      {
         new_pass$field = null;
      }
      
      public function get hasNewPass() : Boolean
      {
         return new_pass$field != null;
      }
      
      public function set newPass(param1:String) : void
      {
         new_pass$field = param1;
      }
      
      public function get newPass() : String
      {
         return new_pass$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967293;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 2;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         if(hasInputPass)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,input_pass$field);
         }
         if(hasPrePass)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,pre_pass$field);
         }
         if(hasNewPass)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,new_pass$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: VicePasswordMsg.opType cannot be set twice.");
                  }
                  _loc4_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: VicePasswordMsg.inputPass cannot be set twice.");
                  }
                  _loc8_++;
                  inputPass = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: VicePasswordMsg.prePass cannot be set twice.");
                  }
                  _loc5_++;
                  prePass = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: VicePasswordMsg.newPass cannot be set twice.");
                  }
                  _loc3_++;
                  newPass = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: VicePasswordMsg.result cannot be set twice.");
                  }
                  _loc6_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

