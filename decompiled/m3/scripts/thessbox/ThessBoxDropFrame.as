package thessbox
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.storehouse.StoreHouseAddSkillMsg;
   import flash.events.Event;
   import flash.geom.Point;
   import managers.TheseussoulManager;
   import mvc.module.theseus.ThessboxFightInfo;
   import thessbox.view.ThessBoxChooseView;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ThessBoxDropFrame extends Frame
   {
      
      private var _view:ThessBoxChooseView;
      
      public function ThessBoxDropFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _view = new ThessBoxChooseView();
         addChild(_view);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         TheseussoulManager.Instance.addEventListener("EVENT_BOX_FIGHT",updateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         TheseussoulManager.Instance.removeEventListener("EVENT_BOX_FIGHT",updateHandler);
      }
      
      private function _moveComplete(param1:int, param2:BaseIconView) : void
      {
         TweenMax.to(param2,0.5,{
            "alpha":0,
            "onComplete":disapearComplete,
            "onCompleteParams":[param1,param2]
         });
      }
      
      private function disapearComplete(param1:int, param2:BaseIconView) : void
      {
         ObjectUtils.disposeObject(param2);
         dispose();
      }
      
      private function iconComplete(param1:BaseIconView = null) : void
      {
         var bottleAnimePoint:Point;
         var endPoint:Point;
         var icon:BaseIconView = param1;
         if(icon)
         {
            bottleAnimePoint = _view.getFlyPoint();
            icon.x = bottleAnimePoint.x + 42;
            icon.y = bottleAnimePoint.y + 32;
            endPoint = new Point(100,479);
            TweenMax.to(icon,1.2,{
               "delay":0.3,
               "bezierThrough":[{
                  "x":icon.x,
                  "y":icon.y
               },{
                  "x":endPoint.x,
                  "y":endPoint.y
               }],
               "scaleX":0.3,
               "scaleY":0.3,
               "orientToBezier":false,
               "ease":Quart.easeIn,
               "onUpdate":function():void
               {
                  if(!icon.parent)
                  {
                     StageReferance.stage.addChild(icon);
                  }
               },
               "onComplete":_moveComplete,
               "onCompleteParams":[1,icon]
            });
         }
      }
      
      public function updateHandler(param1:Event = null) : void
      {
         var _loc4_:SkillTempInfo = null;
         var _loc2_:BaseIconView = null;
         var _loc3_:ThessboxFightInfo = TheseussoulManager.Instance.thessboxInInfo;
         if(_loc3_.type == 3 && _loc3_.addSkill > 0)
         {
            _loc3_.type = 0;
            _loc4_ = TempleteManager.instance.getSkillById(_loc3_.addSkill);
            _loc2_ = ComponentFactory.Instance.creatCustomObject("ui.thessbox.addnIcon",[iconComplete]);
            _loc2_.mouseEnabled = _loc2_.mouseEnabled = false;
            _loc2_.icon = IconFactory.getTecIconByIcon(_loc4_.Icons);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
      }
      
      public function show(param1:StoreHouseAddSkillMsg) : void
      {
         _view.data = param1;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

