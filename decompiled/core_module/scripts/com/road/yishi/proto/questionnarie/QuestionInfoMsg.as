package com.road.yishi.proto.questionnarie
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class QuestionInfoMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var title$field:String;
      
      private var type$field:int;
      
      private var contenType$field:int;
      
      private var a$field:String;
      
      private var b$field:String;
      
      private var c$field:String;
      
      private var d$field:String;
      
      private var e$field:String;
      
      private var f$field:String;
      
      private var g$field:String;
      
      private var h$field:String;
      
      private var i$field:String;
      
      private var j$field:String;
      
      public function QuestionInfoMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeTitle() : void
      {
         title$field = null;
      }
      
      public function get hasTitle() : Boolean
      {
         return title$field != null;
      }
      
      public function set title(param1:String) : void
      {
         title$field = param1;
      }
      
      public function get title() : String
      {
         return title$field;
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
      
      public function removeContenType() : void
      {
         hasField$0 &= 4294967291;
         contenType$field = new int();
      }
      
      public function get hasContenType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set contenType(param1:int) : void
      {
         hasField$0 |= 4;
         contenType$field = param1;
      }
      
      public function get contenType() : int
      {
         return contenType$field;
      }
      
      public function removeA() : void
      {
         a$field = null;
      }
      
      public function get hasA() : Boolean
      {
         return a$field != null;
      }
      
      public function set a(param1:String) : void
      {
         a$field = param1;
      }
      
      public function get a() : String
      {
         return a$field;
      }
      
      public function removeB() : void
      {
         b$field = null;
      }
      
      public function get hasB() : Boolean
      {
         return b$field != null;
      }
      
      public function set b(param1:String) : void
      {
         b$field = param1;
      }
      
      public function get b() : String
      {
         return b$field;
      }
      
      public function removeC() : void
      {
         c$field = null;
      }
      
      public function get hasC() : Boolean
      {
         return c$field != null;
      }
      
      public function set c(param1:String) : void
      {
         c$field = param1;
      }
      
      public function get c() : String
      {
         return c$field;
      }
      
      public function removeD() : void
      {
         d$field = null;
      }
      
      public function get hasD() : Boolean
      {
         return d$field != null;
      }
      
      public function set d(param1:String) : void
      {
         d$field = param1;
      }
      
      public function get d() : String
      {
         return d$field;
      }
      
      public function removeE() : void
      {
         e$field = null;
      }
      
      public function get hasE() : Boolean
      {
         return e$field != null;
      }
      
      public function set e(param1:String) : void
      {
         e$field = param1;
      }
      
      public function get e() : String
      {
         return e$field;
      }
      
      public function removeF() : void
      {
         f$field = null;
      }
      
      public function get hasF() : Boolean
      {
         return f$field != null;
      }
      
      public function set f(param1:String) : void
      {
         f$field = param1;
      }
      
      public function get f() : String
      {
         return f$field;
      }
      
      public function removeG() : void
      {
         g$field = null;
      }
      
      public function get hasG() : Boolean
      {
         return g$field != null;
      }
      
      public function set g(param1:String) : void
      {
         g$field = param1;
      }
      
      public function get g() : String
      {
         return g$field;
      }
      
      public function removeH() : void
      {
         h$field = null;
      }
      
      public function get hasH() : Boolean
      {
         return h$field != null;
      }
      
      public function set h(param1:String) : void
      {
         h$field = param1;
      }
      
      public function get h() : String
      {
         return h$field;
      }
      
      public function removeI() : void
      {
         i$field = null;
      }
      
      public function get hasI() : Boolean
      {
         return i$field != null;
      }
      
      public function set i(param1:String) : void
      {
         i$field = param1;
      }
      
      public function get i() : String
      {
         return i$field;
      }
      
      public function removeJ() : void
      {
         j$field = null;
      }
      
      public function get hasJ() : Boolean
      {
         return j$field != null;
      }
      
      public function set j(param1:String) : void
      {
         j$field = param1;
      }
      
      public function get j() : String
      {
         return j$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasTitle)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,title$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasContenType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,contenType$field);
         }
         if(hasA)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,a$field);
         }
         if(hasB)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,b$field);
         }
         if(hasC)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,c$field);
         }
         if(hasD)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,d$field);
         }
         if(hasE)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,e$field);
         }
         if(hasF)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,f$field);
         }
         if(hasG)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,g$field);
         }
         if(hasH)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,h$field);
         }
         if(hasI)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,i$field);
         }
         if(hasJ)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,j$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc15_:* = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         var _loc16_:uint = 0;
         var _loc13_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc17_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc15_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionInfoMsg.id cannot be set twice.");
                  }
                  _loc5_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionInfoMsg.title cannot be set twice.");
                  }
                  _loc9_++;
                  title = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionInfoMsg.type cannot be set twice.");
                  }
                  _loc6_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionInfoMsg.contenType cannot be set twice.");
                  }
                  _loc12_++;
                  contenType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionInfoMsg.a cannot be set twice.");
                  }
                  _loc16_++;
                  a = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionInfoMsg.b cannot be set twice.");
                  }
                  _loc13_++;
                  b = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionInfoMsg.c cannot be set twice.");
                  }
                  _loc10_++;
                  c = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionInfoMsg.d cannot be set twice.");
                  }
                  _loc7_++;
                  d = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionInfoMsg.e cannot be set twice.");
                  }
                  _loc14_++;
                  e = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionInfoMsg.f cannot be set twice.");
                  }
                  _loc3_++;
                  f = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionInfoMsg.g cannot be set twice.");
                  }
                  _loc4_++;
                  g = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionInfoMsg.h cannot be set twice.");
                  }
                  _loc8_++;
                  h = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionInfoMsg.i cannot be set twice.");
                  }
                  _loc11_++;
                  i = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionInfoMsg.j cannot be set twice.");
                  }
                  _loc17_++;
                  j = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc15_ & 7);
            }
         }
      }
   }
}

