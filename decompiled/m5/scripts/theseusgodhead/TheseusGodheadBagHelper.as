package theseusgodhead
{
   import bag.helper.BagHelper;
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import managers.TheseussoulManager;
   import theseusgodhead.UI.TheseusGodheadBagItem;
   import yishi.manager.CursorManagerII;
   
   public class TheseusGodheadBagHelper extends BagHelper
   {
      
      private static var _instance:TheseusGodheadBagHelper;
      
      public function TheseusGodheadBagHelper()
      {
         super();
      }
      
      public static function get instance() : TheseusGodheadBagHelper
      {
         if(!_instance)
         {
            _instance = new TheseusGodheadBagHelper();
         }
         return _instance;
      }
      
      override public function vpLockBtnClickHandler(param1:Object) : void
      {
         if(!isVpLock)
         {
            CursorManagerII.instance.showCursorByType("VICE_PASSWORD_LOCK");
            isVpLock = !isVpLock;
            StageReferance.stage.addEventListener("click",__vpLockClickHandler,true);
            StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
            StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
         }
         else
         {
            CursorManagerII.instance.resetCursor();
            isVpLock = !isVpLock;
            StageReferance.stage.removeEventListener("click",__vpLockClickHandler,true);
            StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
            StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
         }
      }
      
      override protected function __vpLockClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:DisplayObject = null;
         var _loc5_:int = 0;
         var _loc2_:TheseusGodheadBagItem = null;
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         var _loc4_:Array = StageReferance.stage.getObjectsUnderPoint(new Point(param1.stageX,param1.stageY));
         var _loc3_:int = int(_loc4_.length);
         _loc5_ = 0;
         loop0:
         while(_loc5_ < _loc3_)
         {
            _loc6_ = _loc4_[_loc5_];
            while(true)
            {
               if(!_loc6_)
               {
                  _loc5_++;
                  continue loop0;
               }
               if(_loc6_ is TheseusGodheadBagItem)
               {
                  _loc2_ = _loc6_ as TheseusGodheadBagItem;
                  if(_loc2_ && _loc2_.data)
                  {
                     break;
                  }
               }
               _loc6_ = _loc6_.parent;
            }
            TheseussoulManager.Instance.lockSlate(_loc2_.data.stoneId);
            return;
         }
         isVpLock = false;
         CursorManagerII.instance.resetCursor();
         StageReferance.stage.removeEventListener("click",__vpLockClickHandler,true);
         StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
         StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
      }
   }
}

