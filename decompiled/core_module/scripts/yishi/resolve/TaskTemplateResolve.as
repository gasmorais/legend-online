package yishi.resolve
{
   import flash.utils.Dictionary;
   import mvc.module.task.TaskTemplate;
   import yishi.utils.ClassFactory;
   
   public class TaskTemplateResolve extends TemplateBaseResolve
   {
      
      public function TaskTemplateResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:TaskTemplate = ClassFactory.createInstanceIII(TaskTemplate,_list[_index]);
         _dic[_loc1_.TemplateId] = _loc1_;
         super.resolveImp();
      }
   }
}

