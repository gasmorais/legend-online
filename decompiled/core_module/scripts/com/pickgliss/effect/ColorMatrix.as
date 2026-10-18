package com.pickgliss.effect
{
   public class ColorMatrix extends DynamicMatrix
   {
      
      protected static const LUMINANCER:Number = 0.3086;
      
      protected static const LUMINANCEG:Number = 0.6094;
      
      protected static const LUMINANCEB:Number = 0.082;
      
      public function ColorMatrix()
      {
         super(5,5);
         LoadIdentity();
      }
      
      public function SetBrightnessMatrix(param1:Number) : void
      {
         if(!m_matrix)
         {
            return;
         }
         m_matrix[0][4] = param1;
         m_matrix[1][4] = param1;
         m_matrix[2][4] = param1;
      }
      
      public function SetContrastMatrix(param1:Number) : void
      {
         if(!m_matrix)
         {
            return;
         }
         var _loc2_:Number = 0.5 * (127 - param1);
         param1 /= 127;
         m_matrix[0][0] = param1;
         m_matrix[1][1] = param1;
         m_matrix[2][2] = param1;
         m_matrix[0][4] = _loc2_;
         m_matrix[1][4] = _loc2_;
         m_matrix[2][4] = _loc2_;
      }
      
      public function SetSaturationMatrix(param1:Number) : void
      {
         if(!m_matrix)
         {
            return;
         }
         var _loc2_:Number = 1 - param1;
         var _loc3_:Number = _loc2_ * 0.3086;
         m_matrix[0][0] = _loc3_ + param1;
         m_matrix[1][0] = _loc3_;
         m_matrix[2][0] = _loc3_;
         _loc3_ = _loc2_ * 0.6094;
         m_matrix[0][1] = _loc3_;
         m_matrix[1][1] = _loc3_ + param1;
         m_matrix[2][1] = _loc3_;
         _loc3_ = _loc2_ * 0.082;
         m_matrix[0][2] = _loc3_;
         m_matrix[1][2] = _loc3_;
         m_matrix[2][2] = _loc3_ + param1;
      }
      
      public function SetHueMatrix(param1:Number) : void
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(!m_matrix)
         {
            return;
         }
         LoadIdentity();
         var _loc4_:DynamicMatrix = new DynamicMatrix(3,3);
         var _loc6_:DynamicMatrix = new DynamicMatrix(3,3);
         var _loc3_:DynamicMatrix = new DynamicMatrix(3,3);
         var _loc5_:Number = Math.cos(param1);
         var _loc11_:Number = Math.sin(param1);
         var _loc9_:Number = 0.213;
         var _loc2_:Number = 0.715;
         var _loc10_:Number = 0.072;
         _loc4_.SetValue(0,0,_loc9_);
         _loc4_.SetValue(1,0,_loc9_);
         _loc4_.SetValue(2,0,_loc9_);
         _loc4_.SetValue(0,1,_loc2_);
         _loc4_.SetValue(1,1,_loc2_);
         _loc4_.SetValue(2,1,_loc2_);
         _loc4_.SetValue(0,2,_loc10_);
         _loc4_.SetValue(1,2,_loc10_);
         _loc4_.SetValue(2,2,_loc10_);
         _loc6_.SetValue(0,0,1 - _loc9_);
         _loc6_.SetValue(1,0,-_loc9_);
         _loc6_.SetValue(2,0,-_loc9_);
         _loc6_.SetValue(0,1,-_loc2_);
         _loc6_.SetValue(1,1,1 - _loc2_);
         _loc6_.SetValue(2,1,-_loc2_);
         _loc6_.SetValue(0,2,-_loc10_);
         _loc6_.SetValue(1,2,-_loc10_);
         _loc6_.SetValue(2,2,1 - _loc10_);
         _loc6_.MultiplyNumber(_loc5_);
         _loc3_.SetValue(0,0,-_loc9_);
         _loc3_.SetValue(1,0,0.143);
         _loc3_.SetValue(2,0,-(1 - _loc9_));
         _loc3_.SetValue(0,1,-_loc2_);
         _loc3_.SetValue(1,1,0.14);
         _loc3_.SetValue(2,1,_loc2_);
         _loc3_.SetValue(0,2,1 - _loc10_);
         _loc3_.SetValue(1,2,-0.283);
         _loc3_.SetValue(2,2,_loc10_);
         _loc3_.MultiplyNumber(_loc11_);
         _loc4_.Add(_loc6_);
         _loc4_.Add(_loc3_);
         _loc7_ = 0;
         while(_loc7_ < 3)
         {
            _loc8_ = 0;
            while(_loc8_ < 3)
            {
               m_matrix[_loc7_][_loc8_] = _loc4_.GetValue(_loc7_,_loc8_);
               _loc8_++;
            }
            _loc7_++;
         }
      }
      
      public function GetFlatArray() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!m_matrix)
         {
            return null;
         }
         var _loc4_:Array = [];
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc3_ = 0;
            while(_loc3_ < 5)
            {
               _loc4_[_loc1_] = m_matrix[_loc2_][_loc3_];
               _loc1_++;
               _loc3_++;
            }
            _loc2_++;
         }
         return _loc4_;
      }
   }
}

class XFormData
{
   
   public var ox:Number;
   
   public var oy:Number;
   
   public var oz:Number;
   
   public function XFormData()
   {
      super();
   }
}
