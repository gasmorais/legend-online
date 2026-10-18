package stararea
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.pb.helper.army.ThaneInfoHelper;
   import events.ObjectsEvent;
   import flash.display.Sprite;
   import flash.geom.Point;
   import map.internals.utils.ArmySpeedUtils;
   import mvc.module.stararea.StarareaArmy;
   import mvc.module.stararea.StarareaManager;
   import mvc.module.stararea.StarareaModel;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class StarareaWalkLayer extends Sprite implements IEnterFrame, Disposeable
   {
      
      private var _gray:Array;
      
      private var armyView:StarareaArmyView;
      
      public function StarareaWalkLayer()
      {
         super();
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _gray = [UIFilter.getGrayFilter()];
         this.mouseEnabled = false;
         this.mouseChildren = false;
         createArmy();
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      private function __warkOverHandler(param1:ObjectsEvent) : void
      {
      }
      
      private function get model() : StarareaModel
      {
         return StarareaManager.instance.model;
      }
      
      private function createArmy() : void
      {
         armyView = new StarareaArmyView();
         model.myArmy = new StarareaArmy();
         model.myArmy.baseHero = ThaneInfoHelper.currentThane;
         var _loc2_:AIBaseInfo = new BaseArmyAiInfo();
         _loc2_.speed = ArmySpeedUtils.getMoveSpeed(model.myArmy);
         armyView.info = _loc2_;
         armyView.data = model.myArmy;
         armyView.filter = null;
         armyView.mouseChildren = false;
         armyView.mouseEnabled = false;
         var _loc1_:Point = model.getStarPosById(model.myPointId);
         armyView.setPoint(model.myPointId);
         armyView.x = _loc1_.x;
         armyView.y = _loc1_.y;
         addChild(armyView);
      }
      
      public function enterFrame() : void
      {
         armyView.execute();
         if(!armyView.isLiving)
         {
            if(armyView)
            {
               armyView.dispose();
            }
            armyView = null;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(armyView);
         armyView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _gray = null;
      }
   }
}

