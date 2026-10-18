package dragontalker
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.manager.CursorManagerII;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTalkerMutipleIntensifyHelper
   {
      
      private static var _instance:DragonTalkerMutipleIntensifyHelper;
      
      public var isSelling:Boolean;
      
      public function DragonTalkerMutipleIntensifyHelper()
      {
         super();
      }
      
      public static function get instance() : DragonTalkerMutipleIntensifyHelper
      {
         if(!_instance)
         {
            _instance = new DragonTalkerMutipleIntensifyHelper();
         }
         return _instance;
      }
      
      public function onIntensifyButtonClickHandler() : void
      {
         if(!isSelling)
         {
            CursorManagerII.instance.showCursorByType("REMOVE_CURSOR_UP");
            isSelling = !isSelling;
            StageReferance.stage.addEventListener("click",__intensifyClickHandler,true);
            StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
            StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
         }
         else
         {
            CursorManagerII.instance.resetCursor();
            isSelling = !isSelling;
            StageReferance.stage.removeEventListener("click",__intensifyClickHandler,true);
            StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
            StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
         }
      }
      
      private function __intensifyClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:Boolean = false;
         var _loc3_:DragonTalkerTalismanInfo = null;
         var _loc2_:String = "";
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         var _loc4_:Array = StageReferance.stage.getObjectsUnderPoint(new Point(param1.stageX,param1.stageY));
         var _loc5_:DisplayObject = _loc4_.pop();
         if(MessageTipManager.instance().enable)
         {
            _loc5_ = _loc4_.pop();
         }
         while(_loc5_)
         {
            if(getIsCanOp(_loc5_))
            {
               StageReferance.stage.removeEventListener("click",__intensifyClickHandler,true);
               StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
               StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
               if(_loc5_ is SelectedIconButton)
               {
                  (_loc5_ as SelectedIconButton).dispatchEvent(new MouseEvent("click"));
               }
               else if(_loc5_ is SelectedButton)
               {
                  (_loc5_ as SelectedButton).dispatchEvent(new MouseEvent("click"));
               }
               StageReferance.stage.addEventListener("click",__intensifyClickHandler,true);
               StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
               StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
               return;
            }
            _loc6_ = _loc5_.hasOwnProperty("stylename") && _loc5_["stylename"] == "DragonTalkerBagView.bagCell";
            _loc3_ = _loc5_.hasOwnProperty("data") && _loc5_["data"] ? _loc5_["data"] : null;
            if(_loc6_ && _loc3_)
            {
               CursorManagerII.instance.resetCursor();
               StageReferance.stage.removeEventListener("click",__intensifyClickHandler,true);
               StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
               StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
               if(_loc3_.isEquip)
               {
                  isSelling = false;
                  _loc2_ = LanguageMgr.GetTranslation("DragonTalkerIntensifyView.isEqup.intensifyalert");
                  MessageTipManager.instance().show(_loc2_);
                  CursorManagerII.instance.showCursorByType("REMOVE_CURSOR_UP");
                  StageReferance.stage.addEventListener("click",__intensifyClickHandler,true);
                  StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
                  return;
               }
               isSelling = true;
               MsgMan.notifyObserver("ADD_INTENSIFY_TALISMAN",_loc3_);
               CursorManagerII.instance.showCursorByType("REMOVE_CURSOR_UP");
               StageReferance.stage.addEventListener("click",__intensifyClickHandler,true);
               StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
               StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
               return;
            }
            _loc5_ = _loc5_.parent;
         }
         isSelling = false;
         CursorManagerII.instance.resetCursor();
         StageReferance.stage.removeEventListener("click",__intensifyClickHandler,true);
         StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
         StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
      }
      
      private function __onMouseDownHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function __onMouseUpHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function getIsCanOp(param1:DisplayObject) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:Boolean = param1 && (param1 is SelectedIconButton || param1 is SelectedButton);
         if(_loc3_ && param1.hasOwnProperty("stylename"))
         {
            _loc2_ = param1["stylename"];
            if(_loc2_ == "DragonTalkerBagView.propBtn")
            {
               return true;
            }
            if(_loc2_ == "DragonTalkerBagView.expBtn")
            {
               return true;
            }
            if(_loc2_ == "DragonTalkerBagView.typeBtn1")
            {
               return true;
            }
            if(_loc2_ == "DragonTalkerBagView.typeBtn2")
            {
               return true;
            }
            if(_loc2_ == "DragonTalkerBagView.typeBtn3")
            {
               return true;
            }
            if(_loc2_ == "DragonTalkerBagView.typeBtn4")
            {
               return true;
            }
            if(_loc2_ == "DragonTalkerBagView.typeBtn5")
            {
               return true;
            }
            if(_loc2_ == "DragonTalkerBagView.typeBtn6")
            {
               return true;
            }
            return false;
         }
         return false;
      }
   }
}

