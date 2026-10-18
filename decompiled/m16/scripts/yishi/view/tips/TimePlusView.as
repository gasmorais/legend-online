package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.text.TextField;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class TimePlusView extends Sprite implements Disposeable
   {
      
      private var _timeTxt:FilterFrameText;
      
      public function TimePlusView()
      {
         super();
         init();
      }
      
      public static function dateToString(param1:Date, param2:TextField) : void
      {
         param2.text = "";
         param2.text = DateFormatter.format(param1,"YYYY-MM-DD hh:mm:ss");
      }
      
      public static function formatToStandard(param1:Number) : String
      {
         var _loc2_:String = param1.toString();
         if(_loc2_.length < 2)
         {
            return "0" + _loc2_;
         }
         return _loc2_;
      }
      
      protected function init() : void
      {
         PlayerManager.instance.currentPlayerModel.addEventListener("SYSTIME_UPGRADE_MINUTE",__timeHandler,false,0,true);
      }
      
      protected function __timeHandler(param1:PlayerEvent) : void
      {
         setTimeCount(param1.currentTarget.sysCurtime);
      }
      
      public function set timeTxtStyle(param1:String) : void
      {
         if(_timeTxt)
         {
            ObjectUtils.disposeObject(_timeTxt);
         }
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename(param1);
         addChild(_timeTxt);
      }
      
      public function setTimeCount(param1:Date) : void
      {
         if(param1 && _timeTxt)
         {
            dateToString(param1,_timeTxt);
         }
      }
      
      public function dispose() : void
      {
         PlayerManager.instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__timeHandler);
         removeChild(_timeTxt);
      }
   }
}

