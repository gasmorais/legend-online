package dragontalker
{
   import bag.events.BagEvent;
   import bag.helper.GoodsCheck;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.controls.SelectedButton;
   import dragontalker.cell.DragonTalkerTalismanBagCell;
   import flash.display.DisplayObject;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.CursorManagerII;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTalkerSellHelp extends EventDispatcher
   {
      
      private static var _instance:DragonTalkerSellHelp;
      
      public var isSelling:Boolean;
      
      public function DragonTalkerSellHelp()
      {
         super();
      }
      
      public static function get Ins() : DragonTalkerSellHelp
      {
         if(_instance == null)
         {
            _instance = new DragonTalkerSellHelp();
         }
         return _instance;
      }
      
      public function stopSelling() : void
      {
         isSelling = false;
         CursorManagerII.instance.resetCursor();
         StageReferance.stage.removeEventListener("click",__sellClickHandler,true);
         StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
         StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
      }
      
      public function onSellButtonClickHandler(param1:Object) : void
      {
         if(!isSelling)
         {
            CursorManagerII.instance.showCursorByType("SELL_CIRSOR");
            isSelling = !isSelling;
            StageReferance.stage.addEventListener("click",__sellClickHandler,true);
            StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
            StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
         }
         else
         {
            CursorManagerII.instance.resetCursor();
            isSelling = !isSelling;
            StageReferance.stage.removeEventListener("click",__sellClickHandler,true);
            StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
            StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
         }
      }
      
      private function __sellClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:DragonTalkerTalismanBagCell = null;
         var _loc8_:GoodsInfo = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         var _loc2_:String = "";
         var _loc5_:Array = StageReferance.stage.getObjectsUnderPoint(new Point(param1.stageX,param1.stageY));
         _loc5_.pop();
         var _loc7_:DisplayObject = _loc5_.pop();
         if(MessageTipManager.instance().enable)
         {
            _loc7_ = _loc5_.pop();
         }
         while(_loc7_)
         {
            if(_loc7_ is SelectedButton)
            {
               StageReferance.stage.removeEventListener("click",__sellClickHandler,true);
               StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
               StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
               (_loc7_ as SelectedButton).dispatchEvent(new MouseEvent("click"));
               StageReferance.stage.addEventListener("click",__sellClickHandler,true);
               StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
               StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
               return;
            }
            _loc6_ = _loc7_ as DragonTalkerTalismanBagCell;
            if(_loc6_ && _loc6_.data)
            {
               _loc8_ = _loc6_.data.goodInfo;
               if(_loc8_)
               {
                  CursorManagerII.instance.resetCursor();
                  StageReferance.stage.removeEventListener("click",__sellClickHandler,true);
                  StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
                  _loc3_ = GoodsCheck.getSellGold(_loc8_) * _loc8_.count;
                  if(_loc3_ == 0)
                  {
                     isSelling = false;
                     _loc2_ = LanguageMgr.GetTranslation("bag.helper.BagHelper.command01");
                     MessageTipManager.instance().show(_loc2_);
                     CursorManagerII.instance.showCursorByType("SELL_CIRSOR");
                     StageReferance.stage.addEventListener("click",__sellClickHandler,true);
                     StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
                     StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
                     return;
                  }
                  if(_loc6_.data.equipPos > 0)
                  {
                     isSelling = false;
                     _loc4_ = LanguageMgr.GetTranslation("vicepassword.description2");
                     MessageTipManager.instance().show(_loc4_);
                     CursorManagerII.instance.showCursorByType("SELL_CIRSOR");
                     StageReferance.stage.addEventListener("click",__sellClickHandler,true);
                     StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
                     StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
                     return;
                  }
                  isSelling = true;
                  dispatchEvent(new BagEvent("SELL_GOODS",_loc8_));
                  CursorManagerII.instance.showCursorByType("SELL_CIRSOR");
                  StageReferance.stage.addEventListener("click",__sellClickHandler,true);
                  StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
                  return;
               }
            }
            _loc7_ = _loc7_.parent;
         }
         isSelling = false;
         CursorManagerII.instance.resetCursor();
         StageReferance.stage.removeEventListener("click",__sellClickHandler,true);
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
   }
}

