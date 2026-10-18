package theseus
{
   import bag.helper.BagHelper;
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mainBar.vicePassword.VicePasswordUtil;
   import theseus.item.TheseusBagCell;
   import theseus.view.TreasureCell;
   import theseus.view.TreasureOuterItem;
   import theseus.war.item.TheseusInsfBagCell;
   import theseus.war.item.TheseusWarEquipCell;
   import yishi.manager.CursorManagerII;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusBagHelper extends BagHelper
   {
      
      private static var _instance:TheseusBagHelper;
      
      public function TheseusBagHelper()
      {
         super();
      }
      
      public static function get instance() : TheseusBagHelper
      {
         if(!_instance)
         {
            _instance = new TheseusBagHelper();
         }
         return _instance;
      }
      
      override public function vpLockBtnClickHandler(param1:Object) : void
      {
         if(!isVpLock)
         {
            CursorManagerII.instance.showCursorByType("VICE_PASSWORD_LOCK");
            MsgMan.notifyObserver("VICE_PASSWORD_LOCK");
            isVpLock = !isVpLock;
            StageReferance.stage.addEventListener("click",__vpLockClickHandler,true);
            StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
            StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
         }
         else
         {
            CursorManagerII.instance.resetCursor();
            MsgMan.notifyObserver("notVICE_PASSWORD_LOCK");
            isVpLock = !isVpLock;
            StageReferance.stage.removeEventListener("click",__vpLockClickHandler,true);
            StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
            StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
         }
      }
      
      override public function __onMouseDownHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      override public function __onMouseUpHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      override protected function __vpLockClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:TheseusBagCell = null;
         var _loc8_:TreasureCell = null;
         var _loc5_:TreasureOuterItem = null;
         var _loc3_:TheseusWarEquipCell = null;
         var _loc4_:TheseusInsfBagCell = null;
         var _loc2_:String = "";
         var _loc7_:Array = StageReferance.stage.getObjectsUnderPoint(new Point(param1.stageX,param1.stageY));
         _loc7_.pop();
         var _loc9_:DisplayObject = _loc7_.pop();
         if(MessageTipManager.instance().enable)
         {
            _loc9_ = _loc7_.pop();
         }
         while(_loc9_)
         {
            if(_loc9_ is TheseusBagCell)
            {
               param1.stopImmediatePropagation();
               param1.stopPropagation();
               _loc6_ = _loc9_ as TheseusBagCell;
               if(_loc6_ && _loc6_.data)
               {
                  CursorManagerII.instance.resetCursor();
                  StageReferance.stage.removeEventListener("click",__vpLockClickHandler,true);
                  StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
                  VicePasswordUtil.vpLockOp(11,0,_loc6_.data.id);
                  isVpLock = true;
                  CursorManagerII.instance.showCursorByType("VICE_PASSWORD_LOCK");
                  StageReferance.stage.addEventListener("click",__vpLockClickHandler,true);
                  StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
                  return;
               }
            }
            if(_loc9_ is TreasureCell)
            {
               _loc8_ = _loc9_ as TreasureCell;
               if(_loc8_ && _loc8_.data)
               {
                  CursorManagerII.instance.resetCursor();
                  VicePasswordUtil.vpLockOp(8,_loc8_.data.pos);
                  isVpLock = true;
                  CursorManagerII.instance.showCursorByType("VICE_PASSWORD_LOCK");
                  StageReferance.stage.addEventListener("click",__vpLockClickHandler,true);
                  StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
                  return;
               }
            }
            if(_loc9_ is TreasureOuterItem)
            {
               _loc5_ = _loc9_ as TreasureOuterItem;
               if(_loc5_ && _loc5_.data)
               {
                  CursorManagerII.instance.resetCursor();
                  StageReferance.stage.removeEventListener("click",__vpLockClickHandler,true);
                  StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
                  VicePasswordUtil.vpLockOp(13,_loc5_.data.pos);
                  isVpLock = true;
                  CursorManagerII.instance.showCursorByType("VICE_PASSWORD_LOCK");
                  StageReferance.stage.addEventListener("click",__vpLockClickHandler,true);
                  StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
                  return;
               }
            }
            if(_loc9_ is TheseusWarEquipCell)
            {
               param1.stopImmediatePropagation();
               param1.stopPropagation();
               _loc3_ = _loc9_ as TheseusWarEquipCell;
               if(_loc3_ && _loc3_.data)
               {
                  CursorManagerII.instance.resetCursor();
                  StageReferance.stage.removeEventListener("click",__vpLockClickHandler,true);
                  StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
                  VicePasswordUtil.vpLockOp(9,0,_loc3_.data.id);
                  isVpLock = true;
                  CursorManagerII.instance.showCursorByType("VICE_PASSWORD_LOCK");
                  StageReferance.stage.addEventListener("click",__vpLockClickHandler,true);
                  StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
                  return;
               }
            }
            if(_loc9_ is TheseusInsfBagCell)
            {
               param1.stopImmediatePropagation();
               param1.stopPropagation();
               _loc4_ = _loc9_ as TheseusInsfBagCell;
               if(_loc4_ && _loc4_.data)
               {
                  CursorManagerII.instance.resetCursor();
                  StageReferance.stage.removeEventListener("click",__vpLockClickHandler,true);
                  StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
                  VicePasswordUtil.vpLockOp(9,0,_loc4_.data.id);
                  isVpLock = true;
                  CursorManagerII.instance.showCursorByType("VICE_PASSWORD_LOCK");
                  StageReferance.stage.addEventListener("click",__vpLockClickHandler,true);
                  StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
                  return;
               }
            }
            _loc9_ = _loc9_.parent;
         }
         isVpLock = false;
         CursorManagerII.instance.resetCursor();
         MsgMan.notifyObserver("notVICE_PASSWORD_LOCK");
         StageReferance.stage.removeEventListener("click",__vpLockClickHandler,true);
         StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
         StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
      }
   }
}

