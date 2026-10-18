package mvc.module.children
{
   public class NsLifeWheelInfo
   {
      
      public var grade:int;
      
      public var reduceResiGrade:int;
      
      public var reduceResiGp:int;
      
      public var fireResiGrade:int;
      
      public var fireResiGp:int;
      
      public var waterResiGrade:int;
      
      public var waterResiGp:int;
      
      public var elcResiGrade:int;
      
      public var elcResiGp:int;
      
      public var windResiGrade:int;
      
      public var windResiGp:int;
      
      public var darkResiGrade:int;
      
      public var darkResiGp:int;
      
      public var lightResiGrade:int;
      
      public var lightResiGp:int;
      
      public var activeSkillId:int;
      
      public function NsLifeWheelInfo()
      {
         super();
      }
      
      public function get resiGradeArr() : Array
      {
         return [reduceResiGrade,fireResiGrade,waterResiGrade,elcResiGrade,windResiGrade,darkResiGrade,lightResiGrade];
      }
      
      public function get resiGpArr() : Array
      {
         return [reduceResiGp,fireResiGp,waterResiGp,elcResiGp,windResiGp,darkResiGp,lightResiGp];
      }
   }
}

