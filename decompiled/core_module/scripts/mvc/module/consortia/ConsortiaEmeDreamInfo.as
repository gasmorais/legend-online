package mvc.module.consortia
{
   import yishi.datas.templates.ConsortiaBossTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class ConsortiaEmeDreamInfo
   {
      
      public static var NEED_CONSORTIA_LEVEL:int = 5;
      
      public static var BOSS_TYPE:int = 3;
      
      public static var ELITE_TYPE:int = 2;
      
      public static var NORMAL_TYPE:int = 1;
      
      public static var TRAP_STUN_BUFF_ID:int = 5;
      
      public static var TRAP_STUN_TIME:int = 65;
      
      private var _grade:int;
      
      public var callGrade:int;
      
      public var spirit:Number;
      
      public var state:int;
      
      public var endTime:String;
      
      public var totalHp:Number;
      
      public var selfOrde:int;
      
      public var selfScore:Number;
      
      public var selfWound:Number;
      
      public var BufferIds:String;
      
      public var taskProcessArr:Array;
      
      public var taskMaxProcessArr:Array;
      
      public var taskSkillIdProcessArr:Array;
      
      public var nightmareState:int;
      
      public var sleepState:int;
      
      public function ConsortiaEmeDreamInfo()
      {
         super();
      }
      
      public function get grade() : int
      {
         return _grade;
      }
      
      public function set grade(param1:int) : void
      {
         if(_grade == param1)
         {
            return;
         }
         _grade = param1;
         setTaskMaxProcess();
      }
      
      private function setTaskMaxProcess() : void
      {
         var _loc1_:ConsortiaBossTemplateInfo = TempleteManager.instance.consortiaBossTemplateCate.getTemplateByLevel(_grade);
         if(_loc1_)
         {
            taskMaxProcessArr = [_loc1_.ATotal,_loc1_.BTotal,_loc1_.CTotal];
         }
      }
   }
}

