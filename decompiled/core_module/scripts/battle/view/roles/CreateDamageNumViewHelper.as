package battle.view.roles
{
   import battle.view.ui.DamageNumView;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   
   public class CreateDamageNumViewHelper
   {
      
      private static var _ins:CreateDamageNumViewHelper;
      
      private var dir:Dictionary;
      
      public function CreateDamageNumViewHelper()
      {
         super();
      }
      
      public static function ins() : CreateDamageNumViewHelper
      {
         if(_ins == null)
         {
            _ins = new CreateDamageNumViewHelper();
         }
         return _ins;
      }
      
      public function getDamageNumView(param1:int, param2:int = 1, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : DamageNumView
      {
         var _loc6_:DamageNumView = null;
         if(dir == null)
         {
            dir = new Dictionary();
         }
         var _loc7_:String = param2.toString() + param3 + param4 + param5;
         if(dir[_loc7_] == null)
         {
            dir[_loc7_] = [];
         }
         if(dir[_loc7_].length == 0)
         {
            _loc6_ = new DamageNumView(param1,param2,param3,param4,param5);
            dir[_loc7_].push(_loc6_);
         }
         _loc6_ = dir[_loc7_].pop();
         _loc6_.updateData(param1,param2,param3,param4,param5);
         return _loc6_;
      }
      
      public function push(param1:DamageNumView) : void
      {
         if(dir[param1.key] == null)
         {
            dir[param1.key] = [];
         }
         dir[param1.key].push(param1);
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         if(dir == null)
         {
            return;
         }
         for(var _loc1_:String in dir)
         {
            _loc2_ = 0;
            while(_loc2_ < dir[_loc1_].length)
            {
               ObjectUtils.disposeViolentMc(dir[_loc1_][_loc2_]);
               dir[_loc1_][_loc2_] = null;
               _loc2_++;
            }
            delete dir[_loc1_];
         }
      }
   }
}

