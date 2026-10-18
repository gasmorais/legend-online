package ui.tasktracebar.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class TransferAnimationView extends Frame
   {
      
      private var titleBack:MovieClip;
      
      private var fire:MovieClip;
      
      public var fireOver:Function;
      
      private var pt1:Point;
      
      private var pt2:Point;
      
      private var px:int;
      
      private var py:int;
      
      public function TransferAnimationView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleBack = ComponentFactory.Instance.creatCustomObject("taskTracebar.Dragonback");
         fire = ComponentFactory.Instance.creatCustomObject("taskTracebar.Fire");
         addToContent(titleBack);
         addToContent(fire);
      }
      
      private function initEvent() : void
      {
         StageReferance.addEventListener("resize",__onResize);
         this.addEventListener("addedToStage",__addtoStage);
      }
      
      private function removeEvent() : void
      {
         StageReferance.removeEventListener("resize",__onResize);
         this.removeEventListener("addedToStage",__addtoStage);
      }
      
      public function show(param1:int, param2:int) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         var _loc3_:Point = new Point(param1,param2);
         _loc3_ = this.globalToLocal(_loc3_);
         TweenLite.to(fire,1.8,{
            "scaleX":0.1,
            "scaleY":0.1,
            "x":_loc3_.x,
            "y":_loc3_.y,
            "onComplete":__completeHandler
         });
      }
      
      private function __completeHandler() : void
      {
         fireOver();
         dispose();
      }
      
      private function __onResize(param1:Event = null) : void
      {
         px = StageReferance.gameStageWidth;
         py = StageReferance.gameStageHeight;
         pt1 = new Point((px - fire.width) / 2,(py - fire.height) / 2);
         pt2 = new Point(px / 2,(py - titleBack.height) / 2);
         pt1 = fire.globalToLocal(pt1);
         pt2 = titleBack.globalToLocal(pt2);
         fire.x = pt1.x + 50;
         fire.y = pt1.y + 50;
         titleBack.x = pt2.x;
         titleBack.y = pt2.y - 150;
      }
      
      private function __addtoStage(param1:Event) : void
      {
         __onResize();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(titleBack);
         titleBack = null;
         ObjectUtils.disposeObject(fire);
         fire = null;
         super.dispose();
      }
   }
}

