package map.internals.data
{
   import events.ArmyEvent;
   import flash.events.EventDispatcher;
   
   public class ArmyChildrenInfo extends EventDispatcher
   {
      
      private var _childrenName:String;
      
      private var _childrenJob:int;
      
      private var _childrenSex:int;
      
      private var _childrenFightPower:int;
      
      private var _childrenGrade:int;
      
      private var _growthGrade2:int = -1;
      
      private var changed:Boolean = false;
      
      public var posX:int = 0;
      
      public var posY:int = 0;
      
      public function ArmyChildrenInfo()
      {
         super();
      }
      
      public function get childrenName() : String
      {
         return _childrenName;
      }
      
      public function set childrenName(param1:String) : void
      {
         if(_childrenName == param1)
         {
            return;
         }
         _childrenName = param1;
         changed = true;
      }
      
      public function get childrenJob() : int
      {
         return _childrenJob;
      }
      
      public function set childrenJob(param1:int) : void
      {
         if(_childrenJob == param1)
         {
            return;
         }
         _childrenJob = param1;
         changed = true;
      }
      
      public function get childrenSex() : int
      {
         return _childrenSex;
      }
      
      public function set childrenSex(param1:int) : void
      {
         if(_childrenSex == param1)
         {
            return;
         }
         _childrenSex = param1;
         changed = true;
      }
      
      public function get childrenFightPower() : int
      {
         return _childrenFightPower;
      }
      
      public function set childrenFightPower(param1:int) : void
      {
         if(_childrenFightPower == param1)
         {
            return;
         }
         _childrenFightPower = param1;
         changed = true;
      }
      
      public function commit() : void
      {
         if(changed)
         {
            dispatchEvent(new ArmyEvent("CHILDRENINFO_CHANGED",this));
            changed = false;
         }
      }
      
      public function get childrenGrade() : int
      {
         return _childrenGrade;
      }
      
      public function set childrenGrade(param1:int) : void
      {
         if(_childrenGrade == param1)
         {
            return;
         }
         _childrenGrade = param1;
         changed = true;
      }
      
      public function get growthGrade2() : int
      {
         return _growthGrade2;
      }
      
      public function set growthGrade2(param1:int) : void
      {
         if(_growthGrade2 == param1)
         {
            return;
         }
         _growthGrade2 = param1;
         changed = true;
      }
   }
}

