package yishi.resolve
{
   import mvc.module.task.TaskGoodsTemplate;
   import yishi.utils.ClassFactory;
   
   public class TaskGoodsTemplateResolve extends TemplateBaseResolve
   {
      
      public function TaskGoodsTemplateResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = [];
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:TaskGoodsTemplate = ClassFactory.createInstanceIII(TaskGoodsTemplate,_list[_index]);
         _dic.push(_loc1_);
         super.resolveImp();
      }
   }
}

