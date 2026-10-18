package yishi.manager
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.utils.Dictionary;
   import yishi.view.frame.TodayNotAlertFrame;
   
   public class NotAlertManager
   {
      
      private static var _ins:NotAlertManager;
      
      private static var useBindDic:Dictionary;
      
      private var key:String;
      
      private var callBack:Function;
      
      private var hasUseBindPrompt:Boolean;
      
      public function NotAlertManager()
      {
         super();
      }
      
      public static function get ins() : NotAlertManager
      {
         if(_ins == null)
         {
            _ins = new NotAlertManager();
            useBindDic = new Dictionary();
         }
         return _ins;
      }
      
      public function getIsUseBind(param1:String) : Boolean
      {
         key = param1;
         return Boolean(useBindDic[key + "_" + SharedManager.instance.userId]);
      }
      
      public function needAlert(param1:String, param2:Function, param3:String, param4:String, param5:Boolean = true) : void
      {
         var _loc7_:String = null;
         var _loc8_:TodayNotAlertFrame = null;
         var _loc6_:Boolean = false;
         key = param1;
         callBack = param2;
         hasUseBindPrompt = param5;
         if(useBindDic[key + "_" + SharedManager.instance.userId] == null)
         {
            _loc7_ = hasUseBindPrompt ? "" : "2";
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert" + _loc7_);
            _loc8_.show(param4,param3,showTipResult,null,"center",2,true);
         }
         else if(hasUseBindPrompt)
         {
            _loc6_ = Boolean(useBindDic[key + "_" + SharedManager.instance.userId]);
            callBack(_loc6_);
         }
         else
         {
            callBack();
         }
      }
      
      private function showTipResult(param1:Boolean, param2:Boolean = false) : void
      {
         if(param1)
         {
            useBindDic[key + "_" + SharedManager.instance.userId] = param2;
         }
         if(hasUseBindPrompt)
         {
            callBack(param2);
         }
         else
         {
            callBack();
         }
      }
   }
}

