package yishi.resolve
{
   import mvc.module.task.TaskCondictionTemplate;
   import yishi.utils.ClassFactory;
   
   public class TaskCondictionTemplateResolve extends TemplateBaseResolve
   {
      
      public function TaskCondictionTemplateResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = [];
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:TaskCondictionTemplate = ClassFactory.createInstanceIII(TaskCondictionTemplate,_list[_index]);
         _dic.push(_loc1_);
         super.resolveImp();
      }
   }
}

