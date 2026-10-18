package com.road.yishi.proto.alchemyworkshop
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SharedFormulaMsg extends Message implements IExternalizable
   {
      
      private var shareUid$field:int;
      
      private var hasField$0:uint = 0;
      
      private var formulaId$field:int;
      
      private var startTime$field:String;
      
      [ArrayElementType("com.road.yishi.proto.alchemyworkshop.ChildFormulaMsg")]
      public var childFormula:Array = [];
      
      public function SharedFormulaMsg()
      {
         super();
      }
      
      public function removeShareUid() : void
      {
         hasField$0 &= 4294967294;
         shareUid$field = new int();
      }
      
      public function get hasShareUid() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set shareUid(param1:int) : void
      {
         hasField$0 |= 1;
         shareUid$field = param1;
      }
      
      public function get shareUid() : int
      {
         return shareUid$field;
      }
      
      public function removeFormulaId() : void
      {
         hasField$0 &= 4294967293;
         formulaId$field = new int();
      }
      
      public function get hasFormulaId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set formulaId(param1:int) : void
      {
         hasField$0 |= 2;
         formulaId$field = param1;
      }
      
      public function get formulaId() : int
      {
         return formulaId$field;
      }
      
      public function removeStartTime() : void
      {
         startTime$field = null;
      }
      
      public function get hasStartTime() : Boolean
      {
         return startTime$field != null;
      }
      
      public function set startTime(param1:String) : void
      {
         startTime$field = param1;
      }
      
      public function get startTime() : String
      {
         return startTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasShareUid)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,shareUid$field);
         }
         if(hasFormulaId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,formulaId$field);
         }
         if(hasStartTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,startTime$field);
         }
         _loc2_ = 0;
         while(_loc2_ < childFormula.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,childFormula[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:ChildFormulaMsg = null;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SharedFormulaMsg.shareUid cannot be set twice.");
                  }
                  _loc6_++;
                  shareUid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SharedFormulaMsg.formulaId cannot be set twice.");
                  }
                  _loc3_++;
                  formulaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SharedFormulaMsg.startTime cannot be set twice.");
                  }
                  _loc4_++;
                  startTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  _loc5_ = new ChildFormulaMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  childFormula.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

